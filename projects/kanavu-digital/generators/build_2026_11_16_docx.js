const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const { execSync } = require('child_process');

const TEMPLATE_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-technologies/2026-11-02/sample_docx_extract');
const BATCH_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-digital/2026-11-16');
const OUTPUTS_DIR = path.join(BATCH_DIR, 'outputs');

if (!fs.existsSync(OUTPUTS_DIR)) {
  fs.mkdirSync(OUTPUTS_DIR, { recursive: true });
}

const blogs = [
  {
    slug: 'pillar-top-digital-marketing-company-strategies-for-growth',
    filename: 'Top_Digital_Marketing_Company_Strategies_for_Growth.docx'
  },
  {
    slug: 'blog-1-how-to-use-claude-for-social-media-marketing',
    filename: 'How_to_Use_Claude_for_Social_Media_Marketing.docx'
  },
  {
    slug: 'blog-2-ai-agents-in-digital-marketing',
    filename: 'AI_Agents_in_Digital_Marketing_5_Tasks_You_Can_Automate.docx'
  },
  {
    slug: 'blog-3-fifa-world-cup-2026-marketing-campaigns',
    filename: 'FIFA_World_Cup_2026_Marketing_Campaigns.docx'
  },
  {
    slug: 'blog-4-what-is-google-e-e-a-t',
    filename: 'What_Is_Google_EEAT_Why_It_Matters_for_SEO_and_Website_Trust.docx'
  },
  {
    slug: 'blog-5-ai-generated-images-viral-marketers',
    filename: 'AI_Generated_Images_Are_Going_Viral_Marketer_Guide.docx'
  },
  {
    slug: 'blog-6-top-ppc-trends-of-2027',
    filename: 'Top_PPC_Trends_of_2027_7_Changes_to_Prepare_For.docx'
  }
];

function safeWriteFileSync(filePath, buffer) {
  for (let attempt = 1; attempt <= 3; attempt++) {
    try {
      fs.writeFileSync(filePath, buffer);
      return;
    } catch (e) {
      if ((e.code === 'EBUSY' || e.code === 'EPERM') && attempt < 3) {
        try { execSync('powershell -Command "Start-Sleep -Milliseconds 400"'); } catch (_) {}
      } else if (attempt === 3) {
        const dir = path.dirname(filePath);
        const ext = path.extname(filePath);
        const base = path.basename(filePath, ext).replace(/_Updated|_v\d+/g, '');
        
        const candidates = [
          path.join(dir, `${base}_Updated${ext}`),
          path.join(dir, `${base}_v2${ext}`),
          path.join(dir, `${base}_v3${ext}`)
        ];
        
        let written = false;
        for (const cand of candidates) {
          try {
            fs.writeFileSync(cand, buffer);
            console.log(`Original file was locked, wrote to fallback: ${cand}`);
            written = true;
            break;
          } catch (_) {}
        }
        if (!written) {
          console.warn(`Could not overwrite locked file: ${filePath}`);
        }
        return;
      } else {
        throw e;
      }
    }
  }
}

function createZip(files) {
  const localHeaders = [];
  const centralHeaders = [];
  let offset = 0;

  for (const f of files) {
    const fn = Buffer.from(f.path.replace(/\\/g, '/'), 'utf8');
    const data = Buffer.isBuffer(f.data) ? f.data : Buffer.from(f.data, 'utf8');
    const crc = zlib.crc32(data);
    const comp = zlib.deflateRawSync(data);

    const lh = Buffer.alloc(30);
    lh.writeUInt32LE(0x04034b50, 0);
    lh.writeUInt16LE(20, 4);
    lh.writeUInt16LE(0x0800, 6);
    lh.writeUInt16LE(8, 8);
    lh.writeUInt16LE(0, 10);
    lh.writeUInt16LE(0, 12);
    lh.writeUInt32LE(crc, 14);
    lh.writeUInt32LE(comp.length, 18);
    lh.writeUInt32LE(data.length, 22);
    lh.writeUInt16LE(fn.length, 26);
    lh.writeUInt16LE(0, 28);

    localHeaders.push(lh, fn, comp);

    const cd = Buffer.alloc(46);
    cd.writeUInt32LE(0x02014b50, 0);
    cd.writeUInt16LE(20, 4);
    cd.writeUInt16LE(20, 6);
    cd.writeUInt16LE(0x0800, 8);
    cd.writeUInt16LE(8, 10);
    cd.writeUInt16LE(0, 12);
    cd.writeUInt16LE(0, 14);
    cd.writeUInt32LE(crc, 16);
    cd.writeUInt32LE(comp.length, 20);
    cd.writeUInt32LE(data.length, 24);
    cd.writeUInt16LE(fn.length, 28);
    cd.writeUInt16LE(0, 30);
    cd.writeUInt16LE(0, 32);
    cd.writeUInt16LE(0, 34);
    cd.writeUInt16LE(0, 36);
    cd.writeUInt32LE(0, 38);
    cd.writeUInt32LE(offset, 42);

    centralHeaders.push(cd, fn);
    offset += lh.length + fn.length + comp.length;
  }

  const cdStart = offset;
  const cdSize = centralHeaders.reduce((acc, b) => acc + b.length, 0);

  const eocd = Buffer.alloc(22);
  eocd.writeUInt32LE(0x06054b50, 0);
  eocd.writeUInt16LE(0, 4);
  eocd.writeUInt16LE(0, 6);
  eocd.writeUInt16LE(files.length, 8);
  eocd.writeUInt16LE(files.length, 10);
  eocd.writeUInt32LE(cdSize, 12);
  eocd.writeUInt32LE(cdStart, 16);
  eocd.writeUInt16LE(0, 20);

  return Buffer.concat([...localHeaders, ...centralHeaders, eocd]);
}

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

      runsXml += `<w:hyperlink r:id="${rId}"><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:color w:val="1A73E8"/><w:u w:val="single"/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(linkText)}</w:t></w:r></w:hyperlink>`;
      remaining = remaining.substring(linkMatch[0].length);
    }
  }

  return runsXml;
}

