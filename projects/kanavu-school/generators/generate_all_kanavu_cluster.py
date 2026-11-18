import os
import docx
import sys

# Add generators dir to path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build_kanavu_doc import (
    create_kanavu_document,
    add_title,
    add_metadata_block,
    add_h2,
    add_h3,
    add_para,
    add_callout_box,
    add_image_card,
    add_faqs
)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.abspath(os.path.join(BASE_DIR, ".."))
OUTPUT_DIR = os.path.join(PROJECT_ROOT, "2026-10-31")
ASSETS_DIR = os.path.join(OUTPUT_DIR, "assets")
os.makedirs(OUTPUT_DIR, exist_ok=True)

# ==============================================================================
# BLOG 0: INDEX PILLAR BLOG
# Title: English Learning and Teaching Guide for Students and Teachers
# ==============================================================================
def build_index_blog():
    doc = create_kanavu_document()
    
    # 1. Title
    add_title(doc, "English Learning and Teaching Guide for Students and Teachers")
    
    # 2. Metadata Block
    add_metadata_block(
        doc,
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
    
    # 3. 3-Beat "Imagine" Sensory Opening Hook (Intro Section)
    add_para(doc, [
        ("Imagine a bustling morning in a rural Tamil Nadu classroom where students whisper in quiet hesitation whenever called to the blackboard. ", False, "990000"),
        ("Suddenly, the English bell rings, and anxiety fills the room!", False, None)
    ])
    add_para(doc, [
        ("That fear ends when practical ", False, None),
        ("English learning and teaching", True, None),
        (" shifts focus from rigid textbook grammar drills to lively, everyday spoken conversations. You don't need fancy language labs to build fluent speakers. When students talk freely, real progress begins.", False, None)
    ])
    
    # 4. "Why" Reasoning Section
    add_h2(doc, "Why Spoken English Confidence Matters in Rural Classrooms", color="0000FF")
    add_para(doc, [
        ("For decades, rural schools focused almost entirely on written grammar tests. Students could write answers on paper, but froze when greeting a stranger. Look at any government school in Erode or Kodumudi—bright young minds have plenty of ideas, yet lack safe spaces to speak without fear.", False, None)
    ])
    add_para(doc, [
        ("That is why the holistic framework developed by ", False, None),
        ("Kanavu School of English", False, None, "https://school.kanavu.org/about-us"),
        (" flips traditional instruction on its head. By treating spoken confidence as the foundation for reading and writing, teachers help rural children discover that English is simply a tool for communication.", False, None)
    ])
    
    # 5. Numbered Step-by-Step Action Guide
    add_h2(doc, "4 Core Pillars of English Learning and Teaching", color="0000FF")
    
    # Primary Infographic Card
    img_path = os.path.join(ASSETS_DIR, "english_learning_teaching_guide_kanavu.png")
    add_image_card(
        doc,
        img_path=img_path,
        caption="Figure 1: The Kanavu School Statewide English Learning and Teaching Framework",
        filename="english_learning_teaching_guide_kanavu.png",
        alt="Kanavu School of English statewide learning and teaching network across Tamil Nadu"
    )
    
    add_h3(doc, "1. Story-Based Classroom Immersion", color="FF0000")
    add_para(doc, "Children absorb words naturally through engaging narratives. Short video stories introduce everyday words in context, sparking questions and joyful moral discussions before students ever touch a grammar rule.")
    
    add_h3(doc, "2. High Student Talk Time (STT)", color="FF0000")
    add_para(doc, "Traditional classrooms give eighty percent of talk time to teachers. Flipping this balance gives children forty minutes of active spoken practice through pair conversations, story retells, and daily classroom routines.")
    
    add_h3(doc, "3. Everyday Bilingual Bridging", color="FF0000")
    add_para(doc, "Tamil speakers already use hundreds of English loan words like 'bus', 'ticket', 'table', and 'fan'. Connecting these familiar words to simple sentence stems removes mental hesitation and builds rapid oral courage.")
    
    add_h3(doc, "4. Dedicated Spoken Teacher Mentorship", color="FF0000")
    add_para(doc, [
        ("Teachers cannot teach what they fear practicing. As highlighted in a ", False, None),
        ("government school spoken English curriculum report in The Hindu", False, None, "https://www.thehindu.com/news/cities/chennai/spoken-english-in-govt-school-curriculum/article30091336.ece"),
        (", empowering educators with interactive spoken training directly accelerates rural classroom fluency across Tamil Nadu.", False, None)
    ])
    
    # 6. Callout Box
    add_callout_box(
        doc,
        title="KANAVU CLASSROOM INSIGHT",
        items=[
            ("Active Centers:", "Over 36 school branches operating across Erode and surrounding districts."),
            ("Speaking Shift:", "85% Student Talk Time replaces silent textbook memorization."),
            ("College Bridge:", "600+ first-year students trained at PKR College for Women.")
        ],
        border_color="990000"
    )
    
    # 7. Facility / Client Spotlight Section
    add_h2(doc, "Inside the Kanavu Learning Network Across Tamil Nadu", color="0000FF")
    add_para(doc, [
        ("Supported by Kanavu Startup Village under CEO Mr. Karthi Easwaramoorthy, the initiative operates across ", False, None),
        ("36+ Kanavu learning centers", False, None, "https://school.kanavu.org/location"),
        (" including Poondurai Semur, Ganapathypalayam GHSS, Muthur, and Kodumudi. Dedicated mentors like Deepa Teacher and Kousalya Devi Teacher conduct high-energy shift classes that transform quiet students into confident, eager speakers.", False, None)
    ])
    
    # 8. Warm Conversational Conclusion
    add_h2(doc, "Ready to Make Spoken English Natural and Enjoyable?", color="0000FF")
    add_para(doc, "Fluency isn't built overnight with thick textbooks. It starts with one small daily conversation, a smile from an encouraging teacher, and the freedom to make mistakes.")
    add_para(doc, [
        ("“When students find their voice in English, they unlock bigger opportunities for life.”", True, "38761D")
    ])
    
    # 9. Frequently Asked Questions (Exactly 3 FAQs)
    add_faqs(doc, [
        (
            "How does Kanavu make English learning enjoyable for rural students?",
            "Kanavu uses short video stories, daily interactive games, and peer discussions. Children speak without fear of mistakes, connecting everyday Tamil loan words to practical English conversation stems."
        ),
        (
            "Why is teacher training vital for spoken English success?",
            "When teachers build personal spoken confidence, they shift from lecture-heavy classes to student-led activities. Senior mentors train teachers in classroom drama, storytelling, and high student talk time."
        ),
        (
            "Can Tamil medium students become fluent in English quickly?",
            "Yes! By practicing everyday sentence patterns and chunk phrases rather than memorizing isolated grammar rules, Tamil medium students overcome translation lag and build conversational confidence within weeks."
        )
    ])
    
    filename = "Index_Blog_English_Learning_and_Teaching_Guide.docx"
    path = os.path.join(OUTPUT_DIR, filename)
    doc.save(path)
    print("Built:", path)
    return path

# ==============================================================================
# BLOG 1: Spoken English Teacher Training: How Kanavu Helps Teachers
# ==============================================================================
def build_blog_1():
    doc = create_kanavu_document()
    
    # 1. Title
    add_title(doc, "Spoken English Teacher Training: How Kanavu Helps Teachers")
    
    # 2. Metadata Block
    add_metadata_block(
        doc,
        primary_kw="Spoken English Teacher Training",
        secondary_kws=[
            "Teacher Training for Government Schools",
            "Interactive English Teaching Methods",
            "Spoken English Confidence",
            "Classroom Communication",
            "English Pedagogy"
        ],
        meta_desc="Discover how Kanavu's spoken English teacher training empowers government school teachers with interactive methods, storytelling, and high student talk time."
    )
    
    # 3. 3-Beat "Imagine" Sensory Opening Hook (Intro Section)
    add_para(doc, [
        ("Imagine standing before fifty eager government school students, wanting to speak fluent English yet worrying about every single grammar slip. ", False, "990000"),
        ("Many committed educators feel this exact silent pressure every single day!", False, None)
    ])
    add_para(doc, [
        ("That hesitation fades when teachers receive hands-on ", False, None),
        ("spoken English teacher training", True, None),
        (" focused on natural conversation rather than textbook grammar drills. You don't need a foreign accent to lead an inspiring classroom. When teachers speak comfortably, students follow with joy.", False, None)
    ])
    
    # 4. "Why" Reasoning Section
    add_h2(doc, "Why Government School Teachers Need Spoken English Mentorship", color="0000FF")
    add_para(doc, "Most teacher training programs spend days analyzing syllabus chapters and exam patterns. Yet teachers rarely get a supportive forum to practice spontaneous classroom dialogue, storytelling, or pronunciation.")
    add_para(doc, [
        ("As explained in our comprehensive ", False, None),
        ("English Learning and Teaching Guide for Students and Teachers", False, None, "https://school.kanavu.org/resources/english-learning-and-teaching-guide"),
        (", true classroom transformation happens only when educators overcome speaking inhibitions first. Confident teachers naturally create lively, interactive classrooms.", False, None)
    ])
    
    # 5. Numbered Step-by-Step Action Guide
    add_h2(doc, "4 Ways Kanavu Transforms Spoken English Teacher Training", color="0000FF")
    
    # Primary Infographic Card
    img_path = os.path.join(ASSETS_DIR, "spoken_english_teacher_training_kanavu.png")
    add_image_card(
        doc,
        img_path=img_path,
        caption="Figure 1: Kanavu Spoken English Teacher Training Methodology and Core Pillars",
        filename="spoken_english_teacher_training_kanavu.png",
        alt="Kanavu spoken English teacher training framework showing interactive methods"
    )
    
    add_h3(doc, "1. Banishing Teacher Speaking Hesitation", color="FF0000")
    add_para(doc, "Workshops begin with fun, low-pressure conversational warm-ups. Teachers practice daily classroom greetings, spontaneous storytelling, and question stems without worrying about strict grammatical perfection.")
    
    add_h3(doc, "2. Shifting to 85% Student Talk Time", color="FF0000")
    add_para(doc, "Mentors guide educators to replace 40-minute monologues with student-centered dialogue circles. Teachers learn how to step back, ask open prompts, and let children carry the conversation.")
    
    add_h3(doc, "3. Utilizing Contextual Video Tales", color="FF0000")
    add_para(doc, "Rather than reading dry comprehension passages, teachers learn to play short animated stories. Students observe context, discuss morals, and pick up fresh vocabulary in authentic, memorable situations.")
    
    add_h3(doc, "4. Structured Peer Feedback Circles", color="FF0000")
    add_para(doc, [
        ("Teachers practice micro-teaching sessions with peer mentors. Following models highlighted in a ", False, None),
        ("teacher spoken English training program reported by The Hindu", False, None, "https://www.thehindu.com/news/cities/Coimbatore/govt-school-teachers-to-be-trained-in-spoken-english/article38339708.ece"),
        (", practical feedback helps educators refine pronunciation, classroom instructions, and interactive group management.", False, None)
    ])
    
    # 6. Callout Box
    add_callout_box(
        doc,
        title="MENTORSHIP HIGHLIGHTS AT KANAVU",
        items=[
            ("Expert Mentors:", "Led by Senior Mentor Mrs. Shyla and Coordinator Abi Ma'am."),
            ("College Faculty Impact:", "Two-day spoken training conducted for 15 English professors at PKR College."),
            ("Rural Reach:", "Empowering educators across 36 government school learning centers.")
        ],
        border_color="990000"
    )
    
    # 7. Facility / Client Spotlight Section
    add_h2(doc, "Kanavu's Teacher Coaching Hub and School Partnerships", color="0000FF")
    add_para(doc, [
        ("Kanavu School of English works closely with headmistresses and government schools across ", False, None),
        ("Kanavu School of English branch locations", False, None, "https://school.kanavu.org/location"),
        (" like Poondurai Semur and Ganapathypalayam. Trainers like Deepa Teacher collaborate with school staff daily, ensuring that interactive spoken English techniques become a permanent part of classroom culture.", False, None)
    ])
    
    # 8. Warm Conversational Conclusion
    add_h2(doc, "What Happens When Teachers Speak Without Fear?", color="0000FF")
    add_para(doc, "Classrooms stop feeling like silent lecture halls and become vibrant conversation hubs where curiosity thrives. It all starts with empowering the teacher at the front.")
    add_para(doc, [
        ("“A confident teacher creates a classroom where every student speaks with pride.”", True, "38761D")
    ])
    
    # 9. Frequently Asked Questions (Exactly 3 FAQs)
    add_faqs(doc, [
        (
            "What makes Kanavu teacher training different from standard workshops?",
            "Kanavu focuses on practical spoken confidence rather than theoretical grammar lectures. Teachers learn interactive storytelling, peer roleplays, and techniques to give students 85% of classroom talking time."
        ),
        (
            "How long are the Kanavu teacher training sessions?",
            "Programs range from intensive two-day immersion workshops to ongoing weekly mentorship sessions, supported by classroom observation and structured daily conversational materials across school branches."
        ),
        (
            "Do teachers need advanced English proficiency to participate?",
            "Not at all. The training is tailored for educators of all proficiency levels, beginning with basic conversational instructions and gradually building spontaneous classroom speaking skills."
        )
    ])
    
    filename = "Blog_1_Spoken_English_Teacher_Training_Kanavu.docx"
    path = os.path.join(OUTPUT_DIR, filename)
    doc.save(path)
    print("Built:", path)
    return path

# ==============================================================================
# BLOG 2: 5 English Speaking Activities for Students at Kanavu School
# ==============================================================================
def build_blog_2():
    doc = create_kanavu_document()
    
    # 1. Title
    add_title(doc, "5 English Speaking Activities for Students at Kanavu School")
    
    # 2. Metadata Block
    add_metadata_block(
        doc,
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
    
    # 3. 3-Beat "Imagine" Sensory Opening Hook (Intro Section)
    add_para(doc, [
        ("Imagine a quiet classroom where children hide behind open textbooks, terrified that the teacher will ask them to speak out loud. ", False, "990000"),
        ("Suddenly, a student laughs as a classmate acts out a funny village story!", False, None)
    ])
    add_para(doc, [
        ("That sudden burst of joy comes from structured ", False, None),
        ("English speaking activities for students", True, None),
        (" that treat language like a lively playground game. When learning feels like play, hesitation vanishes. Children start speaking English without even realizing they are practicing.", False, None)
    ])
    
    # 4. "Why" Reasoning Section
    add_h2(doc, "Why Speaking Games Beat Grammar Drills in Primary Classrooms", color="0000FF")
    add_para(doc, "Memorizing verb conjugations on a blackboard produces anxious test-takers, not fluent speakers. Children learn languages through emotion, rhythm, and active physical participation.")
    add_para(doc, [
        ("As outlined in our ", False, None),
        ("English Learning and Teaching Guide for Students and Teachers", False, None, "https://school.kanavu.org/resources/english-learning-and-teaching-guide"),
        (", interactive games remove the fear of making mistakes. When error correction takes a backseat to creative expression, student talk time skyrockets.", False, None)
    ])
    
    # 5. Numbered Step-by-Step Action Guide
    add_h2(doc, "5 Practical English Speaking Activities for Students", color="0000FF")
    
    # Primary Infographic Card
    img_path = os.path.join(ASSETS_DIR, "english_speaking_activities_kanavu.png")
    add_image_card(
        doc,
        img_path=img_path,
        caption="Figure 1: High-Energy Classroom Speaking Activities Practiced at Kanavu School",
        filename="english_speaking_activities_kanavu.png",
        alt="Interactive English speaking activities for students at Kanavu School"
    )
    
    add_h3(doc, "1. Story Retell and Moral Chat", color="FF0000")
    add_para(doc, "Students watch a 2-minute animated fable on the Kanavu screen. In pairs, one child retells what the clever crow did, while the other explains the story's moral using simple adjectives.")
    
    add_h3(doc, "2. One-Minute Everyday Object Talk", color="FF0000")
    add_para(doc, "A student picks up a familiar classroom object—a water bottle, ruler, or neem leaf—and speaks four quick sentences describing its color, use, and importance in daily life.")
    
    add_h3(doc, "3. Word Relay and Sentence Chain", color="FF0000")
    add_para(doc, "The teacher starts with one word like 'Yesterday'. Each student in the row adds one English word to build a collaborative, funny story around the room without pausing.")
    
    add_h3(doc, "4. Real-Life Community Roleplay", color="FF0000")
    add_para(doc, "Classmates pair up to act out realistic local scenes. One plays a passenger asking for a bus ticket to Erode, while the other plays the conductor checking coins and giving change.")
    
    add_h3(doc, "5. Picture Prompt Detective Game", color="FF0000")
    add_para(doc, [
        ("The teacher displays a colorful village market illustration. Supporting ", False, None),
        ("interactive language practice methods highlighted in The Hindu", False, None, "https://www.thehindu.com/features/kids/Ways-to-learn-English/article15522203.ece"),
        (", children spot hidden clues and describe actions using energetic present continuous verbs.", False, None)
    ])
    
    # 6. Callout Box
    add_callout_box(
        doc,
        title="CLASSROOM ACTIVITY RULES AT KANAVU",
        items=[
            ("No Red Pens:", "Zero grammar interruptions during active speaking games."),
            ("Equal Turns:", "Back-row and shy learners speak first in pair work."),
            ("Daily Routine:", "Fifteen minutes of game-based speaking practiced in every period.")
        ],
        border_color="990000"
    )
    
    # 7. Facility / Client Spotlight Section
    add_h2(doc, "Daily Speaking Sessions Across Kanavu Learning Centers", color="0000FF")
    add_para(doc, [
        ("Across schools like Panchayath Union Middle School Muthur and Ganapathypalayam GHSS, recorded on ", False, None),
        ("Kanavu school resource updates and center launches", False, None, "https://school.kanavu.org/resources/school"),
        (", over 120 students engage in these daily activities. Mentors like Deepa Teacher prove that rural students love speaking English when the classroom feels warm and supportive.", False, None)
    ])
    
    # 8. Warm Conversational Conclusion
    add_h2(doc, "Which Speaking Game Will Your Students Try First?", color="0000FF")
    add_para(doc, "You don't need expensive software or complicated worksheets to build speaking confidence. Start with a simple one-minute object game tomorrow morning and watch your classroom come alive.")
    add_para(doc, [
        ("“When speaking feels like play, fluency follows without effort.”", True, "38761D")
    ])
    
    # 9. Frequently Asked Questions (Exactly 3 FAQs)
    add_faqs(doc, [
        (
            "How do speaking games help shy students participate?",
            "Paired games remove the pressure of speaking in front of the entire class. Working with a friend in a low-stakes activity helps quiet students test new words comfortably."
        ),
        (
            "How much time should teachers dedicate to speaking activities?",
            "Dedicate at least 15 to 20 minutes of every 45-minute period to oral games. Consistent daily practice builds vocal muscle memory much faster than occasional long lectures."
        ),
        (
            "Should teachers correct pronunciation errors during these games?",
            "Never interrupt a student mid-game. Allow ideas to flow freely, note common pronunciation slips silently, and address them with the whole group during a friendly wrap-up drill later."
        )
    ])
    
    filename = "Blog_2_English_Speaking_Activities_Kanavu.docx"
    path = os.path.join(OUTPUT_DIR, filename)
    doc.save(path)
    print("Built:", path)
    return path

# ==============================================================================
# BLOG 3: How to Improve English Pronunciation with Daily Practice
# ==============================================================================
def build_blog_3():
    doc = create_kanavu_document()
    
    # 1. Title
    add_title(doc, "How to Improve English Pronunciation with Daily Practice")
    
    # 2. Metadata Block
    add_metadata_block(
        doc,
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
    
    # 3. 3-Beat "Imagine" Sensory Opening Hook (Intro Section)
    add_para(doc, [
        ("Imagine reading an English sentence clearly in your mind, but stumbling the second words hit your tongue. ", False, "990000"),
        ("Why do simple words like 'world' or 'ship' feel so tricky to pronounce?", False, None)
    ])
    add_para(doc, [
        ("That awkwardness disappears with targeted ", False, None),
        ("English pronunciation practice", True, None),
        (" that trains your mouth muscles just like an athlete trains for a race. You don't need to change who you are. Clear sounds simply make your message easy for anyone to understand.", False, None)
    ])
    
    # 4. "Why" Reasoning Section
    add_h2(doc, "Why Mouth Muscle Memory Matters for Second-Language Learners", color="0000FF")
    add_para(doc, "Tamil and English use different mouth shapes, tongue positions, and breath patterns. When Tamil speakers read English letters using mother tongue sounds, words like 'fan' can sound like 'pan'.")
    add_para(doc, [
        ("As detailed in our ", False, None),
        ("English Learning and Teaching Guide for Students and Teachers", False, None, "https://school.kanavu.org/resources/english-learning-and-teaching-guide"),
        (", pronunciation is physical muscle memory rather than book knowledge. Practicing five minutes of daily vocal drills retrains your lips and vocal cords effortlessly.", False, None)
    ])
    
    # 5. Numbered Step-by-Step Action Guide
    add_h2(doc, "5 Steps for Daily English Pronunciation Practice", color="0000FF")
    
    # Primary Infographic Card
    img_path = os.path.join(ASSETS_DIR, "english_pronunciation_practice_guide.png")
    add_image_card(
        doc,
        img_path=img_path,
        caption="Figure 1: 5-Step Daily English Pronunciation Routine for Clear Speech",
        filename="english_pronunciation_practice_guide.png",
        alt="Daily English pronunciation practice guide showing phonics and shadowing steps"
    )
    
    add_h3(doc, "1. Active Listening to Clear Native Audio", color="FF0000")
    add_para(doc, "Spend five minutes listening closely to short audio clips. Don't worry about complex vocabulary; just listen to where voices rise, fall, and pause naturally.")
    
    add_h3(doc, "2. Mirror Lip and Tongue Shadowing", color="FF0000")
    add_para(doc, "Stand before a mirror while pronouncing tricky sounds. For the /f/ sound, gently touch your top teeth to your bottom lip; for /th/, place your tongue lightly between teeth.")
    
    add_h3(doc, "3. Minimal Pairs Sound Contrasts", color="FF0000")
    add_para(doc, "Practice word pairs that differ by just one sound: 'ship' versus 'sheep', 'bet' versus 'bat', and 'vest' versus 'west'. Contrasting pairs sharpens short and long vowel clarity.")
    
    add_h3(doc, "4. Voice Note Self-Recording", color="FF0000")
    add_para(doc, "Record a thirty-second reading passage on your smartphone. Playing it back helps you identify where you rush, drop ending consonants, or stumble over multi-syllable terms.")
    
    add_h3(doc, "5. Playful Tongue Twister Drills", color="FF0000")
    add_para(doc, [
        ("Warm up your jaw and tongue with classic rhymes. Utilizing resources like ", False, None),
        ("BBC Learning English pronunciation guides", False, None, "https://www.bbc.co.uk/learningenglish/features/pronunciation"),
        (", repeating phrases like 'Red lorry, yellow lorry' builds agile articulation and fluid conversational rhythm.", False, None)
    ])
    
    # 6. Callout Box
    add_callout_box(
        doc,
        title="PRONUNCIATION CHEAT SHEET FOR TAMIL SPEAKERS",
        items=[
            ("Lip Bite vs Pop:", "Bite bottom lip for /f/ (fan); pop lips for /p/ (pan)."),
            ("Vowel Length:", "Stretch the /ee/ in 'sheep'; keep the /i/ crisp in 'ship'."),
            ("Tongue Rest:", "Slide tongue between teeth for 'think', not 'sink'.")
        ],
        border_color="990000"
    )
    
    # 7. Facility / Client Spotlight Section
    add_h2(doc, "How Kanavu Builds Clear Speech Across 36 Locations", color="0000FF")
    add_para(doc, [
        ("At Kanavu School of English branches, mentors integrate phonics and speech drills into daily sessions. Through ", False, None),
        ("Kanavu daily English tips", False, None, "https://school.kanavu.org/resources/daily-tips"),
        (" and video fables, students in Ganapathypalayam GHSS and Kodumudi hear clear spoken sounds every day, overcoming mother tongue sound interference naturally.", False, None)
    ])
    
    # 8. Warm Conversational Conclusion
    add_h2(doc, "Ready to Speak English with Crisp Clarity?", color="0000FF")
    add_para(doc, "Good pronunciation is never about copying a foreign accent. It is about speaking clearly and confidently so your thoughts connect with the world.")
    add_para(doc, [
        ("“Clear speech is not about a fancy accent; it is about being understood with ease.”", True, "38761D")
    ])
    
    # 9. Frequently Asked Questions (Exactly 3 FAQs)
    add_faqs(doc, [
        (
            "How much time should I spend on pronunciation practice each day?",
            "Just 10 minutes of focused daily practice is enough. Consistency trains mouth muscle memory far more effectively than an hour of tiring drills once a week."
        ),
        (
            "Do I need to copy a British or American accent to speak well?",
            "No. Clear, neutral pronunciation with correct syllable stress and crisp consonants is all you need to communicate effectively in professional and academic settings anywhere."
        ),
        (
            "Why do Tamil speakers confuse /f/ and /p/ sounds?",
            "The Tamil script has one letter for /p/, so speakers naturally substitute it for /f/. Gently touching your top teeth to your bottom lip quickly fixes this habit."
        )
    ])
    
    filename = "Blog_3_English_Pronunciation_Practice.docx"
    path = os.path.join(OUTPUT_DIR, filename)
    doc.save(path)
    print("Built:", path)
    return path

# ==============================================================================
# BLOG 4: 5 Effective English Teaching Methods for School Teachers
# ==============================================================================
def build_blog_4():
    doc = create_kanavu_document()
    
    # 1. Title
    add_title(doc, "5 Effective English Teaching Methods for School Teachers")
    
    # 2. Metadata Block
    add_metadata_block(
        doc,
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
    
    # 3. 3-Beat "Imagine" Sensory Opening Hook (Intro Section)
    add_para(doc, [
        ("Imagine filling an entire green blackboard with complex verb tables while rows of silent students copy notes without uttering a word. ", False, "990000"),
        ("When the period ends, can any student speak a full sentence?", False, None)
    ])
    add_para(doc, [
        ("That frustrating disconnect ends when educators embrace practical ", False, None),
        ("English teaching methods", True, None),
        (" that place student voices at the center of every lesson. Classrooms shouldn't feel like silent lecture halls. Real language acquisition happens through lively, high-energy communication.", False, None)
    ])
    
    # 4. "Why" Reasoning Section
    add_h2(doc, "Why Traditional Lecture Methods Fail in Language Classrooms", color="0000FF")
    add_para(doc, "The classic grammar-translation method teaches students about English rather than how to use it. Children memorize rules for exams, but freeze when asked to introduce themselves.")
    add_para(doc, [
        ("As emphasized in our master ", False, None),
        ("English Learning and Teaching Guide for Students and Teachers", False, None, "https://school.kanavu.org/resources/english-learning-and-teaching-guide"),
        (", language is a practical craft like cycling or swimming. Teachers must shift from lecturing about grammar to facilitating spontaneous student conversation every single period.", False, None)
    ])
    
    # 5. Numbered Step-by-Step Action Guide
    add_h2(doc, "5 Modern English Teaching Methods for Real Classrooms", color="0000FF")
    
    # Primary Infographic Card
    img_path = os.path.join(ASSETS_DIR, "effective_english_teaching_methods.png")
    add_image_card(
        doc,
        img_path=img_path,
        caption="Figure 1: English Teaching Methods Rated by Student Talk Time and Engagement",
        filename="effective_english_teaching_methods.png",
        alt="Effective English teaching methods framework for school teachers"
    )
    
    add_h3(doc, "1. Story-Based Context Immersion", color="FF0000")
    add_para(doc, "Introduce new vocabulary through animated video tales and colorful picture books. When students see actions unfold, they deduce word meanings naturally without dry textbook definitions.")
    
    add_h3(doc, "2. Total Physical Response (TPR)", color="FF0000")
    add_para(doc, "Connect verbs to physical actions. When teaching 'jump', 'whisper', or 'stretch', have students perform the motion. Kinesthetic movement locks new words into long-term memory.")
    
    add_h3(doc, "3. Communicative Language Teaching (CLT)", color="FF0000")
    add_para(doc, "Organize lessons around real-life communication tasks like ordering lunch, asking bus directions, or interviewing a desk partner. The primary goal is getting the message across.")
    
    add_h3(doc, "4. Collaborative Task-Based Missions", color="FF0000")
    add_para(doc, "Assign small teams a mini-project, such as planning a school sports day or writing a three-line skit. Working together forces students to negotiate and speak in English.")
    
    add_h3(doc, "5. Classroom Drama and Roleplay", color="FF0000")
    add_para(doc, [
        ("Let students step into different characters. As demonstrated in ", False, None),
        ("classroom drama and interactive pedagogy reported in The Hindu", False, None, "https://www.thehindu.com/education/drama-in-the-classroom/article65575346.ece"),
        (", roleplays create a protective mask where shy students speak loudly and expressively without self-consciousness.", False, None)
    ])
    
    # 6. Callout Box
    add_callout_box(
        doc,
        title="KANAVU PEDAGOGY BENCHMARKS",
        items=[
            ("Lecture Limit:", "Teacher explanation capped at 15% of period duration."),
            ("Active Talk Time:", "Students speak in pairs or groups for 30+ minutes."),
            ("Visual First:", "Stories and videos precede formal grammar exercises.")
        ],
        border_color="990000"
    )
    
    # 7. Facility / Client Spotlight Section
    add_h2(doc, "How Kanavu Mentors Partner with Tamil Nadu Schools", color="0000FF")
    add_para(doc, [
        ("The educational framework at ", False, None),
        ("Kanavu School of English mission", False, None, "https://school.kanavu.org/about-us"),
        (" demonstrates how these methods thrive in government schools. Operating in Poondurai Semur and Ganapathypalayam GHSS, Kanavu trainers guide local teachers to turn quiet rooms into lively conversation workshops.", False, None)
    ])
    
    # 8. Warm Conversational Conclusion
    add_h2(doc, "How Will You Reimagine Your Next English Period?", color="0000FF")
    add_para(doc, "You don't need a complete syllabus rewrite to energize your classroom. Pick just one interactive method tomorrow, step aside, and let your students take the stage.")
    add_para(doc, [
        ("“Great teachers do not teach English; they create spaces where English happens naturally.”", True, "38761D")
    ])
    
    # 9. Frequently Asked Questions (Exactly 3 FAQs)
    add_faqs(doc, [
        (
            "Which teaching method works best for large government classrooms?",
            "Communicative Language Teaching paired with structured peer discussions works best. Breaking 50 students into small pairs ensures that every child speaks, even in crowded classrooms."
        ),
        (
            "How do I prevent students from slipping back into Tamil during activities?",
            "Set clear, encouraging classroom norms and provide visual sentence starters on the board. Praise students who try English phrases, keeping corrections light, positive, and non-judgmental."
        ),
        (
            "Can these interactive methods still prepare students for written exams?",
            "Absolutely! Students who understand and speak English comfortably write exam essays and answer reading comprehension questions much faster than those who rely on rote memorization."
        )
    ])
    
    filename = "Blog_4_Effective_English_Teaching_Methods.docx"
    path = os.path.join(OUTPUT_DIR, filename)
    doc.save(path)
    print("Built:", path)
    return path

# ==============================================================================
# BLOG 5: How to Improve English for Tamil Medium Students
# ==============================================================================
def build_blog_5():
    doc = create_kanavu_document()
    
    # 1. Title
    add_title(doc, "How to Improve English for Tamil Medium Students")
    
    # 2. Metadata Block
    add_metadata_block(
        doc,
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
    
    # 3. 3-Beat "Imagine" Sensory Opening Hook (Intro Section)
    add_para(doc, [
        ("Imagine knowing exactly what you want to say in rich, colorful Tamil, but freezing because English words feel like an unreachable wall. ", False, "990000"),
        ("That sudden mental block stops thousands of brilliant rural students in their tracks!", False, None)
    ])
    add_para(doc, [
        ("The secret to mastering ", False, None),
        ("English for Tamil medium students", True, None),
        (" is not memorizing heavy grammar rules, but discovering that English is already part of your daily routine. You don't have to abandon your mother tongue. Tamil is the bridge that leads you forward.", False, None)
    ])
    
    # 4. "Why" Reasoning Section
    add_h2(doc, "Why Direct Mental Translation Slows Down Spoken Fluency", color="0000FF")
    add_para(doc, "Tamil and English follow opposite sentence structures. Tamil uses Subject-Object-Verb (நான் பள்ளிக்கு போகிறேன்), whereas English uses Subject-Verb-Object (I go to school).")
    add_para(doc, [
        ("As explained in our foundational ", False, None),
        ("English Learning and Teaching Guide for Students and Teachers", False, None, "https://school.kanavu.org/resources/english-learning-and-teaching-guide"),
        (", translating word-by-word creates mental lag and stuttering. Teaching students to think in ready-made English phrase chunks eliminates translation fatigue instantly.", False, None)
    ])
    
    # 5. Numbered Step-by-Step Action Guide
    add_h2(doc, "4 Practical Steps to Improve English for Tamil Medium Students", color="0000FF")
    
    # Primary Infographic Card
    img_path = os.path.join(ASSETS_DIR, "english_for_tamil_medium_students.png")
    add_image_card(
        doc,
        img_path=img_path,
        caption="Figure 1: The 4-Stage Pathway Connecting Everyday Tamil to Spoken English Fluency",
        filename="english_for_tamil_medium_students.png",
        alt="Pathway to improve English for Tamil medium students using daily words"
    )
    
    add_h3(doc, "1. Spotting Everyday English Words", color="FF0000")
    add_para(doc, "Tamil households already use hundreds of English words: 'bus', 'ticket', 'switch', 'light', 'fan', 'gate', and 'table'. Recognizing that you already speak basic English removes initial intimidation.")
    
    add_h3(doc, "2. Mastering Ready-Made Sentence Stems", color="FF0000")
    add_para(doc, "Instead of assembling grammar pieces from scratch, memorize versatile starter stems: 'Can I have...', 'Where is the...', 'I want to...', and 'Let us go to...'. Plug in everyday nouns to speak instantly.")
    
    add_h3(doc, "3. Thinking in 3-Word Chunks", color="FF0000")
    add_para(doc, "Train your brain to store phrases rather than single words. Saying 'turn on the fan' or 'open the door' as one fluid unit bypasses awkward mental translation from Tamil.")
    
    add_h3(doc, "4. Low-Stakes Peer Speaking Practice", color="FF0000")
    add_para(doc, [
        ("Speak with a supportive classmate for five minutes daily. As highlighted in a ", False, None),
        ("vernacular language transition analysis published in The Hindu", False, None, "https://www.thehindu.com/features/education/issues/language-barrier-puts-students-from-tamil-medium-in-a-fix/article3336855.ece"),
        (", removing performance anxiety and fear of ridicule is the single biggest factor in helping regional-medium students speak freely.", False, None)
    ])
    
    # 6. Callout Box
    add_callout_box(
        doc,
        title="WORDS TAMIL LEARNERS ALREADY KNOW",
        items=[
            ("Around the Home:", "Fan, light, switch, chair, table, plate, soap, clock."),
            ("On the Road:", "Bus, stop, ticket, auto, cycle, road, signal, shop."),
            ("At School:", "Pen, pencil, notebook, bell, test, mark, gate, ground.")
        ],
        border_color="990000"
    )
    
    # 7. Facility / Client Spotlight Section
    add_h2(doc, "Kanavu's Dedicated Support for Rural Tamil Students", color="0000FF")
    add_para(doc, [
        ("Through specialized shift classes at ", False, None),
        ("Kanavu rural learning centers", False, None, "https://school.kanavu.org/location"),
        (" such as Ganapathypalayam GHSS and Muthur Middle School, trainers like Kousalya Devi Teacher help Tamil medium children build oral confidence. Students quickly realize that English is simply another friendly way to share ideas.", False, None)
    ])
    
    # 8. Warm Conversational Conclusion
    add_h2(doc, "Are You Ready to Take Your First Spoken Step Today?", color="0000FF")
    add_para(doc, "Don't let grammar fear keep you silent. Speak your first simple English sentence today, smile through mistakes, and watch your confidence grow.")
    add_para(doc, [
        ("“Your Tamil foundation is not a barrier; it is the launchpad for your English journey.”", True, "38761D")
    ])
    
    # 9. Frequently Asked Questions (Exactly 3 FAQs)
    add_faqs(doc, [
        (
            "How can Tamil medium students stop translating words in their head?",
            "Practice learning words in complete 3-word phrase chunks like 'give me water' or 'let's go out'. Memorizing ready-made phrases allows you to respond without pausing for translation."
        ),
        (
            "Is strict English grammar necessary for speaking confidently?",
            "Not in the early stages. Communication and getting your meaning across comes first. Once you speak comfortably without hesitation, grammatical polish develops naturally through listening and reading."
        ),
        (
            "How does Kanavu help first-generation rural learners?",
            "Kanavu uses story videos, familiar Tamil loan words, and daily paired speaking games. This supportive setup helps first-generation learners overcome fear of mistakes and build everyday fluency."
        )
    ])
    
    filename = "Blog_5_English_for_Tamil_Medium_Students.docx"
    path = os.path.join(OUTPUT_DIR, filename)
    doc.save(path)
    print("Built:", path)
    return path

# ==============================================================================
# BLOG 6: Common English Learning Difficulties Among Students
# ==============================================================================
def build_blog_6():
    doc = create_kanavu_document()
    
    # 1. Title
    add_title(doc, "Common English Learning Difficulties Among Students")
    
    # 2. Metadata Block
    add_metadata_block(
        doc,
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
    
    # 3. 3-Beat "Imagine" Sensory Opening Hook (Intro Section)
    add_para(doc, [
        ("Imagine sitting in the middle row of a classroom, knowing the answer to the teacher's question, but keeping your hand firmly down. ", False, "990000"),
        ("What makes spoken English feel so terrifying for bright young minds?", False, None)
    ])
    add_para(doc, [
        ("Understanding these ", False, None),
        ("English learning difficulties", True, None),
        (" is the first step toward transforming silent fear into confident, everyday spoken expression. You don't lack intelligence. Most learning roadblocks come from outdated classroom pressure that can be easily fixed.", False, None)
    ])
    
    # 4. "Why" Reasoning Section
    add_h2(doc, "Why Fear of Judgment Causes Classrooms to Fall Silent", color="0000FF")
    add_para(doc, "Children do not fear English; they fear peer laughter and harsh corrections. When a teacher stops a student mid-sentence to fix a preposition, the child shuts down and resolves never to speak again.")
    add_para(doc, [
        ("As explored throughout our ", False, None),
        ("English Learning and Teaching Guide for Students and Teachers", False, None, "https://school.kanavu.org/resources/english-learning-and-teaching-guide"),
        (", language acquisition requires psychological safety. When mistakes are welcomed as natural learning steps, hesitation melts away and classroom energy explodes.", False, None)
    ])
    
    # 5. Numbered Step-by-Step Action Guide
    add_h2(doc, "4 Common English Learning Difficulties and Simple Fixes", color="0000FF")
    
    # Primary Infographic Card
    img_path = os.path.join(ASSETS_DIR, "common_english_learning_difficulties.png")
    add_image_card(
        doc,
        img_path=img_path,
        caption="Figure 1: Diagnosing Common English Difficulties and Actionable Classroom Fixes",
        filename="common_english_learning_difficulties.png",
        alt="Common English learning difficulties among students and solutions"
    )
    
    add_h3(doc, "1. Paralyzing Fear of Making Mistakes", color="FF0000")
    add_para(doc, "Students obsess over perfect grammar. The fix: play low-stakes storytelling games where points are awarded for participation and laughter, with zero red-pen corrections during oral activities.")
    
    add_h3(doc, "2. The Mother Tongue Translation Trap", color="FF0000")
    add_para(doc, "Converting sentences from Tamil to English creates awkward pauses. The fix: teach everyday sentence frames ('I need...', 'Can we...') so students express ideas without mental translation delays.")
    
    add_h3(doc, "3. Unpredictable Spelling and Silent Letters", color="FF0000")
    add_para(doc, "English spelling rarely matches its pronunciation. The fix: use short video fables and audio shadowing so students hear and mimic natural speech before confronting complex spelling rules.")
    
    add_h3(doc, "4. Zero English Environment at Home", color="FF0000")
    add_para(doc, [
        ("First-generation learners hear no English outside class. As examined in ", False, None),
        ("student communication barrier studies reported in The Hindu", False, None, "https://www.thehindu.com/news/cities/puducherry/a-programme-that-removes-inhibitions-over-english/article6939856.ece"),
        (", creating 15-minute daily peer conversation shifts bridges the home environment gap and builds lasting communication resilience.", False, None)
    ])
    
    # 6. Callout Box
    add_callout_box(
        doc,
        title="KANAVU DIFFICULTY DIAGNOSTIC",
        items=[
            ("Root Cause:", "70% of student silence stems from fear of mockery, not lack of ability."),
            ("Rapid Fix:", "Daily paired games eliminate speaking hesitation within two weeks."),
            ("Home Bridge:", "Story videos provide rich audio immersion for rural learners.")
        ],
        border_color="990000"
    )
    
    # 7. Facility / Client Spotlight Section
    add_h2(doc, "How Kanavu Removes Learning Hurdles in 36+ Locations", color="0000FF")
    add_para(doc, [
        ("At ", False, None),
        ("Kanavu School of English branches and programs", False, None, "https://school.kanavu.org/resources/school"),
        (" across Poondurai Semur, Ganapathypalayam, and Muthur, mentors replace pressure with encouragement. Through supportive daily coaching, even the quietest back-row students find their voice and speak with genuine pride.", False, None)
    ])
    
    # 8. Warm Conversational Conclusion
    add_h2(doc, "What Is the Smallest Step You Can Take This Week?", color="0000FF")
    add_para(doc, "Learning hurdles look huge only when faced alone. Start with one fun speaking activity tomorrow, cheer for every effort, and watch your classroom thrive.")
    add_para(doc, [
        ("“Mistakes are not proof of failure; they are the sound of a student learning to fly.”", True, "38761D")
    ])
    
    # 9. Frequently Asked Questions (Exactly 3 FAQs)
    add_faqs(doc, [
        (
            "Why do students understand English when reading but cannot speak it?",
            "Reading is passive recognition, while speaking requires active oral muscle recall and confidence. Without daily spoken practice, passive vocabulary never transitions into fluent speech."
        ),
        (
            "How can teachers stop classmates from laughing at speaking errors?",
            "Establish a firm classroom rule: courage is celebrated and mistakes are natural. When teachers model warmth and laugh along kindly, the whole room becomes a safe space."
        ),
        (
            "Can students from non-English speaking homes still become fluent?",
            "Yes! Consistent 15-minute daily classroom dialogues, story videos, and sentence chunk practice provide all the immersion needed to achieve natural, confident spoken fluency."
        )
    ])
    
    filename = "Blog_6_Common_English_Learning_Difficulties.docx"
    path = os.path.join(OUTPUT_DIR, filename)
    doc.save(path)
    print("Built:", path)
    return path

if __name__ == "__main__":
    print("="*80)
    print("GENERATING ALL 7 KANAVU SCHOOL BLOG DELIVERABLES")
    print("="*80)
    build_index_blog()
    build_blog_1()
    build_blog_2()
    build_blog_3()
    build_blog_4()
    build_blog_5()
    build_blog_6()
    print("="*80)
    print("ALL 7 BLOGS GENERATED SUCCESSFULLY!")
    print("="*80)
