import os
import html
import docx
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.oxml import OxmlElement, parse_xml
from docx.oxml.ns import nsdecls, qn

def set_cell_margins(cell, top=100, bottom=100, left=120, right=120):
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = OxmlElement('w:tcMar')
    for m_name, val in [('w:top', top), ('w:bottom', bottom), ('w:left', left), ('w:right', right)]:
        node = OxmlElement(m_name)
        node.set(qn('w:w'), str(val))
        node.set(qn('w:type'), 'dxa')
        tcMar.append(node)
    tcPr.append(tcMar)

def set_callout_box_borders(cell, border_color="990000", sz="12"):
    tcPr = cell._tc.get_or_add_tcPr()
    borders = parse_xml(f'''
        <w:tcBorders {nsdecls("w")}>
            <w:top w:val="single" w:sz="{sz}" w:space="0" w:color="{border_color}"/>
            <w:left w:val="single" w:sz="{sz}" w:space="0" w:color="{border_color}"/>
            <w:bottom w:val="single" w:sz="{sz}" w:space="0" w:color="{border_color}"/>
            <w:right w:val="single" w:sz="{sz}" w:space="0" w:color="{border_color}"/>
        </w:tcBorders>
    ''')
    tcPr.append(borders)
    shd = parse_xml(f'<w:shd {nsdecls("w")} w:fill="auto" w:val="clear"/>')
    tcPr.append(shd)

def add_hyperlink(paragraph, url, text, color="0000FF", underline=True):
    part = paragraph.part
    r_id = part.relate_to(url, docx.opc.constants.RELATIONSHIP_TYPE.HYPERLINK, is_external=True)
    hyperlink = parse_xml(f'<w:hyperlink {nsdecls("w")} r:id="{r_id}" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"/>')
    escaped_text = html.escape(text)
    u_tag = '<w:u w:val="single"/>' if underline else ''
    new_run = parse_xml(f'<w:r {nsdecls("w")}><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:color w:val="{color}"/>{u_tag}<w:sz w:val="28"/></w:rPr><w:t xml:space="preserve">{escaped_text}</w:t></w:r>')
    hyperlink.append(new_run)
    paragraph._p.append(hyperlink)

def create_nallore_document():
    doc = docx.Document()
    for section in doc.sections:
        section.top_margin = Inches(1.0)
        section.bottom_margin = Inches(1.0)
        section.left_margin = Inches(1.0)
        section.right_margin = Inches(1.0)
    
    style_normal = doc.styles['Normal']
    font = style_normal.font
    font.name = 'Times New Roman'
    font.size = Pt(14)
    font.color.rgb = RGBColor(0, 0, 0)
    
    return doc

def add_title(doc, text):
    p = doc.add_paragraph(style='Heading 1')
    p.paragraph_format.space_before = Pt(0)
    p.paragraph_format.space_after = Pt(8)
    r = p.add_run(text)
    r.font.name = 'Times New Roman'
    r.font.size = Pt(18)
    r.font.bold = True
    r.font.color.rgb = RGBColor(0, 0, 0)
    return p

