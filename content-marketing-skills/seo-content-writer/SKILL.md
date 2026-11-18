---
name: seo-content-writer
description: "Professional SEO content writing, topic cluster architecture, smart internal linking, visual design, and document automation skill. Follows the 21-section Final Master Architecture."
metadata:
  category: seo-geo
  domain: content-creation
  version: 3.0.0
risk: safe
source: custom
---

# Professional SEO Blog Writing & Topic Cluster Automation System

Executes the end-to-end 21-section professional SEO content workflow:
`INPUT -> SOURCE RESEARCH -> SEARCH INTENT -> CLUSTER MAPPING -> ORIGINAL DRAFT -> 4-TIER LINKING -> MULTI-VISUAL PLAN -> IMAGE GENERATION -> QUALITY REVIEW -> DOCX AUTOMATION -> SAVE DELIVERABLES`.

---

## 1. Core Principles & Rule Precedence

1. **Hierarchy:** Current prompt > Client brand guidelines (`projects/<client>/...`) > Verified facts & safety > Repository guidelines > Defaults.
2. **Zero False Promises:** Never promise search rankings, Google AI Overview inclusion, ChatGPT citations, or specific AI-detector scores. Prioritize editorial excellence, verified mechanisms, and genuine human value.
3. **Research First:** Evaluate 5–10 sources, analyze intent, and identify competitor content gaps before drafting.
4. **Answer-First Openings:** Answer the main question directly in the very first sentence. Zero routine use of *"Imagine..."*, *"In today's fast-paced digital world..."*, or formulaic fluff.
5. **Exact Word Count:** Main blog body must strictly be **450–500 words** (programmatically counted, excluding metadata, image captions, and FAQs). Exactly three concise FAQs (15–25 words per answer).
6. **Dynamic Topic Structures:** Choose from Tutorial (Step-by-Step), Concept Explanation, Comparison, Cost Guide, Troubleshooting, Listicle, or Health/Technical standards.
7. **Special Brand Rule (Kanavu & Clients):** The article is about the topic, NOT the client brand. Education must dominate (90%+). Brand connection is restricted to 1 concise, natural paragraph near the end. No unsubstantiated superlatives (*"best IT company"*, *"number one"*).
8. **4-Tier Smart Linking Strategy:**
   - **Internal Link A (Pillar Blog):** Connected in broader category context.
   - **Internal Link B (Related Branch Blog):** Contextually placed where the supporting topic is discussed.
   - **Internal Link C (Verified Service Page):** Supporting commercial step near the end.
   - **External Link (Authoritative Reference):** Direct supporting citation beside factual claims.
   - *Meaning-Based Placement:* Distributed across the reader's journey. Zero link clustering at the end; zero links in the opening hook or after FAQs.
9. **Universal Blog Image Generation Standard:** 2 to 3 distinct 16:9 widescreen visuals per blog (`1920 × 1080`), placed contextually across the article near the H2 section explained. Clean white (`#FFFFFF`) or light neutral background with **large bold titles inside the image itself** (65–90px title, 35–48px main labels, 28–36px supporting labels). Content-type matching (processes, comparisons, architecture loops, feature callouts), effective canvas usage without excessive margins, zero repetition across the same blog, zero invented statistics/prices, and mandatory 12-point visual QA inspection on actual exported images and rendered Word document layouts.
10. **Word Document Automation:** Always generate and update native Word `.docx` documents in `projects/<brand>/<date>/outputs/` and in the blog directory.

---

## 2. 11-Part Deliverable Architecture

Every blog project saves 11 discrete files in `projects/<brand>/<date>/<blog-slug>/`:
1. `seo-brief.md`: Metadata, primary/secondary keywords, search intent, audience profile.
2. `research-sources.md`: Summary of 5–10 analyzed sources, verified facts vs. assumptions, competitor gaps.
3. `internal-linking-strategy.md`: Pillar, related branch, service, and external link plan with section placements.
4. `blog-draft.md`: Publication-ready markdown content (strictly 450–500 words main body).
5. `seo-metadata.md`: Meta title (50–60 chars), meta description (140–160 chars), primary & secondary keywords.
6. `faqs.md`: Exactly 3 concise, non-repetitive FAQs (15–25 words each).
7. `image-prompts.md`: Production-ready prompts for 2 to 3 distinct visuals with on-canvas bold titles.
8. `visual-plan.md`: Visual concept rationale, placement, dimensions (16:9), filenames, and alt text.
9. Generated `.jpg` image files (`hero-image.jpg` + secondary diagrams).
10. `Blog_<Title>.docx`: Native formatted Word document (also copied to `projects/<brand>/<date>/outputs/`).
11. `content-review.md`: Quality checklist audit, word count verification, Flesch score, and 14-point link audit.
