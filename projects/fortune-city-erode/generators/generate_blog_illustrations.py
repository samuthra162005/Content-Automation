from PIL import Image, ImageDraw, ImageFont
import os

def create_illustration_card(data, filepath):
    W, H = 1200, 675
    img = Image.new('RGB', (W, H), color=(15, 30, 60))
    draw = ImageDraw.Draw(img)

    # Gradient background effect
    for y in range(H):
        r = int(15 + (y / H) * 12)
        g = int(30 + (y / H) * 24)
        b = int(60 + (y / H) * 45)
        draw.line([(0, y), (W, y)], fill=(r, g, b))

    # Outer decorative frame
    draw.rectangle([25, 25, W - 25, H - 25], outline=(3, 105, 161), width=2)
    draw.rectangle([35, 35, W - 35, H - 35], outline=(14, 165, 233), width=1)

    # Header fonts
    font_cat = ImageFont.truetype('C:/Windows/Fonts/segoeuib.ttf', 20)
    font_title = ImageFont.truetype('C:/Windows/Fonts/segoeuib.ttf', 40)
    font_sub = ImageFont.truetype('C:/Windows/Fonts/segoeui.ttf', 24)
    font_card_t = ImageFont.truetype('C:/Windows/Fonts/segoeuib.ttf', 22)
    font_card_d = ImageFont.truetype('C:/Windows/Fonts/segoeui.ttf', 17)
    font_footer = ImageFont.truetype('C:/Windows/Fonts/segoeuib.ttf', 18)

    # Category Tag
    draw.rounded_rectangle([60, 60, 360, 96], radius=8, fill=(3, 105, 161))
    draw.text((75, 66), data["category"].upper(), font=font_cat, fill=(255, 255, 255))

    # Title & Subtitle
    draw.text((60, 115), data["title"], font=font_title, fill=(255, 255, 255))
    draw.text((60, 170), data["subtitle"], font=font_sub, fill=(186, 230, 253))

    # Decorative separator line
    draw.line([(60, 215), (W - 60, 215)], fill=(56, 189, 248), width=2)

    # 4 Grid Feature Cards
    card_coords = [
        (60, 240, 580, 400),
        (620, 240, 1140, 400),
        (60, 425, 580, 585),
        (620, 425, 1140, 585)
    ]

    for idx, (x1, y1, x2, y2) in enumerate(card_coords):
        card = data["cards"][idx]
        # Card background
        draw.rounded_rectangle([x1, y1, x2, y2], radius=12, fill=(20, 45, 90), outline=(56, 189, 248), width=1)
        # Accent number badge
        draw.rounded_rectangle([x1 + 15, y1 + 15, x1 + 55, y1 + 55], radius=6, fill=(3, 105, 161))
        draw.text((x1 + 27, y1 + 22), str(idx + 1), font=font_card_t, fill=(255, 255, 255))
        # Card Title
        draw.text((x1 + 70, y1 + 22), card["title"], font=font_card_t, fill=(255, 255, 255))
        # Card Description
        draw.text((x1 + 20, y1 + 75), card["desc1"], font=font_card_d, fill=(224, 242, 254))
        draw.text((x1 + 20, y1 + 105), card["desc2"], font=font_card_d, fill=(147, 197, 253))

    # Bottom Branding Footer
    draw.rectangle([35, H - 65, W - 35, H - 35], fill=(10, 25, 50))
    draw.text((60, H - 58), data["footer"], font=font_footer, fill=(125, 211, 252))

    img.save(filepath, quality=95)
    print(f"Created image: {filepath}")

