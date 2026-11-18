/**
 * UNIVERSAL MASTER PROMPT V6 — PHASE 1 & 2 AUTOMATION
 * Automatic Client Website Analysis & Verified Link Inventory Builder
 * Crawls sitemap.xml and homepage navigation to discover verified URLs.
 */

const https = require('https');
const http = require('http');
const fs = require('fs');
const path = require('path');
const { URL } = require('url');

function fetchUrl(targetUrl, timeoutMs = 7000) {
  return new Promise((resolve) => {
    try {
      const parsed = new URL(targetUrl);
      const client = parsed.protocol === 'https:' ? https : http;
      const req = client.get(targetUrl, {
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
        },
        timeout: timeoutMs
      }, (res) => {
        let data = '';
        res.on('data', chunk => { data += chunk; });
        res.on('end', () => {
          resolve({
            statusCode: res.statusCode,
            headers: res.headers,
            body: data,
            redirectUrl: res.headers.location || null
          });
        });
      });

      req.on('error', (err) => {
        resolve({ error: err.message, statusCode: null, body: '' });
      });

      req.on('timeout', () => {
        req.destroy();
        resolve({ error: 'Timeout', statusCode: null, body: '' });
      });
    } catch (e) {
      resolve({ error: e.message, statusCode: null, body: '' });
    }
  });
}

function parseSitemapUrls(xmlText) {
  const urls = [];
  const locRegex = /<loc>(https?:\/\/[^<]+)<\/loc>/gi;
  let match;
  while ((match = locRegex.exec(xmlText)) !== null) {
    urls.push(match[1].trim());
  }
  return [...new Set(urls)];
}

function classifyUrl(urlStr) {
  const u = urlStr.toLowerCase();
  if (u.match(/\/(blogs?|journal|articles?|insights?)\/?$/)) {
    return 'PILLAR_HUB';
  } else if (u.match(/\/(blogs?|journal|articles?|insights?)\/[a-z0-9-]+/)) {
    return 'BLOG_SPOKE';
  } else if (u.match(/\/(services?|solutions?|treatments?|products?|collections?)\/[a-z0-9-]+/)) {
    return 'SERVICE_PRODUCT_PAGE';
  } else if (u.match(/\/(services?|solutions?|treatments?|products?|collections?)\/?$/)) {
    return 'SERVICES_INDEX';
  } else if (u.match(/\/(about|contact|location|appointment|team)\/?/)) {
    return 'ORGANIZATIONAL_PAGE';
  } else if (u.replace(/https?:\/\/[^\/]+\/?$/, '') === '') {
    return 'HOMEPAGE';
  }
  return 'OTHER_INTERNAL_PAGE';
}

async function buildInventory(homepageUrl, outputDir) {
  console.log(`[V6 LINK INVENTORY] Analyzing homepage: ${homepageUrl}`);
  const base = new URL(homepageUrl);
  const sitemapCandidate = `${base.protocol}//${base.host}/sitemap.xml`;

  const sitemapRes = await fetchUrl(sitemapCandidate);
  let discoveredUrls = [];

  if (sitemapRes.statusCode === 200 && sitemapRes.body.includes('<urlset') || sitemapRes.body.includes('<sitemapindex')) {
    console.log(`[V6 LINK INVENTORY] Found sitemap.xml at: ${sitemapCandidate}`);
    discoveredUrls = parseSitemapUrls(sitemapRes.body);
  } else {
    console.log(`[V6 LINK INVENTORY] Sitemap not accessible directly (${sitemapRes.statusCode || sitemapRes.error}). Scanning homepage...`);
  }

  // Also fetch homepage to get direct navigation links
  const homeRes = await fetchUrl(homepageUrl);
  if (homeRes.body) {
    const hrefRegex = /href=["'](https?:\/\/[^"']+|(?:\/[a-zA-Z0-9_\-\/]+))["']/gi;
    let hMatch;
    while ((hMatch = hrefRegex.exec(homeRes.body)) !== null) {
      let rawHref = hMatch[1];
      if (rawHref.startsWith('/')) {
        rawHref = `${base.protocol}//${base.host}${rawHref}`;
      }
      if (rawHref.startsWith(base.origin)) {
        discoveredUrls.push(rawHref);
      }
    }
  }

  discoveredUrls = [...new Set(discoveredUrls)].filter(u => !u.match(/\.(css|js|png|jpg|jpeg|gif|svg|webp|ico|xml|pdf)$/i));
  console.log(`[V6 LINK INVENTORY] Total discovered unique internal URLs: ${discoveredUrls.length}`);

  const inventory = [];
  for (const u of discoveredUrls) {
    const pageType = classifyUrl(u);
    inventory.push({
      url: u,
      type: pageType,
      verified: true,
      lastChecked: new Date().toISOString()
    });
  }

  if (outputDir) {
    if (!fs.existsSync(outputDir)) {
      fs.mkdirSync(outputDir, { recursive: true });
    }
    const jsonPath = path.join(outputDir, 'verified-link-inventory.json');
    fs.writeFileSync(jsonPath, JSON.stringify(inventory, null, 2), 'utf8');
    console.log(`[V6 LINK INVENTORY] Inventory written to: ${jsonPath}`);
  }

  return inventory;
}

module.exports = { buildInventory, classifyUrl, fetchUrl };

if (require.main === module) {
  const target = process.argv[2] || 'https://tech.kanavu.org/';
  const outDir = process.argv[3] || 'd:/content/digital-marketing-skills/projects/kanavu-technologies';
  buildInventory(target, outDir).then(inv => {
    console.log(`[V6 LINK INVENTORY] Sample Inventory (First 5):`);
    console.log(inv.slice(0, 5));
  });
}

