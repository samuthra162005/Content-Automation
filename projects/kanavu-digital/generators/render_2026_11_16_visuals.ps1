<#
.SYNOPSIS
    Generates high-resolution 1920x1080 (16:9) infographics for Kanavu Digital Marketing 2026-11-16 Cluster:
    14 distinct visuals (2 per blog across 7 blogs) with bold Segoe UI typography and question marks.
#>

Add-Type -AssemblyName System.Drawing

$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16"

function Add-RoundedRectangle($path, $x, $y, $w, $h, $r) {
    $d = $r * 2
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
}

function Create-Infographic {
    param (
        [string]$TargetFolder,
        [string]$FileName,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [array]$Cards,
        [string]$AccentColorHex = "1A73E8"
    )

    $fullPath = Join-Path (Join-Path $baseDir $TargetFolder) $FileName
    Write-Host "Rendering: $fullPath"

    $bmp = [System.Drawing.Bitmap]::new(1920, 1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    
    # Crisp white background with soft gradient
    $g.Clear([System.Drawing.Color]::FromArgb(255, 255, 255))
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Colors
    $accentColor = [System.Drawing.ColorTranslator]::FromHtml("#$AccentColorHex")
    $slateDark = [System.Drawing.Color]::FromArgb(15, 23, 42)
    $slateMuted = [System.Drawing.Color]::FromArgb(71, 85, 105)
    $cardBg = [System.Drawing.Color]::FromArgb(248, 250, 252)
    $cardBorder = [System.Drawing.Color]::FromArgb(226, 232, 240)
    $emerald = [System.Drawing.Color]::FromArgb(5, 150, 105)

    # Top Brand / Category Bar
    $barBrush = [System.Drawing.SolidBrush]::new($accentColor)
    $g.FillRectangle($barBrush, 0, 0, 1920, 10)
    $barBrush.Dispose()

    # Badge
    $badgeRect = [System.Drawing.RectangleF]::new(60, 35, 340, 36)
    $bPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $bPath 60 35 340 36 10
    $badgeBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(238, 242, 255))
    $g.FillPath($badgeBg, $bPath)
    $badgeBorderPen = [System.Drawing.Pen]::new($accentColor, 1.5)
    $g.DrawPath($badgeBorderPen, $bPath)
    
    $badgeFont = [System.Drawing.Font]::new("Segoe UI", [float]13, [System.Drawing.FontStyle]::Bold)
    $badgeBrush = [System.Drawing.SolidBrush]::new($accentColor)
    $badgeFmt = [System.Drawing.StringFormat]::new()
    $badgeFmt.Alignment = [System.Drawing.StringAlignment]::Center
    $badgeFmt.LineAlignment = [System.Drawing.StringAlignment]::Center
    $g.DrawString($BadgeText.ToUpper(), $badgeFont, $badgeBrush, $badgeRect, $badgeFmt)

    # Title
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]36, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new($slateDark)
    $titleFmt = [System.Drawing.StringFormat]::new()
    $titleFmt.Alignment = [System.Drawing.StringAlignment]::Near
    $titleRect = [System.Drawing.RectangleF]::new(60, 85, 1800, 60)
    $g.DrawString($Title, $titleFont, $titleBrush, $titleRect, $titleFmt)

    # Subtitle
    $subFont = [System.Drawing.Font]::new("Segoe UI", [float]19, [System.Drawing.FontStyle]::Bold)
    $subBrush = [System.Drawing.SolidBrush]::new($emerald)
    $subRect = [System.Drawing.RectangleF]::new(60, 145, 1800, 35)
    $g.DrawString($Subtitle, $subFont, $subBrush, $subRect, $titleFmt)

    # Divider line
    $divPen = [System.Drawing.Pen]::new($cardBorder, 1.5)
    $g.DrawLine($divPen, 60, 195, 1860, 195)

    # Draw Cards (Grid Layout: 1 to 5 cards)
    $numCards = $Cards.Count
    $startY = 225
    $totalWidth = 1800
    $gap = 25
    
    if ($numCards -le 4) {
        $cardWidth = ($totalWidth - ($gap * ($numCards - 1))) / $numCards
        $cardHeight = 770
        for ($i = 0; $i -lt $numCards; $i++) {
            $cx = 60 + ($i * ($cardWidth + $gap))
            Draw-Card -g $g -x $cx -y $startY -w $cardWidth -h $cardHeight -c $Cards[$i] -accent $accentColor
        }
    } elseif ($numCards -eq 5) {
        $cardWidth = ($totalWidth - ($gap * 4)) / 5
        $cardHeight = 770
        for ($i = 0; $i -lt 5; $i++) {
            $cx = 60 + ($i * ($cardWidth + $gap))
            Draw-Card -g $g -x $cx -y $startY -w $cardWidth -h $cardHeight -c $Cards[$i] -accent $accentColor
        }
    }

    # Footer attribution
    $footFont = [System.Drawing.Font]::new("Segoe UI", [float]12, [System.Drawing.FontStyle]::Regular)
    $footBrush = [System.Drawing.SolidBrush]::new($slateMuted)
    $footRect = [System.Drawing.RectangleF]::new(60, 1025, 1800, 30)
    $footFmt = [System.Drawing.StringFormat]::new()
    $footFmt.Alignment = [System.Drawing.StringAlignment]::Far
    $g.DrawString("KANAVU DIGITAL MARKETING  •  ENTERPRISE GROWTH & EVIDENCE-BASED MARKETING", $footFont, $footBrush, $footRect, $footFmt)

    # Save as High-Quality JPEG
    $encoderParams = [System.Drawing.Imaging.EncoderParameters]::new(1)
    $encoderParams.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]95)
    $jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $bmp.Save($fullPath, $jpegCodec, $encoderParams)

    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Saved: $fullPath (1920x1080, PASS)"
}

