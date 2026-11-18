Add-Type -AssemblyName System.Drawing

function Composite-Illustration {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$SubtitleColorHex = "1A73E8",
        [string]$FooterText = "KANAVU DIGITAL MARKETING • EVIDENCE-BASED MARKETING & ENTERPRISE GROWTH"
    )

    Write-Host "Compositing illustration: $SourcePath -> $OutputPath"
    if (-not (Test-Path $SourcePath)) {
        Write-Error "Source file does not exist: $SourcePath"
        return
    }

    $srcImg = [System.Drawing.Image]::FromFile($SourcePath)

    $targetW = 1920
    $targetH = 1080
    $bmp = [System.Drawing.Bitmap]::new($targetW, $targetH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    
    $g.Clear([System.Drawing.Color]::White)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Extra Large Bold Title (42pt)
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]42, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Slate 900
    $titleFormat = [System.Drawing.StringFormat]::new()
    $titleFormat.Alignment = [System.Drawing.StringAlignment]::Center
    $titleFormat.LineAlignment = [System.Drawing.StringAlignment]::Center

    $titleRect = [System.Drawing.RectangleF]::new(40, 20, 1840, 65)
    $g.DrawString($Title, $titleFont, $titleBrush, $titleRect, $titleFormat)

    # Large Bold Subtitle (21pt)
    if ($Subtitle -and $Subtitle.Trim().Length -gt 0) {
        $subColor = [System.Drawing.ColorTranslator]::FromHtml("#" + $SubtitleColorHex)
        $subFont = [System.Drawing.Font]::new("Segoe UI", [float]21, [System.Drawing.FontStyle]::Bold)
        $subBrush = [System.Drawing.SolidBrush]::new($subColor)
        $subRect = [System.Drawing.RectangleF]::new(40, 88, 1840, 45)
        $g.DrawString($Subtitle, $subFont, $subBrush, $subRect, $titleFormat)
        $subFont.Dispose()
        $subBrush.Dispose()
    }

    # Illustration positioning (Y: 145 to 1035, available H: 890, available W: 1840)
    $availW = 1840
    $availH = 890
    $scaleW = $availW / $srcImg.Width
    $scaleH = $availH / $srcImg.Height
    $scale = [Math]::Min($scaleW, $scaleH)

    $drawW = [int]($srcImg.Width * $scale)
    $drawH = [int]($srcImg.Height * $scale)
    $drawX = [int]((1920 - $drawW) / 2)
    $drawY = [int](145 + ($availH - $drawH) / 2)

    # Soft border around illustration
    $borderPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(226, 232, 240), 2)
    $g.DrawRectangle($borderPen, $drawX - 2, $drawY - 2, $drawW + 4, $drawH + 4)
    $borderPen.Dispose()

    # Draw the rich AI illustration
    $g.DrawImage($srcImg, $drawX, $drawY, $drawW, $drawH)
    $srcImg.Dispose()

    # Subtle footer branding
    $footFont = [System.Drawing.Font]::new("Segoe UI", [float]12, [System.Drawing.FontStyle]::Bold)
    $footBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(148, 163, 184))
    $footRect = [System.Drawing.RectangleF]::new(40, 1045, 1840, 25)
    $g.DrawString($FooterText, $footFont, $footBrush, $footRect, $titleFormat)
    $footFont.Dispose()
    $footBrush.Dispose()

    # Save as JPEG with 95 quality
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $encoderParams = [System.Drawing.Imaging.EncoderParameters]::new(1)
    $encoderParams.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]95)

    $outDir = [System.IO.Path]::GetDirectoryName($OutputPath)
    if (-not (Test-Path $outDir)) {
        New-Item -ItemType Directory -Path $outDir -Force | Out-Null
    }

    $tempPath = [System.IO.Path]::GetTempFileName() + ".jpg"
    $bmp.Save($tempPath, $codec, $encoderParams)

    $g.Dispose()
    $bmp.Dispose()
    $titleFont.Dispose()
    $titleBrush.Dispose()

    Move-Item -Path $tempPath -Destination $OutputPath -Force
    Write-Host "[SUCCESS] Saved composited visual: $OutputPath"
}

$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16"
$brainDir = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78"

# 1. PILLAR HUB
Write-Host "--- COMPOSITING PILLAR HUB ---" -ForegroundColor Cyan
Composite-Illustration `
    -SourcePath (Join-Path $brainDir "erode_digital_marketing_agency_1794632782497.jpg") `
    -OutputPath (Join-Path $baseDir "pillar-top-digital-marketing-company-strategies-for-growth\hero-image.jpg") `
    -Title "TOP DIGITAL MARKETING COMPANY: HOW TO DRIVE MEASURABLE GROWTH?" `
    -Subtitle "5 Foundational Pillars: Technical SEO, Precision Paid Media, Content Authority, CRO & Analytics" `
    -SubtitleColorHex "1A73E8" `
    -FooterText "KANAVU DIGITAL MARKETING • ENTERPRISE GROWTH & EVIDENCE-BASED MARKETING"

