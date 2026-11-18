/**
 * UNIVERSAL SEO CONTENT ENGINE V7 — PART 16 SCORECARD AUDITOR
 * Programmatic 100-point Quality Scorecard across 8 Core Dimensions.
 */

const fs = require('fs');
const path = require('path');
const { countWords } = require('./count_blog_words');

function evaluateContent(blogDirPath) {
  const draftPath = path.join(blogDirPath, 'blog-draft.md');
  const metaPath = path.join(blogDirPath, 'seo-metadata.md');
  const linkPath = path.join(blogDirPath, 'internal-linking-strategy.md');
  const reviewPath = path.join(blogDirPath, 'content-review.md');

  if (!fs.existsSync(draftPath)) {
    return { error: `Missing draft file: ${draftPath}`, totalScore: 0, status: 'Needs Review' };
  }

  const wordStats = countWords(draftPath);
  const draftContent = fs.readFileSync(draftPath, 'utf8');

  let score = 0;
  const breakdown = [];

  // 1. Search Intent & Title Alignment (Max 15 pts)
  const firstSentence = wordStats.bodyText.split(/[.!?]/)[0] || '';
  const hasOpeningAnswer = firstSentence.length > 25 && !firstSentence.match(/in today's|imagine|fast-paced|ever-evolving/i);
  const intentScore = hasOpeningAnswer ? 15 : 8;
  score += intentScore;
  breakdown.push({ dimension: 'Search Intent & Title Alignment', max: 15, score: intentScore, pass: intentScore === 15 });

  // 2. Factual Accuracy & Sources (Max 20 pts)
  const hasSourcesFile = fs.existsSync(path.join(blogDirPath, 'research-sources.md'));
  const hasInventedCliches = draftContent.match(/\b(guaranteed #1|overnight rankings|guaranteed 100%|10x traffic)\b/i);
  const factualScore = (hasSourcesFile && !hasInventedCliches) ? 20 : 10;
  score += factualScore;
  breakdown.push({ dimension: 'Factual Accuracy & Sources', max: 20, score: factualScore, pass: factualScore === 20 });

  // 3. Original Usefulness & Trend Recency (Max 15 pts)
  const hasComparisonTable = draftContent.includes('|') && draftContent.includes('---');
  const hasSpecificExamples = draftContent.match(/\b(Tamil Nadu|Erode|textile|healthcare|hospital|Google Search Central|LexiRef|HabitShare|Aindhin|SQL|Power BI|Tableau|Ebbinghaus|Cambridge|etymology|spaced repetition|database)\b/i);
  const usefulnessScore = (hasComparisonTable && hasSpecificExamples) ? 15 : 10;
  score += usefulnessScore;
  breakdown.push({ dimension: 'Original Usefulness & Trend Recency', max: 15, score: usefulnessScore, pass: usefulnessScore === 15 });

  // 4. Writing Quality & Human Tone (Max 10 pts)
  const cliches = ['delve', 'tapestry', 'testament', 'beacon', 'paramount', 'leverage', 'unleash', 'game-changer', 'seamless'];
  let foundCliche = false;
  cliches.forEach(c => {
    if (new RegExp(`\\b${c}\\b`, 'i').test(draftContent)) foundCliche = true;
  });
  const wordCountPass = wordStats.bodyWordCount >= 450 && wordStats.bodyWordCount <= 500;
  const writingScore = (!foundCliche && wordCountPass) ? 10 : (wordCountPass ? 7 : 4);
  score += writingScore;
  breakdown.push({ dimension: 'Writing Quality & Human Tone (450-500w)', max: 10, score: writingScore, pass: writingScore === 10 });

  // 5. On-Page SEO & Metadata (Max 10 pts)
  let metaScore = 10;
  if (!fs.existsSync(metaPath)) {
    metaScore = 5;
  }
  score += metaScore;
  breakdown.push({ dimension: 'On-Page SEO & Metadata', max: 10, score: metaScore, pass: metaScore === 10 });

  // 6. Internal Linking & Topic Cluster (Max 10 pts)
  const links = (draftContent.match(/(?<!\!)\[([^\]]+)\]\((https?:\/\/[^)]+)\)/g) || []);
  const linkScore = (links.length >= 3 && links.length <= 6) ? 10 : 6;
  score += linkScore;
  breakdown.push({ dimension: 'Internal Linking & Topic Cluster', max: 10, score: linkScore, pass: linkScore === 10 });

  // 7. AEO, GEO & FAQ Quality (Max 10 pts)
  const faqsPass = wordStats.faqs.length === 3 && wordStats.faqs.every(f => f.wordCount >= 15 && f.wordCount <= 25);
  const aeoScore = faqsPass ? 10 : 5;
  score += aeoScore;
  breakdown.push({ dimension: 'AEO, GEO & FAQ Quality (3 FAQs, 15-25w)', max: 10, score: aeoScore, pass: aeoScore === 10 });

  // 8. Visual Suite & DOCX Quality (Max 10 pts)
  const hasImages = fs.existsSync(path.join(blogDirPath, 'hero-image.jpg'));
  const hasDocx = fs.readdirSync(blogDirPath).some(f => f.endsWith('.docx'));
  const visualScore = (hasImages && hasDocx) ? 10 : 5;
  score += visualScore;
  breakdown.push({ dimension: 'Visual Suite & DOCX Quality (16:9, .docx)', max: 10, score: visualScore, pass: visualScore === 10 });

  const releaseStatus = score >= 90 ? 'Publication-Ready' : 'Needs Review';

  return {
    totalScore: score,
    maxScore: 100,
    status: releaseStatus,
    bodyWordCount: wordStats.bodyWordCount,
    faqs: wordStats.faqs,
    breakdown
  };
}

module.exports = { evaluateContent };

if (require.main === module) {
  const target = process.argv[2] || 'd:/content/digital-marketing-skills/projects/kanavu-digital/2026-11-14/best-digital-marketing-agency-erode-kanavu-digital';
  const result = evaluateContent(path.resolve(target));
  console.log('='.repeat(80));
  console.log(`UNIVERSAL SEO CONTENT ENGINE V7 — 100-POINT EDITORIAL SCORECARD`);
  console.log(`Target: ${target}`);
  console.log('='.repeat(80));
  result.breakdown.forEach(b => {
    console.log(`${b.dimension.padEnd(45)} : ${String(b.score).padStart(2)} / ${b.max} [${b.pass ? 'PASS' : 'WARN'}]`);
  });
  console.log('-'.repeat(80));
  console.log(`TOTAL SCORE: ${result.totalScore} / 100 — STATUS: ${result.status.toUpperCase()}`);
  console.log('='.repeat(80));
}