illustrations = [
    {
        "filename": "indoor_entertainment_erode.png",
        "category": "Entertainment & Leisure Guide",
        "title": "Indoor Entertainment in Erode",
        "subtitle": "Rainy Day Family Recreation & Multiplex Guide at Fortune City",
        "footer": "Fortune Multiplex & Avenue Malls | Fortune City, NH 544, Chithode, Erode",
        "cards": [
            {"title": "Fortune Multiplex", "desc1": "• Multi-screen digital cinema & 3D sound", "desc2": "• Luxury push-back recliner seats for families"},
            {"title": "Arcade & Gaming Zone", "desc1": "• Interactive simulators and virtual reality", "desc2": "• Safe, supervised indoor play arena for kids"},
            {"title": "Avenue Shopping Malls", "desc1": "• Air-conditioned fashion & lifestyle stores", "desc2": "• Wide pedestrian walkways & festive collections"},
            {"title": "Food Valley Dining", "desc1": "• Hot filter coffee & crispy tea snacks", "desc2": "• Multi-cuisine family seating & fast service"}
        ]
    },
    {
        "filename": "wedding_hall_cost_erode.png",
        "category": "Wedding & Event Planning",
        "title": "Wedding Hall Cost Guide in Erode",
        "subtitle": "Mandapam Pricing, Guest Capacity & Venue Selection Factors",
        "footer": "Fortune Wedding Mahal | Fortune City, NH 544, Chithode, Erode",
        "cards": [
            {"title": "Guest Capacity (1,500+)", "desc1": "• Grand column-free main banquet hall", "desc2": "• Accommodates large wedding & reception crowds"},
            {"title": "Dining & Kitchen Infra", "desc1": "• Spacious 800+ seat dining hall layout", "desc2": "• Modern commercial kitchen for traditional caterers"},
            {"title": "Bridal & Guest Suites", "desc1": "• Fully furnished air-conditioned suites", "desc2": "• Overnight preparation rooms for bride and groom"},
            {"title": "Highway Parking & Access", "desc1": "• 500+ vehicles parking with valet space", "desc2": "• Direct NH 544 access for outstation relatives"}
        ]
    },
    {
        "filename": "comfort_foods_tamil_nadu.png",
        "category": "Culinary & Dining Guide",
        "title": "Comfort Foods in Tamil Nadu",
        "subtitle": "Popular Monsoon Snacks, Hot Brews & Regional Delicacies",
        "footer": "Food Valley Dining Hub | Fortune City, NH 544, Chithode, Erode",
        "cards": [
            {"title": "Crispy Milagai & Onion Bajji", "desc1": "• Piping-hot chickpea batter fritters", "desc2": "• Served with freshly ground coconut & mint chutney"},
            {"title": "Immunity Pepper Rasam Rice", "desc1": "• Tangy tamarind broth with crushed black pepper", "desc2": "• Kongu herbal spices to warm up on rainy days"},
            {"title": "Crispy Ghee Podi Dosa", "desc1": "• Golden-crusted rice crepe with spiced podi", "desc2": "• Accompanied by steaming hot lentil sambar"},
            {"title": "Traditional Filter Coffee", "desc1": "• Rich, frothy dark-roast chicory brew", "desc2": "• Classic South Indian brass dabarah & tumbler"}
        ]
    },
    {
        "filename": "cotton_fabric_quality_texvalley.png",
        "category": "Wholesale Sourcing Guide",
        "title": "How to Check Cotton Fabric Quality",
        "subtitle": "4-Point Quality Inspection Checklist for Wholesale Textile Buyers",
        "footer": "Texvalley Wholesale Textile Market | Fortune City, Erode",
        "cards": [
            {"title": "1. Hand Feel & Pure Fiber Test", "desc1": "• Combed cotton feels naturally breathable & cool", "desc2": "• Burn test leaves light grey ash without plastic bead"},
            {"title": "2. Weave Density & GSM Check", "desc1": "• Uniform thread count against direct light source", "desc2": "• Balanced warp & weft without uneven weave gaps"},
            {"title": "3. Wet Colorfastness Rub", "desc1": "• Rub moist white cloth firmly across fabric swatch", "desc2": "• Zero dye pigment transfer confirms reactive dyeing"},
            {"title": "4. Tensile Recovery Examination", "desc1": "• Firm diagonal stretch across fabric edges", "desc2": "• Quality fabric snaps back without permanent skew"}
        ]
    },
    {
        "filename": "ev_charging_rain_safety.png",
        "category": "Automotive & Highway Guide",
        "title": "Safe EV Charging During Rain",
        "subtitle": "Weatherproof Engineering & Safety Standards on Highway NH 544",
        "footer": "Fortune City EV Charging Station | NH 544 Highway, Erode",
        "cards": [
            {"title": "IP67 Submersible Port Seals", "desc1": "• Vehicle inlet and gun sealed with rubber gaskets", "desc2": "• Rated to prevent water ingress in heavy downpours"},
            {"title": "Digital Safety Handshake", "desc1": "• ISO 15118 automated software verification", "desc2": "• Zero voltage flows until connection is confirmed dry"},
            {"title": "Ground-Fault Interrupters", "desc1": "• Millisecond earth leakage circuit breakers", "desc2": "• Instant power cut-off if any electrical leak occurs"},
            {"title": "Covered Highway Charging Bays", "desc1": "• Canopy-sheltered high-speed DC fast chargers", "desc2": "• Adjoining café, dining & restrooms while charging"}
        ]
    },
    {
        "filename": "coliving_vs_pg_erode.png",
        "category": "Corporate & Housing Guide",
        "title": "Co-Living vs PG Accommodation",
        "subtitle": "Modern Executive Living vs Traditional Hostels in Erode",
        "footer": "Retail Arcade & Co-Living | Fortune City, NH 544, Erode",
        "cards": [
            {"title": "Private Executive Living", "desc1": "• Fully furnished private or twin suites", "desc2": "• Acoustic comfort and complete personal privacy"},
            {"title": "Productive Remote Work", "desc1": "• Dedicated work desk & high-speed fiber Wi-Fi", "desc2": "• Ideal for IT, textile managers & hybrid professionals"},
            {"title": "Professional Housekeeping", "desc1": "• Daily room cleaning and laundry facilities", "desc2": "• No weekend chore stress or maintenance hassles"},
            {"title": "Integrated Lifestyle Perks", "desc1": "• Direct access to food court, retail & recreation", "desc2": "• 24/7 biometric security with zero restrictive curfews"}
        ]
    }
]

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    out_dir = os.path.abspath(os.path.join(base_dir, "..", "2026-10-29", "assets"))
    os.makedirs(out_dir, exist_ok=True)
    for ill in illustrations:
        filepath = os.path.join(out_dir, ill["filename"])
        create_illustration_card(ill, filepath)

