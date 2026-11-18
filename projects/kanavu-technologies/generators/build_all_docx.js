const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const { execSync } = require('child_process');

const TEMPLATE_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-technologies/2026-11-02/sample_docx_extract');
const BATCH_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-technologies/2026-11-13');
const OUTPUTS_DIR = path.join(BATCH_DIR, 'outputs');

if (!fs.existsSync(OUTPUTS_DIR)) {
  fs.mkdirSync(OUTPUTS_DIR, { recursive: true });
}

const blogs = [
  {
    slug: 'pillar-latest-technology-trends',
    filename: 'Pillar_Latest_Technology_Trends_Kanavu_Technologies.docx'
  },
  {
    slug: 'blog-1-free-website-hosting-cloudflare-pages',
    filename: 'Blog_1_How_to_Host_a_Website_for_Free_Cloudflare_Pages.docx'
  },
  {
    slug: 'blog-2-what-is-a-cdn',
    filename: 'Blog_2_What_Is_a_CDN_Website_Speed_Optimization.docx'
  },
  {
    slug: 'blog-3-technology-trends-2027',
    filename: 'Blog_3_Technology_Trends_in_2027_Software_Development.docx'
  },
  {
    slug: 'blog-4-textile-industry-website-development',
    filename: 'Blog_4_Website_Development_for_Textile_Industry_B2B_Features.docx'
  },
  {
    slug: 'blog-5-food-delivery-app-development',
    filename: 'Blog_5_Food_Delivery_App_Development_Cost_and_Features.docx'
  },
  {
    slug: 'blog-6-what-is-an-ai-agent',
    filename: 'Blog_6_What_Is_an_AI_Agent_and_How_Does_It_Work.docx'
  }
];

function safeWriteFileSync(filePath, buffer) {
  for (let attempt = 1; attempt <= 3; attempt++) {
    try {
      fs.writeFileSync(filePath, buffer);
      return;
    } catch (e) {
      if ((e.code === 'EBUSY' || e.code === 'EPERM') && attempt < 3) {
        try { execSync('powershell -Command "Start-Sleep -Milliseconds 400"'); } catch (_) {}
      } else if (attempt === 3) {
        const dir = path.dirname(filePath);
        const ext = path.extname(filePath);
        const base = path.basename(filePath, ext).replace(/_Updated|_v\d+/g, '');
        
        // Try fallback names
        const candidates = [
          path.join(dir, `${base}_Updated${ext}`),
          path.join(dir, `${base}_v2${ext}`),
          path.join(dir, `${base}_v3${ext}`)
        ];
        
        let written = false;
        for (const cand of candidates) {
          try {
            fs.writeFileSync(cand, buffer);
            console.log(`Original file was locked, wrote to fallback: ${cand}`);
            written = true;
            break;
          } catch (_) {}
        }
        if (!written) {
          console.warn(`Could not overwrite locked file: ${filePath}`);
        }
        return;
      } else {
        throw e;
      }
    }
  }
}

function createZip(files) {
  const localHeaders = [];
  const centralHeaders = [];
  let offset = 0;

  for (const f of files) {
    const fn = Buffer.from(f.path.replace(/\\/g, '/'), 'utf8');
    const data = Buffer.isBuffer(f.data) ? f.data : Buffer.from(f.data, 'utf8');
    const crc = zlib.crc32(data);
    const comp = zlib.deflateRawSync(data);

    const lh = Buffer.alloc(30);
    lh.writeUInt32LE(0x04034b50, 0);
    lh.writeUInt16LE(20, 4);
    lh.writeUInt16LE(0x0800, 6);
    lh.writeUInt16LE(8, 8);
    lh.writeUInt16LE(0, 10);
    lh.writeUInt16LE(0, 12);
    lh.writeUInt32LE(crc, 14);
    lh.writeUInt32LE(comp.length, 18);
    lh.writeUInt32LE(data.length, 22);
    lh.writeUInt16LE(fn.length, 26);
    lh.writeUInt16LE(0, 28);

    localHeaders.push(lh, fn, comp);

    const cd = Buffer.alloc(46);
    cd.writeUInt32LE(0x02014b50, 0);
    cd.writeUInt16LE(20, 4);
    cd.writeUInt16LE(20, 6);
    cd.writeUInt16LE(0x0800, 8);
    cd.writeUInt16LE(8, 10);
    cd.writeUInt16LE(0, 12);
    cd.writeUInt16LE(0, 14);
    cd.writeUInt32LE(crc, 16);
    cd.writeUInt32LE(comp.length, 20);
    cd.writeUInt32LE(data.length, 24);
    cd.writeUInt16LE(fn.length, 28);
    cd.writeUInt16LE(0, 30);
    cd.writeUInt16LE(0, 32);
    cd.writeUInt16LE(0, 34);
    cd.writeUInt16LE(0, 36);
    cd.writeUInt32LE(0, 38);
    cd.writeUInt32LE(offset, 42);

    centralHeaders.push(cd, fn);
    offset += 30 + fn.length + comp.length;
  }

  const lp = Buffer.concat(localHeaders);
  const cp = Buffer.concat(centralHeaders);
  const eocd = Buffer.alloc(22);
  eocd.writeUInt32LE(0x06054b50, 0);
  eocd.writeUInt16LE(0, 4);
  eocd.writeUInt16LE(0, 6);
  eocd.writeUInt16LE(files.length, 8);
  eocd.writeUInt16LE(files.length, 10);
  eocd.writeUInt32LE(cp.length, 12);
  eocd.writeUInt32LE(lp.length, 16);
  eocd.writeUInt16LE(0, 20);

  return Buffer.concat([lp, cp, eocd]);
}

