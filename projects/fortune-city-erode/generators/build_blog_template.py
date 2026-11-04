import os
import html
import docx
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT, WD_ALIGN_VERTICAL
from docx.oxml import OxmlElement, parse_xml
from docx.oxml.ns import nsdecls, qn

def set_cell_background(cell, fill_hex):
    tcPr = cell._tc.get_or_add_tcPr()
    shd = parse_xml(f'<w:shd {nsdecls("w")} w:fill="{fill_hex}"/>')
    tcPr.append(shd)

def set_cell_margins(cell, top=140, bottom=140, left=180, right=180):
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = OxmlElement('w:tcMar')
    for m_name, val in [('w:top', top), ('w:bottom', bottom), ('w:left', left), ('w:right', right)]:
        node = OxmlElement(m_name)
        node.set(qn('w:w'), str(val))
        node.set(qn('w:type'), 'dxa')
        tcMar.append(node)
    tcPr.append(tcMar)

def set_table_borders(table, color="D1D5DB", sz="4", val="single"):
    tblPr = table._tbl.tblPr
    borders = parse_xml(f'''
        <w:tblBorders {nsdecls("w")}>
            <w:top w:val="{val}" w:sz="{sz}" w:space="0" w:color="{color}"/>
            <w:left w:val="none"/>
            <w:bottom w:val="{val}" w:sz="{sz}" w:space="0" w:color="{color}"/>
            <w:right w:val="none"/>
            <w:insideH w:val="{val}" w:sz="{sz}" w:space="0" w:color="{color}"/>
            <w:insideV w:val="none"/>
        </w:tblBorders>
    ''')
    tblPr.append(borders)

def set_callout_borders(table, border_color="0F2C59", bg_hex="F8FAFC"):
    cell = table.cell(0, 0)
    set_cell_background(cell, bg_hex)
    set_cell_margins(cell, top=160, bottom=160, left=220, right=180)
    tcPr = cell._tc.get_or_add_tcPr()
    borders = parse_xml(f'''
        <w:tcBorders {nsdecls("w")}>
            <w:top w:val="none"/>
            <w:left w:val="single" w:sz="24" w:space="0" w:color="{border_color}"/>
            <w:bottom w:val="none"/>
            <w:right w:val="none"/>
        </w:tcBorders>
    ''')
    tcPr.append(borders)

def add_hyperlink(paragraph, url, text, color="0369A1", underline=True):
    part = paragraph.part
    r_id = part.relate_to(url, docx.opc.constants.RELATIONSHIP_TYPE.HYPERLINK, is_external=True)
    hyperlink = parse_xml(f'<w:hyperlink {nsdecls("w")} r:id="{r_id}" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"/>')
    escaped_text = html.escape(text)
    new_run = parse_xml(f'<w:r {nsdecls("w")}><w:rPr><w:color w:val="{color}"/><w:u w:val="single"/></w:rPr><w:t xml:space="preserve">{escaped_text}</w:t></w:r>')
    hyperlink.append(new_run)
    paragraph._p.append(hyperlink)

def add_html_tag(doc, tag_text):
    p = doc.add_paragraph()
    r = p.add_run(f"[HTML HEADING: <{tag_text}>]")
    r.font.name = "Arial"
    r.font.size = Pt(8.5)
    r.font.bold = True
    r.font.color.rgb = RGBColor(3, 105, 161)
    p.paragraph_format.space_before = Pt(10)
    p.paragraph_format.space_after = Pt(2)

def add_h2(doc, title_text):
    add_html_tag(doc, "H2")
    p = doc.add_paragraph()
    r = p.add_run(title_text)
    r.font.name = "Arial"
    r.font.size = Pt(13.5)
    r.font.bold = True
    r.font.color.rgb = RGBColor(15, 44, 89)
    p.paragraph_format.space_after = Pt(6)

def add_h3(doc, title_text):
    add_html_tag(doc, "H3")
    p = doc.add_paragraph()
    r = p.add_run(title_text)
    r.font.name = "Arial"
    r.font.size = Pt(11)
    r.font.bold = True
    r.font.color.rgb = RGBColor(15, 44, 89)
    p.paragraph_format.space_after = Pt(4)

def add_para(doc, text, space_after=6):
    p = doc.add_paragraph()
    r = p.add_run(text)
    r.font.name = "Arial"
    r.font.size = Pt(10)
    r.font.color.rgb = RGBColor(51, 65, 85)
    p.paragraph_format.space_after = Pt(space_after)
    p.paragraph_format.line_spacing = 1.15
    return p

def add_para_with_links(doc, parts, space_after=6):
    """parts is a list of tuples: (text, url_or_None)"""
    p = doc.add_paragraph()
    p.paragraph_format.space_after = Pt(space_after)
    p.paragraph_format.line_spacing = 1.15
    for text, url in parts:
        if url:
            add_hyperlink(p, url, text)
        else:
            r = p.add_run(text)
            r.font.name = "Arial"
            r.font.size = Pt(10)
            r.font.color.rgb = RGBColor(51, 65, 85)
    return p