function convertMarkdownToDocxXml(mdText, blogDir, rels, mediaFiles, relIdCounter) {
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

    if (!line) continue;
    if (line === '---') continue;

    if (line.startsWith('# Metadata Header')) {
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading1"/><w:spacing w:before="0" w:after="120"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="0F172A"/><w:sz w:val="32"/></w:rPr><w:t>Metadata Header</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('**Meta Title:**')) {
      const val = line.replace('**Meta Title:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="26"/></w:rPr><w:t xml:space="preserve">Meta Title: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="26"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }
    if (line.startsWith('**Primary Keyword:**')) {
      const val = line.replace('**Primary Keyword:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="26"/></w:rPr><w:t xml:space="preserve">Primary Keyword: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="26"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }
    if (line.startsWith('**Secondary Keywords:**')) {
      const val = line.replace('**Secondary Keywords:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="26"/></w:rPr><w:t xml:space="preserve">Secondary Keywords: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="26"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }
    if (line.startsWith('**Meta Description:**')) {
      const val = line.replace('**Meta Description:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="240"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="26"/></w:rPr><w:t xml:space="preserve">Meta Description: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="26"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('# ')) {
      const title = line.replace('# ', '').trim();
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading1"/><w:spacing w:before="0" w:after="180"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="0F172A"/><w:sz w:val="36"/></w:rPr><w:t>${escapeXml(title)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('## ')) {
      const h2 = line.replace('## ', '').trim();
      if (h2.toLowerCase().includes('frequently asked questions') || h2.toLowerCase().includes('faqs')) inFaq = true;
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading2"/><w:spacing w:before="280" w:after="120"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="1A73E8"/><w:sz w:val="30"/></w:rPr><w:t>${escapeXml(h2)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('### ')) {
      const h3 = line.replace('### ', '').trim();
      const color = inFaq ? '0F172A' : '059669';
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="Heading3"/><w:spacing w:before="200" w:after="80"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="${color}"/><w:sz w:val="26"/></w:rPr><w:t>${escapeXml(h3)}</w:t></w:r></w:p>`;
      continue;
    }

    const imgMatch = line.match(/!\[([^\]]*)\]\(([^)"]+)(?:\s+"([^"]+)")?\)/);
    if (imgMatch) {
      const altText = imgMatch[1];
      const imgTarget = imgMatch[2].replace(/file:\/\/\//g, '').replace(/\//g, path.sep);
      const imgTitle = imgMatch[3] || altText;
      
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

        bodyXml += `<w:p><w:pPr><w:spacing w:before="140" w:after="60"/><w:jc w:val="center"/></w:pPr><w:r><w:drawing><wp:inline xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><wp:extent cx="5669280" cy="3188970"/><wp:docPr id="${mediaIndex}" name="Picture ${mediaIndex}"/><wp:cNvGraphicFramePr><a:graphicFrameLocks noChangeAspect="1"/></wp:cNvGraphicFramePr><a:graphic><a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:pic><pic:nvPicPr><pic:cNvPr id="0" name="${mediaName}"/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill><a:blip r:embed="${rId}"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="5669280" cy="3188970"/></a:xfrm><a:prstGeom prst="rect"/></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing></w:r></w:p>`;
        bodyXml += `<w:p><w:pPr><w:spacing w:after="40"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:i/><w:color w:val="646464"/><w:sz w:val="22"/></w:rPr><w:t>${escapeXml(imgTitle)}</w:t></w:r></w:p>`;
        bodyXml += `<w:p><w:pPr><w:spacing w:after="160"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="505050"/><w:sz w:val="20"/></w:rPr><w:t xml:space="preserve">Alt Text: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:color w:val="505050"/><w:sz w:val="20"/></w:rPr><w:t>${escapeXml(altText)}</w:t></w:r></w:p>`;
      }
      continue;
    }

    if (line.startsWith('*Figure')) {
      const figCaption = line.replace(/^\*|\*$/g, '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:before="40" w:after="80"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:i/><w:color w:val="646464"/><w:sz w:val="22"/></w:rPr><w:t>${escapeXml(figCaption)}</w:t></w:r></w:p>`;
      continue;
    }

    if (line.startsWith('* ') || line.startsWith('- ')) {
      const bContent = line.replace(/^[\*\-]\s*/, '').trim();
      const runs = parseMarkdownRuns(bContent, rels, relIdCounter);
      bodyXml += `<w:p><w:pPr><w:pStyle w:val="ListBullet"/><w:spacing w:after="60" w:line="276" w:lineRule="auto"/></w:pPr>${runs}</w:p>`;
      continue;
    }

    if (line.match(/^\d+\.\s+/)) {
      const nContent = line.replace(/^\d+\.\s*/, '').trim();
      const nMatch = line.match(/^(\d+\.)\s*/);
      const prefix = nMatch ? nMatch[1] : '';
      const runs = parseMarkdownRuns(nContent, rels, relIdCounter);
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60" w:line="276" w:lineRule="auto"/><w:ind w:left="360"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="1A73E8"/><w:sz w:val="26"/></w:rPr><w:t xml:space="preserve">${prefix} </w:t></w:r>${runs}</w:p>`;
      continue;
    }

    const pRuns = parseMarkdownRuns(line, rels, relIdCounter);
    bodyXml += `<w:p><w:pPr><w:spacing w:after="140" w:line="276" w:lineRule="auto"/></w:pPr>${pRuns}</w:p>`;
  }

  if (inTable) flushTable();
  return bodyXml;
}

function compileDocx(blog) {
  const blogDir = path.join(BATCH_DIR, blog.slug);
  const mdPath = path.join(blogDir, 'blog-draft.md');

  if (!fs.existsSync(mdPath)) {
    console.error(`Markdown not found: ${mdPath}`);
    return;
  }

  const mdText = fs.readFileSync(mdPath, 'utf8');
  const rels = [];
  const mediaFiles = [];
  const relIdCounter = { val: 8 };

  const bodyXml = convertMarkdownToDocxXml(mdText, blogDir, rels, mediaFiles, relIdCounter);

  const docTemplate = fs.readFileSync(path.join(TEMPLATE_DIR, 'word/document.xml'), 'utf8');
  const sectPrMatch = docTemplate.match(/<w:sectPr[\s\S]*?<\/w:sectPr>/);
  const sectPr = sectPrMatch ? sectPrMatch[0] : '';
  const newDocXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"><w:body>${bodyXml}${sectPr}</w:body></w:document>`;

  let docRels = fs.readFileSync(path.join(TEMPLATE_DIR, 'word/_rels/document.xml.rels'), 'utf8');
  const relEntries = rels.map(r => {
    if (r.type === 'hyperlink') {
      return `<Relationship Id="${r.id}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="${escapeXml(r.target)}" TargetMode="External"/>`;
    } else {
      return `<Relationship Id="${r.id}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="${r.target}"/>`;
    }
  }).join('');
  docRels = docRels.replace('</Relationships>', `${relEntries}</Relationships>`);

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
          zipFiles.push({ path: rel, data: docRels });
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
  const blogDocxPath = path.join(blogDir, blog.filename);
  safeWriteFileSync(blogDocxPath, docxBuffer);
  console.log(`[DOCX SUCCESS] Generated: ${blogDocxPath} (${docxBuffer.length} bytes)`);

  const outDocxPath = path.join(OUTPUTS_DIR, blog.filename);
  safeWriteFileSync(outDocxPath, docxBuffer);
  console.log(`[OUTPUTS SUCCESS] Copied to: ${outDocxPath}`);
}

console.log('=== KANAVU DIGITAL 2026-11-16 DOCX COMPILATION ENGINE ===');
blogs.forEach(compileDocx);
console.log('=== KANAVU DIGITAL DOCX GENERATION COMPLETE ===');

