import os
from PIL import Image, ImageDraw, ImageFont

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ASSETS_DIR = os.path.abspath(os.path.join(BASE_DIR, "..", "2026-10-31", "assets"))
os.makedirs(ASSETS_DIR, exist_ok=True)

W, H = 1672, 941

# Fonts
try:
    font_banner = ImageFont.truetype("arialbd.ttf", 38)
    font_banner_sub = ImageFont.truetype("arial.ttf", 22)
    font_h1 = ImageFont.truetype("arialbd.ttf", 28)
    font_h2 = ImageFont.truetype("arialbd.ttf", 22)
    font_h3 = ImageFont.truetype("arialbd.ttf", 18)
    font_body = ImageFont.truetype("arial.ttf", 16)
    font_bold = ImageFont.truetype("arialbd.ttf", 16)
    font_small = ImageFont.truetype("arial.ttf", 14)
    font_badge = ImageFont.truetype("arialbd.ttf", 20)
    font_huge_num = ImageFont.truetype("arialbd.ttf", 36)
except:
    font_banner = ImageFont.load_default()
    font_banner_sub = ImageFont.load_default()
    font_h1 = ImageFont.load_default()
    font_h2 = ImageFont.load_default()
    font_h3 = ImageFont.load_default()
    font_body = ImageFont.load_default()
    font_bold = ImageFont.load_default()
    font_small = ImageFont.load_default()
    font_badge = ImageFont.load_default()
    font_huge_num = ImageFont.load_default()

def draw_header_banner(draw, title, subtitle, bg_color="#0F2C59", accent_color="#D97706"):
    draw.rectangle([(0, 0), (W, 130)], fill=bg_color)
    draw.rectangle([(0, 130), (W, 136)], fill=accent_color)
    
    # Title
    bbox_t = draw.textbbox((0, 0), title, font=font_banner)
    w_t = bbox_t[2] - bbox_t[0]
    draw.text(((W - w_t) / 2, 28), title, fill="#FFFFFF", font=font_banner)
    
    # Subtitle
    bbox_s = draw.textbbox((0, 0), subtitle, font=font_banner_sub)
    w_s = bbox_s[2] - bbox_s[0]
    draw.text(((W - w_s) / 2, 85), subtitle, fill="#FEF08A", font=font_banner_sub)

def draw_footer_bar(draw, text="# Kanavu School of English | Powered by Kanavu Startup Village | school.kanavu.org"):
    draw.rectangle([(0, H - 45), (W, H)], fill="#0F172A")
    bbox = draw.textbbox((0, 0), text, font=font_small)
    w = bbox[2] - bbox[0]
    draw.text(((W - w) / 2, H - 32), text, fill="#94A3B8", font=font_small)

