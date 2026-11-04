# Mandatory Workspace Rule: Always Check `content-marketing-skills`

## 🚨 MANDATORY INSTRUCTION FOR EVERY USER PROMPT

On **EVERY PROMPT**, before planning, responding, or executing any task:

1. **Check the Skills Library**:
   - You MUST check the [`content-marketing-skills`](file:///d:/content/content-marketing-skills) folder (and [`skills_index.json`](file:///d:/content/content-marketing-skills/skills_index.json)) in this workspace.
   - Identify any relevant skill(s) that apply to the user's prompt (SEO, blog writing, humanized prose, copywriting, web design, web development, responsiveness, accessibility/WCAG, website architecture, image generation, document creation, email sequences, growth strategy, CRO, etc.).

2. **Read Relevant `SKILL.md` Instructions**:
   - Use `view_file` to inspect the `SKILL.md` of the matched skill(s) before writing content, designing layouts, or writing code.
   - Adhere strictly to the workflows, frameworks, quality checklists, and guidelines in that skill.

3. **Web Design, Development & Responsiveness Tasks**:
   - For web design and UI/UX: consult [`frontend-design/SKILL.md`](file:///d:/content/content-marketing-skills/frontend-design/SKILL.md), [`ui-ux-pro-max/SKILL.md`](file:///d:/content/content-marketing-skills/ui-ux-pro-max/SKILL.md), [`web-design-guidelines/SKILL.md`](file:///d:/content/content-marketing-skills/web-design-guidelines/SKILL.md), or [`tailwind-patterns/SKILL.md`](file:///d:/content/content-marketing-skills/tailwind-patterns/SKILL.md).
   - For responsiveness & mobile: consult [`mobile-design/SKILL.md`](file:///d:/content/content-marketing-skills/mobile-design/SKILL.md).
   - For user-friendliness & WCAG accessibility: consult [`accessibility-compliance-accessibility-audit/SKILL.md`](file:///d:/content/content-marketing-skills/accessibility-compliance-accessibility-audit/SKILL.md) and [`wcag-audit-patterns/SKILL.md`](file:///d:/content/content-marketing-skills/wcag-audit-patterns/SKILL.md).
   - For website architecture & performance: consult [`software-architecture/SKILL.md`](file:///d:/content/content-marketing-skills/software-architecture/SKILL.md), [`architect-review/SKILL.md`](file:///d:/content/content-marketing-skills/architect-review/SKILL.md), or [`web-performance-optimization/SKILL.md`](file:///d:/content/content-marketing-skills/web-performance-optimization/SKILL.md).

4. **Content & Blog Writing Tasks**:
   - For any blog writing, article drafting, or content creation request, ALWAYS consult:
     - [`content-marketing-skills/humanized-blog-writing/SKILL.md`](file:///d:/content/content-marketing-skills/humanized-blog-writing/SKILL.md) (and its [AI cliché blacklist](file:///d:/content/content-marketing-skills/humanized-blog-writing/resources/ai-cliche-blacklist.md) and [humanizer framework](file:///d:/content/content-marketing-skills/humanized-blog-writing/resources/humanizer-framework.md)).
     - [`content-marketing-skills/seo-content-writer/SKILL.md`](file:///d:/content/content-marketing-skills/seo-content-writer/SKILL.md) or [`content-creator/SKILL.md`](file:///d:/content/content-marketing-skills/content-creator/SKILL.md).

5. **Marketing & Copywriting Tasks**:
   - For marketing, growth, or copy tasks, consult [`copywriting/SKILL.md`](file:///d:/content/content-marketing-skills/copywriting/SKILL.md), [`marketing-ideas/SKILL.md`](file:///d:/content/content-marketing-skills/marketing-ideas/SKILL.md), [`marketing-psychology/SKILL.md`](file:///d:/content/content-marketing-skills/marketing-psychology/SKILL.md), or the relevant channel automation skill.

6. **Blog Creation, Content Architecture & Quality Standards**:
   - For all blog generation, client deliverables, and reviews, strictly adhere to [`BLOG_CREATION_AND_REVIEW_PROMPT.md`](file:///d:/content/BLOG_CREATION_AND_REVIEW_PROMPT.md).
   - **Compact Metadata Header Mandate (Directly Below H1 Title):**
     - Every document MUST include the complete 4-part metadata header block:
       1. **Meta Title:** 50–60 characters, high-CTR, incorporating the primary keyword.
       2. **Primary Keyword:** 1 target focus phrase.
       3. **Secondary Keywords:** Exactly 5 to 6 relevant LSI keywords, comma-separated.
       4. **Meta Description:** 140–160 characters, conversational and enticing.
   - **Primary Keyword Strategic Placement & Distribution Mandate (Intro, Subheading, Body Gap & Conclusion):**
     - Primary keyword MUST appear in:
       1. **Intro Paragraph:** Within the 3-beat opening hook (Beat 3, bolded).
       2. **Subheading:** In at least one prominent H2 or H3 heading.
       3. **Body Paragraphs with 101–120 Words Gap:** Mentions across body paragraphs spaced evenly with an intentional **101 to 120 words gap** between each occurrence (no clumping or keyword stuffing).
       4. **Conclusion Section:** In the final concluding paragraph or takeaway quote.
   - **Mandatory Structured Bullet Points in Body Sections:**
     - In addition to narrative prose, every blog deliverable MUST incorporate clean, high-impact bullet points in the body sections (e.g., Section 2 dilemma breakdown or Section 3 action takeaways) to improve mobile scannability and quick factual reading, while keeping the sacred 3-beat opening hook strictly prose with zero bullets.
   - **Short & Crisp FAQ Answers Mandate (Strict 15–25 Words Each):**
     - All FAQ answers MUST be short, direct, and concise (strictly **15 to 25 words maximum per answer**; zero filler, answering directly in 1 to 2 short sentences).
   - **Strict Link Distribution Protocol:**
     - ZERO links in the 3-beat opening hook (first 50–100 words).
     - NO bunching/clumping: Never place multiple hyperlinks in the same paragraph or within consecutive sentences in a single section.
     - Distribute across 3 distinct sections:
       1. Section 2 ("Why" Section - H2 #1): Internal Link 1 (Index Pillar Blog with EXACT Blog Title anchor).
       2. Section 3 (Practical Guide / Steps - H2 #2): External Authority Link (High DA 70+ news/editorial article).
       3. Section 4 (Facility Spotlight - H2 #3): Internal Link 2 (Commercial Facility / Booking Landing Page).
     - ZERO links in the Conclusion or FAQs. The Word document must end cleanly right after FAQ 3 (no table below FAQs).
   - **Plain English & Simple Vocabulary Mandate:** Grade 6–8 level (Flesch > 65), zero pretentious/dictionary-lookup words (e.g. use *treated smooth cotton* instead of *mercerised*, *water leaking in* instead of *ingress*).
   - **Absolute Ban on the Word "Imagine" (Zero "Imagine" Tolerance):**
     - NEVER use the word **"Imagine"** anywhere in any blog (e.g., *"Imagine stepping...", "Imagine entering...", "Imagine walking..."*).
     - Starting an article or hook with *"Imagine"* is a lazy, formulaic AI cliché that instantly triggers AI detectors and signals machine output.
     - Always drop the reader directly into active physical reality using concrete nouns, environmental friction, and active verbs (e.g., *"Dawn breaks over cold pavement...", "The morning alarm buzzes at four...", "Rain lashes against the window..."*).
     - *"imagine"* is permanently blacklisted alongside all other banned AI tropes.
   - **Dynamic & Varied Number of Tips / Habits / Steps (Never Fix 5 on All Blogs):**
     - NEVER default to "5 tips", "5 steps", "5 habits", or "5 strategies" across all blogs!
     - Sticking to "5" for every single article creates an obvious, repetitive machine pattern.
     - Dynamically vary the count across articles in a content cluster—use **6, 7, 4, 8, or 3** depending naturally on the topic's real depth and scope (e.g., Blog 1 has 6 steps, Blog 2 has 7 habits, Blog 3 has 4 techniques).
   - **Freedom from Forced Points / Numbered Listicles (Narrative Deep-Dive Option):**
     - Numbered points (`5 tips`, `6 habits`, `7 steps`) are **NOT required for every blog**.
     - Many topics (e.g. strategic analysis, medical/health guides, architecture reviews, event overviews, cultural histories, technical explanations) are far better explained through **narrative thematic prose and descriptive H3 headings without points or artificial numbers**.
     - In any multi-blog cluster, mix formats dynamically: e.g. Blog 1 is a numbered actionable checklist, Blog 2 is a pure narrative deep-dive without numbered points, Blog 3 is an early-takeaway comparison framework.
   - **Mandatory Structural Layout Permutations Across Content Clusters (Never One Structure for All Blogs):**
     - When generating batches of 2 or more blogs, **NEVER use an identical structure or paragraph-and-bullet sequence across every blog**.
     - Monotonous, copy-pasted section layouts make multi-blog deliverables feel like automated machine output.
     - **Sacred 3-Beat Opening Hook Rule:** The opening hook (first 50–100 words) must ALWAYS remain **3 pure narrative prose paragraphs** (Beat 1: Sensory Scene ➔ Beat 2: Dilemma ➔ Beat 3: Solution + Bold Primary Keyword). **ZERO bullet points in the opening hook.**
     - Vary the structural layout across body sections (Section 2 "Why", Section 3 Steps, and callout placement):
       - *Pattern A (Standard Narrative):* Pure 3-Beat Hook ➔ Section 2 Narrative Paras ➔ Numbered Steps (H3s) ➔ Callout Box ➔ Spotlight.
       - *Pattern B (Section 2 Breakdown Bullets):* Pure 3-Beat Hook ➔ Section 2 starts with a dilemma para, then 2–3 crisp bullet points, followed by the explanatory solution paragraph linking to the Index Pillar blog.
       - *Pattern C (Shifted Callout / Early Takeaways):* Pure 3-Beat Hook ➔ Place callout boxes or summary checklists earlier in the document flow (e.g. right under Section 2) before deep dives, creating varied visual rhythms across documents.
       - *Pattern D (Early Checklist Flow):* Pure 3-Beat Hook ➔ Section 3 features a checklist before detailed H3 steps, shifting the reading pace.
     - No two consecutive blogs in any multi-blog batch may share the exact same structural ordering.
   - **Visuals & Distinct Infographic / Illustration Design Styles Per Blog (MANDATORY RULE):**
     - When generating multiple blogs for a project or content cluster, **EVERY SINGLE BLOG MUST USE A COMPLETELY DIFFERENT, UNIQUE DESIGN STYLE** for its illustration image.
     - **Content-Aligned Visual Styles:** Always choose a visual style directly related and customized to the blog's specific subject matter, target audience, and intent (e.g., educational storytelling, technical specs, step-by-step checklists, interactive classroom methods, comparison matrix, roadmaps).
     - **Signature Illustration Design Catalog:**
       1. *Style 1: Multi-Column Step-by-Step Process Poster* (vertical columns with circular number badges, realistic action photos/renders, and takeaways).
       2. *Style 2: Hero Central Object Card with Pointer Lines & Feature Pills* (central 3D product/facility with floating badges and curved arrows).
       3. *Style 3: Multi-Tile Illustrated Bento Grid* (2x2 or 2x3 rounded cards for categories, regional dishes, or activity bundles).
       4. *Style 4: Brand Showcase & Ecosystem Platter Card* (multi-column directories, food halls, retail clusters, or school center networks).
       5. *Style 5: Head-to-Head Comparison Matrix Card* (split two-tone canvas with "VS" badge, parameter rows, and checkmarks/crosses).
       6. *Style 6: Tiered Option & Power / Method Rating Framework* (horizontal/vertical pillars graded by level, power, or student talk time).
       7. *Style 7: 3D Architectural / Space Anatomy Cutaway* (isometric perspective with numbered zone callouts and specs).
       8. *Style 8: Serpentine Journey Roadmap / Milestone Pathway* (wavy ribbon connecting circular milestone nodes with checklists).
       9. *Style 9: Multi-Arch Photographic / Realistic Vignette Card* (parallel pastel arched/capsule panels with realistic human subjects in action, floating contextual doodle icons, and clean pill labels; perfect for speaking activities, storytelling, roleplays, and health procedures).
       10. *Style 10: Split Narrative Hero Scene + Numbered Action Pill Banner* (warm narrative classroom/scene illustration on one side, paired with vertically stacked numbered cards with mini-avatars, speech bubbles, and actionable directives; perfect for teacher training, coaching, and interactive pedagogy).
       11. *Style 11: Doodle-Bordered Character & Concept Pillar Panel* (color-blocked header with playful white chalk line doodles—stars, planes, notebooks—connecting rounded character cards with action captions; perfect for core skills, foundation stages, and solving difficulties).
     - **Mandatory Core Visual Triad (Persons, Charts & Physical Objects):** Illustrations must NEVER look like tables of text, slide decks of bullet points, or typography-only cards. Every illustration MUST feature recognizable human characters / persons in action (teachers coaching, students conversing, children raising hands), visual data charts/gauges (e.g. circular "85% Student Talk Time" progress meters, roadmap nodes), and rich physical 3D objects (open books, microphones, speech balloons, chalkboards, laptops).
     - **Mandatory Realistic & Easy-to-Understand Style:** Illustrations and infographics MUST be visually realistic, clean, and immediately easy to understand at a glance (photorealistic renders/scenarios, clear physical environments, intuitive cues; no abstract or cluttered visual confusion).
     - **Prominent Top Headline Banner:** Every illustration MUST feature a bold, prominent, high-contrast headline banner across the top matching the blog's topic. Headless/untitled images are strictly prohibited.
   - **File & Folder Organization:** Store project files in `projects/<project-name>/<date>/` and testing scripts in `testing_scripts/`.
   - **Quality Checklists:** Pass the full Pre-Submission Checklist and zero violations on Disqualification Criteria before delivery.
