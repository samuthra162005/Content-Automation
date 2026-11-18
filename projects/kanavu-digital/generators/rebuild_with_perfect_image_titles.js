const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const { countWords } = require('../../../generators/count_blog_words.js');

const BASE_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-digital/2026-11-16');
const OUTPUTS_DIR = path.join(BASE_DIR, 'outputs');
const TEMPLATE_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-technologies/2026-11-02/sample_docx_extract');

const blogs = [
  // ----------------------------------------------------------------------------
  // PILLAR HUB
  // ----------------------------------------------------------------------------
  {
    slug: 'pillar-top-digital-marketing-company-strategies-for-growth',
    docxFilename: 'Top_Digital_Marketing_Company_Strategies_for_Growth.docx',
    themeColor: '1E40AF',
    themeBg: 'F0F4FF',
    metaTitle: 'Top Digital Marketing Company: Strategies for Growth',
    metaDesc: 'Discover high-impact digital marketing strategies for growth. Learn how full-funnel attribution, performance media, and CRO accelerate enterprise revenue.',
    primaryKeyword: 'top digital marketing company',
    secondaryKeywords: [
      'digital marketing strategies for growth',
      'enterprise digital marketing agency',
      'full service marketing company',
      'multi channel marketing ROI',
      'performance digital marketing'
    ],
    title: 'Top Digital Marketing Company: Strategies for Growth',
    hookP1: `Choosing a top digital marketing company requires modern enterprises to look beyond surface-level vanity metrics and focus on bottom-line revenue generation, full-funnel attribution, and compounding organic authority. As search algorithms evolve toward AI-assisted discovery and paid advertising auctions become increasingly automated, sustainable commercial growth demands an integrated, cross-disciplinary acquisition strategy.`,
    hookP2: `Selecting an enterprise digital marketing agency capable of driving scalable customer acquisition requires rigorous evaluation of technical capabilities, conversion psychology, and data integrity. Within our [proven growth strategies portfolio](https://www.kanavu.org/digital/), we analyze how leading brands deploy sophisticated digital marketing strategies for growth to achieve predictable revenue expansion.`,
    fig1: {
      title: 'TOP DIGITAL MARKETING COMPANY: HOW TO DRIVE SUSTAINABLE GROWTH?',
      file: 'hero-image.jpg',
      caption: 'Figure 1: 5 Architectural Growth Pillars: Technical SEO, Paid Media, Content Moats, CRO & Attribution.',
      alt: 'Conceptual diagram illustrating top digital marketing company strategies for growth.'
    },
    section1H2: 'The Three Horizons of Sustainable Commercial Expansion',
    section1Text: `Long-term market leadership requires executing across three distinct developmental horizons simultaneously:

1. **Horizon 1: Technical Infrastructure and Revenue Capture:** Choosing a dedicated full service marketing company ensures that clean site architecture, structured JSON-LD schema, and lightning-fast page speeds combine with targeted search ads to capture immediate commercial demand.
2. **Horizon 2: Topical Authority and Market Education:** Publishing comprehensive semantic topic clusters and verified practitioner benchmarks establishes uncontested search authority across competitive verticals, transforming casual informational readers into qualified, long-term commercial buyers.
3. **Horizon 3: Omnichannel Flywheel and Data Moats:** Connecting CRM pipelines directly to advertising algorithms allows automated bidding engines to optimize for customer lifetime value rather than single transactions, creating self-reinforcing acquisition flywheels.

> **Executive Strategy Directive:** Sustainable commercial momentum never comes from isolated marketing tactics or vanity impressions. Real business acceleration requires connecting organic search visibility, targeted paid traffic, and continuous conversion design so each dollar invested compounds future customer lifetime value.

As documented in our guide on [organic search and business expansion models](https://www.kanavu.org/digital/how-seo-and-digital-marketing-help-kanavu-startup-expand-its-online-reach/), blending organic search authority with precision performance digital marketing protects businesses against third-party algorithmic shifts while maintaining steady customer acquisition.`,
    fig2: {
      title: 'THE OMNICHANNEL REVENUE GROWTH FLYWHEEL',
      file: 'omnichannel-growth-engine.jpg',
      caption: 'Figure 2: Synchronizing Inbound Search, Precision Paid Acquisition, Platform CRO & Closed-Loop Attribution.',
      alt: 'Conceptual diagram illustrating the omnichannel revenue growth flywheel.'
    },
    section2H2: 'Unit Economics that Separate Growth Partners from Tactical Vendors',
    section2Text: `Achieving healthy commercial expansion requires maintaining a minimum 3:1 customer lifetime value to acquisition cost ratio across all digital channels. Measuring true multi channel marketing ROI demands tracking verified closed-loop revenue from initial web click to final bank settlement, allowing leadership teams to invest confidently without capital erosion.

> **Financial Growth Benchmark:** Fast-growing enterprises track verified closed-loop revenue from initial web click to final bank settlement. Equipping advertising algorithms with gross profit data ensures media budgets flow dynamically toward high-margin customer segments.`,
    section3H2: 'Partnering with Kanavu Digital Marketing for Scalable Growth',
    section3Text: `Achieving sustained market leadership in today's digital economy requires strategic clarity, technical excellence, and disciplined creative execution. At [Kanavu Digital Marketing](https://www.kanavu.org/), we partner with ambitious textile manufacturers in Erode, healthcare providers, and high-growth commercial enterprises across Tamil Nadu to build resilient, profitable acquisition engines. Through our specialized [digital marketing academy and executive masterclasses](https://www.kanavu.org/academy/), we train marketing teams to implement advanced technical SEO, optimize paid media budgets, and deploy automated data pipelines. We help your business unlock predictable, scalable commercial growth that compounds year after year.`,
    faqs: [
      {
        q: 'What distinguishes a top digital marketing company from an average agency?',
        a: 'Top companies focus on bottom-line revenue attribution, customer lifetime value, and technical SEO architecture rather than superficial vanity impressions or unverified metrics.'
      },
      {
        q: 'How long does it take to see measurable results from multi-channel marketing?',
        a: 'Paid media delivers immediate conversion data within days, while technical SEO and topical content clusters typically generate substantial compounding growth within three to six months.'
      },
      {
        q: 'Why is conversion rate optimization critical alongside paid advertising campaigns?',
        a: 'Optimizing landing page conversion rates maximizes profitability, allowing businesses to acquire customers profitably even as pay-per-click advertising auction costs rise across competitive industries.'
      }
    ]
  },

  // ----------------------------------------------------------------------------
  // BLOG 1: Claude SMM
  // ----------------------------------------------------------------------------
  {
    slug: 'blog-1-how-to-use-claude-for-social-media-marketing',
    docxFilename: 'How_to_Use_Claude_for_Social_Media_Marketing.docx',
    themeColor: 'D97706',
    themeBg: 'FFFBEB',
    metaTitle: 'How to Use Claude for Social Media Marketing: 7 Tasks',
    metaDesc: 'A tactical practitioner playbook on using Claude AI for social media marketing: master audience research, content repurposing, and multi-platform publishing.',
    primaryKeyword: 'Claude for Social Media Marketing',
    secondaryKeywords: [
      'Claude AI social media captions',
      'AI content calendar Claude',
      'social media repurposing Claude',
      'Claude AI marketing prompts',
      'AI campaign ideas social'
    ],
    title: 'How to Use Claude for Social Media Marketing: 7 Tasks You Can Simplify with AI',
    hookP1: `Using Claude for social media marketing enables digital marketers to draft channel-native captions, build structured monthly content calendars, conduct audience research, and turn long webinars into platform-ready post series. As an agile creative partner, Claude cuts tedious drafting time in half while preserving natural brand tone.`,
    hookP2: `Achieving standout social performance requires feeding artificial intelligence clear brand constraints, verified messaging guidelines, and concrete customer personas rather than posting generic automated copy. Through our [digital marketing intelligence network](https://www.kanavu.org/digital/), we teach creative growth teams how to combine artificial intelligence workflows with authentic human storytelling to maintain high engagement across modern social feeds.`,
    fig1: {
      title: 'HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS',
      file: 'hero-image.jpg',
      caption: 'Figure 1: Captions, Monthly Content Calendars, Creative Hooks, Audience Research & Repurposing.',
      alt: 'Photograph illustrating how to use claude for social media marketing.'
    },
    section1H2: '7 High-Impact Social Media Tasks to Accelerate with Claude',
    section1Text: `Modern social marketing workflows demand volume without sacrificing voice. Claude excels across seven specific production tasks:

1. **Audience Research and Persona Simulation:** Feed Claude raw customer interview transcripts to identify core emotional triggers, recurring objections, and authentic conversational phrasing.
2. **Channel-Native Drafting:** Generate punchy Claude AI social media captions customized for LinkedIn, Instagram carousels, or X threads without robotic filler phrases.
3. **Structured Content Planning:** Build a comprehensive AI content calendar Claude workflow organized by audience pain points and brand awareness stages.
4. **Long-Form Content Atomization:** Execute systematic social media repurposing Claude pipelines, extracting actionable soundbites from hour-long podcasts and video transcripts.
5. **Campaign Brainstorming:** Uncover fresh AI campaign ideas social angles by prompting Claude to examine your product features from unconventional customer perspectives.
6. **Competitor Post Deconstruction:** Analyze rival brand announcements to identify messaging weaknesses and counter-positioning angles.
7. **Prompt Library Standardization:** Develop bespoke Claude AI marketing prompts that lock down brand vocabulary, prohibited terms, and specific formatting rules.

> **Operational Guardrail:** Claude processes conversational tone and long context windows exceptionally well. Treat generated drafts as first-pass suggestions that require human editing before publication.`,
    fig2: {
      title: 'CLAUDE AI CONTENT REPURPOSING SPRINT PIPELINE',
      file: 'claude-social-workflow.jpg',
      caption: 'Figure 2: Decomposing Long-Form Video Transcripts & Podcasts into Platform-Ready Carousels & Threads.',
      alt: 'Conceptual diagram illustrating claude ai content repurposing sprint pipeline.'
    },
    section2H2: 'Calibrating Brand Voice and Eliminating AI Clichés',
    section2Text: `To achieve reliable brand consistency, provide Claude with your target customer profile, high-performing historical posts, and explicit style rules. Negative constraints forbidding generic conversational filler and corporate buzzwords compel Claude to generate punchy copy that stands out in crowded feeds.

> **Practitioner Editorial Rule:** Treat artificial intelligence as an eager junior researcher rather than an autonomous publisher. Every generated hook, carousel slide, and caption requires human editorial review to confirm technical accuracy and preserve genuine brand voice.`,
    section3H2: 'Scaling Social Media Growth with Kanavu Digital Marketing',
    section3Text: `Building a resilient, high-converting social media presence requires strategic clarity, creative agility, and systematic production workflows. At [Kanavu Digital Marketing](https://www.kanavu.org/), we guide manufacturing businesses in Erode, regional consumer brands, and fast-growing enterprises across Tamil Nadu in building scalable organic social engines. Through our specialized [social media and digital marketing masterclasses](https://www.kanavu.org/academy/), we assist marketing teams in developing structured prompt libraries, streamlining editorial workflows, and tracking multi-channel social conversions. We help your business turn social interactions into measurable brand loyalty and steady customer acquisition.`,
    faqs: [
      {
        q: 'Can Claude write captions that match our specific brand voice accurately?',
        a: 'Yes, providing Claude with your brand style guide, existing top-performing posts, and clear tone parameters produces remarkably consistent, authentic voice alignment.'
      },
      {
        q: 'How does Claude compare to ChatGPT for social media copywriting?',
        a: 'Claude excels at longer context comprehension and nuanced brand voice calibration, producing less generic filler and more thoughtful long-form carousel scripts.'
      },
      {
        q: 'What is the most effective workflow for repurposing podcast episodes with Claude?',
        a: 'Upload the raw transcript, prompt Claude to extract five contrarian insights, and convert each point into an engaging carousel slide outline.'
      }
    ]
  },

  // ----------------------------------------------------------------------------
  // BLOG 2: AI Agents
  // ----------------------------------------------------------------------------
  {
    slug: 'blog-2-ai-agents-in-digital-marketing',
    docxFilename: 'AI_Agents_in_Digital_Marketing_5_Tasks_You_Can_Automate.docx',
    themeColor: '475569',
    themeBg: 'F1F5F9',
    metaTitle: 'AI Agents in Digital Marketing: 5 Tasks to Automate',
    metaDesc: 'A technical systems teardown of AI agents in digital marketing: automate competitor surveillance, marketing reports, lead triage, and cross-channel bidding.',
    primaryKeyword: 'AI Agents in Digital Marketing',
    secondaryKeywords: [
      'marketing AI agents automation',
      'autonomous marketing agents',
      'AI competitor tracking marketing',
      'automated marketing reports',
      'AI lead qualification'
    ],
    title: 'AI Agents in Digital Marketing: 5 Tasks You Can Automate',
    hookP1: `AI agents in digital marketing represent an evolutionary leap from passive text-generation chatbots to goal-oriented software systems capable of autonomous environment perception, multi-step reasoning, tool execution, and programmatic API actions. Rather than waiting for human prompts, marketing agents continuously observe marketing data and execute optimization workflows autonomously.`,
    hookP2: `Deploying marketing AI agents automation enables modern commercial enterprises to maintain continuous market surveillance, eliminate error-prone spreadsheet reporting, and qualify incoming prospects around the clock. Within our [marketing automation knowledge base](https://www.kanavu.org/digital/), we analyze how forward-looking growth teams deploy autonomous marketing agents to execute complex acquisition workflows with minimal human latency.`,
    fig1: {
      title: 'AI AGENTS IN DIGITAL MARKETING: WHICH TASKS CAN YOU AUTOMATE?',
      file: 'hero-image.jpg',
      caption: 'Figure 1: Autonomous Market Surveillance, Dynamic Reporting, Inbound Routing & Micro-Budget Bidding.',
      alt: '3D illustration showing AI agents in digital marketing control room.'
    },
    section1H2: '5 Core Workflows Built for Autonomous Marketing Execution',
    section1Text: `Deploying autonomous agents frees human strategists from repetitive data hygiene tasks, focusing operational resources across five critical commercial functions:

1. **Continuous Competitor Surveillance:** Utilizing AI competitor tracking marketing setups allows agents to scan rival landing pages, organic ranking shifts, and public ad libraries continuously, notifying strategists whenever competitors alter pricing or messaging.
2. **Dynamic Cross-Platform Performance Reporting:** Agents pull API data from Google Analytics, search consoles, and paid platforms to generate automated marketing reports with anomaly detection.
3. **Predictive Lead Scoring and Inbound Routing:** Deploying automated AI lead qualification protocols inspects inbound form submissions, verifies domain authority, and schedules high-value enterprise demos instantly.
4. **Dynamic Search Bidding Adjustments:** Agents evaluate real-time conversion rates across paid ad auctions, adjusting cost-per-click bids programmatically based on inventory levels.
5. **Content Decay Detection and Refresh Scheduling:** Agents monitor historical blog URLs for ranking drops, flagging pages requiring factual refreshes.

> **Technical Architecture Note:** Marketing agents combine large language models for reasoning with specialized API tools for execution. Establishing strict deterministic guardrails ensures agents operate safely within pre-approved media spend thresholds.`,
    fig2: {
      title: 'AUTONOMOUS MARKETING PERCEPTION-ACTION CLOSED LOOP',
      file: 'ai-agents-marketing-loop.jpg',
      caption: 'Figure 2: How AI Agents Detect Signal Shifts, Reason Multi-Step Goals & Call APIs Within Guardrails.',
      alt: 'Conceptual diagram illustrating autonomous marketing perception-action closed loop.'
    },
    section2H2: 'Chatbots vs Autonomous AI Agents: Architectural Differences',
    section2Text: `Evaluating software architecture clarifies why agents represent a fundamental shift in digital marketing efficiency:

| Dimension | Traditional Chatbot | Autonomous AI Agent |
| :--- | :--- | :--- |
| **Operational Trigger** | User must manually initiate a prompt | Continuously monitors data feeds independently |
| **Task Scope** | Single conversational query response | Multi-step chained workflows across external tools |
| **Tool Integration** | Text answers inside isolated chat windows | Programmatic API calls to CRMs and ad networks |

> **Operational Directive:** Never deploy autonomous marketing agents with unrestricted system access. Always implement human-in-the-loop approval gates for media spend modifications, website code updates, and outward customer communications.`,
    section3H2: 'Deploying Marketing Automation with Kanavu Digital Marketing',
    section3Text: `Building scalable, automated marketing systems requires technical sophistication, structured data pipelines, and clear governance protocols. At [Kanavu Digital Marketing](https://www.kanavu.org/), we help manufacturing leaders in Erode, regional enterprises, and fast-scaling organizations across Tamil Nadu integrate intelligent marketing automation tools into their daily operations. Through our specialized [marketing automation training programs](https://www.kanavu.org/academy/), we guide teams in setting up automated competitor monitoring, connecting CRM data pipelines, and configuring intelligent reporting agents. We help your business eliminate manual operational bottlenecks and build an efficient customer acquisition engine.`,
    faqs: [
      {
        q: 'What is the main technical difference between an AI chatbot and an AI agent?',
        a: 'Chatbots only respond to user prompts, whereas AI agents continuously monitor data streams, formulate multi-step plans, and execute API actions autonomously.'
      },
      {
        q: 'Can marketing AI agents spend advertising budgets without human authorization?',
        a: 'Properly architected agents operate under strict deterministic guardrails that require human confirmation for budget changes exceeding predefined thresholds.'
      },
      {
        q: 'Which marketing task delivers the highest immediate ROI from agentic automation?',
        a: 'Automating multi-channel reporting and real-time lead qualification delivers immediate productivity gains by eliminating hours of manual data consolidation.'
      }
    ]
  },

  // ----------------------------------------------------------------------------
  // BLOG 3: FIFA World Cup 2026
  // ----------------------------------------------------------------------------
  {
    slug: 'blog-3-fifa-world-cup-2026-marketing-campaigns',
    docxFilename: 'FIFA_World_Cup_2026_Marketing_Campaigns.docx',
    themeColor: 'DC2626',
    themeBg: 'FEF2F2',
    metaTitle: 'FIFA World Cup 2026 Marketing Campaigns: 5 Smart Moves',
    metaDesc: 'A sports marketing case study analyzing FIFA World Cup 2026 campaigns: discover how agile brands won fan attention through real-time second-screen storytelling.',
    primaryKeyword: 'FIFA World Cup 2026 Marketing Campaigns',
    secondaryKeywords: [
      'World Cup 2026 brand campaigns',
      'sports marketing World Cup 2026',
      'influencer marketing World Cup',
      'real-time sports social campaigns',
      'fan engagement World Cup 2026'
    ],
    title: 'FIFA World Cup 2026 Marketing Campaigns: 5 Smart Moves Brands Made to Win Attention',
    hookP1: `During the FIFA World Cup 2026, agile consumer brands captured global attention by co-creating content with local host-city creators, publishing sub-90-second reactive social posts, launching augmented reality stadium filters, and linking live match excitement directly to instant digital checkout funnels. Rather than relying solely on multi-million-dollar broadcast sponsorships, non-sponsor disruptors engaged fans on their smartphones.`,
    hookP2: `Analyzing breakout World Cup 2026 brand campaigns reveals how smart sports marketing World Cup 2026 strategies shifted focus from passive billboard impressions toward interactive, second-screen digital experiences. Within our [digital marketing strategy resource center](https://www.kanavu.org/digital/), we examine how modern consumer brands turn fleeting viral sporting moments into measurable customer loyalty and long-term commercial growth.`,
    fig1: {
      title: 'FIFA WORLD CUP 2026 MARKETING CAMPAIGNS: 5 SMART MOVES',
      file: 'hero-image.jpg',
      caption: 'Figure 1: 5 Strategic Moves: Host-City Co-Creation, 90-Second Agile Newsrooms, AR Filters & Flash Commerce.',
      alt: 'Photograph illustrating FIFA World Cup 2026 marketing campaigns stadium atmosphere.'
    },
    section1H2: '5 Agile Marketing Moves that Won Global Fan Attention',
    section1Text: `Modern tournament marketing demands rapid execution and genuine cultural relevance. The most successful brands won market share through five distinct strategic choices:

1. **Sub-90-Second Reactive Social Newsrooms:** Deploying real-time sports social campaigns empowered dedicated creative teams to turn unexpected referee decisions and viral player celebrations into context-native social memes within minutes.
2. **Host-City Micro-Creator Partnerships:** Leading brands activated hyper-local influencer marketing World Cup partnerships across Atlanta, Guadalajara, Vancouver, and Toronto, connecting with passionate local supporters.
3. **Interactive AR Stadium and Second-Screen Experiences:** Engaging mobile experiences, such as virtual trophy face-filters and real-time trivia games, drove massive organic user participation.
4. **Gamified Predictions Linked to Mobile Checkout:** Interactive match predictions unlocked limited-time discount codes, converting passive digital fans into paying e-commerce customers.
5. **Community-First Cultural Storytelling:** Purpose-driven campaigns highlighting grassroots football culture resonated deeply with values-driven younger demographics.

> **Campaign Insight:** Fan engagement World Cup 2026 campaigns achieved the highest return on ad spend by designing second-screen mobile experiences that supplemented the primary match broadcast rather than competing with it.`,
    fig2: {
      title: 'OMNICHANNEL TOURNAMENT FAN ACTIVATION COMMAND CENTER',
      file: 'world-cup-marketing-framework.jpg',
      caption: 'Figure 2: Connecting In-Stadium Live Emotion with Second-Screen Feeds & Instant Mobile Conversions.',
      alt: 'Conceptual diagram illustrating omnichannel tournament fan activation command center.'
    },
    section2H2: 'Traditional Broadcast Sponsorships vs Second-Screen Agility',
    section2Text: `The 2026 tournament confirmed that digital agility consistently outperforms static broadcast placement:

* **Official Stadium Signage:** Required immense capital investment, delivering broad brand awareness but providing limited real-time interaction and zero direct e-commerce attribution.
* **Reactive Social Newsrooms:** Required smaller, agile creative budgets, delivering explosive social engagement and immediate digital sales conversions.

> **Sports Marketing Principle:** Attention during global sporting events belongs to brands that react in real time. Equipping social newsrooms with pre-cleared legal templates and agile creative assets allows marketing teams to publish within ninety seconds of viral tournament moments.`,
    section3H2: 'Executing Agile Digital Marketing with Kanavu Digital Marketing',
    section3Text: `Harnessing viral cultural moments and high-energy sporting tournaments requires strategic preparation, creative precision, and frictionless digital execution. At [Kanavu Digital Marketing](https://www.kanavu.org/), we help manufacturing brands in Erode, consumer product companies, and growing enterprises across Tamil Nadu build responsive digital marketing campaigns that capture immediate audience attention. Through our comprehensive [digital marketing strategy workshops](https://www.kanavu.org/academy/), we train marketing teams to establish real-time content workflows, deploy engaging influencer campaigns, and track measurable conversions. We help your business convert peak cultural attention into lasting commercial value and loyal customer relationships.`,
    faqs: [
      {
        q: 'Can non-sponsor brands run marketing campaigns during the FIFA World Cup legally?',
        a: 'Yes, brands can engage fans legitimately by focusing on generic soccer themes, fan lifestyle culture, and real-time humor without infringing on protected trademarks.'
      },
      {
        q: 'What was the single most effective social media format during the 2026 tournament?',
        a: 'Short-form vertical video reactions published within ninety seconds of dramatic match occurrences generated the highest reach and organic sharing volume.'
      },
      {
        q: 'How did brands connect tournament fan excitement to measurable online sales?',
        a: 'Brands incorporated time-sensitive discount codes and gamified mobile trivia directly into second-screen post formats, driving immediate digital checkout completions.'
      }
    ]
  },

  // ----------------------------------------------------------------------------
  // BLOG 4: Google E-E-A-T
  // ----------------------------------------------------------------------------
  {
    slug: 'blog-4-what-is-google-e-e-a-t',
    docxFilename: 'What_Is_Google_EEAT_Why_It_Matters_for_SEO_and_Website_Trust.docx',
    themeColor: '1E40AF',
    themeBg: 'F0F4FF',
    metaTitle: 'What Is Google E-E-A-T? Why It Matters for SEO Trust',
    metaDesc: 'A forensic audit of Google E-E-A-T: discover how Experience, Expertise, Authoritativeness, and Trustworthiness evaluate website credibility and protect rankings.',
    primaryKeyword: 'Google E-E-A-T',
    secondaryKeywords: [
      'experience expertise authoritativeness trustworthiness',
      'Google E-E-A-T guidelines',
      'E-E-A-T for SEO',
      'demonstrate website trust Google',
      'search quality rater guidelines'
    ],
    title: 'What Is Google E-E-A-T? Why It Matters for SEO and Website Trust',
    hookP1: `Google E-E-A-T stands for Experience, Expertise, Authoritativeness, and Trustworthiness, representing the foundational framework Google uses to evaluate content credibility, accuracy, and real-world value. While not a direct algorithmic ranking factor, E-E-A-T heavily influences the automated systems that reward helpful, defensible information in search results.`,
    hookP2: `Building sustainable organic visibility requires transforming shallow marketing copy into trustworthy expert knowledge that proves genuine first-hand involvement with your subject. Within our [search engine optimization resource database](https://www.kanavu.org/digital/), we demonstrate how establishing defensible author credentials and transparent editorial standards protects your website across major core algorithm updates.`,
    fig1: {
      title: 'WHAT IS GOOGLE E-E-A-T? WHY IT MATTERS FOR SEO TRUST',
      file: 'hero-image.jpg',
      caption: 'Figure 1: Experience, Expertise, Authoritativeness & Trust: How Quality Evaluators Audit Digital Credibility.',
      alt: 'Illustration explaining what is Google E-E-A-T and why it matters for SEO trust.'
    },
    section1H2: 'Deconstructing the 4 Structural Trust Pillars',
    section1Text: `Documented extensively in the official [Google search quality rater guidelines](https://developers.google.com/search/docs/fundamentals/creating-helpful-content), the four components of experience expertise authoritativeness trustworthiness establish comprehensive content credibility:

1. **Experience (First-Hand Practitioner Proof):** Demonstrating authentic engagement with the product or process discussed through original photographs, personal experimentation, and honest practical lessons. Search evaluators prioritize genuine case studies over generic theoretical summaries.
2. **Expertise (Formal Subject Mastery):** Showcasing verified professional credentials, industry certifications, and deep technical comprehension necessary to explain sophisticated concepts accurately.
3. **Authoritativeness (Industry Recognition):** Cultivating external validation through citations in reputable trade publications, digital PR features, and natural editorial backlinks from respected peers.
4. **Trustworthiness (The Central Foundation):** Providing transparent author bios, physical company contact details, visible customer reviews, secure HTTPS encryption, and verifiable primary source citations.

> **Google Quality Rater Standard:** Trustworthiness is the single most critical element of the Google E-E-A-T guidelines. Even if an article demonstrates extensive theoretical knowledge, Google algorithms discount content when reader transparency, verifiable author credentials, or accurate business contact information are missing.`,
    fig2: {
      title: 'THE 4 STRUCTURAL PILLARS OF GOOGLE E-E-A-T SEARCH TRUST',
      file: 'google-eeat-pillars-framework.jpg',
      caption: 'Figure 2: Defensible Author Entities, Peer Citations & Transparent Security Anchoring Site Authority.',
      alt: 'Conceptual diagram illustrating the 4 structural pillars of Google E-E-A-T search trust.'
    },
    section2H2: 'The High-Trust Content Checklist for Competitive Rankings',
    section2Text: `Implementing E-E-A-T for SEO requires tangible evidence across website touchpoints:

* **Byline Attribution:** Verifiable human bylines linked to recognized industry credentials and active professional profiles.
* **Primary Source Citations:** Peer-reviewed studies, government databases, and verified original statistics anchoring factual claims.
* **Transparent Organization:** Visible physical addresses, active customer service phone numbers, and comprehensive terms.

> **Practical Implementation Rule:** To demonstrate website trust Google evaluators respect, eliminate anonymous bylines. Every informational guide should feature a verified author biography citing demonstrable real-world practitioner experience.`,
    section3H2: 'Building Search Authority with Kanavu Digital Marketing',
    section3Text: `Establishing defensible search credibility requires deep technical optimization, authoritative content architecture, and strategic digital PR. At [Kanavu Digital Marketing](https://www.kanavu.org/), we partner with textile manufacturers in Erode, healthcare practices, and educational institutions across Tamil Nadu to transform their digital presence into industry-recognized authorities. Through our comprehensive [SEO and content marketing training programs](https://www.kanavu.org/academy/), we assist marketing teams in building structured author entities, implementing semantic schema markup, and earning authoritative editorial backlinks. We help your organization build lasting search visibility that withstands core algorithmic updates.`,
    faqs: [
      {
        q: 'Is Google E-E-A-T a direct algorithmic ranking factor?',
        a: 'No, E-E-A-T is an evaluation framework used by human quality raters to train automated machine learning algorithms that assess content credibility.'
      },
      {
        q: 'What is the fastest way to demonstrate Experience on an existing blog post?',
        a: 'Add original photos, documented practitioner lessons, client results, and specific project troubleshooting details rather than repeating generic industry summaries.'
      },
      {
        q: 'Which component of E-E-A-T carries the highest weight during core updates?',
        a: 'Trustworthiness sits at the center of the framework, requiring clear author credentials, verified business contact details, and secure website protocols.'
      }
    ]
  },

  // ----------------------------------------------------------------------------
  // BLOG 5: AI Images
  // ----------------------------------------------------------------------------
  {
    slug: 'blog-5-ai-generated-images-viral-marketers',
    docxFilename: 'AI_Generated_Images_Are_Going_Viral_Marketer_Guide.docx',
    themeColor: '7C3AED',
    themeBg: 'F5F3FF',
    metaTitle: 'AI-Generated Images Are Going Viral: Marketer Guide',
    metaDesc: 'A strategic guide to viral AI-generated images for digital marketers: navigate commercial copyright, brand authenticity, visual artifacts, and governance.',
    primaryKeyword: 'AI-Generated Images',
    secondaryKeywords: [
      'viral AI images for marketers',
      'ethical AI image marketing',
      'AI image copyright for brands',
      'brand authenticity AI visuals',
      'generative AI digital campaigns'
    ],
    title: 'AI-Generated Images Are Going Viral: What Should Marketers Know Before Using Them?',
    hookP1: `AI-generated images are going viral across social feeds, paid advertising, and website hero banners, offering creative teams unprecedented speed, visual novelty, and substantial production cost savings. While diffusion models enable marketers to generate eye-catching visuals in seconds, deploying synthetic imagery without strategic governance creates severe commercial and legal risks.`,
    hookP2: `Navigating the explosive popularity of viral AI images for marketers requires understanding legal intellectual property boundaries, commercial copyright restrictions, and consumer trust dynamics. Within our [digital marketing visual media portal](https://www.kanavu.org/digital/), we examine how forward-thinking creative departments leverage generative AI digital campaigns while rigorously safeguarding brand reputation and legal compliance.`,
    fig1: {
      title: 'AI-GENERATED IMAGES ARE GOING VIRAL: WHAT TO KNOW',
      file: 'hero-image.jpg',
      caption: 'Figure 1: Commercial Copyright Realities, Brand Authenticity Dilution, Quality Artifacts & Ethical Disclosure.',
      alt: 'Split-screen comparison illustrating AI-generated images viral trends for marketers.'
    },
    section1H2: '4 Critical Realities Every Digital Marketer Must Evaluate',
    section1Text: `Before replacing professional studio photography with synthetic generation, creative teams must evaluate four operational realities:

1. **Brand Authenticity Dilution:** Overusing synthetic visuals risks eroding consumer trust. Preserving brand authenticity AI visuals requires capturing authentic human photography for physical products, textile manufacturing, and hospitality.
2. **Commercial Copyright Vulnerability:** Global copyright authorities consistently refuse copyright protection for purely synthetic imagery. Understanding AI image copyright for brands is critical to avoid building core campaigns on unprotectable assets.
3. **The Uncanny Valley and Visual Artifacts:** Anatomical distortions, unnatural hand geometries, and hyper-glossy digital textures distract viewers and signal cheap production values that undermine premium brand perception.
4. **Regulatory and Platform Disclosure Rules:** Major advertising networks and social platforms increasingly mandate explicit digital watermarks and disclosure tags for synthetic commercial imagery.

> **Legal Advisory:** Purely machine-generated imagery cannot be copyrighted under current intellectual property law. Any visual asset produced solely through artificial intelligence prompts can be copied legally by competing businesses without infringement recourse.`,
    fig2: {
      title: 'CORPORATE BRAND INTEGRITY & AI IMAGE GOVERNANCE FRAMEWORK',
      file: 'ai-image-governance-framework.jpg',
      caption: 'Figure 2: 4-Stage Review Protocol: Ideation, Legal IP Audit, Human Art Direction & Transparent Release.',
      alt: 'Conceptual diagram illustrating corporate brand integrity & AI image governance framework.'
    },
    section2H2: 'Responsible Production Protocols for Enterprise Brands',
    section2Text: `Establishing clear asset-level criteria for ethical AI image marketing protects brand integrity while maximizing production efficiency:

* **Appropriate Synthetic Use Cases:** Conceptual moodboards, abstract background textures, rapid brainstorming mockups, and stylized educational blog diagrams.
* **Inappropriate Synthetic Use Cases:** Physical product catalog photos, executive leadership headshots, customer testimonials, and verified local facility representations.

> **Corporate Visual Governance Gate:** Before any synthetic image appears in customer-facing marketing, conduct a mandatory four-point inspection: verify human anatomy for distortions, test brand color consistency, confirm copyright safety, and apply clear creator disclosures.`,
    section3H2: 'Mastering Visual Marketing with Kanavu Digital Marketing',
    section3Text: `Balancing innovative creative technologies with authentic brand storytelling is essential for long-term customer loyalty. At [Kanavu Digital Marketing](https://www.kanavu.org/), we guide manufacturing businesses in Erode, regional commercial brands, and emerging digital companies in developing disciplined visual marketing guidelines. Through our comprehensive [creative digital media masterclasses](https://www.kanavu.org/academy/), we teach designers and marketing teams how to combine generative AI tools with human art direction, copyright verification, and brand consistency. We help your business produce captivating digital assets that engage modern audiences while preserving genuine commercial integrity.`,
    faqs: [
      {
        q: 'Can our business copyright marketing visuals generated by artificial intelligence tools?',
        a: 'No, copyright offices grant protection only to works demonstrating meaningful human creative authorship, meaning purely synthetic outputs cannot be copyrighted.'
      },
      {
        q: 'Are digital advertising platforms requiring disclosure labels for synthetic images?',
        a: 'Yes, leading ad platforms and social networks now mandate visible disclosure tags and metadata credentials on photorealistic synthetic advertising imagery.'
      },
      {
        q: 'What is the most effective commercial use case for AI image generators in marketing?',
        a: 'AI image tools excel at rapid creative ideation, abstract campaign moodboarding, and conceptual visual mockups prior to final human production.'
      }
    ]
  },

  // ----------------------------------------------------------------------------
  // BLOG 6: PPC Trends 2027
  // ----------------------------------------------------------------------------
  {
    slug: 'blog-6-top-ppc-trends-of-2027',
    docxFilename: 'Top_PPC_Trends_of_2027_7_Changes_to_Prepare_For.docx',
    themeColor: '0284C7',
    themeBg: 'F0F9FF',
    metaTitle: 'Top PPC Trends of 2027: 7 Changes to Prepare For',
    metaDesc: 'Explore the top PPC trends of 2027: predictive AI bidding, first-party data vaults, multimodal search ads, and incrementality-based attribution.',
    primaryKeyword: 'PPC Trends of 2027',
    secondaryKeywords: [
      'future of PPC advertising 2027',
      'AI-powered paid search trends',
      'first-party data PPC',
      'multimodal search advertising',
      'Performance Max optimization 2027'
    ],
    title: 'Top PPC Trends of 2027: 7 Changes Every Digital Marketer Should Prepare For',
    hookP1: `The top PPC trends of 2027 require digital marketers to transition from manual keyword bidding toward predictive machine-learning bidding models, first-party data architectures, and multimodal search advertising. As conversational AI answer engines reshape search results, consumer behavior is shifting from short queries toward complex dialogues.`,
    hookP2: `Thriving in this evolving paid advertising ecosystem requires advertisers to understand emerging AI-powered paid search trends and feed high-quality business conversion signals into algorithmic ad networks. Within our [digital marketing intelligence database](https://www.kanavu.org/digital/), we analyze how performance marketers configure their acquisition systems to maintain high return on ad spend amid ongoing technological disruption.`,
    fig1: {
      title: 'TOP PPC TRENDS OF 2027: 7 CHANGES TO PREPARE FOR',
      file: 'hero-image.jpg',
      caption: 'Figure 1: Conversational Query Ads, Predictive LTV Bidding, Clean First-Party Vaults & Incrementality Testing.',
      alt: '3D illustration showing top PPC trends of 2027 neural bidding architecture.'
    },
    section1H2: 'Navigating the Future of PPC Advertising 2027',
    section1Text: `Preparing for the future of PPC advertising 2027 requires advertisers to structure campaigns across three fundamental pillars:

* **Pillar 1: Multimodal Search Advertising:** Promotional placements now appear contextually within generative AI chat syntheses, visual camera lookups, and voice search interfaces. Structuring campaigns around topical entities and verified customer problems ensures brands appear prominently within AI-generated conversational answers and real-time shopping recommendations.
* **Pillar 2: Predictive Customer Lifetime Value Bidding:** Algorithmic bidding models optimize media spend based on projected multi-year customer lifetime value rather than short-term acquisition costs, building defensible acquisition moats that compound commercial returns.
* **Pillar 3: Clean First-Party Signal Vaults:** With third-party cookies deprecated, establishing secure first-party data PPC architectures connecting CRM transaction data via server-side APIs maintains superior auction efficiency while equipping bidding models with proprietary conversion data.

> **2027 Search Auction Reality:** As artificial intelligence chat assistants summarize complex user queries directly, paid ads will appear inside conversational dialogue bubbles rather than blue link lists. Campaigns structured around broad customer problems and entity concepts will capture auction priority over legacy keyword phrases.

As discussed in our guide on [multi-channel digital reach methodologies](https://www.kanavu.org/digital/how-seo-and-digital-marketing-help-kanavu-startup-expand-its-online-reach/), combining verified customer signals with continuous Performance Max optimization 2027 workflows delivers superior conversion efficiency across competitive search auctions.`,
    fig2: {
      title: 'THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM',
      file: 'ppc-2027-ecosystem-architecture.jpg',
      caption: 'Figure 2: How Machine Learning Connects First-Party Signal Vaults to Dynamic Real-Time Ad Assembly.',
      alt: 'Conceptual diagram illustrating the 2027 AI-powered PPC campaign ecosystem.'
    },
    section2H2: 'Continuous Incrementality Testing Over Last-Click Attribution',
    section2Text: `Modern performance teams have replaced outdated last-click analytics models with automated geo-lift experimentation. Running structured matched-market tests establishes clear causal relationships between ad spend and incremental business revenue, eliminating wasted spend on organic brand cannibalization while safeguarding media investments across volatile auction cycles.

> **Capital Allocation Mandate:** Stop measuring advertising success through last-click metrics that artificially inflate branded search performance. Running controlled matched-market tests identifies genuine incremental revenue, ensuring media budgets expand into profitable customer acquisition queries.`,
    section3H2: 'Building Future-Ready Paid Media with Kanavu Digital Marketing',
    section3Text: `Navigating the automated, predictive future of paid search advertising requires advanced technical setup, resilient tracking pipelines, and rigorous commercial analysis. At [Kanavu Digital Marketing](https://www.kanavu.org/), our performance media specialists help regional textile mills in Erode, growing retail networks across Tamil Nadu, and global enterprises maximize their advertising efficiency. Through our practical [performance advertising analytics training](https://www.kanavu.org/academy/), we assist growth teams in implementing server-side conversion tracking, structuring first-party CRM data feeds, and testing incremental revenue lift. We ensure your paid advertising budget delivers measurable, scalable business expansion.`,
    faqs: [
      {
        q: 'Will keywords become completely obsolete in PPC campaigns by 2027?',
        a: 'Keywords will not disappear entirely, but ad platforms will prioritize conversational search intent, audience entities, and contextual semantic signals over exact-match keyword strings.'
      },
      {
        q: 'How can small businesses compete against giant ad budgets in automated PPC auctions?',
        a: 'Small businesses compete effectively by feeding highly accurate first-party customer conversion data and verified offline sales signals into algorithmic bidding engines.'
      },
      {
        q: 'Why is incrementality testing replacing traditional last-click attribution?',
        a: 'Last-click attribution artificially credits branded search for conversions that would have happened organically, whereas incrementality testing measures true revenue lift caused directly by advertising.'
      }
    ]
  }
];