# ==============================================================================
# 1. INDEX BLOG: Style 4 - Multi-Center Ecosystem Platter Card
# ==============================================================================
def generate_index_card():
    img = Image.new("RGB", (W, H), "#F8FAFC")
    draw = ImageDraw.Draw(img)
    
    draw_header_banner(draw, 
                       "KANAVU SCHOOL OF ENGLISH: STATEWIDE LEARNING & TEACHING NETWORK",
                       "Building Confident English Communicators Across 36+ Locations in Tamil Nadu",
                       bg_color="#1E3A8A", accent_color="#3B82F6")
    
    pillars = [
        {
            "tag": "GOVERNMENT SCHOOLS",
            "tag_bg": "#DBEAFE", "tag_fg": "#1E40AF",
            "title": "Rural & High Schools",
            "stat": "36+ Active Centers",
            "desc": "Operating in Poondurai Semur, Ganapathypalayam GHSS, Kodumudi SSV, and Vadakkupudupalayam with dedicated trainers.",
            "points": ["Shift-based oral classes", "Story video projections", "Zero fear learning zones"]
        },
        {
            "tag": "MIDDLE SCHOOLS",
            "tag_bg": "#DCFCE7", "tag_fg": "#166534",
            "title": "Foundation Classes",
            "stat": "120+ Muthur Students",
            "desc": "Panchayath Union Middle School Muthur and Arachalur centers breaking barriers for primary and middle grade students.",
            "points": ["Everyday vocabulary drills", "Interactive sentence stems", "Daily student talk time"]
        },
        {
            "tag": "COLLEGE BRIDGE",
            "tag_bg": "#FEF3C7", "tag_fg": "#92400E",
            "title": "Higher Education",
            "stat": "600+ College Students",
            "desc": "Successful 3-day Bridge Course at PKR College for Women giving first-year students the spoken confidence to excel.",
            "points": ["Campus transition bridge", "Academic presentation skills", "Interview readiness"]
        },
        {
            "tag": "TEACHER TRAINING",
            "tag_bg": "#FCE7F3", "tag_fg": "#9D174D",
            "title": "Teacher Workshops",
            "stat": "Expert Mentorship",
            "desc": "Led by Senior Mentor Mrs. Shyla and Abi Ma'am, empowering English teachers with modern, interactive speaking methods.",
            "points": ["Student Talk Time (STT)", "Classroom drama & games", "Continuous mentor coaching"]
        }
    ]
    
    col_w = 360
    col_h = 700
    gap = 26
    start_x = (W - (4 * col_w + 3 * gap)) / 2
    y1 = 165
    
    for idx, p in enumerate(pillars):
        x1 = start_x + idx * (col_w + gap)
        x2 = x1 + col_w
        y2 = y1 + col_h
        
        # Column card
        draw.rounded_rectangle([x1, y1, x2, y2], radius=16, fill="#FFFFFF", outline="#CBD5E1", width=2)
        
        # Tag pill
        draw.rounded_rectangle([x1 + 20, y1 + 25, x1 + 230, y1 + 55], radius=8, fill=p["tag_bg"])
        draw.text((x1 + 30, y1 + 31), p["tag"], fill=p["tag_fg"], font=font_h3)
        
        # Title & Stat
        draw.text((x1 + 20, y1 + 75), p["title"], fill="#0F172A", font=font_h2)
        draw.text((x1 + 20, y1 + 112), p["stat"], fill="#2563EB", font=font_badge)
        
        # Divider
        draw.line([(x1 + 20, y1 + 148), (x2 - 20, y1 + 148)], fill="#E2E8F0", width=2)
        
        # Description
        words = p["desc"].split()
        lines = []
        curr = []
        for w_item in words:
            curr.append(w_item)
            if len(" ".join(curr)) > 32:
                lines.append(" ".join(curr))
                curr = []
        if curr:
            lines.append(" ".join(curr))
            
        cur_y = y1 + 165
        for l in lines:
            draw.text((x1 + 20, cur_y), l, fill="#475569", font=font_body)
            cur_y += 24
            
        # Key Features box
        box_y1 = cur_y + 20
        box_y2 = y2 - 25
        draw.rounded_rectangle([x1 + 15, box_y1, x2 - 15, box_y2], radius=12, fill="#F8FAFC", outline="#E2E8F0", width=1)
        draw.text((x1 + 25, box_y1 + 15), "KEY HIGHLIGHTS:", fill="#0F172A", font=font_bold)
        
        item_y = box_y1 + 45
        for pt in p["points"]:
            draw.text((x1 + 25, item_y), f"• {pt}", fill="#334155", font=font_body)
            item_y += 32
            
    draw_footer_bar(draw, "Kanavu Startup Village | CEO: Mr. Karthi Easwaramoorthy | 36+ Centers Across Tamil Nadu | school.kanavu.org")
    path = os.path.join(ASSETS_DIR, "english_learning_teaching_guide_kanavu.png")
    img.save(path, quality=95)
    print("Saved:", path)