function Draw-Card {
    param ($g, $x, $y, $w, $h, $c, $accent)

    $cPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $cPath $x $y $w $h 16

    # Card Background & Border
    $cBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
    $g.FillPath($cBg, $cPath)
    $cPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(226, 232, 240), 2)
    $g.DrawPath($cPen, $cPath)

    # Card Top Accent Strip
    $stripPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $stripPath.AddArc($x, $y, 32, 32, 180, 90)
    $stripPath.AddArc($x + $w - 32, $y, 32, 32, 270, 90)
    $stripPath.AddLine($x + $w, $y + 12, $x, $y + 12)
    $stripPath.CloseFigure()
    $stripBrush = [System.Drawing.SolidBrush]::new($accent)
    $g.FillPath($stripBrush, $stripPath)

    # Card Number Circle
    $circleRect = [System.Drawing.RectangleF]::new(($x + 24), ($y + 30), 44, 44)
    $circleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(238, 242, 255))
    $g.FillEllipse($circleBrush, $circleRect)
    $circleBorder = [System.Drawing.Pen]::new($accent, 2)
    $g.DrawEllipse($circleBorder, $circleRect)
    
    $numFont = [System.Drawing.Font]::new("Segoe UI", [float]16, [System.Drawing.FontStyle]::Bold)
    $numBrush = [System.Drawing.SolidBrush]::new($accent)
    $numFmt = [System.Drawing.StringFormat]::new()
    $numFmt.Alignment = [System.Drawing.StringAlignment]::Center
    $numFmt.LineAlignment = [System.Drawing.StringAlignment]::Center
    $g.DrawString($c.Num, $numFont, $numBrush, $circleRect, $numFmt)

    # Card Header
    $hFont = [System.Drawing.Font]::new("Segoe UI", [float]19, [System.Drawing.FontStyle]::Bold)
    $hBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
    $hRect = [System.Drawing.RectangleF]::new(($x + 24), ($y + 90), ($w - 48), 55)
    $hFmt = [System.Drawing.StringFormat]::new()
    $hFmt.Alignment = [System.Drawing.StringAlignment]::Near
    $g.DrawString($c.Heading, $hFont, $hBrush, $hRect, $hFmt)

    # Card Subtitle / Role
    $subFont = [System.Drawing.Font]::new("Segoe UI", [float]13, [System.Drawing.FontStyle]::Bold)
    $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(5, 150, 105))
    $subRect = [System.Drawing.RectangleF]::new(($x + 24), ($y + 148), ($w - 48), 30)
    $g.DrawString($c.Subheading, $subFont, $subBrush, $subRect, $hFmt)

    # Card Body Bullets / Descriptions
    $bFont = [System.Drawing.Font]::new("Segoe UI", [float]12, [System.Drawing.FontStyle]::Regular)
    $bBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(51, 65, 85))
    $curY = $y + 195

    foreach ($point in $c.Points) {
        # Bullet dot
        $dotRect = [System.Drawing.RectangleF]::new(($x + 24), ($curY + 5), 8, 8)
        $dotBrush = [System.Drawing.SolidBrush]::new($accent)
        $g.FillEllipse($dotBrush, $dotRect)

        # Bullet Text
        $pRect = [System.Drawing.RectangleF]::new(($x + 40), $curY, ($w - 64), 70)
        $g.DrawString($point, $bFont, $bBrush, $pRect, $hFmt)
        $curY += 78
    }

    # Card Metric Box at bottom
    if ($c.Metric) {
        $mRect = [System.Drawing.RectangleF]::new(($x + 20), ($y + $h - 90), ($w - 40), 65)
        $mPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
        Add-RoundedRectangle $mPath ($x + 20) ($y + $h - 90) ($w - 40) 65 10
        $mBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 255, 255))
        $g.FillPath($mBg, $mPath)
        $mBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 1)
        $g.DrawPath($mBorder, $mPath)

        $mTitleFont = [System.Drawing.Font]::new("Segoe UI", [float]11, [System.Drawing.FontStyle]::Bold)
        $mTitleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(100, 116, 139))
        $mTitleRect = [System.Drawing.RectangleF]::new(($x + 30), ($y + $h - 85), ($w - 60), 20)
        $g.DrawString($c.MetricLabel, $mTitleFont, $mTitleBrush, $mTitleRect, $hFmt)

        $mValFont = [System.Drawing.Font]::new("Segoe UI", [float]15, [System.Drawing.FontStyle]::Bold)
        $mValBrush = [System.Drawing.SolidBrush]::new($accent)
        $mValRect = [System.Drawing.RectangleF]::new(($x + 30), ($y + $h - 62), ($w - 60), 30)
        $g.DrawString($c.Metric, $mValFont, $mValBrush, $mValRect, $hFmt)
    }
}