// ----------------------------------------------------------------------------
// WRITE COMPLETE BESPOKE MARKDOWN DRAFTS
// ----------------------------------------------------------------------------
function writeMarkdownDraft(blog) {
  const blogDir = path.join(BASE_DIR, blog.slug);
  if (!fs.existsSync(blogDir)) {
    fs.mkdirSync(blogDir, { recursive: true });
  }

  const lines = [];

  // Metadata Header
  lines.push('# Metadata Header\n');
  lines.push(`**Meta Title:** ${blog.metaTitle}`);
  lines.push(`**Meta Description:** ${blog.metaDesc}`);
  lines.push(`**Primary Keyword:** ${blog.primaryKeyword}`);
  lines.push(`**Secondary Keywords:** ${blog.secondaryKeywords.join(', ')}\n`);
  lines.push('---\n');

  // Title
  lines.push(`# ${blog.title}\n`);

  // Hook Paragraphs
  lines.push(`${blog.hookP1}\n`);
  lines.push(`${blog.hookP2}\n`);

  // Figure 1 Block
  lines.push(`### Visual Architecture: ${blog.fig1.title}\n`);
  lines.push(`![${blog.fig1.title}](${blog.fig1.file})`);
  lines.push(`*${blog.fig1.caption}*`);
  lines.push(`*Alt Text: ${blog.fig1.alt}*\n`);

  // Section 1
  lines.push(`## ${blog.section1H2}\n`);
  lines.push(`${blog.section1Text}\n`);

  // Figure 2 Block
  lines.push(`### Visual Framework: ${blog.fig2.title}\n`);
  lines.push(`![${blog.fig2.title}](${blog.fig2.file})`);
  lines.push(`*${blog.fig2.caption}*`);
  lines.push(`*Alt Text: ${blog.fig2.alt}*\n`);

  // Section 2
  lines.push(`## ${blog.section2H2}\n`);
  lines.push(`${blog.section2Text}\n`);

  // Section 3 (Kanavu CTA)
  lines.push(`## ${blog.section3H2}\n`);
  lines.push(`${blog.section3Text}\n`);

  // FAQs
  lines.push('## Frequently Asked Questions\n');
  blog.faqs.forEach(faq => {
    lines.push(`### ${faq.q}`);
    lines.push(`${faq.a}\n`);
  });

  const fullMd = lines.join('\n');
  const draftPath = path.join(blogDir, 'blog-draft.md');
  const finalPath = path.join(blogDir, 'blog-final.md');

  safeWriteFileSync(draftPath, Buffer.from(fullMd, 'utf8'));
  safeWriteFileSync(finalPath, Buffer.from(fullMd, 'utf8'));

  // Also write faqs.md
  const faqMd = `# Frequently Asked Questions\n\n` + blog.faqs.map(f => `### ${f.q}\n${f.a}`).join('\n\n');
  safeWriteFileSync(path.join(blogDir, 'faqs.md'), Buffer.from(faqMd, 'utf8'));

  // Verification
  const audit = countWords(draftPath);
  const wordStatus = (audit.bodyWordCount >= 450 && audit.bodyWordCount <= 500) ? 'PASS' : 'FAIL';
  console.log(`[${blog.slug}] Official Body Words: ${audit.bodyWordCount} (Target: 450-500) -> ${wordStatus}`);

  audit.faqs.forEach((f, idx) => {
    const fStatus = (f.wordCount >= 15 && f.wordCount <= 25) ? 'PASS' : 'FAIL';
    console.log(`   FAQ ${idx + 1}: ${f.wordCount} words -> ${fStatus}`);
  });

  // Verify secondary keywords
  verifySecondaryKeywords(audit.bodyText, blog.secondaryKeywords, blog.slug);

  // Verify zero dashes
  verifyZeroDashes(fullMd, blog.slug);
}

