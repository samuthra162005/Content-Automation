/**
 * UNIVERSAL MASTER PROMPT V5 — INTELLIGENT VISUAL DIRECTOR
 * Automatically analyzes brand, industry, blog topic, H2 section, and content intent
 * to classify each image into the optimal V5 visual category:
 * 1. REALISTIC_PHOTOGRAPHY
 * 2. CHARACTER_ILLUSTRATION
 * 3. EDUCATIONAL_INFOGRAPHIC
 * 4. TECHNICAL_DIAGRAM
 * 5. PRODUCT_FOCUSED
 * 6. CHART_DATA_VIZ
 * 7. SOFTWARE_SCREENSHOT
 *
 * Produces the mandatory 14-field structured internal design brief and specialized prompts.
 */

const fs = require('fs');
const path = require('path');

const BRAND_PROFILES = {
  'thalir-kids-dental': {
    name: 'Thalir Kids Dental',
    domain: 'Pediatric Dentistry & Early Orthodontics',
    audience: 'Parents, young children, pediatric dental patients in Erode and Tamil Nadu',
    primaryVisualCategory: 'CHARACTER_ILLUSTRATION',
    secondaryVisualCategory: 'EDUCATIONAL_INFOGRAPHIC',
    bg: '#FFFFFF',
    accentBg: '#E6F4EA', // soft pastel mint
    palette: ['#0D9488', '#2563EB', '#F59E0B', '#EC4899', '#10B981'],
    titleColor: '#0F172A',
    signatureElements: 'Friendly expressive child characters, cute Chompy mascot, anatomically accurate teeth, tooth brushing activities, soft pastel cards, friendly dental instruments',
    avoid: 'Scary surgical tools, extraction forceps, bloody needles, generic corporate laptops, dull gray tones',
    factualRestrictions: 'Use recognized pediatric dental guidance (AAO age 7 rule, AAPD standards). Maintain approved mascot Chompy and Tamil terms (Ethu Pal, Vankal Pal). Do not invent treatment outcomes or medical statistics.'
  },
  'little-natura': {
    name: 'Little Natura',
    domain: 'Organic Baby Clothing & Ayurvastra Herbal Wear',
    audience: 'New parents, eco-conscious families, sensitive-skin infant caregivers',
    primaryVisualCategory: 'PRODUCT_FOCUSED',
    secondaryVisualCategory: 'EDUCATIONAL_INFOGRAPHIC',
    bg: '#FFFDF7', // warm cream
    accentBg: '#F5EFEB',
    palette: ['#432818', '#B45309', '#059669', '#D97706', '#C25E40'],
    titleColor: '#432818',
    signatureElements: 'Authentic organic baby garments, detailed woven cotton textures, mother-baby bonding, raw botanical dye plants (turmeric, indigo, madder), nursery lifestyle scenes',
    avoid: 'Fake synthetic fabrics, plastic shine, robotic baby dolls, neon saturated colors, corporate tech icons',
    factualRestrictions: 'Do not claim plant dyes are always safer than synthetic dyes. Do not promise clothing prevents eczema, cures irritation, or is safe to chew. Preserve verified garment information and age ranges.'
  },
  'kanavu-technologies': {
    name: 'Kanavu Technologies',
    domain: 'Software Engineering, Cloud Architecture & Autonomous AI',
    audience: 'CTOs, product founders, engineering teams, enterprise leaders',
    primaryVisualCategory: 'TECHNICAL_DIAGRAM',
    secondaryVisualCategory: 'EDUCATIONAL_INFOGRAPHIC',
    bg: '#FFFFFF',
    accentBg: '#F8FAFC',
    palette: ['#0F172A', '#2563EB', '#06B6D4', '#10B981', '#6366F1'],
    titleColor: '#0F172A',
    signatureElements: 'Modern cloud edge nodes, serverless pipelines, autonomous AI agent loops, multi-sided app workflows, smartphone wireframes, clean device mockups, color-coded modules',
    avoid: 'Chaotic 3D clutter, illegible micro-traces, generic business handshakes, empty white waste',
    factualRestrictions: 'Verify technical claims against current official documentation (Cloudflare, AWS, Google Cloud, Docker, Kubernetes). Avoid invented performance numbers or exaggerated benefits. Brand connection 1 concise paragraph.'
  },
  'kanavu-digital': {
    name: 'Kanavu Digital Marketing',
    domain: 'Growth Marketing, SEO & Answer Engine Optimization',
    audience: 'Business owners, CMOs, digital marketing managers',
    primaryVisualCategory: 'EDUCATIONAL_INFOGRAPHIC',
    secondaryVisualCategory: 'CHART_DATA_VIZ',
    bg: '#FFFFFF',
    accentBg: '#F8FAFC',
    palette: ['#1A73E8', '#34A853', '#EA4335', '#FBBC04', '#9333EA'],
    titleColor: '#1F2937',
    signatureElements: 'Search engine result interfaces, keyword intent funnels, content distribution workflows, verified analytics charts, social media cards',
    avoid: 'Fabricated ranking claims, fake dashboard metrics, ungrounded traffic promises',
    factualRestrictions: 'Use accurate platform guidance. Zero ranking or traffic guarantees.'
  },
  'fortune-city-erode': {
    name: 'Fortune City Erode',
    domain: 'Commercial Hub, Food, Dining, Retail & Living',
    audience: 'Local residents, shoppers, diners, families, working professionals in Erode',
    primaryVisualCategory: 'REALISTIC_PHOTOGRAPHY',
    secondaryVisualCategory: 'EDUCATIONAL_INFOGRAPHIC',
    bg: '#FFFDF7',
    accentBg: '#FEF3C7',
    palette: ['#1F2937', '#D97706', '#059669', '#DC2626', '#2563EB'],
    titleColor: '#1F2937',
    signatureElements: 'Authentic plated South Indian dishes, natural food textures, realistic restaurant interiors, real architectural amenities, warm ambient lighting',
    avoid: 'Cartoon food, generic American diner imagery, fake brand logos, dull corporate visuals',
    factualRestrictions: 'For food topics, prioritize realistic, appetizing food photography with authentic regional presentation. Do not misrepresent actual restaurant menus.'
  },
  'whats-score': {
    name: 'What\'s Score',
    domain: 'Sports & Tournament Management Platform',
    audience: 'Tournament directors, sports federations, athletes, coaches',
    primaryVisualCategory: 'REALISTIC_PHOTOGRAPHY',
    secondaryVisualCategory: 'SOFTWARE_SCREENSHOT',
    bg: '#FFFFFF',
    accentBg: '#F0FDF4',
    palette: ['#0A192F', '#15803D', '#EA580C', '#2563EB', '#D97706'],
    titleColor: '#0A192F',
    signatureElements: 'Real racket/court sports (badminton, tennis, fencing), match scoreboards, tournament elimination brackets, player statistics, verified app screens',
    avoid: 'Fabricated UI mockups, unrealistic sport postures, generic stock clip art',
    factualRestrictions: 'Use genuine application screenshots when explaining platform features. Never invent an interface and present it as a real client product.'
  },
  'kanavu-school': {
    name: 'Kanavu School of English',
    domain: 'Language Learning & Education',
    audience: 'Students, English language learners, job seekers, teachers',
    primaryVisualCategory: 'CHARACTER_ILLUSTRATION',
    secondaryVisualCategory: 'REALISTIC_PHOTOGRAPHY',
    bg: '#FFFBEB',
    accentBg: '#FEF3C7',
    palette: ['#1D4ED8', '#D97706', '#059669', '#7C3AED', '#DC2626'],
    titleColor: '#1D4ED8',
    signatureElements: 'Active classroom speaking activities, book reading illustrations, step-by-step phonics guides, teacher-student interactive roleplay',
    avoid: 'Bored students staring at blank laptops, empty desks, robotic chalkboard art',
    factualRestrictions: 'Show realistic or engaging educational interactions appropriate to Tamil Nadu students.'
  },
  'qivera-digital': {
    name: 'Qivera Digital',
    domain: 'Digital Products, Mobile Apps (LexiRef & HabitShare)',
    audience: 'Language learners, self-improvement seekers, mobile app users, professionals',
    primaryVisualCategory: 'EDUCATIONAL_INFOGRAPHIC',
    secondaryVisualCategory: 'CHARACTER_ILLUSTRATION',
    bg: '#FFFFFF',
    accentBg: '#F0F9FF',
    palette: ['#2563EB', '#10B981', '#F59E0B', '#6366F1', '#0F172A'],
    titleColor: '#0F172A',
    signatureElements: 'LexiRef vocabulary visual cards, etymology trees, daily habit streak calendars, HabitShare accountability circles, clean mobile product interfaces',
    avoid: 'Fabricated app mockups, exaggerated behavioral claims, cluttered interfaces',
    factualRestrictions: 'Verify application functionality (LexiRef, HabitShare). Avoid overstating psychological outcomes. Connect apps naturally to practical habits.'
  },
  'aindhin': {
    name: 'Aindhin',
    domain: 'Data Analytics, SQL Training, Business Intelligence & Tech Education',
    audience: 'Data analysts, engineers, business intelligence professionals, career transitioners',
    primaryVisualCategory: 'TECHNICAL_DIAGRAM',
    secondaryVisualCategory: 'EDUCATIONAL_INFOGRAPHIC',
    bg: '#FFFFFF',
    accentBg: '#F8FAFC',
    palette: ['#0F172A', '#0284C7', '#10B981', '#F59E0B', '#8B5CF6'],
    titleColor: '#0F172A',
    signatureElements: 'Clean SQL query syntax blocks, relational schema joins, Power BI vs Tableau feature comparison matrices, interactive analytics dashboards',
    avoid: 'Fake statistics, incorrect SQL syntax, biased tool claims',
    factualRestrictions: 'Verify SQL syntax. Compare Power BI and Tableau objectively across data modeling, visualization, licensing, and learning curve.'
  }
};