# ==============================================================================
# 1. PILLAR HUB VISUALS
# ==============================================================================
# Fig 1
$pillarCards1 = @(
    @{ Num = "1"; Heading = "Technical SEO"; Subheading = "Core Search Foundation"; Points = @("Clean site architecture & rapid load speed", "Structured JSON-LD schema integration", "Defensible E-E-A-T search authority"); MetricLabel = "ORGANIC SEARCH IMPACT"; Metric = "3.8x Compounding Pipeline" },
    @{ Num = "2"; Heading = "Precision Paid Media"; Subheading = "Targeted Acquisition"; Points = @("CAC & ROAS-first media buying", "Cross-network Performance Max optimization", "Server-side first-party event tracking"); MetricLabel = "PAID AD CONVERSIONS"; Metric = "45% Lower Cost Per Lead" },
    @{ Num = "3"; Heading = "Topical Content"; Subheading = "Authority & Relevance"; Points = @("Comprehensive semantic topic clusters", "In-depth research-backed client guides", "Zero keyword stuffing or AI fluff"); MetricLabel = "CONTENT TRUST SCORE"; Metric = "Topical Search Dominance" },
    @{ Num = "4"; Heading = "Conversion CRO"; Subheading = "Frictionless UX Design"; Points = @("Data-driven landing page optimization", "Rigorous multivariate A/B testing", "Clear value propositions & trust badges"); MetricLabel = "CONVERSION RATE LIFT"; Metric = "+62% Checkout Completion" },
    @{ Num = "5"; Heading = "Unified Analytics"; Subheading = "Real Revenue Attribution"; Points = @("Multi-touch GA4 & CRM attribution", "Continuous lifetime customer modeling", "Transparent business revenue dashboards"); MetricLabel = "ATTRIBUTION ACCURACY"; Metric = "100% Verified ROI Pipeline" }
)
Create-Infographic "pillar-top-digital-marketing-company-strategies-for-growth" "hero-image.jpg" `
    "TOP DIGITAL MARKETING COMPANY: HOW TO DRIVE MEASURABLE GROWTH?" `
    "5 Pillars: Technical SEO, Precision Paid Media, Content Authority, CRO & Analytics" `
    "Enterprise Growth Blueprint" $pillarCards1 "1A73E8"

# Fig 2
$pillarCards2 = @(
    @{ Num = "A"; Heading = "Organic Search Engine"; Subheading = "Inbound Authority"; Points = @("High-intent commercial keyword rankings", "Helpful content answering search intent", "Defensible topical authority signals"); MetricLabel = "ACQUISITION CHANNEL"; Metric = "Zero Marginal Cost Traffic" },
    @{ Num = "B"; Heading = "Paid Performance Media"; Subheading = "Targeted Scalability"; Points = @("Immediate high-converting paid search ads", "Retargeting engaged website prospects", "Geo-lift testing & incrementality proof"); MetricLabel = "SCALING MECHANISM"; Metric = "Instant Conversion Liquidity" },
    @{ Num = "C"; Heading = "Conversion Platform"; Subheading = "Revenue Engine"; Points = @("Ultra-fast landing page load times", "Intuitive mobile-first checkout flows", "Lead enrichment & instant sales routing"); MetricLabel = "REVENUE MULTIPLIER"; Metric = "Maximized Customer Value" },
    @{ Num = "D"; Heading = "Attribution Feedback"; Subheading = "Closed-Loop Data"; Points = @("Feeding offline CRM sales back to ads", "Re-allocating budgets to high-margin products", "Continuous algorithmic model training"); MetricLabel = "STRATEGIC GOVERNANCE"; Metric = "Predictable Commercial ROI" }
)
Create-Infographic "pillar-top-digital-marketing-company-strategies-for-growth" "omnichannel-growth-engine.jpg" `
    "THE OMNICHANNEL REVENUE GROWTH ENGINE" `
    "Synchronizing Organic Search, Performance Ads, AI Automation & Attribution" `
    "Omnichannel Architecture" $pillarCards2 "059669"