# ==============================================================================
# 2. BLOG 1: Style 10 - Split Narrative Hero Scene + Numbered Action Pill Banner
# ==============================================================================
def generate_blog1_card():
    img = Image.new("RGB", (W, H), "#FDFBF7")
    draw = ImageDraw.Draw(img)
    
    draw_header_banner(draw, 
                       "SPOKEN ENGLISH TEACHER TRAINING: HOW KANAVU HELPS TEACHERS",
                       "Equipping Government & College Educators with Practical Spoken English Methods",
                       bg_color="#7C2D12", accent_color="#EA580C")
    
    # Left Hero Scene (Width: 640px)
    left_x1, left_y1, left_x2, left_y2 = 60, 165, 720, 860
    draw.rounded_rectangle([left_x1, left_y1, left_x2, left_y2], radius=20, fill="#FFF7ED", outline="#FDBA74", width=2)
    
    # Inner banner badge
    draw.rounded_rectangle([left_x1 + 30, left_y1 + 30, left_x2 - 30, left_y1 + 80], radius=10, fill="#EA580C")
    draw.text((left_x1 + 50, left_y1 + 42), "TEACHER TRAINING PILLARS", fill="#FFFFFF", font=font_h2)
    
    # Left quotes and mentorship details
    draw.text((left_x1 + 35, left_y1 + 115), "Led by Senior Mentors:", fill="#9A3412", font=font_bold)
    draw.text((left_x1 + 35, left_y1 + 145), "Mrs. Shyla & Coordinator Abi Ma'am", fill="#0F172A", font=font_h2)
    
    # Big stat callout card inside left
    draw.rounded_rectangle([left_x1 + 30, left_y1 + 200, left_x2 - 30, left_y1 + 360], radius=14, fill="#FFFFFF", outline="#FED7AA", width=1)
    draw.text((left_x1 + 50, left_y1 + 220), "85% STUDENT TALK TIME (STT)", fill="#EA580C", font=font_h2)
    draw.text((left_x1 + 50, left_y1 + 260), "Shifting classrooms from teacher lectures to", fill="#475569", font=font_body)
    draw.text((left_x1 + 50, left_y1 + 288), "high-energy student conversation and peer", fill="#475569", font=font_body)
    draw.text((left_x1 + 50, left_y1 + 316), "practice in government schools.", fill="#475569", font=font_body)
    
    # Warm quotation card
    draw.rounded_rectangle([left_x1 + 30, left_y1 + 385, left_x2 - 30, left_y1 + 520], radius=14, fill="#FFFBEB", outline="#FDE68A", width=1)
    draw.text((left_x1 + 50, left_y1 + 405), "“Small Conversations, Big Progress! ♡”", fill="#B45309", font=font_h2)
    draw.text((left_x1 + 50, left_y1 + 445), "When teachers overcome speaking hesitation,", fill="#78350F", font=font_body)
    draw.text((left_x1 + 50, left_y1 + 472), "students naturally speak with pride and ease.", fill="#78350F", font=font_body)
    
    draw.text((left_x1 + 35, left_y1 + 555), "Proven at PKR College & 36+ School Locations", fill="#9A3412", font=font_bold)
    draw.text((left_x1 + 35, left_y1 + 590), "Continuous weekend workshops, live feedback,", fill="#64748B", font=font_small)
    draw.text((left_x1 + 35, left_y1 + 615), "and structured daily classroom lesson modules.", fill="#64748B", font=font_small)

    # Right Column: 4 Numbered Action Pills
    pills = [
        {"num": "01", "title": "Overcome Teacher Speaking Hesitation", "desc": "Equipping teachers with conversational confidence so English becomes the natural medium of instruction."},
        {"num": "02", "title": "Contextual Story-Based Learning", "desc": "Using video tales and audio prompts so students grasp meaning before formal grammar rules."},
        {"num": "03", "title": "Interactive Classroom Routines", "desc": "Replacing silent reading with structured sentence starters, pair sharing, and speaking shifts."},
        {"num": "04", "title": "Low-Stakes Encouraging Environment", "desc": "Normalizing minor errors and praising student participation to build lifelong communication courage."}
    ]
    
    pill_x1 = 760
    pill_x2 = W - 60
    pill_h = 158
    start_py = 165
    gap_p = 22
    
    for idx, pill in enumerate(pills):
        cur_y1 = start_py + idx * (pill_h + gap_p)
        cur_y2 = cur_y1 + pill_h
        
        # Card
        draw.rounded_rectangle([pill_x1, cur_y1, pill_x2, cur_y2], radius=16, fill="#FFFFFF", outline="#E2E8F0", width=2)
        
        # Number Badge
        draw.rounded_rectangle([pill_x1 + 25, cur_y1 + 35, pill_x1 + 105, cur_y1 + 115], radius=12, fill="#FFF7ED", outline="#FDBA74", width=2)
        draw.text((pill_x1 + 42, cur_y1 + 52), pill["num"], fill="#EA580C", font=font_huge_num)
        
        # Title & Desc
        draw.text((pill_x1 + 130, cur_y1 + 35), pill["title"], fill="#0F172A", font=font_h2)
        draw.text((pill_x1 + 130, cur_y1 + 75), pill["desc"][:70], fill="#475569", font=font_body)
        draw.text((pill_x1 + 130, cur_y1 + 102), pill["desc"][70:], fill="#475569", font=font_body)
        
    draw_footer_bar(draw, "Kanavu School of English Teacher Training Hub | school.kanavu.org")
    path = os.path.join(ASSETS_DIR, "spoken_english_teacher_training_kanavu.png")
    img.save(path, quality=95)
    print("Saved:", path)