function escapeXml(unsafe) {
  return (unsafe || '').replace(/[<>&'"]/g, (c) => {
    switch (c) {
      case '<': return '&lt;';
      case '>': return '&gt;';
      case '&': return '&amp;';
      case '\'': return '&apos;';
      case '"': return '&quot;';
    }
  });
}

function parseMarkdownRuns(text, rels, relIdCounter) {
  let runsXml = '';
  const regex = /\[([^\]]+)\]\(([^)]+)\)|\*\*([^*]+)\*\*|`([^`]+)`|([^[\\*`]+)/g;
  let match;
  
  while ((match = regex.exec(text)) !== null) {
    if (match[1] && match[2]) {
      const linkText = match[1];
      const url = match[2];
      const rId = `rId${relIdCounter.val++}`;
      rels.push({ id: rId, target: url, type: 'hyperlink' });
      
      runsXml += `<w:hyperlink r:id="${rId}"><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:color w:val="0000FF"/><w:u w:val="single"/><w:sz w:val="28"/></w:rPr><w:t xml:space="preserve">${escapeXml(linkText)}</w:t></w:r></w:hyperlink>`;
    } else if (match[3]) {
      const boldText = match[3];
      runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/></w:rPr><w:t xml:space="preserve">${escapeXml(boldText)}</w:t></w:r>`;
    } else if (match[4]) {
      const codeText = match[4];
      runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/><w:color w:val="2563EB"/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(codeText)}</w:t></w:r>`;
    } else if (match[5]) {
      const plainText = match[5];
      runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="28"/></w:rPr><w:t xml:space="preserve">${escapeXml(plainText)}</w:t></w:r>`;
    }
  }
  return runsXml;
}

function buildDocumentXml(content, blogDir, rels, relIdCounter, mediaFiles) {
  const lines = content.split('\n');
  let bodyXml = '';
  let inFaq = false;
  let inTable = false;
  let tableRows = [];
  let inCallout = false;
  let calloutType = 'TIP';
  let calloutLines = [];

  function flushTable() {
    if (!tableRows.length) return;
    let tblXml = '<w:tbl><w:tblPr><w:tblW w:type="auto" w:w="0"/><w:jc w:val="center"/><w:tblBorders>' +
      '<w:top w:val="single" w:sz="6" w:space="0" w:color="2563EB"/>' +
      '<w:left w:val="none"/>' +
      '<w:bottom w:val="single" w:sz="10" w:space="0" w:color="2563EB"/>' +
      '<w:right w:val="none"/>' +
      '<w:insideH w:val="single" w:sz="4" w:space="0" w:color="E2E8F0"/>' +
      '<w:insideV w:val="none"/>' +
      '</w:tblBorders></w:tblPr>';

    tableRows.forEach((row, rowIndex) => {
      tblXml += '<w:tr>';
      row.forEach((cellText) => {
        const isHeader = rowIndex === 0;
        const shd = isHeader ? '<w:shd w:fill="F1F5F9" w:val="clear"/>' : '';
        const bTag = isHeader ? '<w:b/>' : '';
        const cellRuns = parseMarkdownRuns(cellText.trim(), rels, relIdCounter);
        tblXml += `<w:tc><w:tcPr><w:tcMar><w:top w:w="120" w:type="dxa"/><w:bottom w:w="120" w:type="dxa"/><w:left w:w="140" w:type="dxa"/><w:right w:w="140" w:type="dxa"/></w:tcMar>${shd}</w:tcPr>` +
          `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr>${cellRuns || `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/>${bTag}<w:sz w:val="24"/></w:rPr><w:t>${escapeXml(cellText.trim())}</w:t></w:r>`}</w:p></w:tc>`;
      });
      tblXml += '</w:tr>';
    });
    tblXml += '</w:tbl><w:p><w:pPr><w:spacing w:after="160"/></w:pPr></w:p>';
    bodyXml += tblXml;
    tableRows = [];
    inTable = false;
  }

  function flushCallout() {
    if (!calloutLines.length) return;
    const borderColors = {
      TIP: '059669',
      NOTE: '2563EB',
      IMPORTANT: 'DC2626',
      WARNING: 'D97706'
    };
    const bColor = borderColors[calloutType] || '2563EB';
    let cXml = '<w:tbl><w:tblPr><w:tblW w:type="auto" w:w="0"/><w:jc w:val="center"/><w:tblLayout w:type="fixed"/></w:tblPr>' +
      '<w:tblGrid><w:gridCol w:w="9360"/></w:tblGrid>' +
      '<w:tr><w:tc><w:tcPr><w:tcW w:type="dxa" w:w="9360"/>' +
      `<w:tcBorders><w:top w:val="single" w:sz="12" w:space="0" w:color="${bColor}"/><w:left w:val="single" w:sz="12" w:space="0" w:color="${bColor}"/><w:bottom w:val="single" w:sz="12" w:space="0" w:color="${bColor}"/><w:right w:val="single" w:sz="12" w:space="0" w:color="${bColor}"/></w:tcBorders>` +
      '<w:shd w:fill="F8FAFC" w:val="clear"/>' +
      '<w:tcMar><w:top w:w="140" w:type="dxa"/><w:bottom w:w="140" w:type="dxa"/><w:left w:w="160" w:type="dxa"/><w:right w:w="160" w:type="dxa"/></w:tcMar>' +
      '</w:tcPr>';

    cXml += `<w:p><w:pPr><w:spacing w:after="80"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="${bColor}"/><w:sz w:val="28"/></w:rPr><w:t xml:space="preserve">${calloutType.toUpperCase()}</w:t></w:r></w:p>`;

    calloutLines.forEach((cline) => {
      const runs = parseMarkdownRuns(cline, rels, relIdCounter);
      cXml += `<w:p><w:pPr><w:spacing w:after="60" w:line="276" w:lineRule="auto"/></w:pPr>${runs}</w:p>`;
    });

    cXml += '</w:tc></w:tr></w:tbl><w:p><w:pPr><w:spacing w:after="160"/></w:pPr></w:p>';
    bodyXml += cXml;
    calloutLines = [];
    inCallout = false;
  }

  for (let i = 0; i < lines.length; i++) {
    const rawLine = lines[i];
    const line = rawLine.trim();

    if (line.startsWith('|')) {
      if (inCallout) flushCallout();
      if (line.includes('---')) continue;
      const cells = line.split('|').slice(1, -1);
      if (cells.length > 0) {
        tableRows.push(cells);
        inTable = true;
      }
      continue;
    } else if (inTable) {
      flushTable();
    }

    if (line.startsWith('>')) {
      const cContent = line.replace(/^>\s*/, '').trim();
      const calloutMatch = cContent.match(/^\[!(TIP|NOTE|IMPORTANT|WARNING)\]/i);
      if (calloutMatch) {
        if (inCallout) flushCallout();
        inCallout = true;
        calloutType = calloutMatch[1].toUpperCase();
      } else if (inCallout) {
        calloutLines.push(cContent);
      }
      continue;
    } else if (inCallout) {
      flushCallout();
    }

    if (!line) continue;
    if (line === '---' || line === '# Metadata Header') continue;

    if (line.startsWith('**Meta Title:**')) {
      const val = line.replace('**Meta Title:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/></w:rPr><w:t xml:space="preserve">Meta Title: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="28"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }
    if (line.startsWith('**Primary Keyword:**')) {
      const val = line.replace('**Primary Keyword:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/></w:rPr><w:t xml:space="preserve">Primary Keyword: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="28"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }
    if (line.startsWith('**Secondary Keywords:**')) {
      const val = line.replace('**Secondary Keywords:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/></w:rPr><w:t xml:space="preserve">Secondary Keywords: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="28"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }
    if (line.startsWith('**Meta Description:**')) {
      const val = line.replace('**Meta Description:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="240"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/></w:rPr><w:t xml:space="preserve">Meta Description: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="28"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('# ')) {
      const title = line.replace('# ', '').trim();
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading1"/><w:spacing w:before="0" w:after="160"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="000000"/><w:sz w:val="36"/></w:rPr><w:t>${escapeXml(title)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('## ')) {
      const h2 = line.replace('## ', '').trim();
      if (h2.toLowerCase().includes('frequently asked questions')) inFaq = true;
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading2"/><w:spacing w:before="280" w:after="120"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="2563EB"/><w:sz w:val="32"/></w:rPr><w:t>${escapeXml(h2)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('### ')) {
      const h3 = line.replace('### ', '').trim();
      const color = inFaq ? '000000' : '990000';
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading3"/><w:spacing w:before="200" w:after="80"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="${color}"/><w:sz w:val="28"/></w:rPr><w:t>${escapeXml(h3)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('**Figure')) {
      const figTitle = line.replace(/\*\*/g, '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:before="160" w:after="40"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="2563EB"/><w:sz w:val="26"/></w:rPr><w:t>${escapeXml(figTitle)}</w:t></w:r></w:p>`;
      continue;
    }

    const imgMatch = line.match(/!\[([^\]]*)\]\(([^)"]+)(?:\s+"([^"]+)")?\)/);
    if (imgMatch) {
      const altText = imgMatch[1];
      const imgTarget = imgMatch[2].replace(/file:\/\/\//g, '').replace(/\//g, path.sep);
      const imgTitle = imgMatch[3] || altText;
      
      let resolvedImgPath = path.isAbsolute(imgTarget) ? imgTarget : path.resolve(blogDir, imgTarget);
      if (!fs.existsSync(resolvedImgPath)) {
        const fallback = path.resolve(blogDir, 'hero-image.jpg');
        if (fs.existsSync(fallback)) resolvedImgPath = fallback;
      }

      if (fs.existsSync(resolvedImgPath)) {
        const mediaIndex = mediaFiles.length + 1;
        const ext = path.extname(resolvedImgPath) || '.jpg';
        const mediaName = `image${mediaIndex}${ext}`;
        mediaFiles.push({ src: resolvedImgPath, dest: mediaName });

        const rId = `rId${relIdCounter.val++}`;
        rels.push({ id: rId, target: `media/${mediaName}`, type: 'image' });

        bodyXml += `<w:p><w:pPr><w:spacing w:before="120" w:after="60"/><w:jc w:val="center"/></w:pPr><w:r><w:drawing><wp:inline xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><wp:extent cx="5669280" cy="3188970"/><wp:docPr id="${mediaIndex}" name="Picture ${mediaIndex}"/><wp:cNvGraphicFramePr><a:graphicFrameLocks noChangeAspect="1"/></wp:cNvGraphicFramePr><a:graphic><a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:pic><pic:nvPicPr><pic:cNvPr id="0" name="${mediaName}"/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill><a:blip r:embed="${rId}"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="5669280" cy="3188970"/></a:xfrm><a:prstGeom prst="rect"/></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing></w:r></w:p>`;
        bodyXml += `<w:p><w:pPr><w:spacing w:after="40"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:i/><w:color w:val="646464"/><w:sz w:val="22"/></w:rPr><w:t>${escapeXml(imgTitle)}</w:t></w:r></w:p>`;
        bodyXml += `<w:p><w:pPr><w:spacing w:after="160"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="505050"/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">Alt Text: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:color w:val="505050"/><w:sz w:val="20"/></w:rPr><w:t>${escapeXml(altText)}</w:t></w:r></w:p>`;
      }
      continue;
    }

    if (line.startsWith('* ') || line.startsWith('- ')) {
      const bContent = line.replace(/^[\*\-]\s*/, '').trim();
      const runs = parseMarkdownRuns(bContent, rels, relIdCounter);
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="ListBullet"/><w:spacing w:after="60" w:line="276" w:lineRule="auto"/></w:pPr>${runs}</w:p>`;
      continue;
    }

    const pRuns = parseMarkdownRuns(line, rels, relIdCounter);
    bodyXml += `<w:p><w:pPr><w:spacing w:after="120" w:line="276" w:lineRule="auto"/></w:pPr>${pRuns}</w:p>`;
  }

  if (inTable) flushTable();
  if (inCallout) flushCallout();

  bodyXml += '<w:sectPr><w:pgSz w:w="12240" w:h="15840"/><w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440" w:header="720" w:footer="720" w:gutter="0"/><w:cols w:space="720"/><w:docGrid w:linePitch="360"/></w:sectPr>';

  return bodyXml;
}

function getTemplateFiles(dir, baseDir = dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  for (const item of list) {
    const fullPath = path.join(dir, item);
    const stat = fs.statSync(fullPath);
    if (stat.isDirectory()) {
      results = results.concat(getTemplateFiles(fullPath, baseDir));
    } else {
      const relPath = path.relative(baseDir, fullPath).replace(/\\/g, '/');
      results.push({ relPath, fullPath });
    }
  }
  return results;
}

function convertBlog(blogInfo) {
  const blogDir = path.join(BATCH_DIR, blogInfo.slug);
  const draftPath = path.join(blogDir, 'blog-draft.md');
  if (!fs.existsSync(draftPath)) {
    console.error(`Missing draft: ${draftPath}`);
    return;
  }

  const content = fs.readFileSync(draftPath, 'utf8');

  const rels = [
    { id: 'rId1', target: '../customXml/item1.xml', type: 'customXml' },
    { id: 'rId2', target: 'numbering.xml', type: 'numbering' },
    { id: 'rId3', target: 'styles.xml', type: 'styles' },
    { id: 'rId4', target: 'stylesWithEffects.xml', type: 'stylesWithEffects' },
    { id: 'rId5', target: 'settings.xml', type: 'settings' },
    { id: 'rId6', target: 'webSettings.xml', type: 'webSettings' },
    { id: 'rId7', target: 'fontTable.xml', type: 'fontTable' },
    { id: 'rId8', target: 'theme/theme1.xml', type: 'theme' }
  ];
  const relIdCounter = { val: 9 };
  const mediaFiles = [];

  const bodyXml = buildDocumentXml(content, blogDir, rels, relIdCounter, mediaFiles);

  const fullDocumentXml = `<?xml version='1.0' encoding='UTF-8' standalone='yes'?>\n` +
    `<w:document xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mo="http://schemas.microsoft.com/office/mac/office/2008/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:mv="urn:schemas-microsoft-com:mac:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" mc:Ignorable="w14 wp14">` +
    `<w:body>${bodyXml}</w:body></w:document>`;

  const relTypes = {
    customXml: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml',
    numbering: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering',
    styles: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles',
    stylesWithEffects: 'http://schemas.microsoft.com/office/2007/relationships/stylesWithEffects',
    settings: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings',
    webSettings: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/webSettings',
    fontTable: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable',
    theme: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme',
    hyperlink: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink',
    image: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/image'
  };

  let relsXml = `<?xml version='1.0' encoding='UTF-8' standalone='yes'?>\n<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">`;
  rels.forEach((r) => {
    const targetMode = r.type === 'hyperlink' ? ' TargetMode="External"' : '';
    relsXml += `<Relationship Id="${r.id}" Type="${relTypes[r.type]}" Target="${escapeXml(r.target)}"${targetMode}/>`;
  });
  relsXml += `</Relationships>`;

  const templateFiles = getTemplateFiles(TEMPLATE_DIR);
  const zipEntries = [];

  for (const tf of templateFiles) {
    if (tf.relPath === 'word/document.xml') continue;
    if (tf.relPath === 'word/_rels/document.xml.rels') continue;
    if (tf.relPath.startsWith('word/media/')) continue;

    if (tf.relPath === '[Content_Types].xml') {
      let ct = fs.readFileSync(tf.fullPath, 'utf8');
      if (!ct.includes('Extension="jpg"')) {
        ct = ct.replace('</Types>', '<Default Extension="jpg" ContentType="image/jpeg"/><Default Extension="png" ContentType="image/png"/></Types>');
      }
      zipEntries.push({ path: tf.relPath, data: ct });
    } else {
      zipEntries.push({ path: tf.relPath, data: fs.readFileSync(tf.fullPath) });
    }
  }

  zipEntries.push({ path: 'word/document.xml', data: fullDocumentXml });
  zipEntries.push({ path: 'word/_rels/document.xml.rels', data: relsXml });

  for (const m of mediaFiles) {
    zipEntries.push({ path: `word/media/${m.dest}`, data: fs.readFileSync(m.src) });
  }

  const docxBuffer = createZip(zipEntries);

  const blogDocxPath = path.join(blogDir, blogInfo.filename);
  const outputDocxPath = path.join(OUTPUTS_DIR, blogInfo.filename);

  safeWriteFileSync(blogDocxPath, docxBuffer);
  safeWriteFileSync(outputDocxPath, docxBuffer);

  console.log(`Successfully compiled: ${blogInfo.filename} (${docxBuffer.length} bytes)`);
  console.log(`  -> ${outputDocxPath}`);
}

console.log('Starting Pure Node DOCX Generation for all 6 blogs...');
blogs.forEach(convertBlog);
console.log('All DOCX documents successfully compiled!');