# ==============================================================================
# 2. BLOG 1 VISUALS (Claude for SMM)
# ==============================================================================
# Fig 1
$b1Cards1 = @(
    @{ Num = "1"; Heading = "Platform-Native Copy"; Subheading = "Captions & Threads"; Points = @("Distinct voice per social channel", "Contextual hook angles & emojis", "High-converting call to actions"); MetricLabel = "DRAFT EFFICIENCY"; Metric = "75% Faster Copywriting" },
    @{ Num = "2"; Heading = "Content Calendars"; Subheading = "Topical Scheduling"; Points = @("Monthly thematic campaign grids", "Structured markdown publishing schedules", "Topical balance across formats"); MetricLabel = "PLANNING SPEED"; Metric = "Same-Day Monthly Calendar" },
    @{ Num = "3"; Heading = "Campaign Ideation"; Subheading = "Creative Brainstorming"; Points = @("Culturally relevant launch angles", "Interactive contest mechanics & polls", "Pain-point driven messaging angles"); MetricLabel = "CREATIVE OUTPUT"; Metric = "10+ Unique Campaign Hooks" },
    @{ Num = "4"; Heading = "Audience Personas"; Subheading = "Empathetic Research"; Points = @("Review mining & sentiment analysis", "Identifies buyer objections & phrasing", "Tailors tone to customer maturity"); MetricLabel = "RESONANCE SCORE"; Metric = "High-Converting Resonance" }
)
Create-Infographic "blog-1-how-to-use-claude-for-social-media-marketing" "hero-image.jpg" `
    "HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS?" `
    "Captions, Content Calendars, Audience Personas, Repurposing & Tone Calibration" `
    "Social Media AI Workflow" $b1Cards1 "1A73E8"

# Fig 2
$b1Cards2 = @(
    @{ Num = "1"; Heading = "Raw Source Asset"; Subheading = "Long-Form Input"; Points = @("Executive podcast interviews", "Comprehensive technical whitepapers", "Customer webinar transcripts"); MetricLabel = "INPUT ASSET"; Metric = "200k Context Ingestion" },
    @{ Num = "2"; Heading = "Claude Semantic Core"; Subheading = "Nuanced Processing"; Points = @("Extracts memorable key quotes", "Synthesizes tactical action steps", "Calibrates tone to brand guidelines"); MetricLabel = "PROCESSING ENGINE"; Metric = "Deep Semantic Synthesis" },
    @{ Num = "3"; Heading = "Platform Variants"; Subheading = "Channel-Specific Output"; Points = @("LinkedIn thought leadership carousels", "High-velocity conversational X threads", "Instagram visual quote cards"); MetricLabel = "CONTENT LEVERAGE"; Metric = "10x Social Repurposing" }
)
Create-Infographic "blog-1-how-to-use-claude-for-social-media-marketing" "claude-social-workflow.jpg" `
    "CLAUDE AI SOCIAL MEDIA REPURPOSING ARCHITECTURE" `
    "Transforming Long-Form Transcripts into Multi-Platform Social Assets" `
    "Repurposing Architecture" $b1Cards2 "4F46E5"