# ==============================================================================
# 3. BLOG 2: Style 9 - Multi-Arch Photographic / Vignette Capsule Card
# ==============================================================================
def generate_blog2_card():
    img = Image.new("RGB", (W, H), "#F8FAFC")
    draw = ImageDraw.Draw(img)
    
    draw_header_banner(draw, 
                       "5 ENGLISH SPEAKING ACTIVITIES FOR STUDENTS AT KANAVU SCHOOL",
                       "Fun, High-Energy Classroom Practices That Build Natural Fluency & Voice",
                       bg_color="#0F766E", accent_color="#14B8A6")
    
    activities = [
        {
            "num": "01",
            "name": "Story Retell & Video Talk",
            "doodle": "★ WATCH & RETELL",
            "bg": "#F0FDFA", "outline": "#99F6E4",
            "takeaway": "Students watch a 2-minute video story and explain their favorite scene to a partner."
        },
        {
            "num": "02",
            "name": "One-Minute Show & Tell",
            "doodle": "✦ EVERYDAY OBJECT",
            "bg": "#EFF6FF", "outline": "#BFDBFE",
            "takeaway": "Children bring a familiar item (pen, water bottle, leaf) and speak 4 simple sentences."
        },
        {
            "num": "03",
            "name": "Word Relay & Sentence Chain",
            "doodle": "● GROUP RELAY",
            "bg": "#FEFCE8", "outline": "#FEF08A",
            "takeaway": "Each student adds one English word in sequence to build collaborative classroom stories."
        },
        {
            "num": "04",
            "name": "Real-Life Roleplay Corner",
            "doodle": "❖ ROLEPLAY ARENA",
            "bg": "#FDF2F8", "outline": "#FBCFE8",
            "takeaway": "Pairs act out realistic scenarios like buying train tickets, meeting a doctor, or ordering food."
        }
    ]
    
    arch_w = 360
    arch_h = 700
    gap = 26
    start_x = (W - (4 * arch_w + 3 * gap)) / 2
    y1 = 165
    
    for idx, act in enumerate(activities):
        x1 = start_x + idx * (arch_w + gap)
        x2 = x1 + arch_w
        y2 = y1 + arch_h
        
        # Arch Capsule
        draw.rounded_rectangle([x1, y1, x2, y2], radius=28, fill=act["bg"], outline=act["outline"], width=2)
        
        # Top Badge / Doodle
        draw.rounded_rectangle([x1 + 35, y1 + 30, x2 - 35, y1 + 75], radius=10, fill="#FFFFFF", outline=act["outline"], width=1)
        draw.text((x1 + 55, y1 + 42), act["doodle"], fill="#0F766E", font=font_h3)
        
        # Number badge
        draw.ellipse([x1 + (arch_w - 90)/2, y1 + 105, x1 + (arch_w + 90)/2, y1 + 195], fill="#0F766E")
        draw.text((x1 + (arch_w - 45)/2, y1 + 130), act["num"], fill="#FFFFFF", font=font_huge_num)
        
        # Activity Title
        draw.text((x1 + 25, y1 + 230), act["name"], fill="#0F172A", font=font_h2)
        
        # Divider
        draw.line([(x1 + 30, y1 + 275), (x2 - 30, y1 + 275)], fill=act["outline"], width=2)
        
        # Practical Classroom Steps
        draw.text((x1 + 25, y1 + 300), "HOW IT WORKS IN CLASS:", fill="#0F766E", font=font_bold)
        
        words = act["takeaway"].split()
        lines = []
        curr = []
        for w_item in words:
            curr.append(w_item)
            if len(" ".join(curr)) > 28:
                lines.append(" ".join(curr))
                curr = []
        if curr:
            lines.append(" ".join(curr))
            
        cur_y = y1 + 340
        for l in lines:
            draw.text((x1 + 25, cur_y), l, fill="#334155", font=font_body)
            cur_y += 26
            
        # Impact Badge
        draw.rounded_rectangle([x1 + 20, y2 - 140, x2 - 20, y2 - 35], radius=12, fill="#FFFFFF", outline="#CBD5E1", width=1)
        draw.text((x1 + 35, y2 - 125), "STUDENT OUTCOME:", fill="#0F172A", font=font_bold)
        draw.text((x1 + 35, y2 - 95), "✓ Eliminates fear of speaking", fill="#166534", font=font_small)
        draw.text((x1 + 35, y2 - 70), "✓ Sparks instant peer laughter", fill="#166534", font=font_small)
        
    draw_footer_bar(draw, "Kanavu Interactive English Activities | Practiced Across 36+ Locations | school.kanavu.org")
    path = os.path.join(ASSETS_DIR, "english_speaking_activities_kanavu.png")
    img.save(path, quality=95)
    print("Saved:", path)

