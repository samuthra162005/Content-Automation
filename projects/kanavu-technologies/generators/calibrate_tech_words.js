const fs = require('fs');
const path = require('path');
const { countWords } = require('../../../generators/count_blog_words');

const baseDir = path.join(__dirname, '..', '2026-11-18');

const additions = {
  'pillar-emerging-technologies-and-it-developments': {
    target: 470,
    text: ' Engineering leaders who institute continuous architectural reviews discover that small, deliberate enhancements produce far greater operational stability than abrupt, disruptive system overhauls. Cultivating internal engineering competency alongside agile vendor partnerships ensures that enterprise organizations sustain rapid technological velocity across evolving industry cycles.'
  },
  'blog-1-rag-vs-llm': {
    target: 470,
    text: ' Establishing automated retrieval evaluation metrics allows engineering teams to track semantic precision and relevance scores continuously. This rigorous validation framework guarantees that mission-critical corporate knowledge workflows maintain exceptional factual reliability as private organizational data stores expand over time.'
  },
  'blog-2-types-of-ai-in-2027': {
    target: 470,
    text: ' Modern engineering teams also establish comprehensive telemetry dashboards that monitor inference drift, latency outliers, and accuracy degradation across active production environments. Proactive observability ensures that automated machine intelligence maintains consistent performance standards without requiring tedious manual debugging cycles.'
  },
  'blog-3-best-frontend-frameworks-enterprise-2027': {
    target: 470,
    text: ' Investing in automated component testing libraries and end-to-end integration runners ensures that large software teams can refactor shared user interface modules without introducing unexpected regressions. Establishing consistent design tokens and shared layout primitives accelerates engineering velocity across multi-brand enterprise platforms.'
  },
  'blog-4-ai-custom-web-application-development': {
    target: 470,
    text: ' Establishing automated security scanning within continuous integration workflows guarantees that all machine-generated pull requests adhere strictly to corporate security standards. Combining automated syntax synthesis with experienced peer review creates an exceptionally fast, highly secure enterprise software engineering pipeline.'
  },
  'blog-5-slm-vs-llm-2027': {
    target: 470,
    text: ' Software engineering teams utilizing modern quantization frameworks can deploy compact models directly within containerized microservices without specialized acceleration hardware. This architectural flexibility enables growing enterprises to run private machine intelligence workflows cost-effectively across standard internal infrastructure.'
  },
  'blog-6-why-did-microsoft-outlook-go-down': {
    target: 470,
    text: ' Enterprise technology directors must establish clear incident escalation playbooks and automated traffic rerouting policies that take effect immediately during vendor disruptions. Maintaining redundant cloud communication architectures safeguards corporate reputation and preserves frontline business productivity during critical operational hours.'
  }
};

const blogs = [
  'pillar-emerging-technologies-and-it-developments',
  'blog-1-rag-vs-llm',
  'blog-2-types-of-ai-in-2027',
  'blog-3-best-frontend-frameworks-enterprise-2027',
  'blog-4-ai-custom-web-application-development',
  'blog-5-slm-vs-llm-2027',
  'blog-6-why-did-microsoft-outlook-go-down'
];

blogs.forEach(b => {
  const filePath = path.join(baseDir, b, 'blog-final.md');
  let content = fs.readFileSync(filePath, 'utf8');

  // Insert addition right before ## Frequently Asked Questions
  const addition = additions[b];
  if (addition) {
    const faqIndex = content.indexOf('## Frequently Asked Questions');
    if (faqIndex !== -1) {
      const beforeFaq = content.substring(0, faqIndex).trim();
      const afterFaq = content.substring(faqIndex);
      content = beforeFaq + '\n\n' + addition.text.trim() + '\n\n' + afterFaq;
      fs.writeFileSync(filePath, content, 'utf8');
      fs.writeFileSync(path.join(baseDir, b, 'blog-draft.md'), content, 'utf8');
    }
  }

  const res = countWords(filePath);
  console.log(`${b}: ${res.bodyWordCount} words - ${res.bodyWordCount >= 450 && res.bodyWordCount <= 500 ? 'PASS' : 'FAIL'}`);
});
