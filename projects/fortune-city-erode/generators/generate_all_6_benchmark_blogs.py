import os
import re
import statistics
import docx
from build_benchmark_blog import (
    create_benchmark_document,
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
OUTPUT_DIR = os.path.join(PROJECT_ROOT, "2026-10-30")
ASSETS_DIR = os.path.join(PROJECT_ROOT, "2026-10-29", "assets")
REPO_ROOT = os.path.abspath(os.path.join(PROJECT_ROOT, "..", ".."))
SAMPLES_DIR = os.path.join(REPO_ROOT, "extracted_samples")

INDEX_BLOG_URL = "https://www.fortunecity.in/blog/best-places-in-erode-for-shopping-food-entertainment-services"
EXACT_INDEX_TITLE = "Best Places in Erode for Shopping, Food, Entertainment & Services"

def audit_document(doc):
    pre_faq = 0
    faq = 0
    in_faq = False
    for p in doc.paragraphs:
        txt = p.text.strip()
        if not txt:
            continue
        if "Frequently Asked Questions" in txt:
            in_faq = True
        if in_faq:
            faq += len(txt.split())
        else:
            pre_faq += len(txt.split())
    for t in doc.tables:
        for r in t.rows:
            for c in r.cells:
                pre_faq += len(c.text.split())
                
    lengths = []
    for p in doc.paragraphs:
        txt = p.text.strip()
        if not txt or txt.startswith("Primary Keyword") or txt.startswith("Secondary") or txt.startswith("Meta Description"):
            continue
        sentences = [s.strip() for s in re.split(r'[.!?]+', txt) if len(s.strip().split()) > 1]
        for s in sentences:
            lengths.append(len(s.split()))
    stdev_len = statistics.stdev(lengths) if len(lengths) > 3 else 0
    return pre_faq, faq, pre_faq + faq, stdev_len

# ==============================================================================
# BLOG 1: Indoor Entertainment in Erode (Simple Plain English)
# ==============================================================================
def build_blog_1():
    doc = create_benchmark_document()
    add_title(doc, "Rainy Day in Erode? Explore Indoor Entertainment for Families")
    
    add_metadata_block(
        doc,
        primary_kw="Indoor Entertainment in Erode",
        secondary_kws=[
            "things to do in Erode on rainy day",
            "Fortune multiplex cinema Erode",
            "indoor games Erode",
            "family entertainment centre Erode",
            "indoor shopping mall Erode",
            "kids entertainment zone Erode"
        ],
        meta_desc="Looking for indoor entertainment in Erode on a rainy day? Discover arcade games, 4K laser movies, kids zones, and dining at Fortune City."
    )
    
    # 3-Beat Sensory Opening Hook
    add_para(doc, [
        ("Imagine sudden monsoon rain pouring across the streets of Erode on a Saturday afternoon. Your kids had planned cricket at the ground, and now everyone is asking, ", False, "990000"),
        ("“Where can we go today?”", True, "990000")
    ])
    add_para(doc, "Suddenly, outdoor plans are cancelled, and everyone wants something fun, dry, and exciting!")
    add_para(doc, [
        ("From movie theaters to arcade games, finding the right ", False),
        ("Indoor Entertainment in Erode", True),
        (" turns a rainy day into a fun family outing.", False)
    ])
    
    # The "Why" Section
    add_h2(doc, "Why Indoor Entertainment Matters on Rainy Days")
    add_para(doc, "Heavy rain leaves sports grounds muddy and parks unusable. Sitting trapped inside the house quickly makes children restless and bored.")
    add_para(doc, [
        ("When planning family outings across the district, explore our curated regional guide on ", False),
        (EXACT_INDEX_TITLE, False, "0000FF", INDEX_BLOG_URL),
        (" to find sheltered spots that keep everyone dry and happy.", False)
    ])
    
    # Core Step-by-Step Guide
    add_h2(doc, "Indoor Entertainment in Erode: Top Rainy Day Activities")
    
    # Embedded Primary Infographic Card
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "indoor_entertainment_erode_infographic.jpg"),
        caption="Indoor Entertainment in Erode: 5 Family Activities at Fortune City.",
        filename="indoor-entertainment-erode-family-activities.jpg",
        alt="Indoor entertainment in Erode 5 family activities at Fortune City including multiplex cinema, arcade games, and kids play zone"
    )
    
    add_h3(doc, "1. Fortune Multiplex Cinema Experience")
    add_para(doc, [
        ("Sink into soft leather recliners with a tub of hot popcorn. Watch the latest films with ", False),
        ("bright 4K laser projection and clear surround sound", True),
        (" while the rain falls outside.", False)
    ])
    add_para(doc, [
        ("As reported in ", False),
        ("The Hindu cinema and family entertainment coverage", False, "0000FF", "https://www.thehindu.com/entertainment/movies/"),
        (", modern multiplexes have become the top weekend haven for families during monsoon seasons.", False)
    ])
    
    add_h3(doc, "2. Family Arcade and VR Gaming Zones")
    add_para(doc, [
        ("From fast racing car games to ", False),
        ("virtual reality adventures", True),
        (", the arcade zone keeps kids, teenagers, and parents happily playing together.", False)
    ])
    
    add_h3(doc, "3. Safe Toddler and Kids Play Arenas")
    add_para(doc, [
        ("Young children can climb padded slides and play in colorful ball pits. It lets energetic toddlers ", False),
        ("play safely", True),
        (" in a clean, soft environment.", False)
    ])
    
    add_h3(doc, "4. Sheltered Shopping and Brand Outlets")
    add_para(doc, [
        ("While children play, parents can walk through well-lit stores, browsing ", False),
        ("clothes, shoes, and lifestyle brands", True),
        (" without stepping into puddles.", False)
    ])
    
    # Single-Cell Callout Box
    add_callout_box(doc, "DID YOU KNOW?", [
        ("Rainy Day Outings:", "Most families choose indoor shopping malls and entertainment centers during monsoon months to avoid muddy roads."),
        ("Easy Highway Drive:", "Fortune City sits right on NH 544 at Chithode, so families can visit easily without driving through town traffic.")
    ])
    
    # Facility Spotlight Section
    add_h2(doc, "Where to Experience Complete Indoor Entertainment in Erode?")
    add_h3(doc, "Discover Avenue Malls at Fortune City")
    add_para(doc, "The Fortune City center brings movie screens, arcade games, and dining together under one roof, keeping everyone completely protected from wet weather.")
    add_para(doc, [
        ("Families can watch newly released movies, play arcade games, and eat together in comfort. Check current movie times and events on the official ", False),
        ("Fortune City Avenue Malls entertainment portal", False, "0000FF", "https://www.fortunecity.in/avenue-malls"),
        (".", False)
    ])
    
    # Conclusion
    add_h2(doc, "Make Rainy Weekends Unforgettable")
    add_para(doc, "Do not let bad weather cancel family time. Step into a sheltered world where games, movies, and hot snacks wait together.")
    add_para(doc, [("Because rainy afternoons are best spent making happy memories together.", True, "38761D")])
    
    # FAQs (Exactly 3)
    add_faqs(doc, [
        ("What indoor entertainment options in Erode are best for toddlers?",
         "Avenue Malls features soft-play areas with padded slides, ball pits, and trained staff, giving young toddlers a safe, dry place to play during rainy weather."),
        ("Does Fortune Multiplex in Erode have covered parking during rain?",
         "Yes, the building provides covered basement parking with elevators, keeping families completely dry from the moment they park until they reach their movie seats."),
        ("Where can families eat while enjoying indoor activities at Fortune City?",
         "Visitors can walk right into Food Valley on the dining floor, offering hot filter coffee, crispy bajjis, steamed momos, burgers, and family meals in one spot.")
    ])
    
    return doc