# ==============================================================================
# 4. BLOG 3: Style 1 - Multi-Column Step-by-Step Process Poster
# ==============================================================================
def generate_blog3_card():
    img = Image.new("RGB", (W, H), "#FAFAFA")
    draw = ImageDraw.Draw(img)
    
    draw_header_banner(draw, 
                       "HOW TO IMPROVE ENGLISH PRONUNCIATION WITH DAILY PRACTICE",
                       "5 Daily Steps to Master Clear English Sounds, Vowels & Speech Rhythm",
                       bg_color="#4338CA", accent_color="#6366F1")
    
    steps = [
        {
            "num": "1", "title": "Active Listening",
            "desc": "Spend 5 minutes listening to clear audio clips. Focus on how words rise and fall naturally."
        },
        {
            "num": "2", "title": "Mirror Shadowing",
            "desc": "Stand in front of a mirror. Watch your lip shapes and tongue position for tricky sounds like /th/ and /w/."
        },
        {
            "num": "3", "title": "Minimal Pairs Drill",
            "desc": "Practice contrasting word pairs like 'ship' vs 'sheep', 'pan' vs 'fan', and 'bet' vs 'bat' to sharpen vowels."
        },
        {
            "num": "4", "title": "Phone Voice Notes",
            "desc": "Record a 30-second speech sample on your phone. Play it back to identify hesitation points and syllable stress."
        },
        {
            "num": "5", "title": "Tongue Twisters",
            "desc": "Warm up vocal muscles with playful 2-line rhymes to develop effortless tongue agility and clear consonants."
        }
    ]
    
    col_w = 285
    col_h = 700
    gap = 20
    start_x = (W - (5 * col_w + 4 * gap)) / 2
    y1 = 165
    
    for idx, st in enumerate(steps):
        x1 = start_x + idx * (col_w + gap)
        x2 = x1 + col_w
        y2 = y1 + col_h
        
        # Step Column
        draw.rounded_rectangle([x1, y1, x2, y2], radius=16, fill="#FFFFFF", outline="#CBD5E1", width=2)
        
        # Number Badge Circle
        cx = x1 + col_w / 2
        cy = y1 + 65
        draw.ellipse([cx - 36, cy - 36, cx + 36, cy + 36], fill="#4338CA")
        draw.text((cx - 11, cy - 20), st["num"], fill="#FFFFFF", font=font_huge_num)
        
        # Step Title
        draw.text((x1 + 18, y1 + 125), st["title"], fill="#0F172A", font=font_h2)
        draw.text((x1 + 18, y1 + 160), "DAILY ROUTINE", fill="#6366F1", font=font_badge)
        
        # Line
        draw.line([(x1 + 20, y1 + 195), (x2 - 20, y1 + 195)], fill="#E2E8F0", width=2)
        
        # Step details
        words = st["desc"].split()
        lines = []
        curr = []
        for w_item in words:
            curr.append(w_item)
            if len(" ".join(curr)) > 24:
                lines.append(" ".join(curr))
                curr = []
        if curr:
            lines.append(" ".join(curr))
            
        cur_y = y1 + 220
        for l in lines:
            draw.text((x1 + 18, cur_y), l, fill="#334155", font=font_body)
            cur_y += 26
            
        # Bottom Tip Box
        draw.rounded_rectangle([x1 + 15, y2 - 180, x2 - 15, y2 - 30], radius=10, fill="#EEF2FF", outline="#C7D2FE", width=1)
        draw.text((x1 + 25, y2 - 165), "PRACTICE TIP:", fill="#3730A3", font=font_bold)
        draw.text((x1 + 25, y2 - 130), "• 5 to 10 mins daily", fill="#4338CA", font=font_small)
        draw.text((x1 + 25, y2 - 105), "• Speak out loud", fill="#4338CA", font=font_small)
        draw.text((x1 + 25, y2 - 80), "• Celebrate progress", fill="#4338CA", font=font_small)
        
    draw_footer_bar(draw, "Kanavu English Pronunciation Guide | 5-Step Daily Fluency System | school.kanavu.org")
    path = os.path.join(ASSETS_DIR, "english_pronunciation_practice_guide.png")
    img.save(path, quality=95)
    print("Saved:", path)

