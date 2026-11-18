import os
import sys
import docx
import re
import statistics

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
if BASE_DIR not in sys.path:
    sys.path.append(BASE_DIR)
from build_kanavu_doc import (
    create_kanavu_document,
    add_title,
    add_metadata_block,
    add_para,
    add_h2,
    add_h3,
    add_image_card,
    add_callout_box,
    add_faqs
)
def full_audit(doc):
    prose_words = 0
    table_words = 0
    faq_words = 0
    sentences = []
    faq_reached = False
    
    for child in doc.element.body:
        tag = child.tag.split('}')[-1]
        if tag == 'p':
            p_elem = docx.text.paragraph.Paragraph(child, doc)
            text = p_elem.text.strip()
            if not text:
                continue
            if 'Frequently Asked Questions' in text:
                faq_reached = True
            words = text.split()
            if faq_reached:
                faq_words += len(words)
            else:
                prose_words += len(words)
                s_list = [s.strip() for s in re.split(r'[.!?]+', text) if s.strip() and len(s.strip().split()) > 1]
                for s in s_list:
                    sentences.append(len(s.split()))
        elif tag == 'tbl':
            tbl_elem = docx.table.Table(child, doc)
            tbl_text = ' '.join(c.text.strip() for r in tbl_elem.rows for c in r.cells)
            if not faq_reached:
                table_words += len(tbl_text.split())
            else:
                faq_words += len(tbl_text.split())
                
    pre_faq = prose_words + table_words
    tot = pre_faq + faq_words
    stdev = statistics.stdev(sentences) if len(sentences) > 1 else 0
    return pre_faq, faq_words, tot, stdev

PROJECT_ROOT = os.path.abspath(os.path.join(BASE_DIR, ".."))
OUTPUT_DIR = os.path.join(PROJECT_ROOT, "2026-10-31")
ASSETS_DIR = os.path.join(OUTPUT_DIR, "assets")

INDEX_TITLE = "English Learning and Teaching Guide for Students and Teachers"
INDEX_URL = "https://school.kanavu.org/resources/english-learning-and-teaching-guide"

# ==============================================================================
# BLOG 0: INDEX PILLAR BLOG
# ==============================================================================
def build_index_blog():
    doc = create_kanavu_document()
    add_title(doc, "English Learning and Teaching Guide for Students and Teachers")
    
    add_metadata_block(
        doc,
        meta_title="English Learning and Teaching Guide for Students & Teachers",
        primary_kw="English Learning and Teaching",
        secondary_kws=[
            "Spoken English Training",
            "English Teaching Methods",
            "Classroom Speaking Activities",
            "Pronunciation Practice",
            "Tamil Medium English Fluency"
        ],
        meta_desc="Master English learning and teaching with practical classroom tips, teacher training methods, and speaking activities designed for rural and Tamil medium students."
    )
    
    add_para(doc, [
        ("Imagine a quiet morning in a government school classroom where fifty students stare silently at an open blackboard. ", False, "990000"),
        ("Suddenly, the bell rings!", True, "990000")
    ])
    add_para(doc, "Silence descends. Nobody dares speak.")
    add_para(doc, [
        ("That silent hesitation ends when practical ", False),
        ("English learning and teaching", True),
        (" shifts focus from rigid blackboard drills to lively, spoken conversations where children feel completely safe to make mistakes.", False)
    ])
    
    add_h2(doc, "Why Spoken English Confidence Matters in Rural Classrooms")
    add_para(doc, "Speech leads.")
    add_para(doc, "Traditional schools focused strictly on memorizing grammar rules, so children scored high marks on written tests yet froze in terror when asked to speak a single sentence.")
    add_para(doc, [
        ("That is why the field-tested model at ", False),
        ("Kanavu School of English", False, "0000FF", "https://school.kanavu.org/about-us"),
        (" flips old habits upside down, proving that oral practice must always lead written comprehension across rural communities.", False)
    ])
    
    add_h2(doc, "4 Core Pillars of English Learning and Teaching")
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "english_learning_teaching_guide_kanavu.png"),
        caption="Figure 1: Kanavu Statewide English Learning and Teaching Framework.",
        filename="english_learning_teaching_guide_kanavu.png",
        alt="Kanavu School of English statewide learning and teaching network across Tamil Nadu"
    )
    
    add_h3(doc, "1. Story-Based Classroom Immersion")
    add_para(doc, "Stories spark speech. Children absorb words through animated fables, deducing everyday vocabulary naturally from visual contexts.")
    
    add_h3(doc, "2. High Student Talk Time (STT)")
    add_para(doc, "Flip the ratio. Traditional classrooms give eighty percent of talk time to the teacher, but active paired speaking gives children thirty minutes of live oral practice daily.")
    
    add_h3(doc, "3. Everyday Bilingual Bridging")
    add_para(doc, "Notice familiar words. Tamil speakers already use everyday English words like fan, light, bus, and ticket daily.")
    
    add_h3(doc, "4. Dedicated Spoken Teacher Mentorship")
    add_para(doc, [
        ("Mentorship matters. As reported in a ", False),
        ("government school spoken English curriculum report in The Hindu", False, "0000FF", "https://www.thehindu.com/news/cities/chennai/spoken-english-in-govt-school-curriculum/article30091336.ece"),
        (", structured teacher workshops directly build classroom speaking confidence across government schools.", False)
    ])
    
    add_callout_box(doc, "KANAVU CLASSROOM INSIGHT", [
        ("Active Centers:", "Operating across 36 school branches in Tamil Nadu."),
        ("Oral Priority:", "85% student talk time replaces silent rote learning."),
        ("College Bridge:", "600+ students trained at PKR College for Women.")
    ])
    
    add_h2(doc, "Inside the Kanavu Learning Network Across Tamil Nadu")
    add_para(doc, [
        ("Backed by Kanavu Startup Village under CEO Mr. Karthi Easwaramoorthy, programs thrive across ", False),
        ("36+ Kanavu learning centers", False, "0000FF", "https://school.kanavu.org/location"),
        (" including Poondurai Semur and Ganapathypalayam GHSS, where dedicated mentors guide students to speak with joy.", False)
    ])
    
    add_h2(doc, "Ready to Make Spoken English Natural and Enjoyable?")
    add_para(doc, "Start today. Fluency begins with one short daily conversation, an encouraging mentor, and the absolute freedom to make joyful mistakes.")
    add_para(doc, "Words flow freely.")
    add_para(doc, [("“When students find their voice in English, they unlock bigger opportunities for life.”", True, "38761D")])
    
    add_faqs(doc, [
        ("How does Kanavu make English learning enjoyable for rural students?",
         "Kanavu uses short video fables, interactive games, and peer discussions. Children speak without fear of mistakes, connecting everyday Tamil loan words to practical English conversation stems."),
        ("Why is teacher training vital for spoken English success?",
         "When teachers build personal spoken confidence, they shift from lecture-heavy classes to student-led activities. Senior mentors train teachers in classroom drama, storytelling, and high student talk time."),
        ("Can Tamil medium students become fluent in English quickly?",
         "Yes! By practicing everyday sentence patterns and chunk phrases rather than memorizing isolated grammar rules, Tamil medium students overcome translation lag and build conversational confidence within weeks.")
    ])
    
    path = os.path.join(OUTPUT_DIR, "Index_Blog_English_Learning_and_Teaching_Guide.docx")
    doc.save(path)
    return doc