/**
 * V5 Intelligent Visual Category Classifier
 * Evaluates topic keywords, heading intent, and brand domain.
 */
function classifyVisualCategory(brandKey, heading, content) {
  const brand = BRAND_PROFILES[brandKey] || BRAND_PROFILES['kanavu-technologies'];
  const text = (heading + ' ' + content).toLowerCase();

  // 1. Food / Culinary / Dining -> REALISTIC_PHOTOGRAPHY
  if (text.match(/\b(biryani|dosa|food|recipe|dish|cuisine|restaurant|dining|cooking|taste|spices|culinary|chef|meal|menu)\b/i)) {
    return {
      category: 'REALISTIC_PHOTOGRAPHY',
      subType: 'FOOD_AND_DINING',
      reason: 'Subject involves actual food, culinary textures, and dining experiences requiring authentic, appetizing food photography.'
    };
  }

  // 2. Cloud / AI / Software / System Architecture -> TECHNICAL_DIAGRAM
  if (brandKey === 'kanavu-technologies' || text.match(/\b(cloud|cdn|serverless|dns|api|ai agent|docker|kubernetes|backend|database|deployment|data transmission|software architecture|system architecture|edge distribution|caching architecture)\b/i)) {
    if (text.match(/\b(vs|comparison|matrix|difference|features|table)\b/i)) {
      return {
        category: 'EDUCATIONAL_INFOGRAPHIC',
        subType: 'TECH_COMPARISON_MATRIX',
        reason: 'Subject compares multiple technical systems or architecture choices, requiring an organized comparative matrix.'
      };
    }
    return {
      category: 'TECHNICAL_DIAGRAM',
      subType: 'SYSTEM_ARCHITECTURE_FLOW',
      reason: 'Subject explains technical operations, software processes, or data distribution requiring a clean, clear technical diagram.'
    };
  }

  // 3. Real estate / Physical Architecture -> REALISTIC_PHOTOGRAPHY
  if (text.match(/\b(real estate|property|apartment|villa|commercial building|wedding hall|coliving|pg accommodation|living space)\b/i)) {
    return {
      category: 'REALISTIC_PHOTOGRAPHY',
      subType: 'ARCHITECTURE_AND_PROPERTY',
      reason: 'Subject involves physical spaces, buildings, and real-life environments requiring authentic architectural and lifestyle photography.'
    };
  }

  // 3. Physical clothing / Garment details -> PRODUCT_FOCUSED or REALISTIC_PHOTOGRAPHY
  if (text.match(/\b(fabric|cotton|weave|swatch|gsm|garment|clothing|onesie|apparel|textile)\b/i) && brandKey === 'little-natura') {
    if (text.match(/\b(vs|comparison|difference|step|pipeline|how.*made)\b/i)) {
      return {
        category: 'EDUCATIONAL_INFOGRAPHIC',
        subType: 'PRODUCT_COMPARISON_OR_PROCESS',
        reason: 'Subject compares textile materials or explains botanical dyeing steps, best communicated via an educational infographic.'
      };
    }
    return {
      category: 'PRODUCT_FOCUSED',
      subType: 'GARMENT_AND_FABRIC_TEXTURE',
      reason: 'Subject highlights physical babywear, organic cotton textures, and product details requiring authentic product-focused visuals.'
    };
  }

  // 4. Pediatric dental / Mascot / Child health -> CHARACTER_ILLUSTRATION or EDUCATIONAL_INFOGRAPHIC
  if (brandKey === 'thalir-kids-dental' || text.match(/\b(pediatric|child|kids dental|teeth|tooth|braces|chompy|brushing|habit)\b/i)) {
    if (text.match(/\b(types of|comparison|matrix|vs|table|options|features|factors)\b/i)) {
      return {
        category: 'EDUCATIONAL_INFOGRAPHIC',
        subType: 'PEDIATRIC_COMPARISON_MATRIX',
        reason: 'Subject compares multiple pediatric orthodontic choices, requiring an organized multi-card educational infographic with Chompy mascot.'
      };
    }
    return {
      category: 'CHARACTER_ILLUSTRATION',
      subType: 'PEDIATRIC_CHARACTER_EDUCATION',
      reason: 'Subject educates young children and parents on dental habits, best communicated through friendly illustrated characters and Chompy mascot.'
    };
  }

  // 5. Cloud / AI / Software / System Architecture -> TECHNICAL_DIAGRAM
  if (text.match(/\b(architecture|workflow|pipeline|cloud|cdn|serverless|dns|api|ai agent|docker|kubernetes|backend|database|deployment)\b/i)) {
    return {
      category: 'TECHNICAL_DIAGRAM',
      subType: 'SYSTEM_ARCHITECTURE_FLOW',
      reason: 'Subject explains technical operations, software processes, or data distribution requiring a clean, clear technical diagram.'
    };
  }

  // 6. Multi-point tips, comparisons, causes -> EDUCATIONAL_INFOGRAPHIC
  if (text.match(/\b(vs|comparison|matrix|benefits|features|types|steps|causes|factors|guide|reasons)\b/i)) {
    return {
      category: 'EDUCATIONAL_INFOGRAPHIC',
      subType: 'MULTI_CARD_OR_MATRIX',
      reason: 'Subject organizes structured educational points or comparisons requiring short, readable labels and visual containers.'
    };
  }

  // Fallback based on brand's primary visual category
  return {
    category: brand.primaryVisualCategory || 'EDUCATIONAL_INFOGRAPHIC',
    subType: 'BRAND_DEFAULT',
    reason: `Selected brand primary visual standard (${brand.primaryVisualCategory}) to match audience expectations.`
  };
}

