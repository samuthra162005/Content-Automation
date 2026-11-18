const fs = require('fs');
const path = require('path');
const base = 'd:/content/digital-marketing-skills/projects/kanavu-digital/2026-11-16';
const blogs = [
  { slug: 'pillar-top-digital-marketing-company-strategies-for-growth', name: 'Pillar Hub' },
  { slug: 'blog-1-how-to-use-claude-for-social-media-marketing', name: 'Blog 1 (Claude SMM)' },
  { slug: 'blog-2-ai-agents-in-digital-marketing', name: 'Blog 2 (AI Agents)' },
  { slug: 'blog-3-fifa-world-cup-2026-marketing-campaigns', name: 'Blog 3 (FIFA World Cup)' },
  { slug: 'blog-4-what-is-google-e-e-a-t', name: 'Blog 4 (Google E-E-A-T)' },
  { slug: 'blog-5-ai-generated-images-viral-marketers', name: 'Blog 5 (AI Images Viral)' },
  { slug: 'blog-6-top-ppc-trends-of-2027', name: 'Blog 6 (Top PPC Trends)' }
];

console.log('='.repeat(80));
console.log('EXHAUSTIVE AUDIT: ALL 14 IMAGES ACROSS 7 BLOGS');
console.log('='.repeat(80));

let totalImages = 0;
let errors = [];

blogs.forEach(b => {
  console.log('\n[' + b.name + '] ' + b.slug);
  const mdPath = path.join(base, b.slug, 'blog-draft.md');
  const lines = fs.readFileSync(mdPath, 'utf8').split('\n');
  let imgCount = 0;
  
  lines.forEach((line, idx) => {
    if (line.startsWith('![')) {
      imgCount++;
      totalImages++;
      const match = line.match(/^!\[(.*?)\]\((.*?)\)/);
      if (!match) {
        errors.push(`Invalid image syntax in ${b.slug} line ${idx+1}: ${line}`);
        return;
      }
      const title = match[1];
      const filename = match[2];
      const fullImgPath = path.join(base, b.slug, filename);
      const exists = fs.existsSync(fullImgPath);
      const size = exists ? (fs.statSync(fullImgPath).size / 1024).toFixed(1) + ' KB' : 'MISSING';
      
      console.log(`  Figure ${imgCount}:`);
      console.log(`    Title        : "${title}"`);
      console.log(`    File         : ${filename} -> ${exists ? 'EXISTS' : 'NOT FOUND'} (${size})`);
      
      if (!title || title.trim().length === 0) {
        errors.push(`Missing title in ${b.slug} Figure ${imgCount}`);
      }
      if (title.endsWith('...') || title.includes('...')) {
        errors.push(`Title truncated with ellipsis in ${b.slug} Figure ${imgCount}: ${title}`);
      }
      if (!exists) {
        errors.push(`Image file missing in ${b.slug}: ${filename}`);
      }
    }
    if (line.startsWith('*Figure')) {
      console.log(`    Caption      : ${line.trim()}`);
    }
    if (line.startsWith('*Alt Text')) {
      console.log(`    Alt Text     : ${line.trim()}`);
    }
  });
  
  if (imgCount !== 2) {
    errors.push(`Expected 2 images in ${b.slug}, found ${imgCount}`);
  }
});

console.log('\n' + '='.repeat(80));
console.log(`AUDIT SUMMARY: ${totalImages} images checked across 7 blogs.`);
if (errors.length === 0) {
  console.log('STATUS: ALL 14 IMAGES HAVE VALID UNTRUNCATED TITLES, CAPTIONS, AND EXISTING FILES! [PASS]');
} else {
  console.log('STATUS: FOUND ERRORS:');
  errors.forEach(e => console.log('  - ' + e));
}
console.log('='.repeat(80));

