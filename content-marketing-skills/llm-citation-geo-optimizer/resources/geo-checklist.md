# Generative Engine Optimization (GEO) Audit Checklist

Use this checklist to optimize existing blog posts, product pages, and documentation to maximize citation frequency in Perplexity, ChatGPT/SearchGPT, Claude, and Gemini.

---

## 1. Information Gain & Unique Data
- [ ] **Original Research**: Does the page offer original data, surveys, benchmarks, or teardowns?
- [ ] **Exact Percentages**: Are general claims ("many people") replaced with precise numbers ("64% of respondents")?
- [ ] **Proprietary Terms / Frameworks**: Did you name the framework (e.g., "The 3-Tier Authority Stack") so AI models reference your coined term?

---

## 2. Chunking & Syntactic Clarity
- [ ] **Heading Proximity**: Is the key takeaway within the first 50 words of each heading?
- [ ] **Self-Contained Paragraphs**: Can any single paragraph be quoted by an AI assistant without needing the previous paragraph for context?
- [ ] **Pronoun Check**: Are pronouns ("they", "it", "this") replaced with explicit nouns in key takeaway sentences?

---

## 3. Knowledge Graph & Semantic Structure
- [ ] **Schema Markup**: Is JSON-LD implemented (`Article`, `TechArticle`, `FAQPage`, `Dataset`)?
- [ ] **Author Entity Mapping**: Does the author schema link to external verification (`sameAs` Wikipedia, LinkedIn, GitHub)?
- [ ] **Entity Co-occurrence**: Are related industry entities and established authorities referenced accurately?

---

## 4. Technical RAG Crawling
- [ ] **`robots.txt` Verification**: Confirmed that `GPTBot`, `PerplexityBot`, and `ClaudeBot` are not blocked.
- [ ] **HTML Scannability**: Content is available in the initial HTML response (not locked behind client-side React hydration or tabs).
- [ ] **Table of Contents**: Anchor links exist for fast section navigation and direct deep-linking.
