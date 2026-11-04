import docx
import re
import statistics
import os
import sys

sys.path.append(r"d:\content\projects\nallore-vattam\generators")
from build_nallore_vattam_doc import (
    create_nallore_document,
    add_title,
    add_metadata_block_tamil,
    add_para,
    add_h2,
    add_h3,
    add_image_card_tamil,
    add_callout_box,
    add_faqs_tamil
)

ASSETS_DIR = r"d:\content\projects\nallore-vattam\2026-11-04\assets"
OUTPUT_DIR = r"d:\content\projects\nallore-vattam\2026-11-04"

# Audit helper
def audit_doc(doc, kw):
    elements_words = []
    kw_positions = []
    sentences = []
    links = []
    english_chars = []
    
    faq_reached = False
    pre_faq_words = 0
    faq_words = 0
    current_h2 = "துவக்கம்"
    
    for child in doc.element.body:
        tag = child.tag.split('}')[-1]
        if tag == 'p':
            p_elem = docx.text.paragraph.Paragraph(child, doc)
            text = p_elem.text.strip()
            
            eng = re.findall(r'[A-Za-z]', text)
            if eng: english_chars.extend(eng)
            
            if 'அடிக்கடி கேட்கப்படும் வினாக்கள்' in text:
                faq_reached = True
                
            if p_elem.style.name.startswith("Heading 2"):
                current_h2 = text
                
            if text:
                p_words = text.split()
                if faq_reached:
                    faq_words += len(p_words)
                else:
                    pre_faq_words += len(p_words)
                    s_list = [s.strip() for s in re.split(r'[.!?|]+', text) if s.strip() and len(s.strip().split()) > 1]
                    for s in s_list:
                        sentences.append(len(s.split()))
                        
                matches = [m.start() for m in re.finditer(re.escape(kw), text)]
                for m in matches:
                    prefix_len = len(text[:m].split())
                    w_pos = len(elements_words) + prefix_len
                    kw_positions.append((w_pos, p_elem.style.name, text[:40]))
                    
                elements_words.extend(p_words)
                
            for h in p_elem._element.xpath('.//w:hyperlink'):
                r_id = h.get('{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id')
                url = doc.part.rels[r_id].target_ref if r_id in doc.part.rels else 'UNKNOWN'
                link_text = ''.join(h.xpath('.//w:t/text()')).strip()
                links.append((link_text, url, current_h2))
                
        elif tag == 'tbl':
            tbl_elem = docx.table.Table(child, doc)
            tbl_text = ' '.join(cell.text.strip() for row in tbl_elem.rows for cell in row.cells)
            eng = re.findall(r'[A-Za-z]', tbl_text)
            if eng: english_chars.extend(eng)
            t_words = tbl_text.split()
            if not faq_reached:
                pre_faq_words += len(t_words)
            else:
                faq_words += len(t_words)
            elements_words.extend(t_words)
            
    total_words = pre_faq_words + faq_words
    burstiness = statistics.stdev(sentences) if len(sentences) > 1 else 0
    kw_words = len(kw.split())
    
    print("="*60)
    print(f"Pre-FAQ Words: {pre_faq_words} (Target: 400-450)")
    print(f"FAQ Words:     {faq_words}")
    print(f"Total Words:   {total_words} (Target: 540-580)")
    print(f"Burstiness:    {burstiness:.2f} (Target: > 8.0)")
    print(f"Links count:   {len(links)} (Target: 3)")
    print(f"English chars: {len(english_chars)} -> {set(english_chars)}")
    print(f"Total KW Occurrences: {len(kw_positions)}")
    for i, (pos, style, sample) in enumerate(kw_positions):
        print(f"  [{i+1}] Word {pos} ({pos+kw_words}) in [{style}]: '{sample}...'")
        if i > 0:
            prev_end = kw_positions[i-1][0] + kw_words
            gap = pos - prev_end
            print(f"      --> Gap from previous occurrence: {gap} words")
    print("="*60)
    return pre_faq_words, faq_words, total_words, burstiness, links, english_chars, kw_positions