# ==============================================================================
# 5. BLOG 4: Style 6 - Tiered Option & Method Rating Framework
# ==============================================================================
def generate_blog4_card():
    img = Image.new("RGB", (W, H), "#F8FAFC")
    draw = ImageDraw.Draw(img)
    
    draw_header_banner(draw, 
                       "5 EFFECTIVE ENGLISH TEACHING METHODS FOR SCHOOL TEACHERS",
                       "Graded by Student Talk Time (STT), Classroom Engagement & Long-Term Fluency",
                       bg_color="#065F46", accent_color="#10B981")
    
    methods = [
        {
            "rank": "METHOD 1", "score": "95% STT",
            "name": "Story-Based Learning",
            "best": "Primary & Middle",
            "desc": "Using video narratives and picture prompts to spark spontaneous discussions.",
            "color": "#065F46", "bg": "#ECFDF5"
        },
        {
            "rank": "METHOD 2", "score": "90% STT",
            "name": "Total Physical Response",
            "best": "Foundation Learners",
            "desc": "Pairing action verbs and classroom directions with physical body movements.",
            "color": "#047857", "bg": "#F0FDF4"
        },
        {
            "rank": "METHOD 3", "score": "85% STT",
            "name": "Communicative Language",
            "best": "High School & College",
            "desc": "Structuring tasks around meaningful real-life dialogue rather than grammar rules.",
            "color": "#0D9488", "bg": "#F0FDFA"
        },
        {
            "rank": "METHOD 4", "score": "80% STT",
            "name": "Task-Based Teaching",
            "best": "Group Projects",
            "desc": "Students collaborate to solve a riddle, plan an outing, or describe a festival.",
            "color": "#0284C7", "bg": "#F0F9FF"
        },
        {
            "rank": "METHOD 5", "score": "100% Ease",
            "name": "Bilingual Bridging",
            "best": "Tamil Medium Shifts",
            "desc": "Leveraging familiar Tamil loan words to smoothly introduce English sentence stems.",
            "color": "#4338CA", "bg": "#EEF2FF"
        }
    ]
    
    col_w = 285
    col_h = 700
    gap = 20
    start_x = (W - (5 * col_w + 4 * gap)) / 2
    y1 = 165
    
    for idx, m in enumerate(methods):
        x1 = start_x + idx * (col_w + gap)
        x2 = x1 + col_w
        y2 = y1 + col_h
        
        # Tier Pillar
        draw.rounded_rectangle([x1, y1, x2, y2], radius=16, fill="#FFFFFF", outline="#CBD5E1", width=2)
        
        # Top Header pill
        draw.rounded_rectangle([x1 + 15, y1 + 20, x2 - 15, y1 + 65], radius=8, fill=m["color"])
        draw.text((x1 + 35, y1 + 32), m["rank"], fill="#FFFFFF", font=font_h3)
        
        # Score Badge
        draw.rounded_rectangle([x1 + 25, y1 + 85, x2 - 25, y1 + 155], radius=12, fill=m["bg"])
        draw.text((x1 + 45, y1 + 102), m["score"], fill=m["color"], font=font_banner)
        
        # Method Title
        draw.text((x1 + 18, y1 + 180), m["name"], fill="#0F172A", font=font_h3)
        draw.text((x1 + 18, y1 + 215), f"Best For: {m['best']}", fill="#64748B", font=font_small)
        
        # Line
        draw.line([(x1 + 20, y1 + 245), (x2 - 20, y1 + 245)], fill="#E2E8F0", width=2)
        
        # Desc
        words = m["desc"].split()
        lines = []
        curr = []
        for w_item in words:
            curr.append(w_item)
            if len(" ".join(curr)) > 24:
                lines.append(" ".join(curr))
                curr = []
        if curr:
            lines.append(" ".join(curr))
            
        cur_y = y1 + 270
        for l in lines:
            draw.text((x1 + 18, cur_y), l, fill="#334155", font=font_body)
            cur_y += 26
            
        # Metric checklist
        draw.rounded_rectangle([x1 + 15, y2 - 180, x2 - 15, y2 - 30], radius=10, fill="#F8FAFC", outline="#E2E8F0", width=1)
        draw.text((x1 + 25, y2 - 165), "CLASS IMPACT:", fill="#0F172A", font=font_bold)
        draw.text((x1 + 25, y2 - 130), "• High engagement", fill="#166534", font=font_small)
        draw.text((x1 + 25, y2 - 105), "• Spontaneous talk", fill="#166534", font=font_small)
        draw.text((x1 + 25, y2 - 80), "• Fast confidence", fill="#166534", font=font_small)
        
    draw_footer_bar(draw, "Kanavu Pedagogical Teaching Framework | Tested in 36+ Locations | school.kanavu.org")
    path = os.path.join(ASSETS_DIR, "effective_english_teaching_methods.png")
    img.save(path, quality=95)
    print("Saved:", path)

