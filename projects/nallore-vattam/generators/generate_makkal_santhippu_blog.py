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
KW = "நல்லோர் வட்டம் மாண்புமிகு மக்கள் சந்திப்பு"

def generate_perfect_doc():
    doc = create_nallore_document()
    
    # Title (Heading 1) - 10 words
    add_title(doc, "நல்லோர் வட்டம் மாண்புமிகு மக்கள் சந்திப்பு: பாளையங்கோட்டை நிகழ்வு மற்றும் 100 துறைகளின் சமூக எழுச்சி")
    
    # Metadata Block in Pure Tamil (User-Searchable Keywords)
    add_metadata_block_tamil(
        doc,
        meta_title="நல்லோர் வட்டம் மாண்புமிகு மக்கள் சந்திப்பு: புதிய சமூக எழுச்சி",
        primary_kw="நல்லோர் வட்டம் மாண்புமிகு மக்கள் சந்திப்பு",
        secondary_kws=[
            "மாண்புமிகு மக்கள் சந்திப்பு",
            "மாணிக்க மாணவர் திட்டம்",
            "நம்பிக்கை செய்திகள்",
            "தன்னாட்சி நடைப்பயணம்",
            "கிராம வளர்ச்சி குழு"
        ],
        meta_desc="பாளையங்கோட்டையில் நல்லோர் வட்டம் மக்கள் சந்திப்பு மற்றும் தன்னாட்சி நடைப்பயணம்."
    )
    
    # -------------------------------------------------------------
    # 3-BEAT OPENING HOOK (Intro Section - Pure Narrative Prose, 0 Bullets)
    # -------------------------------------------------------------
    # Beat 1: Sensory Scene (Rich compound sentence for burstiness)
    add_para(doc, [
        ("கற்பனை செய்து பாருங்கள்; திருநெல்வேலி பாளையங்கோட்டையின் அமைதியான அரங்கில், சமுதாய மாற்றத்தை விரும்பும் நாற்பதுக்கும் மேற்பட்ட சாமானிய குடிமக்கள் ஒன்று கூடி, தமது கிராமங்களையும் நகரங்களையும் மேம்படுத்தும் நூறு துறைச் செயல் திட்டங்களை நேரில் தீவிரமாக விவாதித்து புதிய சமூக எழுச்சியை நேர்த்தியாக உருவாக்குகிறார்கள். ", False, "990000"),
        ("எளிய மக்களின் நேரடிப் பங்களிப்பு மாற்றத்தை உருவாக்குமா?", True, "990000")
    ])
    # Beat 2: Dilemma (Short punchy sentences)
    add_para(doc, "தடைகள் உடையும். துணிவு வெல்லும்.")
    # Beat 3: Solution + Primary Keyword (KW Mention 1 in Intro)
    add_para(doc, [
        ("அந்தத் தடையை உடைத்து, விழிப்புணர்வை விதைக்கிறது ", False),
        ("நல்லோர் வட்டம் மாண்புமிகு மக்கள் சந்திப்பு", True), # KW 1 in Intro
        (", புதிய சமுதாயப் பொறுப்புணர்வை மக்களிடையே முன்னெடுக்கிறது.", False)
    ])
    
    # -------------------------------------------------------------
    # SECTION 2: WHY SECTION (H2 #1) WITH MANDATORY BULLET POINTS
    # -------------------------------------------------------------
    add_h2(doc, "ஏன் குடிமக்களின் சுய பொறுப்பேற்பு சமுதாய மறுமலர்ச்சியின் அச்சாணியாக மாறுகிறது?")
    add_para(doc, "அரசியல் மேடைகளில் அல்ல, குடிமக்களின் கூட்டுச் சிந்தனையில்தான் நாட்டின் எதிர்காலம் மலர்கிறது. விழிப்புணர்வு வேண்டும். ஒற்றுமை வெல்லும். தன்னம்பிக்கை உயரும்.")
    
    # 3 Structured Bullet Points (Scannable Breakdown)
    add_para(doc, "• சுய பொறுப்பேற்பு: நூறு துறைகளிலும் ஒவ்வொரு குடிமகனும் பொறுப்பேற்றுச் செயல்படுதல்.")
    add_para(doc, "• இளைய தலைமுறை: மாணவிகளை சாதனையாளர்களாக உயர்த்தும் தொடர் பயிற்சி வழங்குதல்.")
    add_para(doc, "• கிராம வளர்ச்சி: தன்னாட்சி ஊராட்சிகளை உருவாக்கி இயற்கை கிராம வளம் காத்தல்.")
    
    # Explanatory narrative with Internal Link 1 (Expanded compound sentence: 49 words for burstiness stdev > 8.0!)
    add_para(doc, [
        ("முன்னாள் இந்தியக் குடியரசுத் தலைவர் டாக்டர் அப்துல் கலாம் அவர்கள் நல்லோர் வட்டத்தின் மீது ஆழமாக வைத்திருந்த அசைக்க முடியாத பெருநம்பிக்கையைத் தொடர்ந்து, ", False),
        ("நல்லோர் வட்டம் அதிகாரப்பூர்வ மக்கள் இயக்கம்", False, "0000FF", "http://nallorevattam.org/"),
        (" தன்னலமற்ற மாபெரும் அறிவார்ந்த சிந்தனையாளர்களையும் இளம் தலைமுறை இளைஞர்களையும் ஒன்றிணைத்துத் தமிழகத்தின் ஒவ்வொரு மாவட்டத்திலும் கிராமப்புறக் கல்வி மற்றும் உள்ளாட்சிக் களங்களில் புதிய விடியலையும் நீடித்த மக்கள் விழிப்புணர்வையும் மிகத் தீவிரமாக முன்னெடுக்கிறது.", False)
    ])
    
    # -------------------------------------------------------------
    # SECTION 3: ACTION HIGHLIGHTS & STEPS (H2 #2)
    # Subheading with Primary Keyword! (KW Mention 2)
    # -------------------------------------------------------------
    add_h2(doc, "களப்பணிகளில் நல்லோர் வட்டம் மாண்புமிகு மக்கள் சந்திப்பு சாதனைகள்")
    
    # Image Card with Realistic Poster
    add_image_card_tamil(
        doc,
        img_path=os.path.join(ASSETS_DIR, "nallore_vattam_citizen_meeting_poster.jpg"),
        caption="படம் 1: குடிமக்கள் கலந்தாய்வு.",
        filename_tamil="நல்லோர்-வட்டம்-சந்திப்பு-படம்",
        alt_tamil="குடிமக்கள் கலந்தாய்வு அரங்கம்"
    )
    
    # Step 1
    add_h3(doc, "1 - பாளையங்கோட்டை மக்கள் சந்திப்பு")
    add_para(doc, "பொறுப்புணர்வு மலர்கிறது. சந்திப்பில் 13 பொறுப்பாளர்கள் உறுதி பூண்டனர். அரசியலமைப்பு முகப்புரை வாசிக்கப்பட்டது.")
    
    # Step 2
    add_h3(doc, "2 - சென்னை மாணிக்க மாணவர் கலந்தாய்வு")
    add_para(doc, "தன்னம்பிக்கை பிறக்கிறது. தீர்வு நம்மிடமே உள்ளது என்பதை மாணவிகள் 1+3 சூத்திரம் மூலம் தெளிவாக உணர்ந்தனர்.")
    
    # Step 3
    add_h3(doc, "3 - தர்மபுரி கலாம் விழா திட்டமிடல்")
    add_para(doc, "பெண் தொழில்முனைவோர் இணைந்தனர். மகளிர் சுய உதவிக்குழுப் பொறுப்பாளர்கள் புதிய விழிப்புணர்வுடன் பங்கேற்றனர்.")
    
    # Step 4: External Authority Link
    add_h3(doc, "4 - தன்னாட்சி 2000 கிலோமீட்டர் நடைப்பயணம்")
    add_para(doc, [
        ("சுயாட்சி காப்போம். ", False),
        ("இந்து தமிழ் திசை நாளிதழின் இளைஞர் மற்றும் கல்விச் செய்தி அறிக்கை", False, "0000FF", "https://www.hindutamil.in/news/vetrikodi/an-entrepreneurial-venture-in-tenkasi"),
        (" சுட்டிக்காட்டியபடி, தொட்டபெட்டாவில் தொடங்கி 100 நாட்கள் மக்களைச் சந்திக்கும் வரலாற்று நடைப்பயணம் தொடங்குகிறது.", False)
    ])
    
    # Step 5: KW Mention 3 in Body Paragraph!
    add_h3(doc, "5 - புளியம்பட்டி கிராம விழிப்புணர்வு")
    add_para(doc, [
        ("உள்ளாட்சி பலப்படுகிறது. புளியம்பட்டி கிராம வளர்ச்சி குழு பொறுப்பாளருக்கு நினைவுப் புத்தகம் வழங்கி, பணிகளை முன்னெடுக்கிறது ", False),
        ("நல்லோர் வட்டம் மாண்புமிகு மக்கள் சந்திப்பு", True), # KW 3 in Body
        (". ஊராட்சிகளில் இளைஞர்களின் பங்களிப்பு உறுதியானது. மாற்றம் பிறக்கிறது.", False)
    ])
    
    # Single-Cell Callout Box in Pure Tamil (Callout title without KW!)
    add_callout_box(doc, "களப்பணிகளின் முதன்மை இலக்குகள் மற்றும் திட்டங்கள்", [
        ("100 துறைகளில் பொறுப்பு:", "ஒவ்வொரு குடிமகனும் ஒரு குறிப்பிட்ட துறையில் சமூகப் பொறுப்பேற்றல்."),
        ("மாணிக்க மாணவர்:", "மாணவர்களிடையே சுய தலைமைப் பண்பையும் தீர்வு காணும் திறனையும் வளர்த்தல்."),
        ("தன்னாட்சி நடைப்பயணம்:", "கிராம ஊராட்சிகளில் உள்ளாட்சி விழிப்புணர்வு ஏற்படுத்துதல்.")
    ])
    
    # -------------------------------------------------------------
    # SECTION 4: MOVEMENT SPOTLIGHT (H2 #3)
    # -------------------------------------------------------------
    add_h2(doc, "கலாம் கண்ட லட்சிய சமுதாயத்தை உருவாக்கும் நல்லோர் வட்டம் பேரியக்கம்")
    add_para(doc, [
        ("சமூகத்தில் உள்ள நல்ல மனிதர்களை ஒருங்கிணைக்கும் உயரிய லட்சியப் பாதையில், ", False),
        ("மாண்புமிகு மக்கள் சந்திப்பு காணொளிப் பதிவு", False, "0000FF", "https://youtu.be/mVwgks44XUU?si=dzKXcBE_sCw4yWVt"),
        (" வழியே நல்லோர் வட்டம் மக்கள் இயக்கம் நமது கிராமப்புறத்து இளைஞர்களிடையே புதிய விடியலையும் சமூக மறுமலர்ச்சியையும் விரைவாக விதைத்து வருகிறது. ஒற்றுமை ஓங்குகிறது. எழுச்சி தொடர்கிறது.", False)
    ])
    
    # -------------------------------------------------------------
    # SECTION 5: WARM CONCLUSION (H2 #4)
    # KW Mention 4 in Conclusion!
    # -------------------------------------------------------------
    add_h2(doc, "புதிய தமிழகத்தின் விடியலுக்காக ஒவ்வொரு குடிமகனும் பொறுப்பேற்போம்!")
    add_para(doc, "அறிவும் நேர்மையும் கொண்ட தலைமுறையே நாட்டின் பலம். மாற்றம் நம்மில் தொடங்கட்டும். எதிர்காலம் சிறக்கும்.")
    add_para(doc, [
        ("செயல் துணிவு பிறக்கட்டும். தன்னம்பிக்கை வெல்லும். சமுதாய மறுமலர்ச்சிக்கு வழிகாட்டுகிறது ", False),
        ("நல்லோர் வட்டம் மாண்புமிகு மக்கள் சந்திப்பு", True), # KW 4 in Conclusion
        (". விடியல் பிறக்கும்.", False)
    ])
    add_para(doc, [("“ஒவ்வொரு மனிதரும் சமுதாயத் துறைகளில் பொறுப்பெடுத்துச் செயல்படும்போது, புதிய தமிழகத்தின் விடியல் உடனடியாகச் சாத்தியமாகும்.”", True, "38761D")])
    
    # -------------------------------------------------------------
    # SECTION 6: FAQs (4 FAQs with short answers 15-20 words each)
    # -------------------------------------------------------------
    add_faqs_tamil(doc, [
        ("மாண்புமிகு மக்கள் சந்திப்பு நிகழ்வின் முதன்மை நோக்கம் என்ன?",
         "சமுதாயத்தின் நூறு வெவ்வேறு துறைகளில் குடிமக்கள் தாமாகவே பொறுப்பெடுத்துச் செயல்படுவதன் மூலம் வளர்ந்த லட்சிய தமிழகத்தை உருவாக்குவதே இதன் முதன்மை நோக்கமாகும்."),
        ("சென்னையில் நடைபெற்ற மாணிக்க மாணவர் அமர்வில் மாணவிகள் கற்றுக் கொண்டது என்ன?",
         "சமூகப் பிரச்சனைகளுக்குத் தீர்வு நம்மிடமே உள்ளது என்பதையும், 1+3 சூத்திரம் மூலம் பொறுப்புணர்வுடன் செயல்படுவதையும் மாணவிகள் முழுமையாகக் கற்றுக் கொண்டனர்."),
        ("தன்னாட்சி நடைப்பயணம் எங்கு தொடங்கி எங்கு நிறைவடைகிறது?",
         "காந்தி ஜெயந்தி அன்று நீலகிரி தொட்டபெட்டாவில் தொடங்கும் 2000 கிலோமீட்டர் விழிப்புணர்வு நடைப்பயணம், 100 நாட்கள் மக்களைச் சந்தித்து சென்னையில் நிறைவடைகிறது."),
        ("புளியம்பட்டி கிராமத்தில் நடைபெற்ற இல்லம் தேடி நிகழ்வின் சிறப்பம்சம் என்ன?",
         "கிராம வளர்ச்சி குழு பொறுப்பாளருக்கு நினைவுப் புத்தகம் வழங்கி, உள்ளாட்சி அமைப்புகளில் இளைஞர்களின் நேரடிப் பங்களிப்பை ஊக்கப்படுத்துவதே இதன் முக்கிய சிறப்பம்சமாகும்.")
    ])
    
    out_path = os.path.join(OUTPUT_DIR, "Nallore_Vattam_Makkal_Santhippu_Blog.docx")
    doc.save(out_path)
    return doc, out_path

def audit_document(doc):
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
    kw_words = len(KW.split())
    
    print("="*60)
    print(f"File Saved:    {OUTPUT_DIR}\\Nallore_Vattam_Makkal_Santhippu_Blog.docx")
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

if __name__ == "__main__":
    doc, path = generate_perfect_doc()
    audit_document(doc)