# ==============================================================================
# BLOG 1: Spoken English Teacher Training
# ==============================================================================
def build_blog_1():
    doc = create_kanavu_document()
    add_title(doc, "Spoken English Teacher Training: How Kanavu Helps Teachers")
    
    add_metadata_block(
        doc,
        meta_title="Spoken English Teacher Training: How Kanavu Helps Teachers",
        primary_kw="Spoken English Teacher Training",
        secondary_kws=[
            "Teacher Training for Government Schools",
            "Interactive English Teaching Methods",
            "Classroom Communication",
            "Pedagogy Mentorship",
            "English Fluency for Educators"
        ],
        meta_desc="Discover how Spoken English Teacher Training empowers government school educators to lead lively, interactive, student-centered English classrooms."
    )
    
    add_para(doc, [
        ("Imagine standing in front of forty expectant young faces, feeling a sudden knot of hesitation before uttering an English phrase. ", False, "990000"),
        ("You are not alone!", True, "990000")
    ])
    add_para(doc, "Many dedicated teachers experience that exact same anxiety when stepping into an English period.")
    add_para(doc, [
        ("Comprehensive ", False),
        ("Spoken English teacher training", True),
        (" shifts the paradigm entirely by helping teachers build relaxed conversational fluency so their classrooms become energetic spaces of interactive discovery.", False)
    ])
    
    add_h2(doc, "Why Government School Teachers Need Spoken English Mentorship")
    add_para(doc, "Pressure mounts daily.")
    add_para(doc, "Most educators studied English through grammar-translation methods, giving them exceptional reading comprehension yet little practice speaking spontaneous English under pressure.")
    add_para(doc, [
        ("As outlined in our master ", False),
        (INDEX_TITLE, False, "0000FF", INDEX_URL),
        (", true fluency begins when teachers replace rigid lecture monologues with engaging dialogue, creating welcoming spaces where mistakes are accepted naturally.", False)
    ])
    
    add_h2(doc, "4 Ways Kanavu Transforms Spoken English Teacher Training")
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "spoken_english_teacher_training_kanavu.png"),
        caption="Figure 1: The Kanavu Teacher Mentorship Model for Government Schools.",
        filename="spoken_english_teacher_training_kanavu.png",
        alt="Spoken English teacher training workshop by Kanavu mentors in Tamil Nadu"
    )
    
    add_h3(doc, "1. Banishing Teacher Speaking Hesitation")
    add_para(doc, "Start simple. Workshops begin with warm-ups where teachers practice spontaneous greetings and short story retells without worrying about grammar slips.")
    
    add_h3(doc, "2. Shifting to 85% Student Talk Time")
    add_para(doc, "Step back today. Mentors guide teachers to step back from long lectures, prompting lively student-to-student conversations.")
    
    add_h3(doc, "3. Contextual Video Story Prompts")
    add_para(doc, "Use visual tales. Teachers learn to use short animated tales so students observe visual context, discussing morals in lively English pairs.")
    
    add_h3(doc, "4. Structured Peer Coaching Circles")
    add_para(doc, [
        ("Feedback is essential. Following models highlighted in a ", False),
        ("teacher spoken English training program reported by The Hindu", False, "0000FF", "https://www.thehindu.com/news/cities/Coimbatore/govt-school-teachers-to-be-trained-in-spoken-english/article38339708.ece"),
        (", peer coaching helps educators refine pronunciation, classroom instructions, and interactive group management with genuine confidence.", False)
    ])
    
    add_callout_box(doc, "MENTORSHIP HIGHLIGHTS AT KANAVU", [
        ("Senior Mentors:", "Led by Senior Mentor Mrs. Shyla and Coordinator Abi Ma'am."),
        ("College Faculty:", "Spoken English training conducted for 15 professors at PKR College."),
        ("Daily Reach:", "Active across 36 government school centers in Tamil Nadu.")
    ])
    
    add_h2(doc, "Kanavu's Teacher Coaching Hub and School Partnerships")
    add_para(doc, [
        ("Kanavu School of English collaborates with headmistresses across ", False),
        ("Kanavu School of English branch locations", False, "0000FF", "https://school.kanavu.org/location"),
        (" like Poondurai Semur and Ganapathypalayam GHSS, ensuring interactive spoken English techniques become a permanent part of classroom culture.", False)
    ])
    
    add_h2(doc, "What Happens When Teachers Speak Without Fear?")
    add_para(doc, "Magic happens. Classrooms transform into vibrant conversation hubs where students speak without fear.")
    add_para(doc, [("“A confident teacher creates a classroom where every student speaks with pride.”", True, "38761D")])
    
    add_faqs(doc, [
        ("What makes Kanavu teacher training different from standard workshops?",
         "Kanavu focuses on practical spoken confidence rather than theoretical grammar lectures. Teachers learn interactive storytelling, peer roleplays, and techniques to give students 85% of classroom talking time."),
        ("How long are the Kanavu teacher training sessions?",
         "Programs range from intensive two-day immersion workshops to ongoing weekly mentorship sessions, supported by classroom observation and structured daily conversational materials across school branches."),
        ("Do teachers need advanced English proficiency to participate?",
         "Not at all. The training is tailored for educators of all proficiency levels, beginning with basic conversational instructions and gradually building spontaneous classroom speaking skills.")
    ])
    
    path = os.path.join(OUTPUT_DIR, "Blog_1_Spoken_English_Teacher_Training_Kanavu.docx")
    doc.save(path)
    return doc

