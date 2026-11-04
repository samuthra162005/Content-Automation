import docx
import re
import statistics

def audit_run_blog(doc, kw):
    elements_words = []
    kw_positions = []
    sentences = []
    links = []
    faq_reached = False
    pre_faq_words = 0
    faq_words = 0
    faq_answers = []
    current_h2 = "Intro"
    
    for child in doc.element.body:
        tag = child.tag.split('}')[-1]
        if tag == 'p':
            p_elem = docx.text.paragraph.Paragraph(child, doc)
            text = p_elem.text.strip()
            
            if 'Frequently Asked Questions' in text:
                faq_reached = True
                
            if p_elem.style.name.startswith("Heading 2"):
                current_h2 = text
                
            if text:
                p_words = text.split()
                if faq_reached:
                    faq_words += len(p_words)
                    # Check if answer
                    if not p_elem.style.name.startswith("Heading"):
                        faq_answers.append((len(p_words), text))
                else:
                    pre_faq_words += len(p_words)
                    s_list = [s.strip() for s in re.split(r'[.!?]+', text) if s.strip() and len(s.strip().split()) > 1]
                    for s in s_list:
                        sentences.append(len(s.split()))
                        
                matches = [m.start() for m in re.finditer(re.escape(kw), text, re.IGNORECASE)]
                for m in matches:
                    prefix_len = len(text[:m].split())
                    w_pos = len(elements_words) + prefix_len
                    kw_positions.append((w_pos, p_elem.style.name, text[:45]))
                    
                elements_words.extend(p_words)
                
            for h in p_elem._element.xpath('.//w:hyperlink'):
                r_id = h.get('{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id')
                url = doc.part.rels[r_id].target_ref if r_id in doc.part.rels else 'UNKNOWN'
                link_text = ''.join(h.xpath('.//w:t/text()')).strip()
                links.append((link_text, url, current_h2))
                
        elif tag == 'tbl':
            tbl_elem = docx.table.Table(child, doc)
            tbl_text = ' '.join(cell.text.strip() for row in tbl_elem.rows for cell in row.cells)
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
    for l_text, l_url, l_sec in links:
        print(f"  - [{l_text}] -> {l_url} (in {l_sec[:30]})")
    print(f"Total KW Occurrences: {len(kw_positions)}")
    for i, (pos, style, sample) in enumerate(kw_positions):
        print(f"  [{i+1}] Word {pos} ({pos+kw_words}) in [{style}]: '{sample}...'")
        if i > 0:
            prev_end = kw_positions[i-1][0] + kw_words
            gap = pos - prev_end
            print(f"      --> Gap from previous occurrence: {gap} words")
    print(f"FAQ Answers count: {len(faq_answers)}")
    for i, (ans_len, ans_txt) in enumerate(faq_answers, 1):
        print(f"  FAQ {i} Answer: {ans_len} words (Target: 15-25 words) -> '{ans_txt[:60]}...'")
    print("="*60)
    return pre_faq_words, faq_words, total_words, burstiness, links, kw_positions, faq_answers