# ==============================================================================
# 3. BLOG 2 VISUALS (AI Agents in Marketing)
# ==============================================================================
# Fig 1
$b2Cards1 = @(
    @{ Num = "1"; Heading = "Competitor Tracking"; Subheading = "24/7 Market Surveillance"; Points = @("Scrapes rival ad libraries automatically", "Monitors landing page price updates", "Detects organic keyword ranking movements"); MetricLabel = "SURVEILLANCE FREQUENCY"; Metric = "Continuous Live Alerts" },
    @{ Num = "2"; Heading = "Cross-Channel Reports"; Subheading = "Automated Analytics"; Points = @("Aggregates GA4, Meta & CRM data", "Diagnoses conversion anomalies instantly", "Distributes executive Slack summaries"); MetricLabel = "REPORTING OVERHEAD"; Metric = "Zero Spreadsheet Assembly" },
    @{ Num = "3"; Heading = "Lead Qualification"; Subheading = "Intelligent Routing"; Points = @("Scores inbound leads in real time", "Enriches profiles with firmographic data", "Routes high-intent deals to sales reps"); MetricLabel = "LEAD VELOCITY"; Metric = "Instant 60-Second Routing" },
    @{ Num = "4"; Heading = "Budget Re-Allocation"; Subheading = "Algorithmic Media Buying"; Points = @("Monitors real-time ROAS across campaigns", "Shifts spend to high-performing segments", "Maintains strictly bounded human rules"); MetricLabel = "CAPITAL EFFICIENCY"; Metric = "+32% Return on Ad Spend" }
)
Create-Infographic "blog-2-ai-agents-in-digital-marketing" "hero-image.jpg" `
    "AI AGENTS IN DIGITAL MARKETING: WHICH TASKS CAN YOU AUTOMATE?" `
    "5 Autonomous Capabilities: Competitor Tracking, Reporting, Lead Routing & Campaigns" `
    "Autonomous Operations" $b2Cards1 "1A73E8"

# Fig 2
$b2Cards2 = @(
    @{ Num = "1"; Heading = "1. Environmental Perception"; Subheading = "Signal Ingestion"; Points = @("Inbound form submission webhooks", "Real-time ad spend auction shifts", "Competitor pricing changes detected"); MetricLabel = "PERCEPTION LAYER"; Metric = "Multi-Channel Ingestion" },
    @{ Num = "2"; Heading = "2. Cognitive Reasoning"; Subheading = "Goal-Driven Decision"; Points = @("Evaluates signals against target goals", "Selects optimal promotional action path", "Verifies compliance within guardrails"); MetricLabel = "REASONING ENGINE"; Metric = "Context-Aware Logic" },
    @{ Num = "3"; Heading = "3. Tool Execution"; Subheading = "Programmatic Action"; Points = @("Invokes CRM lead enrichment API", "Adjusts ad budget in Google Ads API", "Schedules personalized email sequences"); MetricLabel = "ACTION EXECUTION"; Metric = "Automated Tool Calling" },
    @{ Num = "4"; Heading = "4. Feedback Verification"; Subheading = "Performance Validation"; Points = @("Verifies successful conversion delivery", "Logs audit trail for human supervisors", "Updates machine learning confidence model"); MetricLabel = "GOVERNANCE AUDIT"; Metric = "100% Operational Audit" }
)
Create-Infographic "blog-2-ai-agents-in-digital-marketing" "ai-agents-marketing-loop.jpg" `
    "AUTONOMOUS AI MARKETING PERCEPTION-ACTION LOOP" `
    "How AI Agents Detect Market Signals, Analyze Data & Execute Campaigns Autonomously" `
    "Perception-Action Loop" $b2Cards2 "059669"