# ==============================================================================
# BLOG 2: Wedding Hall Cost in Erode (Simple Plain English)
# ==============================================================================
def build_blog_2():
    doc = create_benchmark_document()
    add_title(doc, "How Much Does a Wedding Hall Cost in Erode? A Budget Planning Guide")
    
    add_metadata_block(
        doc,
        primary_kw="Wedding Hall Cost in Erode",
        secondary_kws=[
            "marriage hall rent Erode",
            "wedding mandapam price Erode",
            "Fortune Wedding Mahal Erode",
            "luxury marriage halls in Erode",
            "wedding budget planning Tamil Nadu",
            "reception hall cost Erode"
        ],
        meta_desc="Planning a wedding in Erode? Learn realistic wedding hall cost in Erode, peak season price factors, hidden expenses, and explore Fortune Wedding Mahal."
    )
    
    # 3-Beat Sensory Opening Hook
    add_para(doc, [
        ("Imagine sitting with your family to plan a grand wedding in Erode, listing out 1,500 guests, stage flowers, and dinner menus. Then someone asks, ", False, "990000"),
        ("“What will the marriage hall actually cost us?”", True, "990000")
    ])
    add_para(doc, "Suddenly, you start calling halls and find that rental prices vary wildly without clear explanation!")
    add_para(doc, [
        ("Knowing the realistic ", False),
        ("Wedding Hall Cost in Erode", True),
        (" helps families plan their marriage budget accurately and avoid unexpected extra bills.", False)
    ])
    
    # The "Why" Section
    add_h2(doc, "Why Wedding Hall Costs Vary Across Erode")
    add_para(doc, "Marriage hall rents in Erode range from simple community halls to grand air-conditioned venues. Prices depend mainly on guest seating, air cooling, kitchen facilities, and road access.")
    add_para(doc, [
        ("When planning wedding arrangements across the region, consult our comprehensive directory of the ", False),
        (EXACT_INDEX_TITLE, False, "0000FF", INDEX_BLOG_URL),
        (" to compare venues and vendor options.", False)
    ])
    
    # Core Step-by-Step Guide
    add_h2(doc, "Wedding Hall Cost in Erode: 5 Key Budget Factors")
    
    # Embedded Primary Infographic Card
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "wedding_hall_cost_erode_infographic.jpg"),
        caption="Wedding Hall Cost in Erode: 5 Key Budget Factors at Fortune Wedding Mahal.",
        filename="wedding-hall-cost-erode-budget-factors.jpg",
        alt="Wedding hall cost in Erode 5 budget factors including hall seating capacity, central air conditioning, commercial kitchen, and guest suites"
    )
    
    add_h3(doc, "1. Seating Capacity and Dining Layout")
    add_para(doc, [
        ("Big weddings need halls that seat 1,000 to 2,000 people comfortably. Make sure the dining hall has ", False),
        ("at least 500 dining seats at a time", True),
        (" so guests do not have to wait in long queues for food.", False)
    ])
    add_para(doc, [
        ("According to ", False),
        ("The Economic Times wedding and hospitality market analysis", False, "0000FF", "https://economictimes.indiatimes.com/industry/services/retail"),
        (", wedding halls with direct highway access save families up to 30% on travel time and guest transport costs.", False)
    ])
    
    add_h3(doc, "2. Central Air Conditioning and Generator Backup")
    add_para(doc, [
        ("Summer heat in Erode can make crowded rituals tiring. Fully air-conditioned halls with ", False),
        ("100% generator power backup", True),
        (" keep guests cool, fresh, and comfortable throughout the day.", False)
    ])
    
    add_h3(doc, "3. Large Commercial Kitchen Setup")
    add_para(doc, [
        ("Catering teams need spacious stainless-steel cooking spaces, steam boilers, and strong gas stoves to ", False),
        ("serve fresh, hot food on time", True),
        (" to thousands of relatives.", False)
    ])
    
    add_h3(doc, "4. Furnished Guest Rooms and Dressing Suites")
    add_para(doc, [
        ("Halls that include air-conditioned bride, groom, and family rooms save you the trouble of ", False),
        ("booking costly separate hotel rooms", True),
        (" for visiting relatives.", False)
    ])
    
    # Single-Cell Callout Box
    add_callout_box(doc, "QUICK BUDGET FACT CHECK", [
        ("Simple Town Halls:", "₹75,000 to ₹1.5 Lakhs per day (often extra for generator fuel, cleaning, and AC electricity)."),
        ("Modern AC Halls:", "₹2.5 Lakhs to ₹6 Lakhs per day (usually includes central AC, dining hall, kitchen, and guest suites).")
    ])
    
    # Facility Spotlight Section
    add_h2(doc, "Where to Find Premium Wedding Facilities in Erode?")
    add_h3(doc, "Fortune Wedding Mahal at Fortune City")
    add_para(doc, "The Fortune City campus hosts one of the region's largest wedding destinations, designed for seamless grand celebrations.")
    add_para(doc, [
        ("Fortune Wedding Mahal offers large banquet seating, a full commercial kitchen, bridal suites, and parking for over 1,000 cars. View hall layouts and booking packages at ", False),
        ("Fortune Wedding Mahal venue facilities", False, "0000FF", "https://www.fortunecity.in/wedding-mahal"),
        (".", False)
    ])
    
    # Conclusion
    add_h2(doc, "Choose Value and Comfort for Your Special Day")
    add_para(doc, "Look beyond the basic rental price. Choose a venue with clear, all-inclusive pricing so your wedding day runs smoothly and happily.")
    add_para(doc, [("A great wedding begins with a venue where every guest feels welcome.", True, "38761D")])
    
    # FAQs (Exactly 3)
    add_faqs(doc, [
        ("What is the average wedding hall cost in Erode for a grand reception?",
         "A modern air-conditioned wedding hall in Erode for 1,000 to 2,000 guests usually costs between ₹2.5 Lakhs and ₹5 Lakhs per day, including dining areas and guest bedrooms."),
        ("Does Fortune Wedding Mahal provide air-conditioned suites for families?",
         "Yes, the venue provides fully furnished, air-conditioned rooms for the bride, groom, and close family members right next to the main stage for easy resting and dressing."),
        ("Why is NH 544 highway connectivity advantageous for wedding venues in Erode?",
         "The highway location at Chithode lets guests traveling from Coimbatore, Salem, Tirupur, and Bengaluru drive straight to the hall without getting stuck in narrow city streets.")
    ])
    
    return doc

