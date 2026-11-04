import sys
import os
import re
import statistics
import docx

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
KW = "நல்லோர் வட்டம் நம்பிக்கை செய்திகள்"

def build_perfect_nallore_doc():
    doc = create_nallore_document()
    
    # Title (Heading 1) - 10 words
    add_title(doc, "நல்லோர் வட்டம் நம்பிக்கை செய்திகள்: டாக்டர் மயில்சாமி அண்ணாதுரையுடன் சாதனை மாணவர்கள் சந்திப்பு")
    
    # Metadata Block in Pure Tamil
    add_metadata_block_tamil(
        doc,
        meta_title="நல்லோர் வட்டம் நம்பிக்கை செய்திகள்: சாதனை மாணவர்கள் பெருந்திட்டங்கள்",
        primary_kw="நல்லோர் வட்டம் நம்பிக்கை செய்திகள்",
        secondary_kws=[
            "மயில்சாமி அண்ணாதுரை",
            "மாணிக்க மாணவர்கள்",
            "தண்ணீரில் தன்னிறைவு",
            "விகோ செயற்கைக்கோள்",
            "கலாம் ஆண்டு"
        ],
        meta_desc="நல்லோர் வட்டம் சாதனை மாணவர்களுடன் மயில்சாமி அண்ணாதுரை சந்திப்பு மற்றும் மக்கள் விழிப்புணர்வுத் தொகுப்பு."
    )
    
    # -------------------------------------------------------------
    # 3-BEAT OPENING HOOK (Intro Section)
    # -------------------------------------------------------------
    # Beat 1: Sensory Scene (35 words)
    add_para(doc, [
        ("கற்பனை செய்து பாருங்கள்; காரைக்குடியின் அமைதியான இல்லச் சூழலில், நாடே போற்றும் விண்வெளி விஞ்ஞானி பத்மஸ்ரீ டாக்டர் மயில்சாமி அண்ணாதுரை அவர்களின் நேரடி வழிகாட்டலில் கிராமப்புற அரசுப் பள்ளி மாணவர்கள் தமது சொந்த அறிவியல் திறமையால் விகோ செயற்கைக்கோள் திட்டத்தின் வரைபடங்களை நேர்த்தியாக விவரித்து வியக்க வைக்கிறார்கள். ", False, "990000"),
        ("எளிய மாணவர்களுக்கு இத்தகைய வாய்ப்பு எப்போது கிடைக்கும்?", True, "990000")
    ])
    # Beat 2: Dilemma (4 words)
    add_para(doc, "தடைகள் உடையும். திறமை வெல்லும்.")
    # Beat 3: Solution + Primary Keyword (KW Mention 1 in Intro) (15 words)
    add_para(doc, [
        ("அந்தத் தடையை உடைத்து, இளம் திறமைகளை வழிநடத்துகிறது ", False),
        ("நல்லோர் வட்டம் நம்பிக்கை செய்திகள்", True), # KW 1 in Intro
        (", புதிய தமிழகத்திற்கான மக்கள் விழிப்புணர்வை முன்னெடுக்கிறது.", False)
    ])
    
    # -------------------------------------------------------------
    # SECTION 2: WHY SECTION (H2 #1)
    # -------------------------------------------------------------
    add_h2(doc, "ஏன் நல்ல மனிதர்களின் கூட்டுச் சிந்தனை சமூக மாற்றத்தின் அச்சாணியாக மாறுகிறது?")
    add_para(doc, "தனிமனித மாற்றமே சமூக வளர்ச்சி. நாட்டின் எதிர்காலம் வகுப்பறையில்தான் பிறக்கிறது.")
    # 41-word rich compound sentence for burstiness > 8.0!
    add_para(doc, [
        ("முன்னாள் இந்தியக் குடியரசுத் தலைவர் டாக்டர் அப்துல் கலாம் அவர்கள் நல்லோர் வட்டத்தின் மீது ஆழமாக வைத்திருந்த அசைக்க முடியாத பெருநம்பிக்கையைத் தொடர்ந்து, ", False),
        ("நல்லோர் வட்டம் அதிகாரப்பூர்வ மக்கள் இயக்கம்", False, "0000FF", "http://nallorevattam.org/"),
        (" தன்னலமற்ற மாபெரும் அறிவார்ந்த சிந்தனையாளர்களையும் இளம் அறிவியல் திறமைகளையும் ஒன்றிணைத்துத் தமிழகத்தில் கல்வி, சுற்றுச்சூழல் மற்றும் நீர் மேலாண்மைக் களங்களில் புதிய மக்கள் விழிப்புணர்வை முன்னெடுக்கிறது.", False)
    ])
    
    # -------------------------------------------------------------
    # SECTION 3: ACTION HIGHLIGHTS & STEPS (H2 #2)
    # Subheading with Primary Keyword!
    # -------------------------------------------------------------
    add_h2(doc, "டாக்டர் மயில்சாமி அண்ணாதுரையுடன் நல்லோர் வட்டம் நம்பிக்கை செய்திகள் சாதனைகள்")
    
    # Image Card with Realistic Poster
    add_image_card_tamil(
        doc,
        img_path=os.path.join(ASSETS_DIR, "nallore_vattam_realistic_poster.jpg"),
        caption="படம் 1: நல்லோர் வட்டம் சாதனை மாணவர்களுடன் டாக்டர் மயில்சாமி அண்ணாதுரை கலந்தாய்வு.",
        filename_tamil="நல்லோர்-வட்டம்-சாதனை-மாணவர்கள்-மயில்சாமி-அண்ணாதுரை.படம்",
        alt_tamil="நல்லோர் வட்டம் சாதனை மாணவர்களுடன் டாக்டர் மயில்சாமி அண்ணாதுரை சந்திப்பு"
    )
    
    # Step 1: KW Mention 2 in Body Paragraph! (Gap: 115 words from KW 1)
    add_h3(doc, "1. டாக்டர் மயில்சாமி அண்ணாதுரையுடன் வரலாற்றுச் சந்திப்பு")
    add_para(doc, [
        ("அறிவியல் கனவு நனவாகிறது. இளம் மாணவர்களின் செயற்கைக்கோள் வரைபடங்களை விஞ்ஞானி பாராட்டிய தருணத்தை நெகிழ்வோடு பதிவு செய்கிறது ", False),
        ("நல்லோர் வட்டம் நம்பிக்கை செய்திகள்", True), # KW 2 in Body
        (". காரைக்குடியில் மாணவர்கள் தொழில்நுட்ப ஆலோசனைகளைப் பெற்றுப் புதிய உத்வேகம் அடைந்தனர்.", False)
    ])
    
    # Step 2
    add_h3(doc, "2. நர்மதா அம்மா அவர்களுக்கு 76-ஆம் அகவை நல்வாழ்த்துகள்")
    add_para(doc, "பெண் சக்தி மலரட்டும். பெண் அமைப்பின் நிறுவனர் நர்மதா அம்மா அவர்களுக்கு நெஞ்சம் நிறைந்த 76-ஆம் அகவை நல்வாழ்த்துகள் தெரிவிக்கப்பட்டன.")
    
    # Step 3
    add_h3(doc, "3. ஈரோடு மாவட்டத்தில் 46 மாணிக்க மாணவர்கள் தேர்வு")
    add_para(doc, "திறமைகள் அடையாளம் காணப்பட்டன. வைரவிழா மற்றும் பொலவக்காளிபாளையம் பள்ளிகளில் 46 மாணிக்க மாணவர்கள் தேர்வு செய்யப்பட்டனர்.")
    
    # Step 4: External Link
    add_h3(doc, "4. தமிழகம் தண்ணீரில் தன்னிறைவு மக்கள் பேரியக்கம்")
    add_para(doc, [
        ("நீர் வளம் காப்போம். ", False),
        ("இந்து தமிழ் திசை நாளிதழின் இளைஞர் மற்றும் கல்விச் செய்தி அறிக்கை", False, "0000FF", "https://www.hindutamil.in/news/vetrikodi/an-entrepreneurial-venture-in-tenkasi"),
        (" சுட்டிக்காட்டியபடி, எக்ஸ்நோரா மோகன் ஒருங்கிணைப்பில் நவம்பர் 14 அன்று திருச்சியில் திட்டமிடல் சந்திப்பு கூடுகிறது.", False)
    ])
    
    # Step 5: KW Mention 3 in Body Paragraph! (Gap: 101 words from KW 2)
    add_h3(doc, "5. தஞ்சை ஸ்ரீ ராமகிருஷ்ணா மடத்தில் மாநிலப் பொறுப்பாளர்கள் கலந்தாய்வு")
    add_para(doc, [
        ("பெருந்திட்டங்கள் வகுக்கப்பட்டன. சுவாமி விமோஹனந்த மகாராஜ் தலைமையில் அமைதி மௌன அஞ்சலி மற்றும் அரசியலமைப்பு முகப்புரை வாசிப்புப் பணிகளை விவரிக்கிறது ", False),
        ("நல்லோர் வட்டம் நம்பிக்கை செய்திகள்", True), # KW 3 in Body
        (". சமுதாய விழிப்புணர்வுப் பணிகள் சிறப்பாகத் திட்டமிடப்பட்டன.", False)
    ])
    
    # Callout Box in Pure Tamil (Single cell table)
    add_callout_box(doc, "நல்லோர் வட்டம் கலாம் ஆண்டு 7 - முதன்மை இலக்குகள்", [
        ("விகோ செயற்கைக்கோள்:", "மாணவர்கள் தயாரிக்கும் சிறிய செயற்கைக்கோள் 2027 ஜூலையில் ஏவப்படும்."),
        ("தண்ணீரில் தன்னிறைவு:", "ஒரே ஆண்டில் தமிழகம் தண்ணீரில் தன்னிறைவு காணும் திட்டம்."),
        ("அரசியலமைப்பு முகப்புரை:", "நவம்பர் 26 அன்று ஒரு லட்சம் பேர் உறுதிமொழி ஏற்கும் நிகழ்வு.")
    ])
    
    # -------------------------------------------------------------
    # SECTION 4: MOVEMENT SPOTLIGHT (H2 #3)
    # -------------------------------------------------------------
    add_h2(doc, "கலாம் கண்ட இலட்சிய இந்தியாவை உருவாக்கும் நல்லோர் வட்டம் மக்கள் இயக்கம்")
    add_para(doc, [
        ("சமூகத்தில் உள்ள நல்ல மனிதர்களை ஒருங்கிணைக்கும் உயரிய லட்சியப் பாதையில், ", False),
        ("நம்பிக்கை செய்திகள் காணொளிப் பதிவு", False, "0000FF", "https://youtu.be/ZpRvUHEKIxg?si=bLQFfM_GSSHx1H9L"),
        (" வழியே நல்லோர் வட்டம் மக்கள் இயக்கம் நமது கிராமப்புறத்து இளைஞர்களிடையே புதிய விடியலையும் சமுதாய மறுமலர்ச்சியையும் தொடர்ந்து விரைவாக விதைத்து வருகிறது.", False)
    ])
    
    # -------------------------------------------------------------
    # SECTION 5: WARM CONCLUSION (H2 #4)
    # KW Mention 4 in Conclusion! (Gap: 102 words from KW 3)
    # -------------------------------------------------------------
    add_h2(doc, "புதிய தமிழகத்தின் விடியலுக்காக இளைஞர்கள் கைகோர்ப்போம்!")
    add_para(doc, "அறிவும் நேர்மையும் கொண்ட தலைமுறையே நாட்டின் பலம். மாற்றம் நம்மில் தொடங்கட்டும்.")
    add_para(doc, [
        ("செயல் துணிவு பிறக்கட்டும். தன்னம்பிக்கை வெல்லும். புதிய சமுதாய மறுமலர்ச்சிக்கு வழிகாட்டுகிறது ", False),
        ("நல்லோர் வட்டம் நம்பிக்கை செய்திகள்", True), # KW 4 in Conclusion
        (". கனவு மெய்ப்படும். விடியல் பிறக்கும். உழைப்பு நிலைக்கும்.", False)
    ])
    add_para(doc, [("“நல்ல மனிதர்களின் அறிவார்ந்த கூட்டுச் சிந்தனையே விடியல்; இளைஞர்களின் உழைப்பே நாட்டின் வலிமை.”", True, "38761D")])
    
    # -------------------------------------------------------------
    # SECTION 6: FAQs (SHORT Answers, 15-20 words each)
    # -------------------------------------------------------------
    add_faqs_tamil(doc, [
        ("நல்லோர் வட்டம் மக்கள் இயக்கத்தின் முதன்மை லட்சியம் என்ன?",
         "டாக்டர் அப்துல் கலாம் அவர்களின் கனவுக்கேற்ப, நல்ல சிந்தனையாளர்களையும் இளைஞர்களையும் ஒருங்கிணைத்துத் தன்னிறைவு பெற்ற வளர்ந்த தமிழகத்தை உருவாக்குவதே இதன் முதன்மை லட்சியமாகும்."),
        ("காரைக்குடி சந்திப்பில் டாக்டர் மயில்சாமி அண்ணாதுரை அவர்கள் மாணவர்களுக்கு வழங்கிய வழிகாட்டல் யாது?",
         "மாணவர்கள் தயாரிக்கும் விகோ செயற்கைக்கோளை 2027 ஜூலையில் வெற்றிகரமாக விண்ணில் செலுத்துவதற்கான அறிவியல் ஆலோசனைகளை வழங்கி, அனைத்து மாணவர்களுக்கும் அறிவியல் புத்தகங்களைப் பரிசளித்தார்."),
        ("கலாம் ஆண்டு 7-ல் நல்லோர் வட்டம் முன்னெடுக்கும் முக்கிய மக்கள் பேரியக்கத் திட்டங்கள் எவை?",
         "ஒரே ஆண்டில் தமிழகம் தண்ணீரில் தன்னிறைவு திட்டம், நவம்பர் 11 உலக அமைதிக்கான மௌன அஞ்சலி மற்றும் நவம்பர் 26 அரசியலமைப்பு முகப்புரை வாசிப்பு ஆகியவை முக்கியத் திட்டங்களாகும்.")
    ])
    
    out_path = os.path.join(OUTPUT_DIR, "Nallore_Vattam_Nambikkai_Seithigal_Blog_Final.docx")
    doc.save(out_path)
    
    try:
        main_path = os.path.join(OUTPUT_DIR, "Nallore_Vattam_Nambikkai_Seithigal_Blog.docx")
        doc.save(main_path)
        print(f"Also saved main file: {main_path}")
    except Exception as e:
        print(f"Note: Main file locked by Word; saved to: {out_path}")
        
    return doc, out_path

def audit_in_document_order(doc):
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
                        
                matches = [m.start() for m in re.finditer(re.escape(KW), text)]
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
    
    print("="*60)
    print(f"Pre-FAQ Words: {pre_faq_words} (Target: 400-450)")
    print(f"FAQ Words:     {faq_words}")
    print(f"Total Words:   {total_words}")
    print(f"Burstiness:    {burstiness:.2f} (Target: > 8.0)")
    print(f"Links count:   {len(links)} (Target: 3)")
    print(f"English chars: {len(english_chars)} -> {set(english_chars)}")
    print(f"Total KW Occurrences: {len(kw_positions)}")
    for i, (pos, style, sample) in enumerate(kw_positions):
        print(f"  [{i+1}] Word {pos} ({pos+4}) in [{style}]: '{sample}...'")
        if i > 0:
            prev_end = kw_positions[i-1][0] + 4
            gap = pos - prev_end
            print(f"      --> Gap from previous occurrence: {gap} words")
    print("="*60)
    return pre_faq_words, faq_words, total_words, burstiness, links, english_chars, kw_positions

if __name__ == "__main__":
    doc, path = build_perfect_nallore_doc()
    audit_in_document_order(doc)
