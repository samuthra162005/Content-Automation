import os
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
    set_cell_margins(cell, top=180, bottom=180, left=240, right=200)
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

import html

def add_hyperlink(paragraph, url, text, color="0369A1", underline=True):
    part = paragraph.part
    r_id = part.relate_to(url, docx.opc.constants.RELATIONSHIP_TYPE.HYPERLINK, is_external=True)
    hyperlink = parse_xml(f'<w:hyperlink {nsdecls("w")} r:id="{r_id}" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"/>')
    escaped_text = html.escape(text)
    new_run = parse_xml(f'<w:r {nsdecls("w")}><w:rPr><w:color w:val="{color}"/><w:u w:val="single"/></w:rPr><w:t xml:space="preserve">{escaped_text}</w:t></w:r>')
    hyperlink.append(new_run)
    paragraph._p.append(hyperlink)

def create_index_doc(filepath):
    doc = docx.Document()
    for s in doc.sections:
        s.top_margin = Inches(1)
        s.bottom_margin = Inches(1)
        s.left_margin = Inches(1)
        s.right_margin = Inches(1)

    # Document Header Label
    p_meta = doc.add_paragraph()
    r = p_meta.add_run("FORTUNE CITY, ERODE | CLUSTER INDEX BLOG")
    r.font.name = "Arial"
    r.font.size = Pt(9.5)
    r.font.bold = True
    r.font.color.rgb = RGBColor(15, 44, 89)
    p_meta.paragraph_format.space_after = Pt(4)

    # HTML Marker
    p_tag = doc.add_paragraph()
    r_tag = p_tag.add_run("[HTML HEADING: <H1>]")
    r_tag.font.name = "Arial"
    r_tag.font.size = Pt(9)
    r_tag.font.bold = True
    r_tag.font.color.rgb = RGBColor(3, 105, 161)
    p_tag.paragraph_format.space_after = Pt(2)

    # Title
    p_title = doc.add_paragraph()
    r_title = p_title.add_run("Best Places in Erode for Shopping, Food, Entertainment & Services")
    r_title.font.name = "Arial"
    r_title.font.size = Pt(20)
    r_title.font.bold = True
    r_title.font.color.rgb = RGBColor(15, 44, 89)
    p_title.paragraph_format.space_after = Pt(14)

    # Overview Callout
    t_box = doc.add_table(rows=1, cols=1)
    t_box.alignment = WD_TABLE_ALIGNMENT.CENTER
    t_box.autofit = False
    t_box.columns[0].width = Inches(6.5)
    set_callout_borders(t_box, border_color="0F2C59", bg_hex="F8FAFC")
    cell = t_box.cell(0, 0)
    p_box = cell.paragraphs[0]
    p_box.paragraph_format.space_after = Pt(4)
    r_b = p_box.add_run("Cluster Theme & Pillar Overview\n")
    r_b.font.name = "Arial"
    r_b.font.size = Pt(10.5)
    r_b.font.bold = True
    r_b.font.color.rgb = RGBColor(15, 44, 89)
    r_desc = p_box.add_run(
        "A comprehensive directory and hub guide exploring premier leisure, commercial, culinary, and lifestyle destinations across Erode, Tamil Nadu—centered around the integrated facilities of Fortune City on NH 544."
    )
    r_desc.font.name = "Arial"
    r_desc.font.size = Pt(9.5)
    r_desc.font.color.rgb = RGBColor(51, 65, 85)

    doc.add_paragraph().paragraph_format.space_after = Pt(8)

    # 6 Cluster Topics
    topics = [
        ("1. Rainy Day in Erode? Explore Indoor Entertainment for Families",
         "Discover indoor entertainment in Erode during rainy days with family-friendly activities, multiplex movies, shopping, and dining experiences at Fortune City's Fortune Multiplex and Avenue Malls."),
        ("2. How Much Does a Wedding Hall Cost in Erode? A Budget Planning Guide",
         "Understand wedding hall costs in Erode, from seating capacities and decor packages to dining facilities and guest amenities, featuring grand celebrations at Fortune Wedding Mahal."),
        ("3. What to Eat on a Rainy Day? Popular Comfort Foods in Tamil Nadu",
         "Discover popular rainy-season comfort foods in Tamil Nadu, from hot snacks and authentic filter coffee to diverse multicuisine dining at Fortune City's Food Valley."),
        ("4. How to Check Cotton Fabric Quality Before Buying Wholesale?",
         "Learn how to identify good-quality cotton fabric before buying wholesale by checking yarn count, weave density, texture, and durability at Texvalley wholesale textile market in Erode."),
        ("5. Is It Safe to Charge an Electric Car During Rain?",
         "Learn essential safety precautions, weatherproofing standards, and smart charging tips when using high-speed EV charging stations near NH 544 at Fortune City."),
        ("6. Co-Living vs PG Accommodation: Which Is Better for Working Professionals?",
         "Compare co-living spaces and traditional PG accommodation based on cost, personal privacy, modern facilities, and community living at Fortune City's Retail Arcade & Co-Living suites.")
    ]

    for title, desc in topics:
        p_t = doc.add_paragraph()
        p_t.paragraph_format.space_after = Pt(2)
        r_t = p_t.add_run(title)
        r_t.font.name = "Arial"
        r_t.font.size = Pt(11)
        r_t.font.bold = True
        r_t.font.color.rgb = RGBColor(15, 44, 89)

        p_d = doc.add_paragraph()
        p_d.paragraph_format.space_after = Pt(8)
        r_d = p_d.add_run(desc)
        r_d.font.name = "Arial"
        r_d.font.size = Pt(10)
        r_d.font.color.rgb = RGBColor(51, 65, 85)

    doc.add_paragraph().paragraph_format.space_after = Pt(6)

    # Also Read
    p_ar = doc.add_paragraph()
    p_ar.paragraph_format.space_after = Pt(4)
    r_ar = p_ar.add_run("Also Read: ")
    r_ar.font.name = "Arial"
    r_ar.font.size = Pt(10.5)
    r_ar.font.bold = True
    r_ar.font.color.rgb = RGBColor(15, 44, 89)
    add_hyperlink(p_ar, "https://www.fortunecity.in/blog/best-shopping-mall-in-tamil-nadu-for-shopping-dining-and-entertainment", "Best Shopping Mall in Tamil Nadu for Shopping, Dining and Entertainment")

    # Source
    p_src = doc.add_paragraph()
    p_src.paragraph_format.space_after = Pt(2)
    r_s = p_src.add_run("Source:")
    r_s.font.name = "Arial"
    r_s.font.size = Pt(10.5)
    r_s.font.bold = True
    r_s.font.color.rgb = RGBColor(15, 44, 89)

    p_s1 = doc.add_paragraph()
    p_s1.paragraph_format.space_after = Pt(2)
    add_hyperlink(p_s1, "https://www.goodhomes.co.in/lifestyle/finance/budget-series-how-to-shop-smart-and-save-money-7494.html", "Budget Series: How To Shop Smart and Save Money")

    p_s2 = doc.add_paragraph()
    p_s2.paragraph_format.space_after = Pt(14)
    add_hyperlink(p_s2, "https://www.thehindubusinessline.com/economy/", "Tamil Nadu Commercial Infrastructure & Retail Market Growth")

    doc.save(filepath)
    print(f"Created Index Doc: {filepath}")

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    out_dir = os.path.abspath(os.path.join(base_dir, "..", "2026-10-30"))
    create_index_doc(os.path.join(out_dir, "Index_Blog_Best_Places_in_Erode_Fortune_City.docx"))