# ==============================================================================
# BLOG 3: Comfort Foods in Tamil Nadu (Simple Plain English)
# ==============================================================================
def build_blog_3():
    doc = create_benchmark_document()
    add_title(doc, "What to Eat on a Rainy Day? Popular Comfort Foods in Tamil Nadu")
    
    add_metadata_block(
        doc,
        primary_kw="Popular Comfort Foods in Tamil Nadu",
        secondary_kws=[
            "Hot Foods",
            "Steamed momos",
            "Filter coffee",
            "Milagai bajji",
            "Sambar vadai",
            "Fortune City Erode"
        ],
        meta_desc="Explore popular comfort foods in Tamil Nadu, from crispy bajji to hot idli and momos. Discover great food spots in Erode at Fortune City."
    )
    
    # 3-Beat Sensory Opening Hook
    add_para(doc, [
        ("Imagine a rainy evening in Tamil Nadu. The streets are wet, the air is cool, and someone asks, ", False, "990000"),
        ("“Bajji saapdalaama?”", True, "990000")
    ])
    add_para(doc, "Suddenly, everyone wants something hot, crispy, and tasty!")
    add_para(doc, [
        ("From home-cooked snacks to restaurant meals, the ", False),
        ("Popular Comfort Foods in Tamil Nadu", True),
        (" make rainy days much more enjoyable.", False)
    ])
    
    # The "Why" Section
    add_h2(doc, "Why Do Hot Foods Taste Better on Rainy Days?")
    add_para(doc, "Cool, breezy weather makes hot food feel extra comforting. The smell of fresh sambar, crispy vadai, or filter coffee also brings back warm memories of family gatherings.")
    add_para(doc, [
        ("When planning food outings across the region, explore our curated directory of the ", False),
        (EXACT_INDEX_TITLE, False, "0000FF", INDEX_BLOG_URL),
        (" for authentic dining destinations.", False)
    ])
    
    # Core Step-by-Step Guide
    add_h2(doc, "Popular Comfort Foods in Tamil Nadu to Enjoy During Rain")
    
    # Embedded Primary Infographic Card
    add_image_card(
        doc,
        img_path=os.path.join(SAMPLES_DIR, "sample_1_image2.png"),
        caption="Popular Comfort Foods in Tamil Nadu enjoyed during rainy days.",
        filename="comfort-foods-tamil-nadu-rainy-day.jpg",
        alt="Popular comfort foods in Tamil Nadu including bajji, vadai, idli, rasam and coffee"
    )
    
    add_h3(doc, "1. Bajji and Vadai")
    add_para(doc, [
        ("Milagai bajji, onion bajji, and crispy masala vadai", True),
        (" are favorite evening snacks. Their crunchy texture goes perfectly with coconut chutney or hot tea.", False)
    ])
    
    add_h3(doc, "2. Idli and Sambar")
    add_para(doc, [
        ("Soft, steaming ", False),
        ("idlis dipped in hot sambar with a spoonful of ghee", True),
        (" make a light, warm, and satisfying meal on a chilly day.", False)
    ])
    
    add_h3(doc, "3. Pepper Rasam")
    add_para(doc, [
        ("Prepared with crushed black pepper, cumin, and garlic, hot ", False),
        ("milagu rasam", True),
        (" warms your body and helps keep seasonal colds away.", False)
    ])
    add_para(doc, [
        ("As shared in ", False),
        ("The Hindu regional culinary and food culture stories", False, "0000FF", "https://www.thehindu.com/life-and-style/food/"),
        (", traditional rainy day snacks in Tamil Nadu naturally use warming spices that aid digestion and keep you warm.", False)
    ])
    
    add_h3(doc, "4. Hot Momos and Chinese Dishes")
    add_para(doc, [
        ("Looking for a different taste? ", False),
        ("Steamed momos, noodles, and hot soups", True),
        (" are popular choices for young people and food lovers.", False)
    ])
    
    add_h3(doc, "5. Crispy Chicken and Burgers")
    add_para(doc, [
        ("Crispy fried chicken, burgers, and hot french fries", True),
        (" offer a crunchy, filling treat for family weekend evenings.", False)
    ])
    
    # Single-Cell Callout Box
    add_callout_box(doc, "A LITTLE RAINY DAY FOOD STORY", [
        ("Food Brings People Together:", "Rainy weather is always an invitation to share hot food with friends."),
        ("Simple Pleasures:", "A plate of hot bajjis and a cup of tea turn an ordinary rainy evening into a happy memory.")
    ])
    
    # Facility Spotlight Section
    add_h2(doc, "Where to Explore Different Food Brands in Erode?")
    add_h3(doc, "Discover Food Valley at Fortune City")
    add_para(doc, "At Food Valley, family members do not need to argue over what to eat. Everyone can pick their favorite food under one roof.")
    add_para(doc, [
        ("Whether you crave traditional South Indian snacks or modern meals, explore all food options on the official ", False),
        ("Fortune City Food Valley dining portal", False, "0000FF", "https://www.fortunecity.in/food-valley"),
        (".", False)
    ])
    
    add_h3(doc, "Food Brands to Explore", color="990000")
    
    # Embedded Secondary Showcase Card
    add_image_card(
        doc,
        img_path=os.path.join(SAMPLES_DIR, "sample_1_image1.png"),
        caption="Popular Comfort Foods in Tamil Nadu: Food Brands to Explore at Fortune City.",
        filename="food-valley-brands-fortune-city-erode.jpg",
        alt="Food Valley dining brands at Fortune City Erode including Dipp'd Idly, Wow Momo, McDonald's, KFC"
    )
    
    add_para(doc, [
        ("• Dipp'd Idly: South Indian idlis with fresh chutneys. | Wow! Momo: Steamed momos and noodles. | McDonald's & KFC: Burgers and crispy chicken.", False)
    ])
    
    # Conclusion
    add_h2(doc, "What Is Your Rainy Day Favourite?")
    add_para(doc, "Whether you like traditional bajjis with filter coffee or hot momos with spicy chutney, delicious food makes every rainy day special.")
    add_para(doc, [("Because rainy evenings taste better together.", True, "38761D")])
    
    # FAQs (Exactly 3)
    add_faqs(doc, [
        ("What Are the Most Popular Comfort Foods in Tamil Nadu During Rainy Days?",
         "Popular comfort foods include crispy milagai bajjis, medu vadais, soft idlis with hot sambar, pepper rasam, and fresh filter coffee. Hot momos and burgers are also widely enjoyed."),
        ("Why Do People Prefer Hot Snacks During Rainy Weather?",
         "Cool weather naturally makes us crave warm, freshly made snacks. Crispy foods and mild spices like pepper and ginger warm the body and feel deeply satisfying."),
        ("Where Can Families Enjoy Different Food Varieties in Erode?",
         "Families can visit Food Valley at Fortune City on NH 544 at Chithode, which features South Indian meals, momos, Chinese food, burgers, and ice cream in one clean, covered space.")
    ])
    
    return doc