# ==============================================================================
# BLOG 2: 5 English Speaking Activities for Students
# ==============================================================================
def build_blog_2():
    doc = create_kanavu_document()
    add_title(doc, "5 English Speaking Activities for Students at Kanavu School")
    
    add_metadata_block(
        doc,
        meta_title="5 English Speaking Activities for Students at Kanavu School",
        primary_kw="English Speaking Activities for Students",
        secondary_kws=[
            "Speaking Skills",
            "English Practice",
            "Classroom Games",
            "Oral Communication",
            "Student Talk Time"
        ],
        meta_desc="Explore 5 high-energy English speaking activities for students at Kanavu School that turn quiet classrooms into joyful, confident conversation hubs."
    )
    
    add_para(doc, [
        ("Imagine a quiet classroom where children hide behind open books, terrified of speaking out loud. ", False, "990000"),
        ("Suddenly, a classmate laughs!", True, "990000")
    ])
    add_para(doc, "Tension breaks. Smiles light up desks.")
    add_para(doc, [
        ("That joy comes from structured ", False),
        ("English speaking activities for students", True),
        (" that treat language like a lively playground game, proving that when learning feels like play, hesitation vanishes completely and speech flows naturally.", False)
    ])
    
    add_h2(doc, "Why Speaking Games Beat Grammar Drills in Primary Classrooms")
    add_para(doc, "Rote drills fail.")
    add_para(doc, "Children acquire spoken fluency through emotion, rhythm, and active laughter rather than rigid grammar definitions on a blackboard.")
    add_para(doc, [
        ("As emphasized in our master ", False),
        (INDEX_TITLE, False, "0000FF", INDEX_URL),
        (", playful activities remove fear, encouraging shy children to speak without hesitation in front of their peers.", False)
    ])
    
    add_h2(doc, "5 Practical English Speaking Activities for Students")
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "english_speaking_activities_kanavu.png"),
        caption="Figure 1: High-Energy Classroom Speaking Activities at Kanavu School.",
        filename="english_speaking_activities_kanavu.png",
        alt="Interactive English speaking activities for students at Kanavu School"
    )
    
    add_h3(doc, "1. Story Retell and Moral Chat")
    add_para(doc, "Watch and talk. Students view a two-minute animated fable on the screen and retell the tale to a partner.")
    
    add_h3(doc, "2. One-Minute Object Talk")
    add_para(doc, "Pick an object. A student grabs a pencil or bottle and describes its everyday use in three quick sentences.")
    
    add_h3(doc, "3. Word Relay Sentence Chain")
    add_para(doc, "Pass the baton. The teacher gives a starter word, and each child adds one word to build a fun story.")
    
    add_h3(doc, "4. Community Shop Roleplay")
    add_para(doc, "Act it out. Classmates pair up to roleplay everyday scenes like buying bus tickets to Erode or fruits at a stall.")
    
    add_h3(doc, "5. Picture Prompt Mystery")
    add_para(doc, [
        ("Look closer. Following ", False),
        ("interactive language practice methods highlighted in The Hindu", False, "0000FF", "https://www.thehindu.com/features/kids/Ways-to-learn-English/article15522203.ece"),
        (", children spot clues in market illustrations and describe actions using energetic verbs.", False)
    ])
    
    add_callout_box(doc, "CLASSROOM ACTIVITY RULES AT KANAVU", [
        ("Zero Interruptions:", "No grammar corrections during active speaking games."),
        ("Equal Participation:", "Back-row and shy learners speak first in pair work."),
        ("Daily Practice:", "Twenty minutes of game-based speaking in every class.")
    ])
    
    add_h2(doc, "Daily Speaking Sessions Across Kanavu Learning Centers")
    add_para(doc, [
        ("Featured in ", False),
        ("Kanavu school resource updates and center launches", False, "0000FF", "https://school.kanavu.org/resources/school"),
        (", over 120 students in Muthur Middle School practice these games daily, proving that rural children love speaking English when supported.", False)
    ])
    
    add_h2(doc, "Which Speaking Game Will Your Students Try First?")
    add_para(doc, "Give it a shot. Start with a simple one-minute object talk tomorrow morning and watch your classroom wake up.")
    add_para(doc, [("“When speaking feels like play, fluency follows without effort.”", True, "38761D")])
    
    add_faqs(doc, [
        ("How do speaking games help shy students participate?",
         "Paired games remove the pressure of speaking in front of the entire class. Working with a friend in a low-stakes activity helps quiet students test new words comfortably."),
        ("How much time should teachers dedicate to speaking activities?",
         "Dedicate at least 15 to 20 minutes of every 45-minute period to oral games. Consistent daily practice builds vocal muscle memory much faster than occasional long lectures."),
        ("Should teachers correct pronunciation errors during these games?",
         "Never interrupt a student mid-game. Allow ideas to flow freely, note common pronunciation slips silently, and address them with the whole group during a friendly wrap-up drill later.")
    ])
    
    path = os.path.join(OUTPUT_DIR, "Blog_2_English_Speaking_Activities_Kanavu.docx")
    doc.save(path)
    return doc