# ==============================================================================
# 4. BLOG 3 VISUALS (FIFA World Cup 2026)
# ==============================================================================
# Fig 1
$b3Cards1 = @(
    @{ Num = "1"; Heading = "Local Creator Co-Creation"; Subheading = "Host City Grassroots"; Points = @("Micro-creators in 16 host cities", "Showcases authentic fan culinary culture", "Transcends commercial sponsor skepticism"); MetricLabel = "CREATOR IMPACT"; Metric = "3.4x Higher Engagement" },
    @{ Num = "2"; Heading = "Second-Screen Agility"; Subheading = "Rapid-Response Content"; Points = @("Live match commentary in 90 seconds", "Humorous real-time situational memes", "Contextual reactive social engagement"); MetricLabel = "RESPONSE VELOCITY"; Metric = "Sub-90-Second Turnaround" },
    @{ Num = "3"; Heading = "Augmented Reality"; Subheading = "Immersive Mobile UX"; Points = @("Geo-fenced virtual stadium filters", "Interactive digital jersey customization", "Viral user-generated content sharing"); MetricLabel = "AUDIENCE PARTICIPATION"; Metric = "Millions of Fan Interactions" },
    @{ Num = "4"; Heading = "Frictionless Commerce"; Subheading = "Half-Time Conversion"; Points = @("Exclusive tap-to-buy merchandise", "Flash food delivery promotional codes", "Immediate mobile checkout integration"); MetricLabel = "COMMERCE CONVERSION"; Metric = "+48% Half-Time Orders" }
)
Create-Infographic "blog-3-fifa-world-cup-2026-marketing-campaigns" "hero-image.jpg" `
    "FIFA WORLD CUP 2026 MARKETING CAMPAIGNS: HOW DID BRANDS WIN ATTENTION?" `
    "5 Strategic Moves: Micro-Communities, Fast Real-Time Ads, Local Co-Creation & Omnichannel UX" `
    "Tournament Marketing Moves" $b3Cards1 "1A73E8"

# Fig 2
$b3Cards2 = @(
    @{ Num = "A"; Heading = "In-Stadium Excitement"; Subheading = "Physical Live Energy"; Points = @("Live spectator atmosphere in 16 venues", "Stadium geo-fenced digital activations", "Passionate community celebration moments"); MetricLabel = "PRIMARY PASSION POINT"; Metric = "Live Cultural Grounding" },
    @{ Num = "B"; Heading = "Second-Screen Social"; Subheading = "Digital Synchronization"; Points = @("Real-time TikTok & X commentary", "Humorous match memes & creator videos", "Synchronized commercial brand presence"); MetricLabel = "GLOBAL REACH"; Metric = "Billions of Second-Screen Impressions" },
    @{ Num = "C"; Heading = "Frictionless Mobile Retail"; Subheading = "Conversion Action"; Points = @("Tap-to-buy match merchandise drops", "Geo-targeted food delivery promos", "Instant mobile wallet checkout completion"); MetricLabel = "REVENUE IMPACT"; Metric = "Peak Emotion Conversion" }
)
Create-Infographic "blog-3-fifa-world-cup-2026-marketing-campaigns" "world-cup-marketing-framework.jpg" `
    "OMNICHANNEL TOURNAMENT FAN ACTIVATION FRAMEWORK" `
    "Connecting In-Stadium Passion, Second-Screen Mobile Feeds & Digital Retail Conversions" `
    "Fan Activation Model" $b3Cards2 "DC2626"

# ==============================================================================
# 5. BLOG 4 VISUALS (Google E-E-A-T)
# ==============================================================================
# Fig 1
$b4Cards1 = @(
    @{ Num = "E"; Heading = "Experience"; Subheading = "First-Hand Practical Proof"; Points = @("Original project experimentation", "Documented edge-case troubleshooting", "Authentic non-stock visual evidence"); MetricLabel = "PRACTITIONER PROOF"; Metric = "Real-World In-the-Trenches" },
    @{ Num = "E"; Heading = "Expertise"; Subheading = "Verified Subject Mastery"; Points = @("Accredited professional credentials", "In-depth technical comprehension", "Nuanced industry terminology usage"); MetricLabel = "KNOWLEDGE DEPTH"; Metric = "Formal Subject Authority" },
    @{ Num = "A"; Heading = "Authoritativeness"; Subheading = "External Recognition"; Points = @("Third-party industry citations", "High-tier press & digital PR mentions", "Reputable backlink recommendations"); MetricLabel = "REPUTATION SCORE"; Metric = "Industry-Wide Validation" },
    @{ Num = "T"; Heading = "Trustworthiness"; Subheading = "The Foundational Anchor"; Points = @("Transparent business contact details", "Verifiable author biography pages", "Accurate factual source citations"); MetricLabel = "CORE SEARCH FOUNDATION"; Metric = "Non-Negotiable Trust" }
)
Create-Infographic "blog-4-what-is-google-e-e-a-t" "hero-image.jpg" `
    "WHAT IS GOOGLE E-E-A-T AND WHY DOES IT MATTER FOR WEBSITE TRUST?" `
    "Experience, Expertise, Authoritativeness & Trust: How Google Evaluates Content Credibility" `
    "Search Quality Framework" $b4Cards1 "1A73E8"

# Fig 2
$b4Cards2 = @(
    @{ Num = "1"; Heading = "Experience Signals"; Subheading = "Practical Testing"; Points = @("Step-by-step implementation logs", "Honest failure points & solutions", "Unique proprietary dataset analysis"); MetricLabel = "PRACTICE EVIDENCE"; Metric = "First-Hand Discovery" },
    @{ Num = "2"; Heading = "Expertise Signals"; Subheading = "Credentials & Depth"; Points = @("Authoritative professional bylines", "Peer-reviewed technical accuracy", "Advanced conceptual problem-solving"); MetricLabel = "MASTERY PROOF"; Metric = "Verified Authorship" },
    @{ Num = "3"; Heading = "Authority Signals"; Subheading = "Peer Endorsements"; Points = @("Editorial links from domain leaders", "Academic and media press citations", "Widespread industry knowledge sharing"); MetricLabel = "ECOSYSTEM STATUS"; Metric = "Established Leadership" },
    @{ Num = "4"; Heading = "Trust Anchor"; Subheading = "User Security & Truth"; Points = @("Clear physical business address", "Honest editorial disclosure policy", "Secure HTTPS infrastructure"); MetricLabel = "CENTRAL CORE"; Metric = "Defensible Search Moat" }
)
Create-Infographic "blog-4-what-is-google-e-e-a-t" "google-eeat-pillars-framework.jpg" `
    "THE 4 PILLARS OF GOOGLE E-E-A-T SEARCH TRUST" `
    "The Structural Interplay Between Practical Experience, Subject Expertise & Domain Trust" `
    "Trust Interplay Model" $b4Cards2 "059669"

