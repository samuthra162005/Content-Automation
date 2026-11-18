const { execSync } = require('child_process');
const path = require('path');

const blogs = [
  'projects/qivera-digital/2026-11-14/how-to-improve-vocabulary-10-simple-daily-habits',
  'projects/qivera-digital/2026-11-14/how-to-stay-consistent-with-habits-when-motivation-fades',
  'projects/aindhin/2026-11-14/sql-for-beginners-basic-queries-every-data-analyst-should-know',
  'projects/aindhin/2026-11-14/power-bi-vs-tableau-which-tool-should-you-learn-first'
];

console.log('='.repeat(80));
console.log('BATCH 100-POINT EDITORIAL AUDIT FOR 2026-11-14 DELIVERABLES');
console.log('='.repeat(80));

blogs.forEach(b => {
  const fullB = path.resolve(__dirname, '..', b);
  console.log('\n>>> AUDITING:', b);
  try {
    const out = execSync(`node "${path.join(__dirname, 'evaluate_content_quality.js')}" "${fullB}"`, { encoding: 'utf8' });
    console.log(out.trim());
  } catch (err) {
    console.error(err.stdout || err.message);
  }
});