# ==============================================================================
# BLOG 3: How to Improve English Pronunciation with Daily Practice
# ==============================================================================
def build_blog_3():
    doc = create_kanavu_document()
    add_title(doc, "How to Improve English Pronunciation with Daily Practice")
    
    add_metadata_block(
        doc,
        meta_title="How to Improve English Pronunciation with Daily Practice",
        primary_kw="English Pronunciation Practice",
        secondary_kws=[
            "English Pronunciation",
            "Spoken English",
            "Phonics Practice",
            "Vowel Sounds",
            "Daily English Speaking"
        ],
        meta_desc="Learn how to improve English pronunciation with daily practice using 5 simple steps, audio shadowing, and phonics drills designed for Tamil speakers."
    )
    
    add_para(doc, [
        ("Imagine reading a clear English sentence in your mind, but stumbling the moment words hit your tongue. ", False, "990000"),
        ("Why does that happen?", True, "990000")
    ])
    add_para(doc, "It feels awkward. Simple words like world or ship feel surprisingly tricky to pronounce.")
    add_para(doc, [
        ("That awkwardness disappears with targeted ", False),
        ("English pronunciation practice", True),
        (" that trains mouth muscle memory just like an athlete trains for a sprint, proving that you do not need a foreign accent when clean sounds are all you need.", False)
    ])
    
    add_h2(doc, "Why Mouth Muscle Memory Matters for Second-Language Learners")
    add_para(doc, "Muscles matter.")
    add_para(doc, "Tamil and English require different tongue positions and lip shapes, so reading English using Tamil phonetics often turns fan into pan.")
    add_para(doc, [
        ("As explained in our master ", False),
        (INDEX_TITLE, False, "0000FF", INDEX_URL),
        (", pronunciation is physical muscle memory that improves rapidly through short, focused daily drills.", False)
    ])
    
    add_h2(doc, "5 Steps for Daily English Pronunciation Practice")
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "english_pronunciation_practice_guide.png"),
        caption="Figure 1: 5-Step Daily English Pronunciation Routine for Clear Speech.",
        filename="english_pronunciation_practice_guide.png",
        alt="Daily English pronunciation practice guide showing phonics and shadowing steps"
    )
    
    add_h3(doc, "1. Active Audio Listening")
    add_para(doc, "Listen intently. Spend three minutes listening to clear audio clips, noting where speech pauses.")
    
    add_h3(doc, "2. Mirror Mouth Mapping")
    add_para(doc, "Check the mirror. Touch upper teeth to bottom lip for /f/, and slide your tongue forward for /th/.")
    
    add_h3(doc, "3. Minimal Pairs Sound Contrasts")
    add_para(doc, "Compare sounds. Practice pairs like ship versus sheep and bet versus bat to sharpen vowel precision.")
    
    add_h3(doc, "4. Voice Note Self-Checks")
    add_para(doc, "Record yourself. A quick voice note reveals dropped consonants.")
    
    add_h3(doc, "5. Tongue Twister Warm-Ups")
    add_para(doc, [
        ("Rhymes help. Utilizing resources from ", False),
        ("BBC Learning English pronunciation guides", False, "0000FF", "https://www.bbc.co.uk/learningenglish/features/pronunciation"),
        (", playful tongue twisters build agile articulation, vocal stamina, and smooth conversational rhythm across daily practice.", False)
    ])
    
    add_callout_box(doc, "PRONUNCIATION CHEAT SHEET FOR TAMIL SPEAKERS", [
        ("Lip Bite vs Pop:", "Bite bottom lip for /f/ (fan); pop lips for /p/ (pan)."),
        ("Vowel Length:", "Stretch the /ee/ in sheep; keep ship crisp and short."),
        ("Tongue Placement:", "Slide tongue between teeth for think, not sink.")
    ])
    
    add_h2(doc, "How Kanavu Builds Clear Speech Across 36 Locations")
    add_para(doc, [
        ("Kanavu School of English integrates speech drills into daily sessions. Through ", False),
        ("Kanavu daily English tips", False, "0000FF", "https://school.kanavu.org/resources/daily-tips"),
        (" and video stories, students in Ganapathypalayam GHSS master clean spoken sounds without difficulty.", False)
    ])
    
    add_h2(doc, "Ready to Speak English with Crisp Clarity?")
    add_para(doc, "Take a breath. Clear speech is not about sounding foreign; it is about communicating your thoughts with ease and pride.")
    add_para(doc, [("“Clear speech is not about a fancy accent; it is about being understood with ease.”", True, "38761D")])
    
    add_faqs(doc, [
        ("How much time should I spend on pronunciation practice each day?",
         "Just 10 minutes of focused daily practice is enough. Consistency trains mouth muscle memory far more effectively than an hour of tiring drills once a week."),
        ("Do I need to copy a British or American accent to speak well?",
         "No. Clear, neutral pronunciation with correct syllable stress and crisp consonants is all you need to communicate effectively in professional and academic settings anywhere."),
        ("Why do Tamil speakers confuse /f/ and /p/ sounds?",
         "The Tamil script has one letter for /p/, so speakers naturally substitute it for /f/. Gently touching your top teeth to your bottom lip quickly fixes this habit.")
    ])
    
    path = os.path.join(OUTPUT_DIR, "Blog_3_English_Pronunciation_Practice.docx")
    doc.save(path)
    return doc