def add_metadata_block_tamil(doc, meta_title, primary_kw, secondary_kws, meta_desc):
    # Meta Title in Pure Tamil
    p0 = doc.add_paragraph()
    p0.paragraph_format.space_after = Pt(3)
    r0_lbl = p0.add_run("மெட்டா தலைப்பு: ")
    r0_lbl.font.name = 'Times New Roman'
    r0_lbl.font.size = Pt(14)
    r0_lbl.font.bold = True
    r0_val = p0.add_run(meta_title)
    r0_val.font.name = 'Times New Roman'
    r0_val.font.size = Pt(14)
    
    # Primary Keyword in Pure Tamil
    p1 = doc.add_paragraph()
    p1.paragraph_format.space_after = Pt(3)
    r1_lbl = p1.add_run("முதன்மைத் திறவுச்சொல்: ")
    r1_lbl.font.name = 'Times New Roman'
    r1_lbl.font.size = Pt(14)
    r1_lbl.font.bold = True
    r1_val = p1.add_run(primary_kw)
    r1_val.font.name = 'Times New Roman'
    r1_val.font.size = Pt(14)
    
    # Secondary Keywords in Pure Tamil
    p2 = doc.add_paragraph()
    p2.paragraph_format.space_after = Pt(3)
    r2_lbl = p2.add_run("துணைத் திறவுச்சொற்கள்: ")
    r2_lbl.font.name = 'Times New Roman'
    r2_lbl.font.size = Pt(14)
    r2_lbl.font.bold = True
    r2_val = p2.add_run(", ".join(secondary_kws))
    r2_val.font.name = 'Times New Roman'
    r2_val.font.size = Pt(14)
    
    # Meta Description in Pure Tamil
    p3 = doc.add_paragraph()
    p3.paragraph_format.space_after = Pt(12)
    r3_lbl = p3.add_run("மெட்டா விளக்கம்: ")
    r3_lbl.font.name = 'Times New Roman'
    r3_lbl.font.size = Pt(14)
    r3_lbl.font.bold = True
    r3_val = p3.add_run(meta_desc)
    r3_val.font.name = 'Times New Roman'
    r3_val.font.size = Pt(14)

def add_h2(doc, text, color="0000FF"):
    p = doc.add_paragraph(style='Heading 2')
    p.paragraph_format.space_before = Pt(14)
    p.paragraph_format.space_after = Pt(6)
    r = p.add_run(text)
    r.font.name = 'Times New Roman'
    r.font.size = Pt(16)
    r.font.bold = True
    r.font.color.rgb = RGBColor(int(color[:2], 16), int(color[2:4], 16), int(color[4:], 16))
    return p

def add_h3(doc, text, color="990000"):
    p = doc.add_paragraph(style='Heading 3')
    p.paragraph_format.space_before = Pt(10)
    p.paragraph_format.space_after = Pt(4)
    r = p.add_run(text)
    r.font.name = 'Times New Roman'
    r.font.size = Pt(14)
    r.font.bold = True
    r.font.color.rgb = RGBColor(int(color[:2], 16), int(color[2:4], 16), int(color[4:], 16))
    return p

def add_para(doc, text_runs, space_after=6, line_spacing=1.15):
    p = doc.add_paragraph()
    p.paragraph_format.space_after = Pt(space_after)
    p.paragraph_format.line_spacing = line_spacing
    
    if isinstance(text_runs, str):
        r = p.add_run(text_runs)
        r.font.name = 'Times New Roman'
        r.font.size = Pt(14)
        return p

    for item in text_runs:
        if isinstance(item, str):
            text = item
            is_bold = False
            color_hex = None
            url = None
        else:
            text = item[0]
            is_bold = item[1] if len(item) > 1 else False
            color_hex = item[2] if len(item) > 2 else None
            url = item[3] if len(item) > 3 else None
        
        if url:
            add_hyperlink(p, url, text, color="0000FF", underline=True)
        else:
            r = p.add_run(text)
            r.font.name = 'Times New Roman'
            r.font.size = Pt(14)
            if is_bold:
                r.font.bold = True
            if color_hex:
                r.font.color.rgb = RGBColor(int(color_hex[:2], 16), int(color_hex[2:4], 16), int(color_hex[4:], 16))
    return p