# ==============================================================================
# BLOG 4: Cotton Fabric Quality (Simple Plain English)
# ==============================================================================
def build_blog_4():
    doc = create_benchmark_document()
    add_title(doc, "How to Check Cotton Fabric Quality Before Buying Wholesale?")
    
    add_metadata_block(
        doc,
        primary_kw="How to Check Cotton Fabric Quality",
        secondary_kws=[
            "GSM (fabric thickness)",
            "Fabric Weave",
            "Wholesale Cotton Fabrics in Erode",
            "Texvalley",
            "fabric shrinkage",
            "colour fastness"
        ],
        meta_desc="Learn how to identify good-quality cotton fabric before buying wholesale by checking GSM, weave, colour fastness, shrinkage and fabric feel."
    )
    
    # 3-Beat Sensory Opening Hook
    add_para(doc, [
        ("Imagine ordering 500 metres of cotton fabric. The color looks bright, the price is attractive, and the seller promises fast delivery. Then someone asks, ", False, "990000"),
        ("“Have you checked the weave and shrinkage?”", True, "990000")
    ])
    add_para(doc, "Suddenly, you realize that hidden fabric flaws can ruin hundreds of finished shirts or dresses!")
    add_para(doc, [
        ("Knowing ", False),
        ("How to Check Cotton Fabric Quality", True),
        (" helps wholesale buyers avoid costly mistakes before placing bulk cloth orders.", False)
    ])
    
    # The "Why" Section
    add_h2(doc, "Why Does Cotton Fabric Quality Matter?")
    add_para(doc, "A small defect in one fabric roll can spoil an entire batch of clothing. If cloth shrinks too much or loses color after washing, customers return the items and lose trust in your brand.")
    add_para(doc, [
        ("When sourcing wholesale fabrics across Western Tamil Nadu, consult our regional commercial overview of the ", False),
        (EXACT_INDEX_TITLE, False, "0000FF", INDEX_BLOG_URL),
        (" to identify key trading districts.", False)
    ])
    
    # Core Step-by-Step Guide
    add_h2(doc, "How to Check Cotton Fabric Quality: 6 Essential Steps")
    
    # Embedded Primary Infographic Card
    add_image_card(
        doc,
        img_path=os.path.join(SAMPLES_DIR, "sample_2_image1.png"),
        caption="How to Check Cotton Fabric Quality: 6 Essential Steps for Wholesale Buyers.",
        filename="check-cotton-fabric-quality-wholesale-guide.jpg",
        alt="How to check cotton fabric quality 6 essential steps including GSM, weave, colour fastness, and shrinkage"
    )
    
    add_h3(doc, "1. Feel the Fabric Texture")
    add_para(doc, [
        ("Feel the cloth between your fingers. High-grade cotton feels ", False),
        ("smooth, soft, and slightly heavy", True),
        (". It should not feel scratchy, thin, or unnaturally stiff from starch powder.", False)
    ])
    
    add_h3(doc, "2. Examine the Fabric Weave")
    add_para(doc, [
        ("Hold the cloth up against bright light. Check for ", False),
        ("neat, evenly spaced threads", True),
        (". Large gaps, thick knots, or loose threads mean the fabric was woven carelessly.", False)
    ])
    
    add_h3(doc, "3. Check Cotton Fabric GSM (Thickness)")
    add_para(doc, [
        ("GSM tells you the fabric weight and thickness per square metre. ", False),
        ("Light cotton (100–140 GSM)", True),
        (" is great for summer shirts, while thicker cotton (160–220 GSM) works better for pants and uniforms.", False)
    ])
    add_para(doc, [
        ("According to ", False),
        ("The Economic Times textile and apparel industry reports", False, "0000FF", "https://economictimes.indiatimes.com/industry/cons-products/garments-/-textiles"),
        (", testing fabrics carefully before buying wholesale protects clothing makers from expensive fabric wastage and customer returns.", False)
    ])
    
    add_h3(doc, "4. Test Colour Fastness")
    add_para(doc, [
        ("Rub a damp white handkerchief firmly over the colored cloth. If dye rubs off, the cloth will likely ", False),
        ("fade and bleed color during home washes", True),
        (", which points to cheap dyes.", False)
    ])
    
    add_h3(doc, "5. Check Fabric Shrinkage")
    add_para(doc, [
        ("Natural cotton threads shrink when washed in water. Reliable suppliers provide ", False),
        ("pre-shrunk, treated cotton cloth", True),
        (" that shrinks less than 3% to 5%, keeping shirt sizes accurate.", False)
    ])
    
    add_h3(doc, "6. Verify Fabric Composition")
    add_para(doc, [
        ("Check if the cloth is genuine cotton. A quick ", False),
        ("burn test on a single thread", True),
        (" tells the truth: pure cotton burns with a paper smell leaving soft ash, while synthetic polyester melts into hard plastic beads.", False)
    ])
    
    # Single-Cell Callout Box 1
    add_callout_box(doc, "DID YOU KNOW?", [
        ("100% Cotton Isn't Everything:", "A label saying 100% cotton does not guarantee quality. How tightly the threads are woven matters just as much."),
        ("Combed Cotton Advantage:", "Combed cotton cleans out short, rough fibers, creating cloth that feels noticeably smoother and lasts longer.")
    ])
    
    # Facility Spotlight Section
    add_h2(doc, "Where to Explore Wholesale Cotton Fabrics in Erode?")
    add_h3(doc, "Texvalley: A Major Textile Marketplace")
    add_para(doc, "The market brings hundreds of verified cotton manufacturers under one roof, making bulk sourcing simple and reliable.")
    add_para(doc, [
        ("Buyers can inspect fabric rolls in person, test GSM thickness, compare bulk rates, and connect with weavers on the ", False),
        ("official Texvalley wholesale marketplace portal", False, "0000FF", "https://texvalleyindia.texvalley.in/"),
        (".", False)
    ])
    
    # Single-Cell Callout Box 2
    add_callout_box(doc, "TEXVALLEY AT A GLANCE", [
        ("20 Lakh Sq. Ft.:", "One of South India's largest wholesale textile and garment shopping centers."),
        ("500+ Showrooms:", "Direct wholesale access to cotton fabrics, yarn, lungis, sarees, and readymade clothing."),
        ("Highway Location:", "Right on NH 544 at Gangapuram, Chithode, Erode.")
    ])
    
    # Conclusion
    add_h2(doc, "Choose Quality Before Quantity")
    add_para(doc, "Wholesale buying succeeds when you test every fabric roll. Checking weave, thickness, and color hold saves money and earns your customers' trust.")
    add_para(doc, [("Great garments always begin with genuine fabric quality.", True, "38761D")])
    
    # FAQs (Exactly 3)
    add_faqs(doc, [
        ("How Can I Check Cotton Fabric Quality at Home?",
         "You can check cloth quality by feeling its softness, holding it to sunlight to check weave tightness, rubbing it with a wet white cloth to see if color bleeds, and checking thickness."),
        ("Does Higher GSM Mean Better Cotton Fabric Quality?",
         "Not necessarily. GSM only shows how heavy the cloth is, not how soft it feels. Heavy cloth can still be rough, while a lighter cotton shirt fabric can be very soft, strong, and durable."),
        ("Where Can I Buy Wholesale Cotton Fabric in Erode?",
         "Wholesale buyers can visit Texvalley on NH 544 at Chithode, Erode, which has over 500 textile showrooms and fabric mills offering wholesale prices in one place.")
    ])
    
    return doc