# ==============================================================================
# 6. BLOG 5: Style 8 - Serpentine Journey Roadmap / Milestone Pathway
# ==============================================================================
def generate_blog5_card():
    img = Image.new("RGB", (W, H), "#FFFDF9")
    draw = ImageDraw.Draw(img)
    
    draw_header_banner(draw, 
                       "HOW TO IMPROVE ENGLISH FOR TAMIL MEDIUM STUDENTS",
                       "A 4-Stage Confidence Pathway: Connecting Everyday Tamil to Fluent English",
                       bg_color="#831843", accent_color="#BE185D")
    
    milestones = [
        {
            "phase": "PHASE 1", "title": "Everyday Cognates",
            "desc": "Recognize that over 200 common words (bus, train, ticket, fan, light, school) are already used daily in Tamil households.",
            "color": "#9D174D", "bg": "#FCE7F3"
        },
        {
            "phase": "PHASE 2", "title": "Sentence Stems",
            "desc": "Learn ready-made sentence starters like 'I need...', 'Can you tell me...', and 'Where is...' instead of translating Tamil grammar.",
            "color": "#BE185D", "bg": "#FDF2F8"
        },
        {
            "phase": "PHASE 3", "title": "Thinking in Chunks",
            "desc": "Stop word-by-word mental translation. Group English words into natural 3-word action phrases used in everyday routines.",
            "color": "#701A75", "bg": "#FAE8FF"
        },
        {
            "phase": "PHASE 4", "title": "Fear-Free Speaking",
            "desc": "Practice in supportive pairs with zero fear of grammar errors. Fluency always comes before textbook precision.",
            "color": "#4C1D95", "bg": "#EDE9FE"
        }
    ]
    
    # Serpentine ribbon line
    ribbon_y = 480
    draw.line([(100, ribbon_y), (W - 100, ribbon_y)], fill="#F472B6", width=8)
    
    card_w = 340
    card_h = 580
    gap = 40
    start_x = (W - (4 * card_w + 3 * gap)) / 2
    
    for idx, ms in enumerate(milestones):
        x1 = start_x + idx * (card_w + gap)
        x2 = x1 + card_w
        
        # Position alternating cards or aligned cleanly
        y1 = 180
        y2 = y1 + card_h
        
        # Card container
        draw.rounded_rectangle([x1, y1, x2, y2], radius=20, fill="#FFFFFF", outline="#FBCFE8", width=2)
        
        # Waypoint Node Circle on the ribbon
        cx = x1 + card_w / 2
        draw.ellipse([cx - 40, y1 + 35, cx + 40, y1 + 115], fill=ms["color"])
        draw.text((cx - 15, y1 + 55), str(idx + 1), fill="#FFFFFF", font=font_huge_num)
        
        # Phase Tag
        draw.text((x1 + 35, y1 + 140), ms["phase"], fill=ms["color"], font=font_h3)
        draw.text((x1 + 35, y1 + 175), ms["title"], fill="#0F172A", font=font_h2)
        
        # Divider
        draw.line([(x1 + 35, y1 + 225), (x2 - 35, y1 + 225)], fill="#FCE7F3", width=2)
        
        # Desc
        words = ms["desc"].split()
        lines = []
        curr = []
        for w_item in words:
            curr.append(w_item)
            if len(" ".join(curr)) > 26:
                lines.append(" ".join(curr))
                curr = []
        if curr:
            lines.append(" ".join(curr))
            
        cur_y = y1 + 250
        for l in lines:
            draw.text((x1 + 35, cur_y), l, fill="#334155", font=font_body)
            cur_y += 26
            
        # Action takeaway box
        draw.rounded_rectangle([x1 + 25, y2 - 160, x2 - 25, y2 - 30], radius=12, fill=ms["bg"])
        draw.text((x1 + 40, y2 - 140), "MILESTONE GOAL:", fill=ms["color"], font=font_bold)
        draw.text((x1 + 40, y2 - 105), f"• Overcome Tamil lag", fill="#0F172A", font=font_small)
        draw.text((x1 + 40, y2 - 80), f"• Speak 5 sentences daily", fill="#0F172A", font=font_small)
        
    draw_footer_bar(draw, "Kanavu Tamil-to-English Fluency Bridge | 36+ Locations in Tamil Nadu | school.kanavu.org")
    path = os.path.join(ASSETS_DIR, "english_for_tamil_medium_students.png")
    img.save(path, quality=95)
    print("Saved:", path)