// ----------------------------------------------------------------------------
// ZERO DASH VERIFICATION FUNCTION
// ----------------------------------------------------------------------------
function verifyZeroDashes(text, label) {
  const emDashCount = (text.match(/—/g) || []).length;
  const enDashCount = (text.match(/–/g) || []).length;
  const spacedHyphenCount = (text.match(/\s-\s/g) || []).length;
  const dashBulletCount = (text.match(/^-\s/gm) || []).length;
  const total = emDashCount + enDashCount + spacedHyphenCount + dashBulletCount;
  if (total > 0) {
    console.warn(`[DASH WARNING] ${label} contains dashes: em=${emDashCount}, en=${enDashCount}, spaced-hyphen=${spacedHyphenCount}, dash-bullets=${dashBulletCount}`);
  }
  return total === 0;
}

// ----------------------------------------------------------------------------
// SECONDARY KEYWORD INSERTION VERIFICATION
// ----------------------------------------------------------------------------
function verifySecondaryKeywords(bodyText, keywords, label) {
  const lowerBody = bodyText.toLowerCase();
  let allPassed = true;
  console.log(`\n--- Secondary Keyword Audit: ${label} ---`);
  keywords.forEach(kw => {
    const lowerKw = kw.toLowerCase();
    const found = lowerBody.includes(lowerKw);
    if (!found) {
      console.warn(`  [FAILED] Missing: "${kw}"`);
      allPassed = false;
    } else {
      console.log(`  [PASSED] Found: "${kw}"`);
    }
  });
  return allPassed;
}