/**
 * V5 Structured Internal Design Brief Generator (Section 18)
 */
function createV5DesignBrief(brandKey, blogTitle, h2Heading, content, imageIndex = 1) {
  const brand = BRAND_PROFILES[brandKey] || BRAND_PROFILES['kanavu-technologies'];
  const classification = classifyVisualCategory(brandKey, h2Heading, content);

  // Clean on-canvas headline (uppercase, concise, punchy)
  let onCanvasTitle = h2Heading
    .replace(/^\d+[\.\)]\s*/, '')
    .replace(/^figure\s*\d+:?\s*/i, '')
    .trim()
    .toUpperCase();

  if (onCanvasTitle.length > 55) {
    onCanvasTitle = onCanvasTitle.split(/[:\-–—]/)[0].trim();
  }

  let onCanvasSubtitle = '';
  if (h2Heading.includes(':')) {
    onCanvasSubtitle = h2Heading.split(':')[1].trim();
  } else if (h2Heading.includes('—')) {
    onCanvasSubtitle = h2Heading.split('—')[1].trim();
  }

  // Determine boolean flags based on category
  const realisticPhotographyRequired = (classification.category === 'REALISTIC_PHOTOGRAPHY' || classification.category === 'PRODUCT_FOCUSED');
  const illustrationRequired = (classification.category === 'CHARACTER_ILLUSTRATION' || classification.category === 'EDUCATIONAL_INFOGRAPHIC' || classification.category === 'TECHNICAL_DIAGRAM');
  const exactProductOrScreenshotAssetsRequired = (classification.category === 'SOFTWARE_SCREENSHOT' || classification.category === 'PRODUCT_FOCUSED');

  // Purpose definition
  const imagePurpose = `Visually explain "${h2Heading}" for ${brand.name} readers with maximum clarity and zero irrelevant clutter.`;

  // Construct Specialized Prompt according to V5 standards
  let specializedPrompt = '';

  if (classification.category === 'REALISTIC_PHOTOGRAPHY') {
    specializedPrompt = [
      `A high-resolution, photorealistic 16:9 photograph illustrating "${h2Heading}".`,
      `Context: ${brand.name} (${brand.domain}). Target audience: ${brand.audience}.`,
      `Composition: Natural perspective, shot on 50mm f/2.8 lens with soft directional natural lighting.`,
      `Visual Elements: Authentic real-world setting, genuine textures, believable human expressions or authentic plated food.`,
      `Color Palette: Warm, natural tones reflecting ${brand.palette.join(', ')}.`,
      `Strictly Avoid: AI plastic skin, distorted anatomy, extra fingers, artificial neon studio lighting, generic stock-photo poses.`,
      `Format: 1920x1080 (16:9 widescreen), crisp detail, realistic depth of field.`
    ].join('\n');
  } else if (classification.category === 'CHARACTER_ILLUSTRATION') {
    specializedPrompt = [
      `A warm, child-friendly 16:9 editorial character illustration for "${h2Heading}".`,
      `Client: ${brand.name}. Target audience: ${brand.audience}.`,
      `Canvas Background: Clean ${brand.bg} with soft pastel accents (${brand.accentBg}).`,
      `Prominent Headline: Bold on-canvas typography at top: "${onCanvasTitle}".`,
      `Key Characters & Elements: ${brand.signatureElements}. Expressive, age-appropriate characters, friendly Chompy mascot, anatomically accurate teeth.`,
      `Palette: Welcoming high-contrast colors (${brand.palette.join(', ')}).`,
      `Strictly Avoid: Scary dental tools, dark medical needles, robotic mannequins, cluttered technical icons.`,
      `Format: 1920x1080 (16:9), crisp vector lines, cheerful welcoming pediatric healthcare aesthetic.`
    ].join('\n');
  } else if (classification.category === 'TECHNICAL_DIAGRAM') {
    specializedPrompt = [
      `A clean, modern 16:9 technical architecture diagram illustrating "${h2Heading}".`,
      `Client: ${brand.name} (${brand.domain}). Audience: ${brand.audience}.`,
      `Canvas Background: Solid pure white (#FFFFFF) with subtle grid/accents (${brand.accentBg}).`,
      `Prominent Headline: Bold typography at top: "${onCanvasTitle}".`,
      `Diagram Architecture: Directional system pipeline with color-coded modules (${brand.palette.join(', ')}), clean data flow arrows, and short readable labels.`,
      `Key Technical Nodes: ${brand.signatureElements}.`,
      `Strictly Avoid: Cluttered 3D cubes, illegible micro-traces, fake marketing buzzwords, empty white borders.`,
      `Format: 1920x1080 (16:9 widescreen), crisp modern software engineering visual standard.`
    ].join('\n');
  } else if (classification.category === 'PRODUCT_FOCUSED') {
    specializedPrompt = [
      `A premium, tactile 16:9 product showcase photograph illustrating "${h2Heading}".`,
      `Client: ${brand.name} (${brand.domain}). Target audience: ${brand.audience}.`,
      `Canvas Background: Clean warm cream (${brand.bg}) with soft organic textures.`,
      `Product Focus: Macro focus on authentic garment folds, unbleached organic cotton fibers, natural botanical swatches, and clean wooden elements.`,
      `Lighting: Soft morning sunlight, gentle shadows, natural warmth.`,
      `Strictly Avoid: Synthetic shiny plastic, fake logos, unnatural neon saturation, corporate office imagery.`,
      `Format: 1920x1080 (16:9 widescreen), authentic product fidelity.`
    ].join('\n');
  } else {
    // EDUCATIONAL_INFOGRAPHIC
    specializedPrompt = [
      `A professional 16:9 widescreen educational infographic illustrating "${h2Heading}".`,
      `Client: ${brand.name}. Target audience: ${brand.audience}.`,
      `Canvas Background: Solid ${brand.bg} with balanced margins and soft accents (${brand.accentBg}).`,
      `Prominent Headline: Large bold typography on canvas (65-90px): "${onCanvasTitle}".`,
      `Sub-Headline: Clean supporting subtitle (28-36px): "${onCanvasSubtitle}".`,
      `Visual Layout: Multi-card balanced grid or side-by-side comparative matrix with clear icons and concise labels (35-48px).`,
      `Color Palette: High-contrast coordinating colors (${brand.palette.join(', ')}).`,
      `Strictly Avoid: Excessive empty space, unreadable paragraphs inside boxes, generic stock clip art.`,
      `Format: 1920x1080 (16:9), clean editorial infographic design.`
    ].join('\n');
  }

  // 14-field structured internal design brief (V5 Section 18)
  return {
    brand: brand.name,
    blogTitle,
    h2Section: h2Heading,
    targetAudience: brand.audience,
    imagePurpose,
    selectedVisualType: classification.category,
    visualSubType: classification.subType,
    selectionRationale: classification.reason,
    requiredObjectsOrCharacters: brand.signatureElements,
    realisticPhotographyRequired,
    illustrationRequired,
    exactProductOrScreenshotAssetsRequired,
    titleAndLabelRequirements: {
      onCanvasTitle,
      onCanvasSubtitle,
      mainTitlePx: '65–90 px',
      mainLabelsPx: '35–48 px',
      supportingLabelsPx: '28–36 px'
    },
    brandColours: brand.palette,
    factualRestrictions: brand.factualRestrictions,
    targetDimensions: '1920x1080 (16:9)',
    generatedPrompt: specializedPrompt
  };
}