# ==============================================================================
# 7. BLOG 6: Style 11 - Doodle-Bordered Character & Concept Pillar Panel
# ==============================================================================
def generate_blog6_card():
    img = Image.new("RGB", (W, H), "#F8FAFC")
    draw = ImageDraw.Draw(img)
    
    # Top banner with chalk doodle aesthetic
    draw.rectangle([(0, 0), (W, 130)], fill="#312E81")
    draw.rectangle([(0, 130), (W, 136)], fill="#818CF8")
    
    # Title
    title = "COMMON ENGLISH LEARNING DIFFICULTIES AMONG STUDENTS"
    sub = "4 Common Hurdles in Rural & Vernacular Classrooms and How Kanavu Overcomes Them"
    bbox_t = draw.textbbox((0, 0), title, font=font_banner)
    draw.text(((W - (bbox_t[2] - bbox_t[0])) / 2, 28), title, fill="#FFFFFF", font=font_banner)
    bbox_s = draw.textbbox((0, 0), sub, font=font_banner_sub)
    draw.text(((W - (bbox_s[2] - bbox_s[0])) / 2, 85), sub, fill="#C7D2FE", font=font_banner_sub)
    
    # Chalk doodles on top corners
    draw.text((40, 35), "✎ ✦ ✉", fill="#A5B4FC", font=font_h2)
    draw.text((W - 140, 35), "★ ♫ ✿", fill="#A5B4FC", font=font_h2)
    
    hurdles = [
        {
            "tag": "DIFFICULTY 1",
            "name": "Fear of Making Mistakes",
            "problem": "Students stay silent because they fear peer mockery or harsh teacher criticism.",
            "solution": "Kanavu creates low-stakes story games where imperfect speech is praised for courage.",
            "color": "#4338CA", "bg": "#EEF2FF"
        },
        {
            "tag": "DIFFICULTY 2",
            "name": "Translation Fatigue",
            "problem": "Mentally converting Tamil thoughts word-by-word causes severe speech hesitation.",
            "solution": "Practice situational phrase chunks (e.g., 'Excuse me', 'May I come in') to bypass translation.",
            "color": "#6366F1", "bg": "#F5F3FF"
        },
        {
            "tag": "DIFFICULTY 3",
            "name": "Unpredictable Phonics",
            "problem": "Silent letters and irregular vowels in English confuse first-generation readers.",
            "solution": "Story videos and audio shadowing let students hear sounds naturally before seeing spelling.",
            "color": "#7C3AED", "bg": "#FAF5FF"
        },
        {
            "tag": "DIFFICULTY 4",
            "name": "Limited Daily Practice",
            "problem": "Outside the 45-minute school period, students hear zero English in their home environment.",
            "solution": "Daily routine drills connect English to home objects (fan, plate, clock) for ongoing practice.",
            "color": "#4F46E5", "bg": "#EEF2FF"
        }
    ]
    
    col_w = 360
    col_h = 700
    gap = 26
    start_x = (W - (4 * col_w + 3 * gap)) / 2
    y1 = 165
    
    for idx, h_item in enumerate(hurdles):
        x1 = start_x + idx * (col_w + gap)
        x2 = x1 + col_w
        y2 = y1 + col_h
        
        # Card container
        draw.rounded_rectangle([x1, y1, x2, y2], radius=18, fill="#FFFFFF", outline="#C7D2FE", width=2)
        
        # Pill header
        draw.rounded_rectangle([x1 + 25, y1 + 25, x1 + 200, y1 + 65], radius=8, fill=h_item["bg"])
        draw.text((x1 + 40, y1 + 35), h_item["tag"], fill=h_item["color"], font=font_h3)
        
        # Title
        draw.text((x1 + 25, y1 + 85), h_item["name"], fill="#0F172A", font=font_h2)
        
        # Divider
        draw.line([(x1 + 25, y1 + 130), (x2 - 25, y1 + 130)], fill="#E0E7FF", width=2)
        
        # Problem section
        draw.text((x1 + 25, y1 + 150), "THE HURDLE:", fill="#B91C1C", font=font_bold)
        words_p = h_item["problem"].split()
        lines_p = []
        curr_p = []
        for w_item in words_p:
            curr_p.append(w_item)
            if len(" ".join(curr_p)) > 30:
                lines_p.append(" ".join(curr_p))
                curr_p = []
        if curr_p:
            lines_p.append(" ".join(curr_p))
            
        cur_y = y1 + 180
        for l in lines_p:
            draw.text((x1 + 25, cur_y), l, fill="#475569", font=font_body)
            cur_y += 24
            
        # Solution section
        draw.text((x1 + 25, cur_y + 25), "THE KANAVU FIX:", fill="#15803D", font=font_bold)
        words_s = h_item["solution"].split()
        lines_s = []
        curr_s = []
        for w_item in words_s:
            curr_s.append(w_item)
            if len(" ".join(curr_s)) > 30:
                lines_s.append(" ".join(curr_s))
                curr_s = []
        if curr_s:
            lines_s.append(" ".join(curr_s))
            
        cur_y_s = cur_y + 55
        for l in lines_s:
            draw.text((x1 + 25, cur_y_s), l, fill="#334155", font=font_body)
            cur_y_s += 24
            
        # Action pill
        draw.rounded_rectangle([x1 + 20, y2 - 130, x2 - 20, y2 - 35], radius=12, fill=h_item["bg"])
        draw.text((x1 + 35, y2 - 110), "ACTIONABLE RESULT:", fill=h_item["color"], font=font_bold)
        draw.text((x1 + 35, y2 - 75), "Transforms hesitation into joy", fill="#0F172A", font=font_small)
        
    draw_footer_bar(draw, "Kanavu Student Difficulty Diagnostic & Solution Framework | school.kanavu.org")
    path = os.path.join(ASSETS_DIR, "common_english_learning_difficulties.png")
    img.save(path, quality=95)
    print("Saved:", path)

if __name__ == "__main__":
    generate_index_card()
    generate_blog1_card()
    generate_blog2_card()
    generate_blog3_card()
    generate_blog4_card()
    generate_blog5_card()
    generate_blog6_card()
    print("All 7 unique illustration cards generated successfully!")