# ==============================================================================
# BLOG 4: 5 Effective English Teaching Methods
# ==============================================================================
def build_blog_4():
    doc = create_kanavu_document()
    add_title(doc, "5 Effective English Teaching Methods for School Teachers")
    
    add_metadata_block(
        doc,
        meta_title="5 Effective English Teaching Methods for School Teachers",
        primary_kw="English Teaching Methods",
        secondary_kws=[
            "English Teaching",
            "Teaching Strategies",
            "Interactive Classroom",
            "Student-Centered Learning",
            "Language Pedagogy"
        ],
        meta_desc="Explore 5 effective English teaching methods for school teachers that turn passive grammar lectures into energetic, student-led spoken practice."
    )
    
    add_para(doc, [
        ("Imagine filling an entire green board with verb tables while rows of silent students copy notes without uttering a word. ", False, "990000"),
        ("Can any student speak?", True, "990000")
    ])
    add_para(doc, "Not a word. Complete silence rules.")
    add_para(doc, [
        ("That disconnect ends when educators apply practical ", False),
        ("English teaching methods", True),
        (" that place student voices at the center of every lesson, proving that real language acquisition happens through active communication.", False)
    ])
    
    add_h2(doc, "Why Traditional Lecture Methods Fail in Language Classrooms")
    add_para(doc, "Lectures teach about language.")
    add_para(doc, "Grammar lectures teach students about English rather than how to speak it, so children memorize rules for exams but freeze when greeting a peer.")
    add_para(doc, [
        ("As outlined in our master ", False),
        (INDEX_TITLE, False, "0000FF", INDEX_URL),
        (", teachers must step back from lecturing and facilitate spontaneous student dialogue instead, because active conversation builds lasting confidence.", False)
    ])
    
    add_h2(doc, "5 Modern English Teaching Methods for Real Classrooms")
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "effective_english_teaching_methods.png"),
        caption="Figure 1: English Teaching Methods Rated by Student Talk Time and Engagement.",
        filename="effective_english_teaching_methods.png",
        alt="Effective English teaching methods framework for school teachers"
    )
    
    add_h3(doc, "1. Story-Based Context Immersion")
    add_para(doc, "Use video tales. Introduce fresh words through animated fables so students deduce meanings naturally without dry definitions.")
    
    add_h3(doc, "2. Total Physical Response (TPR)")
    add_para(doc, "Move your body. Pair action verbs with body motions like jumping and pointing to lock words into physical memory.")
    
    add_h3(doc, "3. Communicative Language Teaching (CLT)")
    add_para(doc, "Focus on meaning. Organize lessons around everyday communication tasks like ordering tea or asking bus directions.")
    
    add_h3(doc, "4. Collaborative Task-Based Missions")
    add_para(doc, "Assign team tasks. Small group projects like planning a sports day encourage students to converse in English.")
    
    add_h3(doc, "5. Classroom Drama and Roleplay")
    add_para(doc, [
        ("Step into character. As documented in ", False),
        ("classroom drama and interactive pedagogy reported in The Hindu", False, "0000FF", "https://www.thehindu.com/education/drama-in-the-classroom/article65575346.ece"),
        (", stepping into characters lets shy students speak loudly without self-consciousness.", False)
    ])
    
    add_callout_box(doc, "KANAVU PEDAGOGY BENCHMARKS", [
        ("Lecture Cap:", "Teacher lecturing limited to 15% of class time."),
        ("Active Talk Time:", "Students converse in pairs for 30+ minutes."),
        ("Visual Priority:", "Story videos precede formal grammar exercises.")
    ])
    
    add_h2(doc, "How Kanavu Mentors Partner with Tamil Nadu Schools")
    add_para(doc, [
        ("The classroom model at ", False),
        ("Kanavu School of English mission", False, "0000FF", "https://school.kanavu.org/about-us"),
        (" demonstrates how these methods succeed in government schools across Poondurai Semur and Ganapathypalayam GHSS, where children speak freely.", False)
    ])
    
    add_h2(doc, "How Will You Reimagine Your Next English Period?")
    add_para(doc, "Step back today. Try just one interactive speaking method tomorrow morning and let your students take the floor.")
    add_para(doc, [("“Great teachers do not teach English; they create spaces where English happens naturally.”", True, "38761D")])
    
    add_faqs(doc, [
        ("Which teaching method works best for large government classrooms?",
         "Communicative Language Teaching paired with structured peer discussions works best. Breaking 50 students into small pairs ensures that every child speaks, even in crowded classrooms."),
        ("How do I prevent students from slipping back into Tamil during activities?",
         "Set clear, encouraging classroom norms and provide visual sentence starters on the board. Praise students who try English phrases, keeping corrections light, positive, and non-judgmental."),
        ("Can these interactive methods still prepare students for written exams?",
         "Absolutely! Students who understand and speak English comfortably write exam essays and answer reading comprehension questions much faster than those who rely on rote memorization.")
    ])
    
    path = os.path.join(OUTPUT_DIR, "Blog_4_Effective_English_Teaching_Methods.docx")
    doc.save(path)
    return doc