# ==============================================================================
# BLOG 5: EV Charging During Rain (Simple Plain English)
# ==============================================================================
def build_blog_5():
    doc = create_benchmark_document()
    add_title(doc, "Is It Safe to Charge an Electric Car During Rain?")
    
    add_metadata_block(
        doc,
        primary_kw="Safe to Charge an Electric Car During Rain",
        secondary_kws=[
            "Zeon Charging Station",
            "weather-resistant connectors",
            "EV charging equipment",
            "EV Charging Station at Fortune City",
            "waterproof seals",
            "electric vehicle rain safety"
        ],
        meta_desc="Is it safe to charge an electric car during rain? Learn essential EV charging precautions, weather-resistant connector tech, and charging tips."
    )
    
    # 3-Beat Sensory Opening Hook
    add_para(doc, [
        ("Imagine driving down the highway when heavy rain begins. Your electric car battery is running low, and you spot a charging station ahead through the downpour. Then you wonder: ", False, "990000"),
        ("“Is it dangerous to plug in during heavy rain?”", True, "990000")
    ])
    add_para(doc, "Suddenly, you hesitate to step out and handle electric plugs in wet weather!")
    add_para(doc, [
        ("Yes, it is completely ", False),
        ("Safe to Charge an Electric Car During Rain", True),
        (" when using certified, weather-resistant charging stations with built-in safety seals.", False)
    ])
    
    # The "Why" Section
    add_h2(doc, "Why Is It Safe to Charge an Electric Car During Rain?")
    add_para(doc, "Modern EV chargers use sealed, waterproof connectors. The charging pins and plugs are tightly enclosed so rainwater cannot touch live electric wires.")
    add_para(doc, [
        ("When planning EV road trips across Western Tamil Nadu, consult our regional travel directory of the ", False),
        (EXACT_INDEX_TITLE, False, "0000FF", INDEX_BLOG_URL),
        (" to map out reliable charging stops.", False)
    ])
    
    # Core Step-by-Step Guide
    add_h2(doc, "5 Safety Tips: Safe to Charge an Electric Car During Rain")
    
    # Embedded Primary Infographic Card
    add_image_card(
        doc,
        img_path=os.path.join(SAMPLES_DIR, "sample_3_image2.png"),
        caption="5 EV Charging Safety Tips During Rain for Electric Car Drivers.",
        filename="ev-charging-safety-tips-rain.jpg",
        alt="5 EV charging safety tips during rain including cable inspection, avoiding flooded areas, and checking ports"
    )
    
    add_h3(doc, "1. Inspect the Charging Cable")
    add_para(doc, [
        ("Take a quick look at the cable handle before plugging in. ", False),
        ("Never use a damaged cable with cuts or exposed wires", True),
        (" in wet weather.", False)
    ])
    
    add_h3(doc, "2. Avoid Flooded Areas")
    add_para(doc, [
        ("Park on clean concrete ground. ", False),
        ("Do not stand in deep water puddles", True),
        (" while holding high-power fast-charging cables.", False)
    ])
    
    add_h3(doc, "3. Check the Charging Port")
    add_para(doc, [
        ("Wipe any stray raindrops off your car's charging flap with a clean cloth. ", False),
        ("Make sure the plug clicks firmly into place", True),
        (" before starting the charger.", False)
    ])
    add_para(doc, [
        ("As explained in ", False),
        ("Autocar India electric vehicle technical safety analysis", False, "0000FF", "https://www.autocarindia.com/car-news"),
        (", commercial EV fast chargers have automatic safety sensors that cut power instantly if water enters the plug.", False)
    ])
    
    add_h3(doc, "4. Avoid Extension Cords")
    add_para(doc, [
        ("Never use ordinary home extension cords outdoors in the rain. ", False),
        ("Use only certified commercial charging cables", True),
        (" built for outdoor weather.", False)
    ])
    
    add_h3(doc, "5. Be Careful During Thunderstorms")
    add_para(doc, [
        ("While modern stations have lightning protection, it is always smart to ", False),
        ("wait out severe lightning strikes", True),
        (" before charging outdoors.", False)
    ])
    
    # Single-Cell Callout Box 1
    add_callout_box(doc, "DID YOU KNOW?", [
        ("No Instant Power:", "Electricity does not flow the second you plug in the cable."),
        ("Digital Check:", "The car and charger run a quick electronic safety check first to make sure the connection is dry and grounded.")
    ])
    
    # Single-Cell Callout Box 2
    add_callout_box(doc, "QUICK SAFETY CHECK", [
        ("Normal Rain:", "Safe to charge with standard commercial chargers."),
        ("Damaged Cable:", "Do not plug in under any circumstances."),
        ("Flooded Ground:", "Avoid waterlogged bays; move to higher dry ground.")
    ])
    
    # Facility Spotlight Section
    add_h2(doc, "Where Can You Charge Your EV in Erode?")
    add_h3(doc, "Zeon Charging at Fortune City")
    add_para(doc, "The Fortune City campus offers sheltered fast chargers right along the main road, protected from heavy rain.")
    add_para(doc, [
        ("Drivers can check open charger slots and rates on the ", False),
        ("EV Charging Station at Fortune City portal", False, "0000FF", "https://www.fortunecity.in/explore/ev-charging-station"),
        (" or through the Zeon Charging phone app before arriving.", False)
    ])
    
    # Embedded Secondary Hero Card
    add_image_card(
        doc,
        img_path=os.path.join(SAMPLES_DIR, "sample_3_image1.png"),
        caption="Zeon Fast Charging options and connectors at Fortune City, Erode.",
        filename="zeon-ev-charging-station-fortune-city.jpg",
        alt="Zeon Charging fast EV charging station at Fortune City Erode on NH 544 highway"
    )
    
    # Single-Cell Callout Box 3
    add_callout_box(doc, "FORTUNE CITY EV CHARGING FACTS", [
        ("120 kW Fast Charging:", "High-speed DC fast chargers for highway drivers."),
        ("8 Charging Points:", "Multiple connectors supporting both fast DC and slow AC charging."),
        ("24 Hours Open:", "Sheltered highway parking with food and clean restrooms nearby.")
    ])
    
    # Conclusion
    add_h2(doc, "Charge Safely, Even When It Rains")
    add_para(doc, "Rain does not need to stop your electric drive. With certified chargers and simple common sense, charging in the rain is completely safe.")
    add_para(doc, [("Safe journeys start with safe charging.", True, "38761D")])
    
    # FAQs (Exactly 3)
    add_faqs(doc, [
        ("Is It Safe to Charge an Electric Car During Heavy Rain?",
         "Yes, modern EV charging plugs have waterproof seals that keep water away from live pins, making charging completely safe even during heavy monsoons."),
        ("What Happens If Rainwater Enters an EV Charging Port?",
         "Chargers test the connection first. If water is detected on the pins before power starts, safety sensors block electricity immediately to prevent any shock."),
        ("Where Can I Find a Reliable EV Charging Station in Erode?",
         "EV drivers can charge at Zeon Charging inside Fortune City on NH 544 at Chithode, which features 120 kW fast chargers open 24 hours every day.")
    ])
    
    return doc

