const fs = require('fs');
const path = require('path');

const blogs = [
  'pillar-top-digital-marketing-company-strategies-for-growth',
  'blog-1-how-to-use-claude-for-social-media-marketing',
  'blog-2-ai-agents-in-digital-marketing',
  'blog-3-fifa-world-cup-2026-marketing-campaigns',
  'blog-4-what-is-google-e-e-a-t',
  'blog-5-ai-generated-images-viral-marketers',
  'blog-6-top-ppc-trends-of-2027'
];

let allClean = true;
blogs.forEach(b => {
  const p = path.join('d:/content/digital-marketing-skills/projects/kanavu-digital/2026-11-16', b, 'blog-draft.md');
  const text = fs.readFileSync(p, 'utf8');
  const em = (text.match(/—/g) || []).length;
  const en = (text.match(/–/g) || []).length;
  const sh = (text.match(/\s-\s/g) || []).length;
  const db = (text.match(/^-\s/gm) || []).length;
  const total = em + en + sh + db;
  if (total > 0) {
    console.log(`[DASH DETECTED] ${b}: em=${em}, en=${en}, spaced-hyphen=${sh}, dash-bullet=${db}`);
    allClean = false;
  } else {
    console.log(`[ZERO DASH PASS] ${b}: 0 dashes`);
  }
});

if (allClean) console.log('\nALL 7 BLOGS HAVE EXACTLY ZERO DASH SYMBOLS!');
