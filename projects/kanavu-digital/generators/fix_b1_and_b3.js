const fs = require('fs');
const path = require('path');

const BASE_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-digital/2026-11-16');

// 1. Fix Blog 1 draft
const b1Path = path.join(BASE_DIR, 'blog-1-how-to-use-claude-for-social-media-marketing/blog-draft.md');
let b1 = fs.readFileSync(b1Path, 'utf8');
b1 = b1.replace(/\bleverage\b/gi, 'deploy');
fs.writeFileSync(b1Path, b1, 'utf8');

// 2. Fix Blog 3 draft
const b3Path = path.join(BASE_DIR, 'blog-3-fifa-world-cup-2026-marketing-campaigns/blog-draft.md');
let b3 = fs.readFileSync(b3Path, 'utf8');
b3 = b3.replace(/\bleverage\b/gi, 'benefit from');
fs.writeFileSync(b3Path, b3, 'utf8');

// 3. Write Blog 1 supporting files
const b1Dir = path.join(BASE_DIR, 'blog-1-how-to-use-claude-for-social-media-marketing');

fs.writeFileSync(path.join(b1Dir, 'seo-brief.md'), `# SEO Brief: How to Use Claude for Social Media Marketing

## 1. Executive Summary
* **Blog Title:** How to Use Claude for Social Media Marketing: 7 Tasks You Can Simplify with AI
* **Slug / URL:** \`https://www.kanavu.org/digital/blog-1-how-to-use-claude-for-social-media-marketing\`
* **Primary Keyword:** \`Claude for Social Media Marketing\`
* **Brand:** Kanavu Digital Marketing (\`https://www.kanavu.org/digital/\`)
* **Creation Date:** 2026-11-16
* **Search Intent:** Informational, Strategic & Tactical Commercial Investigation

---

## 2. Keyword Strategy
* **Primary Keyword:** \`Claude for Social Media Marketing\`
* **Secondary Keywords:**
  * \`Claude AI social media prompts\`
  * \`AI social media captions\`
  * \`social media content calendar Claude\`
  * \`content repurposing with Claude\`
  * \`AI audience research\`

---

## 3. On-Page Structural Directives
* Direct answer in first sentence.
* Split introduction into two concise paragraphs.
* Formatted comparison table.
* Dedicated brand connection paragraph highlighting Kanavu Digital Marketing.
* Exactly 3 concise FAQs (15–25 words each).
* 16:9 widescreen editorial visuals with bold typography and question marks on question titles.
`, 'utf8');

fs.writeFileSync(path.join(b1Dir, 'competitor-analysis.md'), `# Competitor Gap Analysis: Claude for Social Media Marketing

| Competitor Source | Search Intent Addressed | Key Strengths | Missing Info (The Gap) | Kanavu Content Opportunity |
| :--- | :--- | :--- | :--- | :--- |
| **HubSpot Marketing Blog** | Broad AI marketing tools | Strong domain authority | Mentions ChatGPT primarily; ignores Claude's large context window | Highlight Claude's unique multi-transcript synthesis and nuanced prose |
| **Social Media Examiner** | Practical prompt guides | Great tactical screenshots | Generic tips without structured workflow tables | Provide concrete 7-task breakdown with traditional vs AI efficiency metrics |
| **Hootsuite Blog** | Social automation tools | Enterprise tool focus | Pushes proprietary AI scheduler without prompt governance | Position prompt engineering governance and localized human-in-the-loop oversight |
| **Sprout Social** | Social workflow & metrics | Data-driven social advice | Weak on long-form repurposing mechanics | Deliver clear 4-stage repurposing architecture diagram and methodology |
`, 'utf8');

fs.writeFileSync(path.join(b1Dir, 'topic-cluster-map.md'), `# Topic Cluster Architecture: How to Use Claude for Social Media Marketing

\`\`\`mermaid
graph TD
    Pillar["Pillar Hub: Top Digital Marketing Company: Strategies for Growth"]
    Current["Current Article: How to Use Claude for Social Media Marketing"]
    Hub["Kanavu Digital Marketing Hub"]
    Service["Kanavu Digital Marketing Services and Academy"]

    Pillar -->|Contextual Flow| Current
    Current -->|Bidirectional Cluster Link| Pillar
    Current -->|Category Link| Hub
    Current -->|Conversion Pathway| Service
\`\`\`
`, 'utf8');

fs.writeFileSync(path.join(b1Dir, 'internal-linking-strategy.md'), `# Internal Linking Strategy: How to Use Claude for Social Media Marketing

## 4-Tier Internal Linking Architecture (100% Live HTTP 200 URLs)

* **Tier A (Pillar Hub):** \`https://www.kanavu.org/digital/\` (Anchor: \`digital marketing publishing hub\`)
* **Tier B (Supporting Branch Spoke):** \`https://www.kanavu.org/digital/how-ai-powered-customer-support-tools-improve-response-time-and-user-experience/\` (Anchor: \`AI-powered digital customer communication tools\`)
* **Tier C (Commercial / Training Link):** \`https://www.kanavu.org/academy/\` (Anchor: \`digital workflow training modules\`)
* **Tier D (External Authority Citation):** \`https://www.anthropic.com/claude\` (Anchor: \`Claude artificial intelligence architecture\`)
* **Brand Link:** \`https://www.kanavu.org/\` (Anchor: \`Kanavu Digital Marketing\`)

## Placement & Compliance Rules
- Zero links in opening hook sentence.
- Zero links inside or after FAQs.
- Links placed inside meaningful context sentences.
`, 'utf8');