# ==============================================================================
# BLOG 6: Co-Living vs PG Accommodation (Simple Plain English)
# ==============================================================================
def build_blog_6():
    doc = create_benchmark_document()
    add_title(doc, "Co-Living vs PG Accommodation in Erode: Which Is Right for You?")
    
    add_metadata_block(
        doc,
        primary_kw="Co-Living vs PG Accommodation",
        secondary_kws=[
            "PG accommodation in Erode",
            "co-living spaces Erode",
            "student housing Erode",
            "executive bachelor stay Erode",
            "managed apartments Erode",
            "Fortune City co-living"
        ],
        meta_desc="Choosing between co-living vs PG accommodation in Erode? Compare rental costs, amenities, privacy, food quality, and managed living options."
    )
    
    # 3-Beat Sensory Opening Hook
    add_para(doc, [
        ("Imagine moving to Erode for a new job or textile project, scrolling through room listings while living out of a suitcase. Then you wonder, ", False, "990000"),
        ("“Where will I actually feel at home?”", True, "990000")
    ])
    add_para(doc, "Suddenly, you face the choice between crowded hostels and modern managed studio spaces!")
    add_para(doc, [
        ("Comparing ", False),
        ("Co-Living vs PG Accommodation", True),
        (" helps working professionals and students choose the right mix of personal privacy, daily comforts, and fair rent.", False)
    ])
    
    # The "Why" Section
    add_h2(doc, "Why Housing Expectations Are Shifting in Erode")
    add_para(doc, "As Erode grows into a bustling business hub, young professionals moving to the city want more than four bare walls and shared bathrooms.")
    add_para(doc, [
        ("To learn about residential and shopping centers in Erode, read our local guide on ", False),
        (EXACT_INDEX_TITLE, False, "0000FF", INDEX_BLOG_URL),
        (". The Fortune City center provides comfortable executive housing.", False)
    ])
    
    # Core Step-by-Step Guide
    add_h2(doc, "Co-Living vs PG Accommodation: 5 Key Differences")
    
    # Embedded Primary Infographic Card
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "coliving_vs_pg_erode_infographic.jpg"),
        caption="Co-Living vs PG Accommodation: 5 Key Factors at Fortune City, Erode.",
        filename="coliving-vs-pg-accommodation-erode-factors.jpg",
        alt="Co-living vs PG accommodation in Erode comparison points including privacy, amenities, wifi, and maintenance"
    )
    
    add_h3(doc, "1. Room Privacy and Personal Space")
    add_para(doc, [
        ("Traditional PGs crowd three or four beds into small rooms. Co-living offers ", False),
        ("private furnished studio rooms", True),
        (" with personal study desks, wardrobes, and attached private bathrooms for quiet rest.", False)
    ])
    
    add_h3(doc, "2. Dining Freedom and Meal Flexibility")
    add_para(doc, [
        ("PG hostels serve fixed food menus at strict hours. Co-living residents enjoy ", False),
        ("shared modern cooking pantries", True),
        (" to prepare snacks, along with easy access to food court dining counters.", False)
    ])
    
    add_h3(doc, "3. Housekeeping and Maintenance Support")
    add_para(doc, [
        ("No more arguments over whose turn it is to sweep. Co-living includes ", False),
        ("regular room cleaning and quick repair service", True),
        (" handled automatically by housekeeping staff.", False)
    ])
    
    add_h3(doc, "4. Work-Ready Internet and Power Backup")
    add_para(doc, [
        ("Remote work requires steady internet. Co-living provides ", False),
        ("fast Wi-Fi and 100% generator power backup", True),
        (" so your work calls never drop during power cuts.", False)
    ])
    add_para(doc, [
        ("According to ", False),
        ("The Economic Times real estate and urban living reports", False, "0000FF", "https://economictimes.indiatimes.com/wealth/real-estate"),
        (", managed co-living spaces offer better value by combining rent, Wi-Fi, electricity, and housekeeping into one clear monthly bill.", False)
    ])
    
    add_h3(doc, "5. Modern Security and Independent Living")
    add_para(doc, [
        ("Instead of early night curfews, co-living uses ", False),
        ("fingerprint smart locks, security cameras, and 24-hour security", True),
        (", giving you safety with complete independence.", False)
    ])
    
    # Single-Cell Callout Box
    add_callout_box(doc, "AT A GLANCE: CO-LIVING VS PG", [
        ("Traditional PG:", "Strict night curfews, shared bathrooms, surprise electricity bills, and fixed meal menus."),
        ("Modern Co-Living:", "All-inclusive rent, fast Wi-Fi, air-conditioned studio options, 24/7 access, and regular cleaning.")
    ])
    
    # Facility Spotlight Section
    add_h2(doc, "Where to Find Managed Living Spaces in Erode?")
    add_h3(doc, "Executive Co-Living at Fortune City")
    add_para(doc, "Today's workers need fast internet for office calls, daily room cleaning, clear rent rules, and good food choices without strict house rules.")
    add_para(doc, [
        ("Located on NH 544 at Chithode, Fortune City Co-Living offers furnished rooms with food, gym, and shopping just an elevator ride away. Check room availability at ", False),
        ("Fortune City Co-Living accommodations", False, "0000FF", "https://www.fortunecity.in/co-living"),
        (".", False)
    ])
    
    # Conclusion
    add_h2(doc, "Choose the Lifestyle That Fits Your Ambition")
    add_para(doc, "Your home should make your daily life easier and more peaceful. Choose a comfortable place that gives you freedom and respect.")
    add_para(doc, [("Your living space should empower your work, not restrict your freedom.", True, "38761D")])
    
    # FAQs (Exactly 3)
    add_faqs(doc, [
        ("What is the main difference between co-living and a traditional PG in Erode?",
         "Co-living provides private furnished rooms with fast Wi-Fi, regular cleaning, clear monthly bills, and independent access, unlike traditional PGs with shared bathrooms and early curfews."),
        ("Is co-living in Erode more expensive than standard rental rooms?",
         "While base co-living rent looks slightly higher, it covers high-speed Wi-Fi, electricity, room cleaning, and building repairs in one bill, saving you from surprise extra costs."),
        ("Where is Fortune City co-living located in Erode?",
         "Fortune City Co-Living is located on NH 544 at Chithode, Erode, providing direct highway access to textile parks, Perundurai SIPCOT, and surrounding business hubs.")
    ])
    
    return doc