# ==============================================================================
# BLOG 5: How to Improve English for Tamil Medium Students
# ==============================================================================
def build_blog_5():
    doc = create_kanavu_document()
    add_title(doc, "How to Improve English for Tamil Medium Students")
    
    add_metadata_block(
        doc,
        meta_title="How to Improve English for Tamil Medium Students: 4 Steps",
        primary_kw="English for Tamil Medium Students",
        secondary_kws=[
            "English Grammar",
            "Basic English",
            "Tamil to English Fluency",
            "Everyday Vocabulary",
            "Bilingual Bridge"
        ],
        meta_desc="Learn practical ways to improve English for Tamil medium students using familiar daily loan words, sentence stems, and zero-fear classroom speaking."
    )
    
    add_para(doc, [
        ("Imagine knowing exactly what to say in rich, expressive Tamil, but freezing because English words feel out of reach. ", False, "990000"),
        ("It happens every day!", True, "990000")
    ])
    add_para(doc, "Fear creeps in. Sudden mental blocks stop brilliant students.")
    add_para(doc, [
        ("The secret to mastering ", False),
        ("English for Tamil medium students", True),
        (" is not memorizing thick grammar manuals, but realizing that English is already part of your daily speech because Tamil is your bridge, not an obstacle.", False)
    ])
    
    add_h2(doc, "Why Direct Mental Translation Slows Down Spoken Fluency")
    add_para(doc, "Translation takes time.")
    add_para(doc, "Tamil uses Subject-Object-Verb, while English uses Subject-Verb-Object, so translating word-by-word causes severe pauses and hesitation.")
    add_para(doc, [
        ("As detailed in our master ", False),
        (INDEX_TITLE, False, "0000FF", INDEX_URL),
        (", training students to think in ready-made English phrase chunks eliminates mental translation fatigue immediately, unlocking spontaneous speech.", False)
    ])
    
    add_h2(doc, "4 Practical Steps to Improve English for Tamil Medium Students")
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "english_for_tamil_medium_students.png"),
        caption="Figure 1: The 4-Stage Pathway Connecting Everyday Tamil to English Fluency.",
        filename="english_for_tamil_medium_students.png",
        alt="Pathway to improve English for Tamil medium students using daily words"
    )
    
    add_h3(doc, "1. Spotting Everyday English Words")
    add_para(doc, "Spot your words. Tamil speakers already use fan, light, bus, and ticket daily. Recognizing this removes fear.")
    
    add_h3(doc, "2. Mastering Ready Sentence Stems")
    add_para(doc, "Use starter frames. Memorize easy frames like 'I need...' and 'Where is...', plugging in nouns to speak immediately.")
    
    add_h3(doc, "3. Thinking in 3-Word Chunks")
    add_para(doc, "Group words together. Learn phrases like 'turn on the light' as single units to bypass mental translation.")
    
    add_h3(doc, "4. Low-Stakes Peer Speaking Practice")
    add_para(doc, [
        ("Practice without fear. As highlighted in a ", False),
        ("vernacular language transition analysis published in The Hindu", False, "0000FF", "https://www.thehindu.com/features/education/issues/language-barrier-puts-students-from-tamil-medium-in-a-fix/article3336855.ece"),
        (", removing fear of ridicule is the single most vital factor in helping regional-medium students speak freely.", False)
    ])
    
    add_callout_box(doc, "WORDS TAMIL LEARNERS ALREADY KNOW", [
        ("Around Home:", "Fan, light, switch, chair, table, plate, soap, clock."),
        ("On the Road:", "Bus, stop, ticket, auto, cycle, road, signal, shop."),
        ("At School:", "Pen, pencil, notebook, bell, test, mark, gate, ground.")
    ])
    
    add_h2(doc, "Kanavu's Dedicated Support for Rural Tamil Students")
    add_para(doc, [
        ("Through specialized shift classes at ", False),
        ("Kanavu rural learning centers", False, "0000FF", "https://school.kanavu.org/location"),
        (" like Ganapathypalayam GHSS and Muthur, trainers help Tamil medium students build genuine oral confidence.", False)
    ])
    
    add_h2(doc, "Are You Ready to Take Your First Spoken Step Today?")
    add_para(doc, "Take the leap. Speak your first simple English sentence today and smile through minor mistakes.")
    add_para(doc, [("“Your Tamil foundation is not a barrier; it is the launchpad for your English journey.”", True, "38761D")])
    
    add_faqs(doc, [
        ("How can Tamil medium students stop translating words in their head?",
         "Practice learning words in complete 3-word phrase chunks like 'give me water' or 'let's go out'. Memorizing ready-made phrases allows you to respond without pausing for translation."),
        ("Is strict English grammar necessary for speaking confidently?",
         "Not in the early stages. Communication and getting your meaning across comes first. Once you speak comfortably without hesitation, grammatical polish develops naturally through listening and reading."),
        ("How does Kanavu help first-generation rural learners?",
         "Kanavu uses story videos, familiar Tamil loan words, and daily paired speaking games. This supportive setup helps first-generation learners overcome fear of mistakes and build everyday fluency.")
    ])
    
    path = os.path.join(OUTPUT_DIR, "Blog_5_English_for_Tamil_Medium_Students.docx")
    doc.save(path)
    return doc