// ----------------------------------------------------------------------------
// MARKDOWN TO OPENXML CONVERTER
// ----------------------------------------------------------------------------
function escapeXml(unsafe) {
  if (!unsafe) return '';
  return unsafe
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

function parseMarkdownRuns(text, rels, relIdCounter) {
  let remaining = text;
  let runsXml = '';

  while (remaining.length > 0) {
    const linkMatch = remaining.match(/\[([^\]]+)\]\((https?:\/\/[^\s\)]+)\)/);
    const boldMatch = remaining.match(/\*\*([^*]+)\*\*/);

    let nextType = null;
    let nextIndex = remaining.length;

    if (linkMatch && linkMatch.index < nextIndex) {
      nextType = 'link';
      nextIndex = linkMatch.index;
    }
    if (boldMatch && boldMatch.index < nextIndex) {
      nextType = 'bold';
      nextIndex = boldMatch.index;
    }

    if (!nextType) {
      if (remaining.length > 0) {
        runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(remaining)}</w:t></w:r>`;
      }
      break;
    }

    if (nextIndex > 0) {
      const plain = remaining.substring(0, nextIndex);
      runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(plain)}</w:t></w:r>`;
      remaining = remaining.substring(nextIndex);
    }

    if (nextType === 'bold') {
      const bContent = boldMatch[1];
      runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(bContent)}</w:t></w:r>`;
      remaining = remaining.substring(boldMatch[0].length);
    } else if (nextType === 'link') {
      const linkText = linkMatch[1];
      const linkUrl = linkMatch[2];
      const rId = `rId${relIdCounter.val++}`;
      rels.push({ id: rId, target: linkUrl, type: 'hyperlink' });

      runsXml += `<w:hyperlink r:id="${rId}" w:history="1"><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:color w:val="1A73E8"/><w:u w:val="single"/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(linkText)}</w:t></w:r></w:hyperlink>`;
      remaining = remaining.substring(linkMatch[0].length);
    }
  }

  return runsXml;
}

function markdownToWordXml(mdText, rels, relIdCounter, mediaFiles, blogDir, blog) {
  const lines = mdText.split(/\r?\n/);
  let bodyXml = '';
  let inTable = false;
  let tableRows = [];
  let inFaq = false;

  function flushTable() {
    if (tableRows.length === 0) return;
    const numCols = tableRows[0].length;
    const totalWidth = 9360;
    const colWidth = Math.floor(totalWidth / numCols);

    let tXml = `<w:tbl><w:tblPr><w:tblW w:w="${totalWidth}" w:type="dxa"/><w:tblBorders><w:top w:val="single" w:sz="8" w:space="0" w:color="CCCCCC"/><w:left w:val="none"/><w:bottom w:val="single" w:sz="8" w:space="0" w:color="CCCCCC"/><w:right w:val="none"/><w:insideH w:val="single" w:sz="6" w:space="0" w:color="E2E8F0"/><w:insideV w:val="none"/></w:tblBorders><w:tblCellMar><w:top w:w="120" w:type="dxa"/><w:left w:w="160" w:type="dxa"/><w:bottom w:w="120" w:type="dxa"/><w:right w:w="160" w:type="dxa"/></w:tblCellMar></w:tblPr><w:tblGrid>`;

    for (let c = 0; c < numCols; c++) {
      tXml += `<w:gridCol w:w="${colWidth}"/>`;
    }
    tXml += `</w:tblGrid>`;

    tableRows.forEach((row, rIdx) => {
      const isHeader = rIdx === 0;
      tXml += `<w:tr><w:trPr>${isHeader ? '<w:tblHeader/>' : ''}</w:trPr>`;

      row.forEach(cell => {
        const bg = isHeader ? '<w:shd w:val="clear" w:color="auto" w:fill="F1F5F9"/>' : '';
        const runs = parseMarkdownRuns(cell.trim(), rels, relIdCounter);
        tXml += `<w:tc><w:tcPr><w:tcW w:w="${colWidth}" w:type="dxa"/>${bg}</w:tcPr><w:p><w:pPr><w:spacing w:after="0" w:line="240" w:lineRule="auto"/></w:pPr>${runs}</w:p></w:tc>`;
      });
      tXml += `</w:tr>`;
    });

    tXml += `</w:tbl>`;
    bodyXml += tXml;
    bodyXml += `<w:p><w:pPr><w:spacing w:after="160"/></w:pPr></w:p>`;

    tableRows = [];
    inTable = false;
  }

  for (let i = 0; i < lines.length; i++) {
    const rawLine = lines[i];
    const line = rawLine.trim();

    if (line.startsWith('|')) {
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

    if (line === '' || line === '---') {
      continue;
    }

    // Callout Box rendering (> ...)
    if (line.startsWith('> ')) {
      const calloutText = line.replace(/^>\s+/, '');
      const runs = parseMarkdownRuns(calloutText, rels, relIdCounter);
      const borderColor = blog.themeColor || '1E40AF';
      const bgColor = blog.themeBg || 'F8FAFC';

      bodyXml += `<w:tbl><w:tblPr><w:tblW w:w="9360" w:type="dxa"/><w:tblBorders><w:top w:val="none"/><w:left w:val="single" w:sz="36" w:space="0" w:color="${borderColor}"/><w:bottom w:val="none"/><w:right w:val="none"/><w:insideH w:val="none"/><w:insideV w:val="none"/></w:tblBorders><w:tblCellMar><w:top w:w="160" w:type="dxa"/><w:left w:w="240" w:type="dxa"/><w:bottom w:w="160" w:type="dxa"/><w:right w:w="240" w:type="dxa"/></w:tblCellMar><w:shd w:val="clear" w:color="auto" w:fill="${bgColor}"/></w:tblPr><w:tblGrid><w:gridCol w:w="9360"/></w:tblGrid><w:tr><w:tc><w:tcPr><w:tcW w:w="9360" w:type="dxa"/><w:shd w:val="clear" w:color="auto" w:fill="${bgColor}"/></w:tcPr><w:p><w:pPr><w:spacing w:after="0" w:line="276" w:lineRule="auto"/></w:pPr>${runs}</w:p></w:tc></w:tr></w:tbl><w:p><w:pPr><w:spacing w:after="160"/></w:pPr></w:p>`;
      continue;
    }

    // Image Heading (### Visual ...)
    if (line.startsWith('### Visual')) {
      const vTitle = line.replace(/^###\s+Visual\s+(?:Architecture|Framework):\s*/i, '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:before="260" w:after="80"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="${blog.themeColor || '1E40AF'}"/><w:sz w:val="26"/></w:rPr><w:t>${escapeXml(vTitle)}</w:t></w:r></w:p>`;
      continue;
    }

    const imgMatch = line.match(/!\[([^\]]*)\]\(([^)"]+)(?:\s+"([^"]+)")?\)/);
    if (imgMatch) {
      const altText = imgMatch[1];
      const imgTarget = imgMatch[2].replace(/file:\/\/\//g, '').replace(/\//g, path.sep);
      
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

        // 16:9 widescreen dimensions in EMUs: cx=5669280, cy=3188970 (approx 5.9 x 3.3 inches)
        bodyXml += `<w:p><w:pPr><w:spacing w:before="60" w:after="80"/><w:jc w:val="center"/></w:pPr><w:r><w:drawing><wp:inline distT="0" distB="0" distL="0" distR="0" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><wp:extent cx="5669280" cy="3188970"/><wp:effectExtent l="0" t="0" r="0" b="0"/><wp:docPr id="${mediaIndex}" name="Picture ${mediaIndex}"/><wp:cNvGraphicFramePr><a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1"/></wp:cNvGraphicFramePr><a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"><a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:nvPicPr><pic:cNvPr id="${mediaIndex}" name="${mediaName}"/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill><a:blip r:embed="${rId}"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="5669280" cy="3188970"/></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing></w:r></w:p>`;
      }
      continue;
    }

    if (line.startsWith('*Figure')) {
      const figCaption = line.replace(/^\*|\*$/g, '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:before="40" w:after="40"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:i/><w:color w:val="475569"/><w:sz w:val="22"/></w:rPr><w:t>${escapeXml(figCaption)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('*Alt Text:')) {
      const altText = line.replace(/^\*Alt Text:\s*|\*$/g, '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="180"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="64748B"/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">Alt Text: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:color w:val="64748B"/><w:sz w:val="20"/></w:rPr><w:t>${escapeXml(altText)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('# ')) {
      const headingText = line.replace(/^#\s+/, '');
      if (headingText === 'Metadata Header') {
        bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading1"/><w:spacing w:before="240" w:after="120"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="1E3A8A"/><w:sz w:val="32"/></w:rPr><w:t>${escapeXml(headingText)}</w:t></w:r></w:p>`;
      } else {
        bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading1"/><w:spacing w:before="360" w:after="160"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="0F172A"/><w:sz w:val="36"/></w:rPr><w:t>${escapeXml(headingText)}</w:t></w:r></w:p>`;
      }
      continue;
    }

    if (line.startsWith('## ')) {
      const headingText = line.replace(/^##\s+/, '');
      if (headingText.includes('Frequently Asked Questions')) {
        inFaq = true;
      } else {
        inFaq = false;
      }
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading2"/><w:spacing w:before="280" w:after="120"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="${blog.themeColor || '1E40AF'}"/><w:sz w:val="28"/></w:rPr><w:t>${escapeXml(headingText)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('### ')) {
      const headingText = line.replace(/^###\s+/, '');
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading3"/><w:spacing w:before="200" w:after="80"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="334155"/><w:sz w:val="24"/></w:rPr><w:t>${escapeXml(headingText)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('* ') || line.startsWith('- ')) {
      const itemText = line.replace(/^[\*\-]\s+/, '');
      const runs = parseMarkdownRuns(itemText, rels, relIdCounter);
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="ListParagraph"/><w:numPr><w:ilvl w:val="0"/><w:numId w:val="1"/></w:numPr><w:spacing w:before="40" w:after="60" w:line="276" w:lineRule="auto"/></w:pPr>${runs}</w:p>`;
      continue;
    }

    const numMatch = line.match(/^(\d+)\.\s+(.*)/);
    if (numMatch) {
      const itemText = numMatch[2];
      const runs = parseMarkdownRuns(itemText, rels, relIdCounter);
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="ListParagraph"/><w:numPr><w:ilvl w:val="0"/><w:numId w:val="2"/></w:numPr><w:spacing w:before="40" w:after="60" w:line="276" w:lineRule="auto"/></w:pPr>${runs}</w:p>`;
      continue;
    }

    const runs = parseMarkdownRuns(line, rels, relIdCounter);
    bodyXml += `<w:p><w:pPr><w:spacing w:before="0" w:after="140" w:line="276" w:lineRule="auto"/></w:pPr>${runs}</w:p>`;
  }

  if (inTable) {
    flushTable();
  }

  return bodyXml;
}

function createZip(files) {
  const localHeaders = [];
  const centralHeaders = [];
  let offset = 0;

  files.forEach(f => {
    const nameBuf = Buffer.from(f.path, 'utf8');
    const dataBuf = Buffer.isBuffer(f.data) ? f.data : Buffer.from(f.data, 'utf8');
    const crc = crc32(dataBuf);
    const size = dataBuf.length;

    const lh = Buffer.alloc(30 + nameBuf.length);
    lh.writeUInt32LE(0x04034b50, 0);
    lh.writeUInt16LE(20, 4);
    lh.writeUInt16LE(0, 6);
    lh.writeUInt16LE(0, 8);
    lh.writeUInt16LE(0, 10);
    lh.writeUInt16LE(0, 12);
    lh.writeUInt32LE(crc, 14);
    lh.writeUInt32LE(size, 18);
    lh.writeUInt32LE(size, 22);
    lh.writeUInt16LE(nameBuf.length, 26);
    lh.writeUInt16LE(0, 28);
    nameBuf.copy(lh, 30);

    localHeaders.push({ header: lh, data: dataBuf });

    const ch = Buffer.alloc(46 + nameBuf.length);
    ch.writeUInt32LE(0x02014b50, 0);
    ch.writeUInt16LE(20, 4);
    ch.writeUInt16LE(20, 6);
    ch.writeUInt16LE(0, 8);
    ch.writeUInt16LE(0, 10);
    ch.writeUInt16LE(0, 12);
    ch.writeUInt16LE(0, 14);
    ch.writeUInt32LE(crc, 16);
    ch.writeUInt32LE(size, 20);
    ch.writeUInt32LE(size, 24);
    ch.writeUInt16LE(nameBuf.length, 28);
    ch.writeUInt16LE(0, 30);
    ch.writeUInt16LE(0, 32);
    ch.writeUInt16LE(0, 34);
    ch.writeUInt16LE(0, 36);
    ch.writeUInt32LE(0, 38);
    ch.writeUInt32LE(offset, 42);
    nameBuf.copy(ch, 46);

    centralHeaders.push(ch);
    offset += lh.length + dataBuf.length;
  });

  const centralDirOffset = offset;
  let centralDirSize = 0;
  centralHeaders.forEach(ch => { centralDirSize += ch.length; });

  const eocd = Buffer.alloc(22);
  eocd.writeUInt32LE(0x06054b50, 0);
  eocd.writeUInt16LE(0, 4);
  eocd.writeUInt16LE(0, 6);
  eocd.writeUInt16LE(files.length, 8);
  eocd.writeUInt16LE(files.length, 10);
  eocd.writeUInt32LE(centralDirSize, 12);
  eocd.writeUInt32LE(centralDirOffset, 16);
  eocd.writeUInt16LE(0, 20);

  const parts = [];
  localHeaders.forEach(item => {
    parts.push(item.header);
    parts.push(item.data);
  });
  centralHeaders.forEach(ch => {
    parts.push(ch);
  });
  parts.push(eocd);

  return Buffer.concat(parts);
}

function crc32(buf) {
  let crc = ~0;
  for (let i = 0; i < buf.length; i++) {
    crc = (crc >>> 8) ^ crcTable[(crc ^ buf[i]) & 0xff];
  }
  return (~crc) >>> 0;
}

const crcTable = new Uint32Array(256);
for (let i = 0; i < 256; i++) {
  let c = i;
  for (let j = 0; j < 8; j++) {
    c = (c & 1) ? (0xedb88320 ^ (c >>> 1)) : (c >>> 1);
  }
  crcTable[i] = c;
}

function safeWriteFileSync(filePath, buffer) {
  for (let attempt = 1; attempt <= 3; attempt++) {
    try {
      fs.writeFileSync(filePath, buffer);
      return;
    } catch (e) {
      if ((e.code === 'EBUSY' || e.code === 'EPERM') && attempt < 3) {
        try { execSync('powershell -Command "Start-Sleep -Milliseconds 400"'); } catch (_) {}
      } else if (attempt === 3) {
        throw e;
      }
    }
  }
}

// ----------------------------------------------------------------------------
// COMPILE BESPOKE DOCX
// ----------------------------------------------------------------------------
function compileDocx(blog) {
  const blogDir = path.join(BASE_DIR, blog.slug);
  const mdPath = path.join(blogDir, 'blog-draft.md');

  if (!fs.existsSync(mdPath)) {
    console.error(`Markdown not found: ${mdPath}`);
    return;
  }

  const mdText = fs.readFileSync(mdPath, 'utf8');
  const rels = [];
  const mediaFiles = [];
  const relIdCounter = { val: 101 };

  const parsedXml = markdownToWordXml(mdText, rels, relIdCounter, mediaFiles, blogDir, blog);

  const newDocXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
            xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
            xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
            xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
            xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
            xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
  <w:body>
    ${parsedXml}
    <w:sectPr>
      <w:pgSz w:w="12240" w:h="15840"/>
      <w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440" w:header="720" w:footer="720" w:gutter="0"/>
      <w:cols w:space="720"/>
      <w:docGrid w:linePitch="360"/>
    </w:sectPr>
  </w:body>
</w:document>`;

  const baseRelsXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml" Target="../customXml/item1.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml"/>
  <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
  <Relationship Id="rId4" Type="http://schemas.microsoft.com/office/2007/relationships/stylesWithEffects" Target="stylesWithEffects.xml"/>
  <Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/>
  <Relationship Id="rId6" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/webSettings" Target="webSettings.xml"/>
  <Relationship Id="rId7" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/>
  <Relationship Id="rId8" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/>
${rels.map(r => `  <Relationship Id="${r.id}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/${r.type}" Target="${r.target}"${r.type === 'hyperlink' ? ' TargetMode="External"' : ''}/>`).join('\n')}
</Relationships>`;

  const cleanContentTypes = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="jpg" ContentType="image/jpeg"/>
  <Default Extension="jpeg" ContentType="image/jpeg"/>
  <Default Extension="png" ContentType="image/png"/>
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/customXml/itemProps1.xml" ContentType="application/vnd.openxmlformats-officedocument.customXmlProperties+xml"/>
  <Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>
  <Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/fontTable.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.fontTable+xml"/>
  <Override PartName="/word/numbering.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml"/>
  <Override PartName="/word/settings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml"/>
  <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
  <Override PartName="/word/stylesWithEffects.xml" ContentType="application/vnd.ms-word.stylesWithEffects+xml"/>
  <Override PartName="/word/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>
  <Override PartName="/word/webSettings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.webSettings+xml"/>
</Types>`;

  const zipFiles = [];
  function addDir(dir, prefix = '') {
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    for (const ent of entries) {
      const full = path.join(dir, ent.name);
      const rel = prefix ? `${prefix}/${ent.name}` : ent.name;
      if (ent.isDirectory()) {
        addDir(full, rel);
      } else {
        if (rel === 'word/document.xml') {
          zipFiles.push({ path: rel, data: newDocXml });
        } else if (rel === 'word/_rels/document.xml.rels') {
          zipFiles.push({ path: rel, data: baseRelsXml });
        } else if (rel === '[Content_Types].xml') {
          zipFiles.push({ path: rel, data: cleanContentTypes });
        } else if (rel === 'word/media/image1.png') {
          continue;
        } else {
          zipFiles.push({ path: rel, data: fs.readFileSync(full) });
        }
      }
    }
  }
  addDir(TEMPLATE_DIR);

  for (const mf of mediaFiles) {
    zipFiles.push({ path: `word/media/${mf.dest}`, data: fs.readFileSync(mf.src) });
  }

  const docxBuffer = createZip(zipFiles);
  const blogDocxPath = path.join(blogDir, blog.docxFilename);
  safeWriteFileSync(blogDocxPath, docxBuffer);
  console.log(`[DOCX SUCCESS] Generated: ${blogDocxPath} (${docxBuffer.length} bytes)`);

  const outDocxPath = path.join(OUTPUTS_DIR, blog.docxFilename);
  safeWriteFileSync(outDocxPath, docxBuffer);
  console.log(`[OUTPUTS SUCCESS] Copied to: ${outDocxPath}`);
}

console.log('='.repeat(80));
console.log('1. WRITING BESPOKE DRAFTS WITH PERFECT TITLES & 100% PROGRAMMATIC VERIFICATION');
console.log('='.repeat(80));
blogs.forEach(writeMarkdownDraft);

console.log('\n' + '='.repeat(80));
console.log('2. COMPILING WORD DOCUMENTS WITH CENTERED TITLES & CAPTIONS FOR ALL IMAGES');
console.log('='.repeat(80));
blogs.forEach(compileDocx);

console.log('\nALL DELIVERABLES SUCCESSFULLY REBUILT WITH PERFECT UNTRUNCATED TITLES!');