Composite-Illustration `
    -SourcePath (Join-Path $brainDir "agency_vs_vendor_comparison_1794632789313.jpg") `
    -OutputPath (Join-Path $baseDir "pillar-top-digital-marketing-company-strategies-for-growth\omnichannel-growth-engine.jpg") `
    -Title "THE OMNICHANNEL REVENUE GROWTH ENGINE" `
    -Subtitle "Synchronizing Organic Search, Performance Ads, AI Automation & Attribution" `
    -SubtitleColorHex "059669" `
    -FooterText "KANAVU DIGITAL MARKETING • ENTERPRISE GROWTH & EVIDENCE-BASED MARKETING"

# 2. BLOG 1 (Claude for SMM)
Write-Host "--- COMPOSITING BLOG 1: CLAUDE SMM ---" -ForegroundColor Cyan
Composite-Illustration `
    -SourcePath (Join-Path $brainDir "claude_social_media_marketing_v2_1794808240650.jpg") `
    -OutputPath (Join-Path $baseDir "blog-1-how-to-use-claude-for-social-media-marketing\hero-image.jpg") `
    -Title "HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS?" `
    -Subtitle "Captions, Content Calendars, Audience Personas, Repurposing & Tone Calibration" `
    -SubtitleColorHex "1A73E8" `
    -FooterText "KANAVU DIGITAL MARKETING • SOCIAL MEDIA AI WORKFLOW"

Composite-Illustration `
    -SourcePath (Join-Path $brainDir "claude_social_media_marketing_v3_1794808267777.jpg") `
    -OutputPath (Join-Path $baseDir "blog-1-how-to-use-claude-for-social-media-marketing\claude-social-workflow.jpg") `
    -Title "CLAUDE AI SOCIAL MEDIA REPURPOSING ARCHITECTURE" `
    -Subtitle "Transforming Long-Form Transcripts into Multi-Platform Social Assets" `
    -SubtitleColorHex "4F46E5" `
    -FooterText "KANAVU DIGITAL MARKETING • SOCIAL MEDIA AI WORKFLOW"

# 3. BLOG 2 (AI Agents)
Write-Host "--- COMPOSITING BLOG 2: AI AGENTS ---" -ForegroundColor Cyan
Composite-Illustration `
    -SourcePath (Join-Path $brainDir "ai_agent_architecture_diagram_1794554902676.jpg") `
    -OutputPath (Join-Path $baseDir "blog-2-ai-agents-in-digital-marketing\hero-image.jpg") `
    -Title "AI AGENTS IN DIGITAL MARKETING: WHICH TASKS CAN YOU AUTOMATE?" `
    -Subtitle "5 Autonomous Capabilities: Competitor Tracking, Reporting, Lead Routing & Campaigns" `
    -SubtitleColorHex "1A73E8" `
    -FooterText "KANAVU DIGITAL MARKETING • AUTONOMOUS MARKETING OPERATIONS"

Composite-Illustration `
    -SourcePath (Join-Path $brainDir "ai_agent_vs_traditional_chatbot_1794560973596.jpg") `
    -OutputPath (Join-Path $baseDir "blog-2-ai-agents-in-digital-marketing\ai-agents-marketing-loop.jpg") `
    -Title "AUTONOMOUS AI MARKETING PERCEPTION-ACTION LOOP" `
    -Subtitle "How AI Agents Detect Market Signals, Analyze Data & Execute Campaigns Autonomously" `
    -SubtitleColorHex "059669" `
    -FooterText "KANAVU DIGITAL MARKETING • AUTONOMOUS MARKETING OPERATIONS"

# 4. BLOG 3 (FIFA World Cup 2026)
Write-Host "--- COMPOSITING BLOG 3: WORLD CUP 2026 ---" -ForegroundColor Cyan
Composite-Illustration `
    -SourcePath (Join-Path $brainDir "fifa_world_cup_2026_marketing_editorial_1794808222723.jpg") `
    -OutputPath (Join-Path $baseDir "blog-3-fifa-world-cup-2026-marketing-campaigns\hero-image.jpg") `
    -Title "FIFA WORLD CUP 2026 MARKETING CAMPAIGNS: HOW DID BRANDS WIN ATTENTION?" `
    -Subtitle "5 Strategic Moves: Micro-Communities, Fast Real-Time Ads, Local Co-Creation & Omnichannel UX" `
    -SubtitleColorHex "1A73E8" `
    -FooterText "KANAVU DIGITAL MARKETING • GLOBAL SPORTS MARKETING STRATEGY"

Composite-Illustration `
    -SourcePath (Join-Path $brainDir "fifa_2026_omnichannel_activation_command_center_1794810042994.jpg") `
    -OutputPath (Join-Path $baseDir "blog-3-fifa-world-cup-2026-marketing-campaigns\world-cup-marketing-framework.jpg") `
    -Title "OMNICHANNEL TOURNAMENT FAN ACTIVATION FRAMEWORK" `
    -Subtitle "Connecting In-Stadium Passion, Second-Screen Mobile Feeds & Digital Retail Conversions" `
    -SubtitleColorHex "DC2626" `
    -FooterText "KANAVU DIGITAL MARKETING • GLOBAL SPORTS MARKETING STRATEGY"