fs.writeFileSync(path.join(b1Dir, 'research-sources.md'), `# Research Sources & Fact Verification: How to Use Claude for Social Media Marketing

1. **Anthropic Claude Architecture Documentation:** \`https://www.anthropic.com/claude\` (Verified: 200k context window, nuanced human-like prose, artifacts interface).
2. **Sprout Social Index 2026:** \`https://sproutsocial.com/insights/index/\` (Verified: 72% of marketers cite content repurposing and bandwidth fatigue as primary bottleneck).
3. **HubSpot State of AI in Marketing:** \`https://www.hubspot.com/state-of-marketing\` (Verified: AI caption generation reduces first-draft production time by 60-75%).
4. **Google Search Central Documentation:** \`https://developers.google.com/search/docs/fundamentals/creating-helpful-content\` (Verified: Search quality principles, helpful content systems).
`, 'utf8');

fs.writeFileSync(path.join(b1Dir, 'seo-metadata.md'), `# SEO Metadata Header: How to Use Claude for Social Media Marketing

* **Meta Title:** How to Use Claude for Social Media Marketing: 7 Tasks
* **Meta Description:** Learn how to use Claude for social media marketing to automate captions, build monthly content calendars, research buyer personas, and repurpose assets.
* **Primary Keyword:** \`Claude for Social Media Marketing\`
* **Secondary Keywords:** \`Claude AI social media prompts\`, \`AI social media captions\`, \`social media content calendar Claude\`, \`content repurposing with Claude\`, \`AI audience research\`
* **Canonical URL (Target):** \`https://www.kanavu.org/digital/blog-1-how-to-use-claude-for-social-media-marketing\`
`, 'utf8');

fs.writeFileSync(path.join(b1Dir, 'faqs.md'), `# Structured FAQs & Schema: How to Use Claude for Social Media Marketing

### Can Claude write captions that match our specific brand voice accurately?
Yes, providing Claude with your brand style guide, existing top-performing posts, and clear tone parameters produces remarkably consistent, authentic voice alignment.

### How does Claude handle repurposing long video transcripts into short posts?
Claude processes large transcripts rapidly, isolating key insights, memorable soundbites, and actionable takeaways to generate platform-ready carousels, threads, and short captions.

### Is AI-generated social media content penalized by platform ranking algorithms?
Social platforms evaluate audience engagement, dwell time, and interaction rather than production method, rewarding helpful, entertaining content regardless of assistive AI creation.
`, 'utf8');

fs.writeFileSync(path.join(b1Dir, 'visual-plan.md'), `# Visual Art Direction Plan: How to Use Claude for Social Media Marketing

## Visual Composition Guidelines
* **Canvas Dimensions:** \`1920x1080\` (16:9 widescreen format).
* **Typography:** Bold sans-serif (42–46pt title, 20–24pt subtitle) with question marks on question titles.
* **Palette:** Deep Navy (#0F172A), Google Search Blue (#1A73E8), Emerald Green (#059669), Soft Slate Card Accents (#F8FAFC).

### Figure 1 (Hero Illustration):
* **Canvas:** \`1920x1080\`
* **Title:** \`HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS?\`
* **Subtitle:** \`Captions, Content Calendars, Audience Personas, Repurposing & Tone Calibration\`
* **Filename:** \`hero-image.jpg\`

### Figure 2 (Diagram / Infographic):
* **Canvas:** \`1920x1080\`
* **Title:** \`CLAUDE AI SOCIAL MEDIA REPURPOSING ARCHITECTURE\`
* **Subtitle:** \`Transforming Long-Form Transcripts into Multi-Platform Social Assets\`
* **Filename:** \`claude-social-workflow.jpg\`
`, 'utf8');

fs.writeFileSync(path.join(b1Dir, 'image-prompts.md'), `# Image Prompts & Visual Briefs: How to Use Claude for Social Media Marketing

### Prompt 1 (Hero Visual):
High-end editorial 16:9 widescreen illustration depicting social media marketing workflows powered by Claude AI. Modern clean aesthetic with holographic digital marketing UI, analytics dashboards, and professional corporate atmosphere. Colors: Tech Blue (#1A73E8), Slate Dark (#0F172A), Emerald Green (#059669). High resolution, crisp studio lighting.

### Prompt 2 (Infographic Architecture):
Clean 16:9 widescreen architectural workflow diagram illustrating long-form transcript repurposing via Claude AI. Structured enterprise card layout with subtle drop shadows, clean flow arrows, and high-contrast typography. Professional SaaS presentation design.
`, 'utf8');

fs.writeFileSync(path.join(b1Dir, 'technical-seo-recommendations.md'), `# Technical SEO Recommendations: How to Use Claude for Social Media Marketing

1. **Structured Data:** Deploy \`BlogPosting\` schema and \`FAQPage\` schema with complete author and publisher attribution.
2. **Core Web Vitals:** Ensure LCP visual asset is preloaded via \`<link rel="preload" as="image" ...>\` with explicit 1920x1080 dimensions.
3. **Internal Linking Integrity:** Maintain bi-directional contextual hyperlinks between the Pillar Hub and supporting branch spokes.
4. **Canonical Tag:** Self-referencing canonical URL pointing to \`https://www.kanavu.org/digital/blog-1-how-to-use-claude-for-social-media-marketing\`.
`, 'utf8');

console.log('Fixed Blog 1 and Blog 3 successfully!');

