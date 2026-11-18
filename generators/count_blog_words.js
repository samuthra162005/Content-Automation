const fs = require('fs');

function countWords(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');

  // Strip frontmatter or Metadata Header if present
  let body = content;
  if (content.startsWith('---')) {
    const parts = content.split('---');
    if (parts.length >= 3) {
      body = parts.slice(2).join('---');
    }
  }

  // Strip Metadata Header block if present
  body = body.replace(/#\s*Metadata Header[\s\S]*?---\s*/i, '');
  body = body.replace(/^\*\*Meta (?:Title|Description):[\s\S]*?$/gm, '');
  body = body.replace(/^\*\*(?:Primary|Secondary) Keywords?:[\s\S]*?$/gm, '');

  // Split FAQs out
  let faqText = '';
  const faqMatch = body.match(/##\s*(?:Frequently Asked Questions|FAQs)[\s\S]*/i);
  if (faqMatch) {
    faqText = faqMatch[0];
    body = body.substring(0, faqMatch.index);
  }

  // Clean body text: remove headers, image tags, captions, bold asterisks
  const cleanBody = body
    .replace(/^#+\s+.*$/gm, '') // headings
    .replace(/!\[.*?\]\(.*?\)/g, '') // images
    .replace(/^\*Figure.*?\*$/gm, '') // captions
    .replace(/^\*Alt Text.*?\*$/gm, '') // alt text
    .replace(/\[([^\]]+)\]\([^)]+\)/g, '$1') // link text
    .replace(/[*_`]/g, '') // formatting
    .replace(/^\s*[-*+]\s+/gm, '') // bullet markers
    .replace(/\|/g, ' ') // table pipes
    .trim();

  const bodyWords = cleanBody.split(/\s+/).filter(w => w.length > 0);

  // Parse FAQs
  const faqs = [];
  if (faqText) {
    const faqBlocks = faqText.split(/###\s+/).slice(1);
    for (const block of faqBlocks) {
      const lines = block.split('\n').map(l => l.trim()).filter(l => l.length > 0);
      const question = lines[0];
      const answer = lines.slice(1).join(' ')
        .replace(/[*_`]/g, '')
        .replace(/\[([^\]]+)\]\([^)]+\)/g, '$1')
        .trim();
      const answerWords = answer.split(/\s+/).filter(w => w.length > 0);
      faqs.push({
        question,
        answer,
        wordCount: answerWords.length
      });
    }
  }

  return {
    bodyWordCount: bodyWords.length,
    bodyText: cleanBody,
    faqs
  };
}

module.exports = { countWords };

if (require.main === module) {
  const target = process.argv[2];
  if (!target) {
    console.log('Usage: node count_blog_words.js <path-to-blog-draft.md>');
    process.exit(1);
  }
  const res = countWords(target);
  console.log('=== BLOG WORD COUNT AUDIT ===');
  console.log(`Main Body Word Count: ${res.bodyWordCount} words (Target: 450-500 words)`);
  console.log(`Status: ${res.bodyWordCount >= 450 && res.bodyWordCount <= 500 ? 'PASS' : 'FAIL'}`);
  console.log('\n--- FAQs ---');
  res.faqs.forEach((faq, i) => {
    console.log(`FAQ ${i + 1}: ${faq.question}`);
    console.log(`Answer Words: ${faq.wordCount} words (Target: 15-25 words) - ${faq.wordCount >= 15 && faq.wordCount <= 25 ? 'PASS' : 'FAIL'}`);
    console.log(`Answer: ${faq.answer}\n`);
  });
}