def build_blog_document(blog_data, filepath):
    doc = docx.Document()
    for s in doc.sections:
        s.top_margin = Inches(1)
        s.bottom_margin = Inches(1)
        s.left_margin = Inches(1)
        s.right_margin = Inches(1)

    # 1. Top Header Label
    p_meta = doc.add_paragraph()
    r = p_meta.add_run(f"FORTUNE CITY ERODE | OFFICIAL BLOG DELIVERABLE")
    r.font.name = "Arial"
    r.font.size = Pt(9)
    r.font.bold = True
    r.font.color.rgb = RGBColor(15, 44, 89)
    p_meta.paragraph_format.space_after = Pt(2)

    # 2. H1 Tag & Title
    add_html_tag(doc, "H1")
    p_title = doc.add_paragraph()
    r_t = p_title.add_run(blog_data["title"])
    r_t.font.name = "Arial"
    r_t.font.size = Pt(18)
    r_t.font.bold = True
    r_t.font.color.rgb = RGBColor(15, 44, 89)
    p_title.paragraph_format.space_after = Pt(10)

    # 3. Compact SEO Parameters Card
    t_seo = doc.add_table(rows=1, cols=1)
    t_seo.alignment = WD_TABLE_ALIGNMENT.CENTER
    t_seo.autofit = False
    t_seo.columns[0].width = Inches(6.5)
    set_callout_borders(t_seo, border_color="0F2C59", bg_hex="F8FAFC")
    cell_seo = t_seo.cell(0, 0)
    p_s = cell_seo.paragraphs[0]
    p_s.paragraph_format.space_after = Pt(3)

    r_sb = p_s.add_run("Blog SEO Parameters\n")
    r_sb.font.name = "Arial"
    r_sb.font.size = Pt(10)
    r_sb.font.bold = True
    r_sb.font.color.rgb = RGBColor(15, 44, 89)

    seo_items = [
        f"• Meta Title: {blog_data['meta_title']}",
        f"• Meta Description: {blog_data['meta_desc']}",
        f"• Primary Keyword: {blog_data['primary_keyword']}",
        f"• Secondary Keywords: {', '.join(blog_data['secondary_keywords'])}"
    ]
    for item in seo_items:
        p_item = cell_seo.add_paragraph()
        p_item.paragraph_format.space_after = Pt(2)
        r_it = p_item.add_run(item)
        r_it.font.name = "Arial"
        r_it.font.size = Pt(8.5)
        r_it.font.color.rgb = RGBColor(51, 65, 85)

    doc.add_paragraph().paragraph_format.space_after = Pt(6)

    # 4. Body Content Paragraphs & Sections
    for block in blog_data["body_blocks"]:
        btype = block["type"]
        if btype == "h2":
            add_h2(doc, block["text"])
        elif btype == "h3":
            add_h3(doc, block["text"])
        elif btype == "para":
            add_para(doc, block["text"])
        elif btype == "para_with_links":
            add_para_with_links(doc, block["parts"])
        elif btype == "image":
            img_path = block["path"]
            if os.path.exists(img_path):
                p_img = doc.add_paragraph()
                p_img.alignment = WD_ALIGN_PARAGRAPH.CENTER
                p_img.paragraph_format.space_before = Pt(8)
                p_img.paragraph_format.space_after = Pt(3)
                run_img = p_img.add_run()
                run_img.add_picture(img_path, width=Inches(5.5))

                p_cap = doc.add_paragraph()
                p_cap.alignment = WD_ALIGN_PARAGRAPH.CENTER
                p_cap.paragraph_format.space_after = Pt(2)
                r_cap = p_cap.add_run(block["caption"])
                r_cap.font.name = "Arial"
                r_cap.font.size = Pt(8.5)
                r_cap.font.italic = True
                r_cap.font.color.rgb = RGBColor(100, 116, 139)

                p_alt = doc.add_paragraph()
                p_alt.alignment = WD_ALIGN_PARAGRAPH.CENTER
                p_alt.paragraph_format.space_after = Pt(8)
                
                r_fn_lbl = p_alt.add_run("Recommended Filename: ")
                r_fn_lbl.font.name = "Arial"
                r_fn_lbl.font.size = Pt(8)
                r_fn_lbl.font.bold = True
                r_fn_lbl.font.color.rgb = RGBColor(71, 85, 105)
                
                r_fn_val = p_alt.add_run(f"{block['filename']}   |   ")
                r_fn_val.font.name = "Arial"
                r_fn_val.font.size = Pt(8)
                r_fn_val.font.color.rgb = RGBColor(71, 85, 105)

                r_alt_lbl = p_alt.add_run("Image Alt Text: ")
                r_alt_lbl.font.name = "Arial"
                r_alt_lbl.font.size = Pt(8)
                r_alt_lbl.font.bold = True
                r_alt_lbl.font.color.rgb = RGBColor(71, 85, 105)

                r_alt_val = p_alt.add_run(block["alt"])
                r_alt_val.font.name = "Arial"
                r_alt_val.font.size = Pt(8)
                r_alt_val.font.color.rgb = RGBColor(71, 85, 105)
        elif btype == "table":
            table_data = block["data"]
            headers = block["headers"]
            widths = block.get("widths", [Inches(1.6), Inches(1.8), Inches(1.5), Inches(1.6)])
            
            t = doc.add_table(rows=len(table_data) + 1, cols=len(headers))
            t.alignment = WD_TABLE_ALIGNMENT.CENTER
            set_table_borders(t, color="D1D5DB")
            
            # Header row
            hdr_cells = t.rows[0].cells
            for idx, h_text in enumerate(headers):
                hdr_cells[idx].width = widths[idx]
                set_cell_background(hdr_cells[idx], "0F2C59")
                set_cell_margins(hdr_cells[idx], top=100, bottom=100, left=120, right=120)
                p_h = hdr_cells[idx].paragraphs[0]
                r_h = p_h.add_run(h_text)
                r_h.font.name = "Arial"
                r_h.font.size = Pt(8.5)
                r_h.font.bold = True
                r_h.font.color.rgb = RGBColor(255, 255, 255)
            
            # Data rows
            for r_idx, row_items in enumerate(table_data):
                row_cells = t.rows[r_idx + 1].cells
                bg = "FFFFFF" if r_idx % 2 == 0 else "F8FAFC"
                for c_idx, cell_value in enumerate(row_items):
                    row_cells[c_idx].width = widths[c_idx]
                    set_cell_background(row_cells[c_idx], bg)
                    set_cell_margins(row_cells[c_idx], top=90, bottom=90, left=120, right=120)
                    p_c = row_cells[c_idx].paragraphs[0]
                    r_c = p_c.add_run(cell_value)
                    r_c.font.name = "Arial"
                    r_c.font.size = Pt(8.5)
                    r_c.font.color.rgb = RGBColor(51, 65, 85)
            doc.add_paragraph().paragraph_format.space_after = Pt(6)

    # 5. Destination Facility Callout Box
    t_fac = doc.add_table(rows=1, cols=1)
    t_fac.alignment = WD_TABLE_ALIGNMENT.CENTER
    t_fac.autofit = False
    t_fac.columns[0].width = Inches(6.5)
    set_callout_borders(t_fac, border_color="0F2C59", bg_hex="F8FAFC")
    cell_f = t_fac.cell(0, 0)
    p_f = cell_f.paragraphs[0]
    p_f.paragraph_format.space_after = Pt(2)
    r_fb = p_f.add_run(f"Plan Your Visit: {blog_data['facility_name']}\n")
    r_fb.font.name = "Arial"
    r_fb.font.size = Pt(10)
    r_fb.font.bold = True
    r_fb.font.color.rgb = RGBColor(15, 44, 89)

    p_finfo = cell_f.add_paragraph()
    p_finfo.paragraph_format.space_after = Pt(1)
    r_fi = p_finfo.add_run(
        f"Location: Fortune City, NH 544 (Salem–Kochi Highway), Chithode, Erode, Tamil Nadu 638102\n"
        f"Facility Features: {blog_data['facility_features']}\n"
        f"Official Portal: "
    )
    r_fi.font.name = "Arial"
    r_fi.font.size = Pt(8.5)
    r_fi.font.color.rgb = RGBColor(51, 65, 85)
    add_hyperlink(p_finfo, blog_data["facility_url"], blog_data["facility_url"])

    doc.add_paragraph().paragraph_format.space_after = Pt(10)

    # 6. Frequently Asked Questions Section
    add_h2(doc, "Frequently Asked Questions")
    for q_num, (q_text, a_text) in enumerate(blog_data["faqs"], 1):
        add_h3(doc, f"Q{q_num}: {q_text}")
        p_ans = doc.add_paragraph()
        p_ans.paragraph_format.space_after = Pt(6)
        r_ans_lbl = p_ans.add_run("Answer: ")
        r_ans_lbl.font.name = "Arial"
        r_ans_lbl.font.size = Pt(9.5)
        r_ans_lbl.font.bold = True
        r_ans_lbl.font.color.rgb = RGBColor(15, 44, 89)
        
        r_ans = p_ans.add_run(a_text)
        r_ans.font.name = "Arial"
        r_ans.font.size = Pt(9.5)
        r_ans.font.color.rgb = RGBColor(51, 65, 85)

    doc.add_paragraph().paragraph_format.space_after = Pt(10)

    try:
        doc.save(filepath)
        print(f"Successfully generated: {filepath}")
    except PermissionError:
        alt_path = filepath.replace(".docx", "_Updated.docx")
        doc.save(alt_path)
        print(f"File locked by Word. Successfully generated fallback: {alt_path}")

print("build_blog_document function ready.")