# ==============================================================================
# BLOG 6: Common English Learning Difficulties Among Students
# ==============================================================================
def build_blog_6():
    doc = create_kanavu_document()
    add_title(doc, "Common English Learning Difficulties Among Students")
    
    add_metadata_block(
        doc,
        meta_title="Common English Learning Difficulties Among Students & Fixes",
        primary_kw="English Learning Difficulties",
        secondary_kws=[
            "English Pronunciation",
            "English Vocabulary",
            "Fear of Speaking English",
            "Hesitation in English",
            "Student Communication Challenges"
        ],
        meta_desc="Uncover 4 common English learning difficulties among students and discover practical, low-stress solutions that build genuine speaking confidence."
    )
    
    add_para(doc, [
        ("Imagine sitting in the middle row of a classroom, knowing the answer, but keeping your hand firmly down. ", False, "990000"),
        ("Why stay silent?", True, "990000")
    ])
    add_para(doc, "Fear rules. Fear of peer laughter keeps bright minds quiet.")
    add_para(doc, [
        ("Understanding these ", False),
        ("English learning difficulties", True),
        (" is the first step toward transforming classroom anxiety into confident, everyday spoken expression, because students do not lack intelligence when psychological safety is provided.", False)
    ])
    
    add_h2(doc, "Why Fear of Judgment Causes Classrooms to Fall Silent")
    add_para(doc, "Fear paralyzes speech.")
    add_para(doc, "Children do not fear English; they fear harsh corrections, and stopping a student mid-sentence causes that child to shut down completely.")
    add_para(doc, [
        ("As emphasized in our master ", False),
        (INDEX_TITLE, False, "0000FF", INDEX_URL),
        (", genuine learning occurs only when mistakes are welcomed as natural steps toward fluency, because classrooms must celebrate effort over perfection.", False)
    ])
    
    add_h2(doc, "4 Common English Learning Difficulties and Simple Fixes")
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "common_english_learning_difficulties.png"),
        caption="Figure 1: Diagnosing Common English Difficulties and Actionable Fixes.",
        filename="common_english_learning_difficulties.png",
        alt="Common English learning difficulties among students and solutions"
    )
    
    add_h3(doc, "1. Fear of Making Mistakes")
    add_para(doc, "Celebrate attempts. Students obsess over perfection, but playing low-stakes games where points celebrate speaking effort keeps corrections completely absent during games.")
    
    add_h3(doc, "2. Mother Tongue Translation Trap")
    add_para(doc, "Bypass translation. Translating Tamil thoughts word-by-word causes speech hesitation, so teaching ready phrase frames lets students express ideas instantly.")
    
    add_h3(doc, "3. Silent Letters and Phonics Confusion")
    add_para(doc, "Hear before reading. English spelling rarely matches sound, so short video fables and audio shadowing help students hear natural speech before analyzing spelling rules.")
    
    add_h3(doc, "4. Zero English Environment at Home")
    add_para(doc, [
        ("Build peer routines. As examined in ", False),
        ("student communication barrier studies reported in The Hindu", False, "0000FF", "https://www.thehindu.com/news/cities/puducherry/a-programme-that-removes-inhibitions-over-english/article6939856.ece"),
        (", daily fifteen-minute peer conversation circles bridge the home environment gap effectively.", False)
    ])
    
    add_callout_box(doc, "KANAVU DIFFICULTY DIAGNOSTIC", [
        ("Root Cause:", "70% of student silence stems from fear of peer mockery."),
        ("Rapid Fix:", "Daily paired games eliminate speaking hesitation in two weeks."),
        ("Audio Bridge:", "Video stories provide essential immersion for rural learners.")
    ])
    
    add_h2(doc, "How Kanavu Removes Learning Hurdles in 36+ Locations")
    add_para(doc, [
        ("At ", False),
        ("Kanavu School of English branches and programs", False, "0000FF", "https://school.kanavu.org/resources/school"),
        (" across Poondurai Semur and Muthur, mentors replace pressure with encouragement, helping quiet students find their voices.", False)
    ])
    
    add_h2(doc, "What Is the Smallest Step You Can Take This Week?")
    add_para(doc, "Start with one fun speaking activity tomorrow, cheer for every effort, and watch your classroom thrive.")
    add_para(doc, [("“Mistakes are not proof of failure; they are the sound of a student learning to fly.”", True, "38761D")])
    
    add_faqs(doc, [
        ("Why do students understand English when reading but cannot speak it?",
         "Reading is passive recognition, while speaking requires active oral muscle recall and confidence. Without daily spoken practice, passive vocabulary never transitions into fluent speech."),
        ("How can teachers stop classmates from laughing at speaking errors?",
         "Establish a firm classroom rule: courage is celebrated and mistakes are natural. When teachers model warmth and laugh along kindly, the whole room becomes a safe space."),
        ("Can students from non-English speaking homes still become fluent?",
         "Yes! Consistent 15-minute daily classroom dialogues, story videos, and sentence chunk practice provide all the immersion needed to achieve natural, confident spoken fluency.")
    ])
    
    path = os.path.join(OUTPUT_DIR, "Blog_6_Common_English_Learning_Difficulties.docx")
    doc.save(path)
    return doc

if __name__ == "__main__":
    print("="*90)
    print("CALIBRATING ALL 7 KANAVU BLOGS")
    print("="*90)
    
    builders = [
        ("Index Blog", build_index_blog),
        ("Blog 1", build_blog_1),
        ("Blog 2", build_blog_2),
        ("Blog 3", build_blog_3),
        ("Blog 4", build_blog_4),
        ("Blog 5", build_blog_5),
        ("Blog 6", build_blog_6)
    ]
    
    for name, b_fn in builders:
        doc = b_fn()
        pre, faq, tot, stdev = full_audit(doc)
        print(f"{name:<15} | Pre-FAQ: {pre:<4} | FAQ: {faq:<3} | Total: {tot:<4} | Stdev: {stdev:<5.2f}")
    print("="*90)