def add_callout_box(doc, title, items, border_color="990000"):
    table = doc.add_table(rows=1, cols=1)
    table.alignment = WD_TABLE_ALIGNMENT.CENTER
    table.autofit = False
    table.columns[0].width = Inches(6.5)
    
    cell = table.cell(0, 0)
    set_callout_box_borders(cell, border_color=border_color, sz="12")
    set_cell_margins(cell, top=120, bottom=120, left=140, right=140)
    
    p_title = cell.paragraphs[0]
    p_title.paragraph_format.space_after = Pt(4)
    r_t = p_title.add_run(title)
    r_t.font.name = 'Times New Roman'
    r_t.font.size = Pt(14)
    r_t.font.bold = True
    r_t.font.color.rgb = RGBColor(int(border_color[:2], 16), int(border_color[2:4], 16), int(border_color[4:], 16))
    
    for item in items:
        p_item = cell.add_paragraph()
        p_item.paragraph_format.space_after = Pt(3)
        if isinstance(item, tuple):
            lead = item[0]
            desc = item[1]
            r_lead = p_item.add_run(lead)
            r_lead.font.name = 'Times New Roman'
            r_lead.font.size = Pt(14)
            r_lead.font.bold = True
            r_desc = p_item.add_run(" " + desc)
            r_desc.font.name = 'Times New Roman'
            r_desc.font.size = Pt(14)
        else:
            r_it = p_item.add_run(item)
            r_it.font.name = 'Times New Roman'
            r_it.font.size = Pt(14)
            
    p_space = doc.add_paragraph()
    p_space.paragraph_format.space_after = Pt(8)

def add_image_card_tamil(doc, img_path, caption, filename_tamil, alt_tamil):
    if not os.path.exists(img_path):
        print(f"எச்சரிக்கை: படம் காணப்படவில்லை -> {img_path}")
        return
        
    p_img = doc.add_paragraph()
    p_img.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_img.paragraph_format.space_before = Pt(8)
    p_img.paragraph_format.space_after = Pt(4)
    
    run_img = p_img.add_run()
    run_img.add_picture(img_path, width=Inches(6.2))
    
    p_cap = doc.add_paragraph()
    p_cap.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_cap.paragraph_format.space_after = Pt(2)
    r_cap = p_cap.add_run(caption)
    r_cap.font.name = 'Times New Roman'
    r_cap.font.size = Pt(11)
    r_cap.font.italic = True
    r_cap.font.color.rgb = RGBColor(100, 100, 100)
    
    p_meta = doc.add_paragraph()
    p_meta.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_meta.paragraph_format.space_after = Pt(10)
    
    r_fn_lbl = p_meta.add_run("தேடுபொறி கோப்புப் பெயர்: ")
    r_fn_lbl.font.name = 'Times New Roman'
    r_fn_lbl.font.size = Pt(10)
    r_fn_lbl.font.bold = True
    r_fn_lbl.font.color.rgb = RGBColor(80, 80, 80)
    
    r_fn_val = p_meta.add_run(f"{filename_tamil}   |   ")
    r_fn_val.font.name = 'Times New Roman'
    r_fn_val.font.size = Pt(10)
    r_fn_val.font.color.rgb = RGBColor(80, 80, 80)
    
    r_alt_lbl = p_meta.add_run("மாற்று உரை: ")
    r_alt_lbl.font.name = 'Times New Roman'
    r_alt_lbl.font.size = Pt(10)
    r_alt_lbl.font.bold = True
    r_alt_lbl.font.color.rgb = RGBColor(80, 80, 80)
    
    r_alt_val = p_meta.add_run(alt_tamil)
    r_alt_val.font.name = 'Times New Roman'
    r_alt_val.font.size = Pt(10)
    r_alt_val.font.color.rgb = RGBColor(80, 80, 80)

def add_faqs_tamil(doc, faq_list):
    add_h2(doc, "அடிக்கடி கேட்கப்படும் வினாக்கள் (கேள்வி பதில்கள்)", color="0000FF")
    for idx, (q, a) in enumerate(faq_list, 1):
        p_q = doc.add_paragraph(style='Heading 3')
        p_q.paragraph_format.space_before = Pt(8)
        p_q.paragraph_format.space_after = Pt(3)
        r_q = p_q.add_run(f"{idx}. {q}")
        r_q.font.name = 'Times New Roman'
        r_q.font.size = Pt(13)
        r_q.font.bold = True
        r_q.font.color.rgb = RGBColor(0, 0, 0)
        
        p_a = doc.add_paragraph()
        p_a.paragraph_format.space_after = Pt(6)
        r_a = p_a.add_run(a)
        r_a.font.name = 'Times New Roman'
        r_a.font.size = Pt(14)