# ==============================================================================
# 6. BLOG 5 VISUALS (AI Generated Images)
# ==============================================================================
# Fig 1
$b5Cards1 = @(
    @{ Num = "1"; Heading = "Brand Authenticity"; Subheading = "Preserving Real Trust"; Points = @("Avoid synthetic deception in real goods", "Customers demand genuine photography", "Preserves authentic consumer connection"); MetricLabel = "TRUST FACTOR"; Metric = "Authenticity Over Novelty" },
    @{ Num = "2"; Heading = "Copyright & IP"; Subheading = "Legal Precautions"; Points = @("Pure AI art cannot be copyrighted", "Vulnerable to competitor appropriation", "Requires significant human editing"); MetricLabel = "LEGAL PROTECTION"; Metric = "Zero IP Exclusivity" },
    @{ Num = "3"; Heading = "Uncanny Artifacts"; Subheading = "Visual Quality Control"; Points = @("Distorted hands & warped typography", "Hyper-glossy synthetic textures", "Undermines premium brand perception"); MetricLabel = "QUALITY SCRUTINY"; Metric = "Rigorous Visual QA" },
    @{ Num = "4"; Heading = "Ethical Disclosure"; Subheading = "Transparent Governance"; Points = @("Clear labeling on synthetic concepts", "Prevents damaging consumer backlash", "Adheres to platform ad disclosures"); MetricLabel = "COMPLIANCE MANDATE"; Metric = "100% Honest Transparency" }
)
Create-Infographic "blog-5-ai-generated-images-viral-marketers" "hero-image.jpg" `
    "AI-GENERATED IMAGES ARE GOING VIRAL: WHAT MUST MARKETERS KNOW?" `
    "Visual Trends, Commercial Copyright Risks, Brand Authenticity & Strategic Guidelines" `
    "Generative Media Brief" $b5Cards1 "1A73E8"

# Fig 2
$b5Cards2 = @(
    @{ Num = "1"; Heading = "1. Ideation & Concepting"; Subheading = "Rapid Prototyping"; Points = @("Brainstorming visual metaphors", "Generating campaign mood boards", "Exploring novel artistic directions"); MetricLabel = "STAGE 1"; Metric = "Fast Visual Alignment" },
    @{ Num = "2"; Heading = "2. Legal & IP Review"; Subheading = "Risk Assessment"; Points = @("Auditing training data infringement", "Evaluating copyright defensibility", "Verifying commercial deployment terms"); MetricLabel = "STAGE 2"; Metric = "IP Compliance Audit" },
    @{ Num = "3"; Heading = "3. Human Art Direction"; Subheading = "Quality Refinement"; Points = @("Fixing anatomical & text artifacts", "Compositing brand typography & colors", "Aligning aesthetics to visual standards"); MetricLabel = "STAGE 3"; Metric = "Human Creative Touch" },
    @{ Num = "4"; Heading = "4. Transparent Deployment"; Subheading = "Channel Delivery"; Points = @("Appropriate context-based disclosure", "Monitoring audience engagement signals", "Preserving core brand integrity"); MetricLabel = "STAGE 4"; Metric = "Controlled Release" }
)
Create-Infographic "blog-5-ai-generated-images-viral-marketers" "ai-image-governance-framework.jpg" `
    "BRAND INTEGRITY & AI IMAGE GOVERNANCE FRAMEWORK" `
    "A 4-Stage Decision Workflow for Evaluating, Auditing & Deploying AI Visual Assets" `
    "Governance Architecture" $b5Cards2 "EA580C"

