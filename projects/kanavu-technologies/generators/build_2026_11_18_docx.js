const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const { execSync } = require('child_process');

const TEMPLATE_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-technologies/2026-11-02/sample_docx_extract');
const BATCH_DIR = path.resolve('d:/content/digital-marketing-skills/projects/kanavu-technologies/2026-11-18');
const OUTPUTS_DIR = path.join(BATCH_DIR, 'outputs');

if (!fs.existsSync(OUTPUTS_DIR)) {
  fs.mkdirSync(OUTPUTS_DIR, { recursive: true });
}

const blogs = [
  {
    slug: 'pillar-emerging-technologies-and-it-developments',
    filename: 'Emerging_Technologies_and_IT_Developments_What_Businesses_Need_to_Know.docx'
  },
  {
    slug: 'blog-1-rag-vs-llm',
    filename: 'RAG_vs_LLM_Key_Differences_Benefits_and_Real_World_Use_Cases.docx'
  },
  {
    slug: 'blog-2-types-of-ai-in-2027',
    filename: 'Types_of_AI_in_2027_Uses_and_Real_World_Examples.docx'
  },
  {
    slug: 'blog-3-best-frontend-frameworks-enterprise-2027',
    filename: 'Best_Frontend_Frameworks_for_Enterprise_Web_Development_in_2027.docx'
  },
  {
    slug: 'blog-4-ai-custom-web-application-development',
    filename: 'How_AI_Is_Making_Custom_Web_Application_Development_Faster.docx'
  },
  {
    slug: 'blog-5-slm-vs-llm-2027',
    filename: 'SLM_vs_LLM_in_2027_Key_Differences_Benefits_and_Use_Cases.docx'
  },
  {
    slug: 'blog-6-why-did-microsoft-outlook-go-down',
    filename: 'Why_Did_Microsoft_Outlook_Go_Down_The_Global_Outage_Explained.docx'
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
        console.warn(`Could not overwrite locked file: ${filePath}`);
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

    localHeaders.push(Buffer.concat([lh, fn, comp]));

    const ch = Buffer.alloc(46);
    ch.writeUInt32LE(0x02014b50, 0);
    ch.writeUInt16LE(20, 4);
    ch.writeUInt16LE(20, 6);
    ch.writeUInt16LE(0x0800, 8);
    ch.writeUInt16LE(8, 10);
    ch.writeUInt16LE(0, 12);
    ch.writeUInt16LE(0, 14);
    ch.writeUInt32LE(crc, 16);
    ch.writeUInt32LE(comp.length, 20);
    ch.writeUInt32LE(data.length, 24);
    ch.writeUInt16LE(fn.length, 28);
    ch.writeUInt16LE(0, 30);
    ch.writeUInt16LE(0, 32);
    ch.writeUInt16LE(0, 34);
    ch.writeUInt16LE(0, 36);
    ch.writeUInt32LE(0, 38);
    ch.writeUInt32LE(offset, 42);

    centralHeaders.push(Buffer.concat([ch, fn]));
    offset += lh.length + fn.length + comp.length;
  }

  const cd = Buffer.concat(centralHeaders);
  const cdOffset = offset;
  const cdSize = cd.length;

  const eocd = Buffer.alloc(22);
  eocd.writeUInt32LE(0x06054b50, 0);
  eocd.writeUInt16LE(0, 4);
  eocd.writeUInt16LE(0, 6);
  eocd.writeUInt16LE(files.length, 8);
  eocd.writeUInt16LE(files.length, 10);
  eocd.writeUInt32LE(cdSize, 12);
  eocd.writeUInt32LE(cdOffset, 16);
  eocd.writeUInt16LE(0, 20);

  return Buffer.concat([...localHeaders, cd, eocd]);
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
  let runsXml = '';
  let remaining = text;

  while (remaining.length > 0) {
    const boldMatch = remaining.match(/^(\*\*|__)(.*?)\1/);
    const linkMatch = remaining.match(/^\[(.*?)\]\((.*?)\)/);
    const italicMatch = remaining.match(/^(\*|_)(.*?)\1/);

    if (!boldMatch && !linkMatch && !italicMatch) {
      const nextSpecial = remaining.search(/[\*\[_]/);
      if (nextSpecial === -1) {
        runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(remaining)}</w:t></w:r>`;
        break;
      } else if (nextSpecial === 0) {
        runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(remaining[0])}</w:t></w:r>`;
        remaining = remaining.substring(1);
      } else {
        const plainText = remaining.substring(0, nextSpecial);
        runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(plainText)}</w:t></w:r>`;
        remaining = remaining.substring(nextSpecial);
      }
    } else if (boldMatch) {
      const boldText = boldMatch[2];
      runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(boldText)}</w:t></w:r>`;
      remaining = remaining.substring(boldMatch[0].length);
    } else if (italicMatch) {
      const itText = italicMatch[2];
      runsXml += `<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:i/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(itText)}</w:t></w:r>`;
      remaining = remaining.substring(italicMatch[0].length);
    } else if (linkMatch) {
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
  let inFaq = false;

  for (let i = 0; i < lines.length; i++) {
    const rawLine = lines[i];
    const line = rawLine.trim();

    if (!line) continue;
    if (line === '---') continue;

    // Metadata lines
    if (line.startsWith('**Meta Title:**')) {
      const val = line.replace('**Meta Title:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">Meta Title: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }
    if (line.startsWith('**Primary Keyword:**')) {
      const val = line.replace('**Primary Keyword:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">Primary Keyword: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }
    if (line.startsWith('**Secondary Keywords:**')) {
      const val = line.replace('**Secondary Keywords:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="60"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">Secondary Keywords: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }
    if (line.startsWith('**Meta Description:**')) {
      const val = line.replace('**Meta Description:**', '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:after="240"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">Meta Description: </w:t></w:r><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr><w:t>${escapeXml(val)}</w:t></w:r></w:p>`;
      continue;
    }

    // Headings
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

    // Image Embed (NO duplicate captions or titles!)
    const imgMatch = line.match(/!\[([^\]]*)\]\(([^)"]+)(?:\s+"([^"]+)")?\)/);
    if (imgMatch) {
      const imgTarget = imgMatch[2].replace(/file:\/\/\//g, '').replace(/\//g, path.sep);
      
      let resolvedImgPath = path.isAbsolute(imgTarget) ? imgTarget : path.resolve(blogDir, imgTarget);
      if (fs.existsSync(resolvedImgPath)) {
        const mediaIndex = mediaFiles.length + 1;
        const ext = path.extname(resolvedImgPath) || '.jpg';
        const mediaName = `image${mediaIndex}${ext}`;
        mediaFiles.push({ src: resolvedImgPath, dest: mediaName });

        const rId = `rId${relIdCounter.val++}`;
        rels.push({ id: rId, target: `media/${mediaName}`, type: 'image' });

        // 16:9 Image Drawing (Centered) - ONLY DRAWING HERE, NO REDUNDANT CAPTIONS
        bodyXml += `<w:p><w:pPr><w:spacing w:before="140" w:after="80"/><w:jc w:val="center"/></w:pPr><w:r><w:drawing><wp:inline xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><wp:extent cx="5669280" cy="3188970"/><wp:docPr id="${mediaIndex}" name="Picture ${mediaIndex}"/><wp:cNvGraphicFramePr><a:graphicFrameLocks noChangeAspect="1"/></wp:cNvGraphicFramePr><a:graphic><a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:pic><pic:nvPicPr><pic:cNvPr id="0" name="${mediaName}"/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill><a:blip r:embed="${rId}"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="5669280" cy="3188970"/></a:xfrm><a:prstGeom prst="rect"/></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing></w:r></w:p>`;
      }
      continue;
    }

    // Figure Caption (Single, Italic, Centered)
    if (line.startsWith('*Figure')) {
      const figCaption = line.replace(/^\*|\*$/g, '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:before="40" w:after="40"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:i/><w:color w:val="475569"/><w:sz w:val="22"/></w:rPr><w:t>${escapeXml(figCaption)}</w:t></w:r></w:p>`;
      continue;
    }

    // Alt Text line (Single, Muted, Centered)
    if (line.startsWith('*Alt Text:')) {
      const altNote = line.replace(/^\*|\*$/g, '').trim();
      bodyXml += `<w:p><w:pPr><w:spacing w:before="0" w:after="160"/><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:color w:val="64748B"/><w:sz w:val="20"/></w:rPr><w:t>${escapeXml(altNote)}</w:t></w:r></w:p>`;
      continue;
    }

    // Numbered list item
    const numMatch = line.match(/^(\d+\.\s+)(.*)/);
    if (numMatch) {
      const numLabel = numMatch[1];
      const rest = numMatch[2];
      const runs = parseMarkdownRuns(rest, rels, relIdCounter);
      bodyXml += `<w:p><w:pPr><w:ind w:left="420" w:hanging="280"/><w:spacing w:after="100" w:line="276" w:lineRule="auto"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="24"/></w:rPr><w:t xml:space="preserve">${escapeXml(numLabel)}</w:t></w:r>${runs}</w:p>`;
      continue;
    }

    // Callout Box
    if (line.startsWith('>')) {
      const calloutText = line.replace(/^>\s*/, '').trim();
      const runs = parseMarkdownRuns(calloutText, rels, relIdCounter);
      bodyXml += `<w:p><w:pPr><w:pBdr><w:left w:val="single" w:sz="24" w:space="15" w:color="2563EB"/></w:pBdr><w:shd w:val="clear" w:color="auto" w:fill="F0F9FF"/><w:ind w:left="240" w:right="120"/><w:spacing w:before="140" w:after="160" w:line="276" w:lineRule="auto"/></w:pPr>${runs}</w:p>`;
      continue;
    }

    // Markdown Table
    if (line.startsWith('|') && line.endsWith('|')) {
      const tableLines = [];
      while (i < lines.length && lines[i].trim().startsWith('|') && lines[i].trim().endsWith('|')) {
        const tLine = lines[i].trim();
        // Skip separator line |---|---|
        if (!/^\|[\s\-:]+(\|[\s\-:]+)+\|$/.test(tLine)) {
          tableLines.push(tLine);
        }
        i++;
      }
      i--; // Rewind one because outer loop increments

      if (tableLines.length > 0) {
        const headerRow = tableLines[0];
        const dataRows = tableLines.slice(1);
        const headerCells = headerRow.split('|').map(c => c.trim()).filter((c, idx, arr) => idx > 0 && idx < arr.length - 1);
        const colCount = Math.max(1, headerCells.length);
        const totalW = 9360;
        const colW = Math.floor(totalW / colCount);

        let tblXml = `<w:tbl><w:tblPr><w:tblW w:w="${totalW}" w:type="dxa"/><w:jc w:val="center"/><w:tblBorders><w:top w:val="single" w:sz="6" w:space="0" w:color="CBD5E1"/><w:bottom w:val="single" w:sz="6" w:space="0" w:color="CBD5E1"/><w:insideH w:val="single" w:sz="4" w:space="0" w:color="E2E8F0"/><w:insideV w:val="none"/><w:left w:val="none"/><w:right w:val="none"/></w:tblBorders></w:tblPr>`;

        // Header Row
        tblXml += `<w:tr><w:trPr><w:tblHeader/></w:trPr>`;
        headerCells.forEach(cell => {
          const runs = parseMarkdownRuns(cell, rels, relIdCounter);
          tblXml += `<w:tc><w:tcPr><w:tcW w:w="${colW}" w:type="dxa"/><w:shd w:fill="F1F5F9"/><w:tcMar><w:top w:w="120" w:type="dxa"/><w:bottom w:w="120" w:type="dxa"/><w:left w:w="140" w:type="dxa"/><w:right w:w="140" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:spacing w:after="0"/><w:rPr><w:b/></w:rPr></w:pPr>${runs}</w:p></w:tc>`;
        });
        tblXml += `</w:tr>`;

        // Data Rows
        dataRows.forEach((dRow, rIdx) => {
          const cells = dRow.split('|').map(c => c.trim()).filter((c, idx, arr) => idx > 0 && idx < arr.length - 1);
          const bgFill = (rIdx % 2 === 1) ? 'F8FAFC' : 'FFFFFF';
          tblXml += `<w:tr>`;
          cells.forEach(cell => {
            const runs = parseMarkdownRuns(cell, rels, relIdCounter);
            tblXml += `<w:tc><w:tcPr><w:tcW w:w="${colW}" w:type="dxa"/><w:shd w:fill="${bgFill}"/><w:tcMar><w:top w:w="100" w:type="dxa"/><w:bottom w:w="100" w:type="dxa"/><w:left w:w="140" w:type="dxa"/><w:right w:w="140" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:spacing w:after="0"/></w:pPr>${runs}</w:p></w:tc>`;
          });
          tblXml += `</w:tr>`;
        });

        tblXml += `</w:tbl>`;
        bodyXml += tblXml;
      }
      continue;
    }

    // Standard Paragraph
    const runs = parseMarkdownRuns(line, rels, relIdCounter);
    bodyXml += `<w:p><w:pPr><w:spacing w:after="160" w:line="276" w:lineRule="auto"/></w:pPr>${runs}</w:p>`;
  }

  return bodyXml;
}

function processBlog(blog) {
  console.log(`Processing docx for: ${blog.slug}`);
  const blogDir = path.join(BATCH_DIR, blog.slug);
  const mdPath = path.join(blogDir, 'blog-final.md');

  if (!fs.existsSync(mdPath)) {
    console.error(`Missing blog-final.md in ${blogDir}`);
    return;
  }

  const mdText = fs.readFileSync(mdPath, 'utf8');

  // Load template files
  const rels = [];
  const mediaFiles = [];
  const relIdCounter = { val: 101 };

  const bodyXml = convertMarkdownToDocxXml(mdText, blogDir, rels, mediaFiles, relIdCounter);

  const docTemplate = fs.readFileSync(path.join(TEMPLATE_DIR, 'word/document.xml'), 'utf8');
  const sectPrMatch = docTemplate.match(/<w:sectPr[\s\S]*?<\/w:sectPr>/);
  const sectPr = sectPrMatch ? sectPrMatch[0] : '';
  const newDocXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"><w:body>${bodyXml}${sectPr}</w:body></w:document>`;

  // Clean base relationships without leftover sample links
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
`;

  const relEntries = rels.map(r => {
    if (r.type === 'hyperlink') {
      return `  <Relationship Id="${r.id}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="${escapeXml(r.target)}" TargetMode="External"/>\n`;
    } else {
      return `  <Relationship Id="${r.id}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="${r.target}"/>\n`;
    }
  }).join('');

  const finalDocRels = `${baseRelsXml}${relEntries}</Relationships>`;

  // Clean Content Types including jpg, jpeg, png
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
          zipFiles.push({ path: rel, data: finalDocRels });
        } else if (rel === '[Content_Types].xml') {
          zipFiles.push({ path: rel, data: cleanContentTypes });
        } else if (rel === 'word/media/image1.png') {
          // Skip old template sample image
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

  const localDest = path.join(blogDir, blog.filename);
  const outputDest = path.join(OUTPUTS_DIR, blog.filename);

  safeWriteFileSync(localDest, docxBuffer);
  safeWriteFileSync(outputDest, docxBuffer);

  console.log(`[SUCCESS] Generated: ${localDest}`);
  console.log(`[SUCCESS] Copied to: ${outputDest}`);
}

blogs.forEach(b => processBlog(b));
console.log('All 7 docx files generated successfully.');
