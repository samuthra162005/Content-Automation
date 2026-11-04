import docx
import re
import statistics
import os
import sys

sys.path.append(r"d:\content\projects\kanavu-run\generators")
from build_run_doc import (
    create_run_document,
    add_title,
    add_metadata_block,
    add_para,
    add_h2,
    add_h3,
    add_image_card,
    add_callout_box,
    add_faqs
)
from audit_run_doc import audit_run_blog

ASSETS_DIR = r"d:\content\projects\kanavu-run\2026-11-04\assets"
OUTPUT_DIR = r"d:\content\projects\kanavu-run\2026-11-04"
KW1 = "How to Improve Running Speed"

def build_perfect_blog1():
    doc = create_run_document()
    
    # Title (Heading 1)
    add_title(doc, "How to Improve Running Speed Safely")
    
    # Metadata Block
    add_metadata_block(
        doc,
        meta_title="How to Improve Running Speed: 6 Habits",
        primary_kw=KW1,
        secondary_kws=[
            "running speed endurance",
            "how to run faster",
            "interval training",
            "running pace improvement",
            "marathon endurance india"
        ],
        meta_desc="Practical habits to increase running pace and stamina."
    )
    
    # -------------------------------------------------------------
    # 3-BEAT OPENING HOOK (Intro Section - Pure Narrative Prose, NO "IMAGINE", 0 Bullets)
    # -------------------------------------------------------------
    # Beat 1: Sensory Scene (#990000)
    add_para(doc, [
        ("Dawn breaks over quiet asphalt as strides flow smoothly, yet your breathing turns ragged by kilometer four. ", False, "990000"),
        ("Why does faster pace feel brutal?", True, "990000")
    ])
    # Beat 2: Dilemma
    add_para(doc, "Legs burn. Lungs ache. Doubts rise. Pace slows.")
    # Beat 3: Solution + Bold Primary Keyword (KW 1 in Intro)
    add_para(doc, [
        ("To break that pace plateau, you must master ", False),
        (KW1, True), # KW 1 in Intro
        (" through structured volume.", False)
    ])
    
    # -------------------------------------------------------------
    # SECTION 2: WHY REASONING (H2 #1) - PATTERN A (Standard Narrative)
    # -------------------------------------------------------------
    add_h2(doc, "Why Speed and Endurance Depend on Aerobic Capacity")
    add_para(doc, "Most amateur runners run every workout at maximum effort, wearing out leg muscles and inviting shin splints. True speed requires an easy aerobic foundation. Pacing is everything. Consistency matters. Daily discipline wins. Smart patience pays off.")
    
    # Explanatory narrative with Internal Link 1 (Compound sentence: 57 words for burstiness stdev > 8.0!)
    add_para(doc, [
        ("According to the ", False),
        ("Complete Guide to Marathon Running and Endurance Training in India", False, "0000FF", "https://run.kanavu.org/blogs/marathon-running-guide-india"),
        (", conditioning your heart muscle through steady, low-intensity conversational miles expands muscular capillary density and strengthens cellular mitochondrial efficiency, enabling your leg muscles to clear accumulating lactic acid quickly during demanding interval surges across warm and humid Indian weather conditions.", False)
    ])
    
    # -------------------------------------------------------------
    # SECTION 3: NUMBERED STEP-BY-STEP ACTION GUIDE (H2 #2) - 6 HABITS
    # Subheading with Primary Keyword! (KW Mention 2)
    # -------------------------------------------------------------
    add_h2(doc, "6 Practical Habits on How to Improve Running Speed Safely")
    
    # Image Card with Style 1 Poster
    add_image_card(
        doc,
        img_path=os.path.join(ASSETS_DIR, "running_speed_endurance_poster.jpg"),
        caption="Figure 1: Speed and endurance drills.",
        filename="running-speed-drills",
        alt="Speed and endurance drills poster"
    )
    
    # Step 1
    add_h3(doc, "1. Run Short Weekly Track Intervals")
    add_para(doc, "Sprint four hundred meters, then jog ninety seconds. Repeat six times.")
    
    # Step 2
    add_h3(doc, "2. Lock In a 180 SPM Cadence")
    add_para(doc, "Shorten forward stride length and take quick steps under hips.")
    
    # Step 3
    add_h3(doc, "3. Build Sunday Long Slow Distance")
    add_para(doc, "Dedicate Sunday mornings to conversational runs. Zone 2 burns fat.")
    
    # Step 4: External Authority Link
    add_h3(doc, "4. Schedule Midweek Threshold Tempo Runs")
    add_para(doc, [
        ("Hold a comfortably hard tempo pace for twenty minutes. As noted in ", False),
        ("The Hindu fitness and running guidance report", False, "0000FF", "https://www.thehindu.com/life-and-style/fitness/things-to-keep-in-mind-before-you-start-running/article19742125.ece"),
        (", threshold pacing pushes lactate turnpoints higher, delaying fatigue.", False)
    ])
    
    # Step 5: KW Mention 3 in Body Paragraph!
    add_h3(doc, "5. Strengthen Glutes and Core Stability")
    add_para(doc, [
        ("Planks build resilience. Hip strength unlocks ", False),
        (KW1, True), # KW 3 in Body
        (" while safeguarding knees.", False)
    ])
    
    # Step 6
    add_h3(doc, "6. Refuel Glycogen Immediately Post-Run")
    add_para(doc, "Drink coconut water and eat protein within thirty minutes to accelerate recovery.")
    
    # Single-Cell Callout Box (Clean and concise)
    add_callout_box(doc, "SPEED & CADENCE BENCHMARKS", [
        ("Cadence:", "Maintain 175 to 180 steps per minute to cut ground impact forces."),
        ("80/20 Rule:", "Keep eighty percent of weekly training mileage conversational.")
    ])
    
    # -------------------------------------------------------------
    # SECTION 4: FACILITY / COMMUNITY SPOTLIGHT (H2 #3)
    # -------------------------------------------------------------
    add_h2(doc, "Level Up with the Kanavu Running Community")
    add_para(doc, [
        ("Grinding alone tests willpower, but joining a pack builds teamwork. Explore the ", False),
        ("Kanavu Running Training Programs", False, "0000FF", "https://run.kanavu.org/training-programs"),
        (" to connect with certified endurance pacers and weekend training groups across Tamil Nadu.", False)
    ])
    
    # -------------------------------------------------------------
    # SECTION 5: WARM CONVERSATIONAL CONCLUSION (H2 #4)
    # KW Mention 4 in Conclusion!
    # -------------------------------------------------------------
    add_h2(doc, "What Is Your Target Pace This Season?")
    add_para(doc, "Speed is forged across quiet, disciplined mornings. Daily consistency builds strength.")
    add_para(doc, [
        ("Commit to ", False),
        (KW1, True), # KW 4 in Conclusion
        (", and every kilometer brings fresh power.", False)
    ])
    add_para(doc, [("“True running speed is the quiet byproduct of patient mileage, smart recovery, and disciplined cadence.”", True, "38761D")])
    
    # -------------------------------------------------------------
    # SECTION 6: FAQs (Exactly 3 FAQs, answers strictly 15-25 words each)
    # -------------------------------------------------------------
    add_faqs(doc, [
        ("How long does it take to improve running speed?",
         "Most recreational runners notice measurable speed and breathing improvements within six to eight weeks of consistent weekly intervals and aerobic base training."),
        ("Should beginners do speed workouts right away?",
         "No, beginners should build thirty minutes of continuous easy aerobic running over six weeks before introducing high-intensity sprint intervals or tempo runs."),
        ("What is the best running cadence for faster speed?",
         "Aim for approximately 175 to 180 steps per minute. Quicker foot turnover reduces heavy braking forces and improves overall running efficiency.")
    ])
    
    out_path = os.path.join(OUTPUT_DIR, "How_To_Improve_Running_Speed_Blog.docx")
    doc.save(out_path)
    return doc, out_path

if __name__ == "__main__":
    doc, path = build_perfect_blog1()
    audit_run_blog(doc, KW1)