# 5. BLOG 4 (Google E-E-A-T)
Write-Host "--- COMPOSITING BLOG 4: GOOGLE E-E-A-T ---" -ForegroundColor Cyan
Composite-Illustration `
    -SourcePath (Join-Path $brainDir "google_eeat_seo_trust_editorial_1794808252841.jpg") `
    -OutputPath (Join-Path $baseDir "blog-4-what-is-google-e-e-a-t\hero-image.jpg") `
    -Title "WHAT IS GOOGLE E-E-A-T AND WHY DOES IT MATTER FOR WEBSITE TRUST?" `
    -Subtitle "Experience, Expertise, Authoritativeness & Trust: How Google Evaluates Content Credibility" `
    -SubtitleColorHex "1A73E8" `
    -FooterText "KANAVU DIGITAL MARKETING • SEARCH QUALITY & TRUST ARCHITECTURE"

Composite-Illustration `
    -SourcePath (Join-Path $brainDir "google_eeat_seo_trust_shield_1794808230818.jpg") `
    -OutputPath (Join-Path $baseDir "blog-4-what-is-google-e-e-a-t\google-eeat-pillars-framework.jpg") `
    -Title "THE 4 PILLARS OF GOOGLE E-E-A-T SEARCH TRUST" `
    -Subtitle "The Structural Interplay Between Practical Experience, Subject Expertise & Domain Trust" `
    -SubtitleColorHex "059669" `
    -FooterText "KANAVU DIGITAL MARKETING • SEARCH QUALITY & TRUST ARCHITECTURE"

# 6. BLOG 5 (AI Generated Images)
Write-Host "--- COMPOSITING BLOG 5: AI IMAGES ---" -ForegroundColor Cyan
Composite-Illustration `
    -SourcePath (Join-Path $brainDir "ai_generated_images_marketers_guide_1794808242160.jpg") `
    -OutputPath (Join-Path $baseDir "blog-5-ai-generated-images-viral-marketers\hero-image.jpg") `
    -Title "AI-GENERATED IMAGES ARE GOING VIRAL: WHAT MUST MARKETERS KNOW?" `
    -Subtitle "Visual Trends, Commercial Copyright Risks, Brand Authenticity & Strategic Guidelines" `
    -SubtitleColorHex "1A73E8" `
    -FooterText "KANAVU DIGITAL MARKETING • GENERATIVE MEDIA & BRAND INTEGRITY"

Composite-Illustration `
    -SourcePath (Join-Path $brainDir "ai_marketing_governance_framework_1794810026062.jpg") `
    -OutputPath (Join-Path $baseDir "blog-5-ai-generated-images-viral-marketers\ai-image-governance-framework.jpg") `
    -Title "BRAND INTEGRITY & AI IMAGE GOVERNANCE FRAMEWORK" `
    -Subtitle "A 4-Stage Decision Workflow for Evaluating, Auditing & Deploying AI Visual Assets" `
    -SubtitleColorHex "EA580C" `
    -FooterText "KANAVU DIGITAL MARKETING • GENERATIVE MEDIA & BRAND INTEGRITY"

# 7. BLOG 6 (Top PPC Trends 2027)
Write-Host "--- COMPOSITING BLOG 6: PPC TRENDS 2027 ---" -ForegroundColor Cyan
Composite-Illustration `
    -SourcePath (Join-Path $brainDir "ppc_trends_2027_editorial_hero_v2_1794808271894.jpg") `
    -OutputPath (Join-Path $baseDir "blog-6-top-ppc-trends-of-2027\hero-image.jpg") `
    -Title "TOP PPC TRENDS OF 2027: 7 CHANGES MARKETERS MUST PREPARE FOR?" `
    -Subtitle "Predictive Bidding, Conversational Query Ads, First-Party Signals & Real-Time Creative Synthesis" `
    -SubtitleColorHex "1A73E8" `
    -FooterText "KANAVU DIGITAL MARKETING • PREDICTIVE PERFORMANCE ADVERTISING"

Composite-Illustration `
    -SourcePath (Join-Path $brainDir "ppc_trends_2027_editorial_hero_1794808251673.jpg") `
    -OutputPath (Join-Path $baseDir "blog-6-top-ppc-trends-of-2027\ppc-2027-ecosystem-architecture.jpg") `
    -Title "THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM" `
    -Subtitle "How Machine Learning Systems Predict Customer Intent & Deliver Dynamic Cross-Channel Ads" `
    -SubtitleColorHex "4F46E5" `
    -FooterText "KANAVU DIGITAL MARKETING • PREDICTIVE PERFORMANCE ADVERTISING"

Write-Host "`n=== ALL 14 EDITORIAL ILLUSTRATIONS COMPOSITED SUCCESSFULLY ===" -ForegroundColor Green
