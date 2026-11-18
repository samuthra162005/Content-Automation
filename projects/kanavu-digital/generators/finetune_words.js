const fs = require('fs');
const path = require('path');

const BASE_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-digital/2026-11-16');

// 1. Pillar: add ~30 words
let pPath = path.join(BASE_DIR, 'pillar-top-digital-marketing-company-strategies-for-growth/blog-draft.md');
let pContent = fs.readFileSync(pPath, 'utf8');
pContent = pContent.replace(
  'Adhering to official [Google helpful content guidelines](https://developers.google.com/search/docs/fundamentals/creating-helpful-content) guarantees long-term search defensibility.',
  'Adhering to official [Google helpful content guidelines](https://developers.google.com/search/docs/fundamentals/creating-helpful-content) guarantees long-term search defensibility. By conducting deep audience research and mapping search queries across customer journeys, top agencies consistently construct resilient organic assets that turn casual searchers into high-intent inbound sales leads.'
);
fs.writeFileSync(pPath, pContent, 'utf8');

// 2. Blog 2: add ~30 words
let b2Path = path.join(BASE_DIR, 'blog-2-ai-agents-in-digital-marketing/blog-draft.md');
let b2Content = fs.readFileSync(b2Path, 'utf8');
b2Content = b2Content.replace(
  'integrating agentic perception-action loops enables lean marketing teams to operate with the technical efficiency of global enterprise corporations.',
  'integrating agentic perception-action loops enables lean marketing teams to operate with the technical efficiency of global enterprise corporations. These autonomous systems systematically analyze real-time bidding feedback, eliminate manual spreadsheet reconciliation, and safeguard promotional budgets against costly operational oversight.'
);
fs.writeFileSync(b2Path, b2Content, 'utf8');

// 3. Blog 3: currently 450 words, add ~20 words for safety
let b3Path = path.join(BASE_DIR, 'blog-3-fifa-world-cup-2026-marketing-campaigns/blog-draft.md');
let b3Content = fs.readFileSync(b3Path, 'utf8');
b3Content = b3Content.replace(
  'removing conversion friction during high-emotion sporting moments creates unforgettable consumer brand impressions.',
  'removing conversion friction during high-emotion sporting moments creates unforgettable consumer brand impressions that inspire passionate user advocacy and repeat product purchases long after the tournament ends.'
);
fs.writeFileSync(b3Path, b3Content, 'utf8');

// 4. Blog 4: add ~50 words
let b4Path = path.join(BASE_DIR, 'blog-4-what-is-google-e-e-a-t/blog-draft.md');
let b4Content = fs.readFileSync(b4Path, 'utf8');
b4Content = b4Content.replace(
  '1. **Experience (First-Hand Proof):** Demonstrating authentic, real-world engagement with the product, process, or problem discussed, through original photographs, personal experimentation, and honest practical lessons.',
  '1. **Experience (First-Hand Proof):** Demonstrating authentic, real-world engagement with the product, process, or problem discussed, through original photographs, personal experimentation, and honest practical lessons. Search raters prioritize genuine case studies that showcase practical troubleshooting over generic theoretical summaries.'
);
b4Content = b4Content.replace(
  'Google’s systems discount its overall quality score.',
  'Google’s systems discount its overall quality score. Prioritizing verified editorial authorship, transparent corrections, and verifiable organizational history ensures your digital content establishes permanent authority across competitive search verticals.'
);
fs.writeFileSync(b4Path, b4Content, 'utf8');

// 5. Blog 5: add ~50 words
let b5Path = path.join(BASE_DIR, 'blog-5-ai-generated-images-viral-marketers/blog-draft.md');
let b5Content = fs.readFileSync(b5Path, 'utf8');
b5Content = b5Content.replace(
  '1. **Brand Authenticity and Consumer Trust:** Overusing synthetic imagery can make your brand appear detached, superficial, or dishonest—especially in industries like hospitality, physical manufacturing, and food, where customers expect real photography.',
  '1. **Brand Authenticity and Consumer Trust:** Overusing synthetic imagery can make your brand appear detached, superficial, or dishonest—especially in industries like hospitality, physical manufacturing, and food, where customers expect real photography. Misrepresenting physical products with synthetic generation risks immediate customer returns and brand disillusionment.'
);
b5Content = b5Content.replace(
  'relying on verified human photography for core commercial products.',
  'relying on verified human photography for core commercial products. Establishing strict visual brand guidelines prevents stylistic inconsistencies and ensures creative experiments support rather than dilute core brand identity.'
);
fs.writeFileSync(b5Path, b5Content, 'utf8');

// 6. Blog 6: currently 511 words, reduce by ~25 words
let b6Path = path.join(BASE_DIR, 'blog-6-top-ppc-trends-of-2027/blog-draft.md');
let b6Content = fs.readFileSync(b6Path, 'utf8');
b6Content = b6Content.replace(
  'The top PPC trends of 2027 demand that digital marketers transition from manual keyword bidding and static ad copywriting toward orchestrating predictive machine-learning bidding models, privacy-preserving first-party data architectures, and multimodal search advertising. As search engines integrate conversational AI answer engines directly into search result pages, consumer inquiry behavior is shifting from short keyword queries to complex, multi-intent dialogues.',
  'The top PPC trends of 2027 require digital marketers to transition from manual keyword bidding toward predictive machine-learning bidding models, first-party data architectures, and multimodal search advertising. As conversational AI answer engines reshape search results, consumer behavior is shifting from short queries toward complex, multi-intent dialogues.'
);
b6Content = b6Content.replace(
  '7. **Privacy-Preserving Edge Conversion Modeling:** Conversion tracking will rely on on-device machine learning and server-side APIs to measure campaign performance without compromising individual consumer privacy.\n\nAs discussed in our operational guide on [multi-channel digital reach methodologies](https://www.kanavu.org/digital/how-seo-and-digital-marketing-help-kanavu-startup-expand-its-online-reach/), paid advertising success no longer belongs to those with the largest budgets, but to those with the cleanest first-party data pipelines.',
  '7. **Privacy-Preserving Conversion Modeling:** Conversion tracking will rely on server-side APIs to measure performance without compromising privacy.\n\nAs discussed in our guide on [multi-channel digital reach methodologies](https://www.kanavu.org/digital/how-seo-and-digital-marketing-help-kanavu-startup-expand-its-online-reach/), paid advertising success belongs to businesses with clean first-party data pipelines.'
);
fs.writeFileSync(b6Path, b6Content, 'utf8');

console.log('Fine-tuning script finished.');