# ==============================================================================
# MAIN GENERATION PIPELINE
# ==============================================================================
if __name__ == "__main__":
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    blogs = [
        ("Blog_1_Indoor_Entertainment_in_Erode.docx", build_blog_1),
        ("Blog_2_Wedding_Hall_Cost_in_Erode.docx", build_blog_2),
        ("Blog_3_Comfort_Foods_in_Tamil_Nadu.docx", build_blog_3),
        ("Blog_4_How_to_Check_Cotton_Fabric_Quality.docx", build_blog_4),
        ("Blog_5_Safe_to_Charge_an_Electric_Car_During_Rain.docx", build_blog_5),
        ("Blog_6_Co-Living_vs_PG_Accommodation.docx", build_blog_6)
    ]
    
    print("="*75)
    print("GENERATING ALL 6 BENCHMARK BLOGS (PLAIN ENGLISH + BENCHMARK POSTERS)")
    print("="*75)
    
    for filename, builder in blogs:
        doc = builder()
        out_path = os.path.join(OUTPUT_DIR, filename)
        try:
            doc.save(out_path)
            pre_faq, faq, total, stdev_len = audit_document(doc)
            print(f"✅ {filename}")
            print(f"   Pre-FAQ: {pre_faq}w | FAQ: {faq}w | Total: {total}w | Burstiness StdDev: {stdev_len:.2f}")
        except PermissionError:
            alt_path = out_path.replace(".docx", "_Updated.docx")
            doc.save(alt_path)
            pre_faq, faq, total, stdev_len = audit_document(doc)
            print(f"⚠️ {filename} was locked; saved as {os.path.basename(alt_path)}")
            print(f"   Pre-FAQ: {pre_faq}w | FAQ: {faq}w | Total: {total}w | Burstiness StdDev: {stdev_len:.2f}")
    
    print("\nGeneration complete!")