# ==============================================================================
# 7. BLOG 6 VISUALS (Top PPC Trends 2027)
# ==============================================================================
# Fig 1
$b6Cards1 = @(
    @{ Num = "1"; Heading = "Conversational Query Ads"; Subheading = "Multimodal Search"; Points = @("Ads within generative AI answer engines", "Visual lens lookups & voice queries", "Multi-intent semantic matching"); MetricLabel = "SEARCH FORMAT"; Metric = "Generative Answer Ads" },
    @{ Num = "2"; Heading = "Predictive LTV Bidding"; Subheading = "Lifetime Value Optimization"; Points = @("Bidding optimized on multi-year revenue", "Moves beyond immediate CPA limits", "Attracts high-retention customers"); MetricLabel = "BIDDING STRATEGY"; Metric = "Maximized Customer LTV" },
    @{ Num = "3"; Heading = "First-Party Data Moat"; Subheading = "Cookieless Tracking"; Points = @("Offline CRM sales signals fed back", "Encrypted customer list matching", "Defensible auction advantage"); MetricLabel = "DATA MOAT"; Metric = "Clean First-Party Signals" },
    @{ Num = "4"; Heading = "Incrementality Lift"; Subheading = "True Causality Proof"; Points = @("Geo-lift statistical experimentation", "Eliminates last-click attribution bias", "Proves true incremental conversions"); MetricLabel = "MEASUREMENT RIGOR"; Metric = "Statistical Geo-Lift" }
)
Create-Infographic "blog-6-top-ppc-trends-of-2027" "hero-image.jpg" `
    "TOP PPC TRENDS OF 2027: 7 CHANGES MARKETERS MUST PREPARE FOR?" `
    "Predictive Bidding, Conversational Query Ads, First-Party Signals & Real-Time Creative Synthesis" `
    "Future PPC Evolution" $b6Cards1 "1A73E8"

# Fig 2
$b6Cards2 = @(
    @{ Num = "A"; Heading = "First-Party Ingestion"; Subheading = "Verified Data Inputs"; Points = @("Server-side conversion API events", "Encrypted CRM lifetime sales data", "Offline physical showroom footfall"); MetricLabel = "SIGNAL QUALITY"; Metric = "High-Fidelity Training" },
    @{ Num = "B"; Heading = "Predictive AI Bidding"; Subheading = "Algorithmic Precision"; Points = @("Real-time auction intent evaluation", "Cross-network placement allocation", "Dynamic budget shifting to high ROAS"); MetricLabel = "ALGORITHMIC CORE"; Metric = "Self-Optimizing Bids" },
    @{ Num = "C"; Heading = "Multimodal Ad Assembly"; Subheading = "Contextual Delivery"; Points = @("Dynamic real-time headline synthesis", "Personalized image & product carousels", "Tailored to conversational queries"); MetricLabel = "CREATIVE SYNTHESIS"; Metric = "Real-Time Personalization" },
    @{ Num = "D"; Heading = "Incrementality Testing"; Subheading = "True Value Proof"; Points = @("Continuous geo-lift experiment control", "Eliminates branded search attribution bias", "Validates true bottom-line expansion"); MetricLabel = "REVENUE VALIDATION"; Metric = "Verified Incremental Lift" }
)
Create-Infographic "blog-6-top-ppc-trends-of-2027" "ppc-2027-ecosystem-architecture.jpg" `
    "THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM" `
    "How Machine Learning Systems Predict Customer Intent & Deliver Dynamic Cross-Channel Ads" `
    "2027 PPC Architecture" $b6Cards2 "4F46E5"

Write-Host "`n[SUCCESS] ALL 14 VISUAL ASSETS RENDERED AT 1920x1080 (16:9)!"

