# Mandatory Workspace Rule: Always Check `content-marketing-skills`

## 🚨 MANDATORY INSTRUCTION FOR EVERY USER PROMPT

On **EVERY PROMPT**, before planning, responding, or executing any task:

1. **Check the Skills Library**:
   - You MUST check the [`content-marketing-skills`](file:///d:/content/digital-marketing-skills/content-marketing-skills) folder (and [`skills_index.json`](file:///d:/content/digital-marketing-skills/content-marketing-skills/skills_index.json)) in this workspace.
   - Identify any relevant skill(s) that apply to the user's prompt (SEO, blog writing, humanized prose, copywriting, web design, web development, responsiveness, accessibility/WCAG, website architecture, image generation, document creation, email sequences, growth strategy, CRO, etc.).

2. **Read Relevant `SKILL.md` Instructions**:
   - Use `view_file` to inspect the `SKILL.md` of the matched skill(s) before writing content, designing layouts, or writing code.
   - Adhere strictly to the workflows, frameworks, quality checklists, and guidelines in that skill.

3. **Web Design, Development & Responsiveness Tasks**:
   - For web design and UI/UX: consult [`frontend-design/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/frontend-design/SKILL.md), [`ui-ux-pro-max/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/ui-ux-pro-max/SKILL.md), [`web-design-guidelines/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/web-design-guidelines/SKILL.md), or [`tailwind-patterns/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/tailwind-patterns/SKILL.md).
   - For responsiveness & mobile: consult [`mobile-design/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/mobile-design/SKILL.md).
   - For user-friendliness & WCAG accessibility: consult [`accessibility-compliance-accessibility-audit/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/accessibility-compliance-accessibility-audit/SKILL.md) and [`wcag-audit-patterns/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/wcag-audit-patterns/SKILL.md).
   - For website architecture & performance: consult [`software-architecture/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/software-architecture/SKILL.md), [`architect-review/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/architect-review/SKILL.md), or [`web-performance-optimization/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/web-performance-optimization/SKILL.md).

4. **Content & Blog Writing Tasks**:
   - For any blog writing, article drafting, or content creation request, ALWAYS consult:
     - [`content-marketing-skills/humanized-blog-writing/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/humanized-blog-writing/SKILL.md) (and its [AI cliché blacklist](file:///d:/content/digital-marketing-skills/content-marketing-skills/humanized-blog-writing/resources/ai-cliche-blacklist.md) and [humanizer framework](file:///d:/content/digital-marketing-skills/content-marketing-skills/humanized-blog-writing/resources/humanizer-framework.md)).
     - [`content-marketing-skills/seo-content-writer/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/seo-content-writer/SKILL.md) or [`content-creator/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/content-creator/SKILL.md).

5. **Marketing & Copywriting Tasks**:
   - For marketing, growth, or copy tasks, consult [`copywriting/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/copywriting/SKILL.md), [`marketing-ideas/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/marketing-ideas/SKILL.md), [`marketing-psychology/SKILL.md`](file:///d:/content/digital-marketing-skills/content-marketing-skills/marketing-psychology/SKILL.md), or the relevant channel automation skill.

6. **Professional SEO Blog Writing, Topic Clusters & Document Automation (Final Master Architecture):**
   - Strictly adhere to [`BLOG_CREATION_AND_REVIEW_PROMPT.md`](file:///d:/content/digital-marketing-skills/BLOG_CREATION_AND_REVIEW_PROMPT.md) and the 21-section universal workflow.
   - **Strict Priority Order When Rules Conflict:**
     1. User's newest explicit instructions for the current blog.
     2. Approved client-specific brand guidelines (`projects/<client>/...`).
     3. Verified facts and safety requirements.
     4. This updated SEO workflow.
     5. Older generic repository templates.
   - **Zero False Claims Mandate:**
     - Do NOT promise search rankings, Google AI Overview inclusion, ChatGPT citations, or specific AI-detector scores.
   - **Pre-Writing Research & Search Intent (Sections 3 & 4):**
     - Review 5–10 relevant, credible sources (primary documentation, standards, reputable industry publications).
     - Identify competitor gaps and verified mechanisms before drafting. Never invent research findings or search volume.
   - **Topic Cluster Strategy & 4-Tier Smart Linking (Sections 5, 6, 7 & 18):**
     - **Internal Link A (Pillar Hub):** Connected naturally in broader category context.
     - **Internal Link B (Related Branch Blog):** Contextually placed where the supporting topic is discussed.
     - **Internal Link C (Verified Service Page):** 1 concise natural connection paragraph near the end.
     - **External Link (Authoritative Reference):** Direct supporting citation beside factual claims.
     - Meaning-based distribution: Zero link clustering at the end; zero links in the opening hook or after FAQs.
   - **Client-Specific Factual Accuracy & Brand Rules (Section 8):**
     - The blog is about the topic, NOT the client brand unless specifically stated in the title.
     - Brand connection should be 1 concise paragraph near the end. No unsubstantiated superlatives (*"best IT company"*, *"number one"*).
     - **Little Natura:** Do not claim plant dyes are always safer than synthetic dyes. Do not promise clothing prevents eczema, cures skin irritation, or is safe to chew. No invented ingredients or medicinal claims.
     - **Thalir Kids Dental:** Use recognized pediatric dental guidance and approved Tamil terms/Chompy mascot. No invented treatment outcomes or statistics.
     - **Kanavu Technologies:** Verify technical claims against current official documentation. Avoid invented performance numbers or exaggerated benefits.
     - **Kanavu Digital Marketing:** Use accurate platform guidance. Zero ranking or traffic guarantees.
   - **Exact Word Count & Human Writing Mandate (Sections 9 & 10):**
     - Main body strictly **450–500 words** (excluding metadata, image captions, and FAQs). Count programmatically.
     - First sentence directly answers the title. Zero banned AI clichés (*"In today's fast-paced digital world..."*, *"Imagine..."*).
     - Exactly three concise FAQs (15–25 words per answer).
   - **Universal Master Prompt V5 — Intelligent Visual Selection & Image Standards (Sections 14 & 15):**
     - Automatically select the most suitable visual format from the 7 V5 categories: Realistic Photography, Character-Based Illustrations, Educational Infographics, Technical Diagrams, Product-Focused Images, Charts/Data Visualizations, or Real Software Screenshots.
     - Generate the mandatory 14-field structured internal design brief before image creation.
     - Food blogs: Prioritize realistic, appetizing food photography (authentic regional plating, natural textures; zero cartoon food).
     - 2 to 3 distinct 16:9 widescreen visuals per blog (1920 × 1080), placed contextually across the article near the H2 section explained.
     - Clean white (#FFFFFF) or light neutral/warm pastel background with **large bold titles inside the image itself** for infographics (65–90px title, 35–48px main labels, 28–36px supporting labels).
     - Effective canvas usage; avoid excessive empty space or shrunken centered diagrams.
     - Never repeat visual layouts across the same blog. Never invent statistics, prices, or software screenshots.
     - Enforce mandatory visual QA inspection on actual exported images and rendered Word document layouts.
   - **Professional Word Document Automation (Section 16):**
     - Native Word H1/H2/H3 styles, clean typography, real tables, proportional images, active hyperlinks.
     - Automatic `.docx` compilation saved in `projects/<brand>/<date>/outputs/` and in the blog directory.
   - **11-Part Modular File Output Architecture (Section 20):**
     - Save in `projects/<brand>/<date>/<blog-slug>/`:
       1. `seo-brief.md`
       2. `research-sources.md`
       3. `internal-linking-strategy.md`
       4. `blog-draft.md`
       5. `seo-metadata.md`
       6. `faqs.md`
       7. `image-prompts.md`
       8. `visual-plan.md`
       9. Generated `.jpg` image files
       10. `Blog_<Title>.docx`
       11. `content-review.md`
   - **Zero Auto-Publish / Approval Gateway (Section 21):**
     - Automatic `.docx` generation enabled. Never publish to live CMS or push to remote git repositories without explicit approval.
