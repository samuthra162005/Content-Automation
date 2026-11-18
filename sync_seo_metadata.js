const fs = require('fs');
const path = require('path');
const base = 'd:/content/digital-marketing-skills/projects/kanavu-digital/2026-11-16';

const cluster = [
  {
    slug: 'pillar-top-digital-marketing-company-strategies-for-growth',
    keywords: [ 'digital marketing strategies for growth', 'enterprise digital marketing agency', 'full service marketing company', 'multi channel marketing ROI', 'performance digital marketing' ]
  },
  {
    slug: 'blog-1-how-to-use-claude-for-social-media-marketing',
    keywords: [ 'Claude AI social media captions', 'AI content calendar Claude', 'social media repurposing Claude', 'Claude AI marketing prompts', 'AI campaign ideas social' ]
  },
  {
    slug: 'blog-2-ai-agents-in-digital-marketing',
    keywords: [ 'marketing AI agents automation', 'autonomous marketing agents', 'AI competitor tracking marketing', 'automated marketing reports', 'AI lead qualification' ]
  },
  {
    slug: 'blog-3-fifa-world-cup-2026-marketing-campaigns',
    keywords: [ 'World Cup 2026 brand campaigns', 'sports marketing World Cup 2026', 'influencer marketing World Cup', 'real-time sports social campaigns', 'fan engagement World Cup 2026' ]
  },
  {
    slug: 'blog-4-what-is-google-e-e-a-t',
    keywords: [ 'experience expertise authoritativeness trustworthiness', 'Google E-E-A-T guidelines', 'E-E-A-T for SEO', 'demonstrate website trust Google', 'search quality rater guidelines' ]
  },
  {
    slug: 'blog-5-ai-generated-images-viral-marketers',
    keywords: [ 'viral AI images for marketers', 'ethical AI image marketing', 'AI image copyright for brands', 'brand authenticity AI visuals', 'generative AI digital campaigns' ]
  },
  {
    slug: 'blog-6-top-ppc-trends-of-2027',
    keywords: [ 'future of PPC advertising 2027', 'AI-powered paid search trends', 'first-party data PPC', 'multimodal search advertising', 'Performance Max optimization 2027' ]
  }
];

cluster.forEach(b => {
  const p = path.join(base, b.slug, 'seo-metadata.md');
  if (fs.existsSync(p)) {
    let content = fs.readFileSync(p, 'utf8');
    const kwString = b.keywords.map(k => '`' + k + '`').join(', ');
    content = content.replace(/\* \*\*Secondary Keywords:\*\* .*/, '* **Secondary Keywords:** ' + kwString);
    fs.writeFileSync(p, content, 'utf8');
    console.log('Updated seo-metadata.md for ' + b.slug);
  }
});