module.exports = {
  BRAND_PROFILES,
  classifyVisualCategory,
  createV5DesignBrief
};

// Self-test if run directly
if (require.main === module) {
  console.log('=== V5 INTELLIGENT VISUAL DIRECTOR SELF-TEST ===\n');

  const test1 = createV5DesignBrief(
    'fortune-city-erode',
    'Best Traditional South Indian Foods in Erode',
    'Authentic Biryani and Traditional Banana Leaf Meals',
    'Exploring the preparation and authentic taste of traditional wood-fired biryani served on fresh banana leaves.',
    1
  );
  console.log('TEST 1 (Food / Dining):', test1.selectedVisualType, '->', test1.visualSubType);
  console.log('Selection Rationale:', test1.selectionRationale);
  console.log('Realistic Photography Required:', test1.realisticPhotographyRequired);

  const test2 = createV5DesignBrief(
    'thalir-kids-dental',
    'Types of Braces for Kids: Which Is Right for Your Child?',
    'Comparing Pediatric Braces: Clinical Feature Matrix',
    'Evaluating traditional metal braces, ceramic brackets, self-ligating braces, and clear aligners across child durability and hygiene.',
    2
  );
  console.log('\nTEST 2 (Pediatric Dentistry):', test2.selectedVisualType, '->', test2.visualSubType);
  console.log('Selection Rationale:', test2.selectionRationale);
  console.log('Illustration Required:', test2.illustrationRequired);

  const test3 = createV5DesignBrief(
    'kanavu-technologies',
    'What Is a CDN and How Does It Make Your Website Faster?',
    'How a Content Delivery Network Works: Edge Distribution Architecture',
    'Explaining the request-response cycle from origin servers to distributed point-of-presence edge nodes.',
    1
  );
  console.log('\nTEST 3 (Cloud / Tech Architecture):', test3.selectedVisualType, '->', test3.visualSubType);
  console.log('Selection Rationale:', test3.selectionRationale);
  console.log('Technical Diagram Required:', test3.selectedVisualType === 'TECHNICAL_DIAGRAM');
}
