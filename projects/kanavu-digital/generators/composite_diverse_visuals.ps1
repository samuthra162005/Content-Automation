Add-Type -AssemblyName System.Drawing

function Composite-Visual {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$Theme = "Navy", # Navy, Emerald, Indigo, Crimson, Slate, Violet, Amber
        [string]$BadgeText = "TACTICAL FRAMEWORK"
    )

    Write-Host "Compositing: $OutputPath (Theme: $Theme)"
    if (-not (Test-Path $SourcePath)) {
        Write-Error "Source missing: $SourcePath"
        return
    }

    $srcImg = [System.Drawing.Image]::FromFile($SourcePath)

    $targetW = 1920
    $targetH = 1080
    $bmp = [System.Drawing.Bitmap]::new($targetW, $targetH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Theme colors
    $primaryColor = [System.Drawing.Color]::FromArgb(15, 23, 42)
    $accentColor = [System.Drawing.Color]::FromArgb(26, 115, 232)
    $subColor = [System.Drawing.Color]::FromArgb(5, 150, 105)
    $bgColor = [System.Drawing.Color]::FromArgb(248, 250, 252)

    switch ($Theme) {
        "Navy" {
            $accentColor = [System.Drawing.Color]::FromArgb(30, 64, 175) # Blue 800
            $subColor = [System.Drawing.Color]::FromArgb(14, 165, 233)   # Sky 500
            $bgColor = [System.Drawing.Color]::FromArgb(248, 250, 252)
        }
        "Emerald" {
            $accentColor = [System.Drawing.Color]::FromArgb(5, 150, 105) # Emerald 600
            $subColor = [System.Drawing.Color]::FromArgb(16, 185, 129)  # Emerald 500
            $bgColor = [System.Drawing.Color]::FromArgb(240, 253, 244)
        }
        "Indigo" {
            $accentColor = [System.Drawing.Color]::FromArgb(79, 70, 229) # Indigo 600
            $subColor = [System.Drawing.Color]::FromArgb(99, 102, 241)  # Indigo 500
            $bgColor = [System.Drawing.Color]::FromArgb(245, 243, 255)
        }
        "Crimson" {
            $accentColor = [System.Drawing.Color]::FromArgb(220, 38, 38) # Red 600
            $subColor = [System.Drawing.Color]::FromArgb(239, 68, 68)   # Red 500
            $bgColor = [System.Drawing.Color]::FromArgb(254, 242, 242)
        }
        "Slate" {
            $accentColor = [System.Drawing.Color]::FromArgb(51, 65, 85)  # Slate 700
            $subColor = [System.Drawing.Color]::FromArgb(71, 85, 105)   # Slate 600
            $bgColor = [System.Drawing.Color]::FromArgb(241, 245, 249)
        }
        "Amber" {
            $accentColor = [System.Drawing.Color]::FromArgb(217, 119, 6) # Amber 600
            $subColor = [System.Drawing.Color]::FromArgb(245, 158, 11)  # Amber 500
            $bgColor = [System.Drawing.Color]::FromArgb(255, 251, 235)
        }
        "Violet" {
            $accentColor = [System.Drawing.Color]::FromArgb(124, 58, 237) # Violet 600
            $subColor = [System.Drawing.Color]::FromArgb(139, 92, 246)  # Violet 500
            $bgColor = [System.Drawing.Color]::FromArgb(250, 245, 255)
        }
    }

    $g.Clear($bgColor)

    # Top Accent Strip
    $accentBrush = [System.Drawing.SolidBrush]::new($accentColor)
    $g.FillRectangle($accentBrush, 0, 0, 1920, 8)
    $accentBrush.Dispose()

    # Category Pill Badge
    $badgeRect = [System.Drawing.RectangleF]::new(50, 24, 280, 32)
    $bBrush = [System.Drawing.SolidBrush]::new($accentColor)
    $bFont = [System.Drawing.Font]::new("Segoe UI", [float]11, [System.Drawing.FontStyle]::Bold)
    $bFmt = [System.Drawing.StringFormat]::new()
    $bFmt.Alignment = [System.Drawing.StringAlignment]::Near
    $bFmt.LineAlignment = [System.Drawing.StringAlignment]::Center
    $g.DrawString($BadgeText.ToUpper(), $bFont, $bBrush, $badgeRect, $bFmt)
    $bBrush.Dispose()
    $bFont.Dispose()

    # Title (40pt bold)
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]38, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new($primaryColor)
    $titleFormat = [System.Drawing.StringFormat]::new()
    $titleFormat.Alignment = [System.Drawing.StringAlignment]::Near
    $titleFormat.LineAlignment = [System.Drawing.StringAlignment]::Near
    $titleRect = [System.Drawing.RectangleF]::new(50, 58, 1820, 54)
    $g.DrawString($Title, $titleFont, $titleBrush, $titleRect, $titleFormat)
    $titleFont.Dispose()
    $titleBrush.Dispose()

    # Subtitle (18pt bold)
    $subFont = [System.Drawing.Font]::new("Segoe UI", [float]18, [System.Drawing.FontStyle]::Bold)
    $subBrush = [System.Drawing.SolidBrush]::new($subColor)
    $subRect = [System.Drawing.RectangleF]::new(50, 114, 1820, 32)
    $g.DrawString($Subtitle, $subFont, $subBrush, $subRect, $titleFormat)
    $subFont.Dispose()
    $subBrush.Dispose()

    # Illustration area (Y: 154 to 1040, height 886)
    $availW = 1820
    $availH = 886
    $scaleW = $availW / $srcImg.Width
    $scaleH = $availH / $srcImg.Height
    $scale = [Math]::Min($scaleW, $scaleH)

    $drawW = [int]($srcImg.Width * $scale)
    $drawH = [int]($srcImg.Height * $scale)
    $drawX = [int](50 + ($availW - $drawW) / 2)
    $drawY = [int](154 + ($availH - $drawH) / 2)

    # Frame border around artwork
    $framePen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 1.5)
    $g.DrawRectangle($framePen, $drawX - 1, $drawY - 1, $drawW + 2, $drawH + 2)
    $framePen.Dispose()

    $g.DrawImage($srcImg, $drawX, $drawY, $drawW, $drawH)
    $srcImg.Dispose()

    # Footer
    $footFont = [System.Drawing.Font]::new("Segoe UI", [float]11, [System.Drawing.FontStyle]::Bold)
    $footBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(100, 116, 139))
    $footRect = [System.Drawing.RectangleF]::new(50, 1048, 1820, 24)
    $footFmt = [System.Drawing.StringFormat]::new()
    $footFmt.Alignment = [System.Drawing.StringAlignment]::Far
    $g.DrawString("KANAVU DIGITAL MARKETING • EVIDENCE-BASED MARKETING & ENTERPRISE GROWTH", $footFont, $footBrush, $footRect, $footFmt)
    $footFont.Dispose()
    $footBrush.Dispose()

    # Save
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $encoderParams = [System.Drawing.Imaging.EncoderParameters]::new(1)
    $encoderParams.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]95)

    $outDir = [System.IO.Path]::GetDirectoryName($OutputPath)
    if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }

    $tempPath = [System.IO.Path]::GetTempFileName() + ".jpg"
    $bmp.Save($tempPath, $codec, $encoderParams)

    $g.Dispose()
    $bmp.Dispose()

    Move-Item -Path $tempPath -Destination $OutputPath -Force
    Write-Host "[SUCCESS] Saved: $OutputPath"
}

$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16"
$brainDir = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78"

# 1. PILLAR HUB
Composite-Visual `
    -SourcePath (Join-Path $brainDir "erode_digital_marketing_agency_1794632782497.jpg") `
    -OutputPath (Join-Path $baseDir "pillar-top-digital-marketing-company-strategies-for-growth\hero-image.jpg") `
    -Title "TOP DIGITAL MARKETING COMPANY: HOW TO DRIVE SUSTAINABLE GROWTH?" `
    -Subtitle "5 Architectural Growth Pillars: Technical SEO, Paid Media, Content Moats, CRO & Attribution" `
    -Theme "Navy" `
    -BadgeText "EXECUTIVE GROWTH BLUEPRINT"

Composite-Visual `
    -SourcePath (Join-Path $brainDir "agency_vs_vendor_comparison_1794632789313.jpg") `
    -OutputPath (Join-Path $baseDir "pillar-top-digital-marketing-company-strategies-for-growth\omnichannel-growth-engine.jpg") `
    -Title "THE OMNICHANNEL REVENUE GROWTH FLYWHEEL" `
    -Subtitle "Synchronizing Inbound Search, Precision Paid Acquisition, Platform CRO & Closed-Loop Attribution" `
    -Theme "Emerald" `
    -BadgeText "FULL-FUNNEL ARCHITECTURE"

# 2. BLOG 1 (Claude SMM) - USING THE BRAND NEW DAYLIGHT CREATOR PHOTO!
Composite-Visual `
    -SourcePath (Join-Path $brainDir "modern_creator_smm_workspace_1794810623130.jpg") `
    -OutputPath (Join-Path $baseDir "blog-1-how-to-use-claude-for-social-media-marketing\hero-image.jpg") `
    -Title "HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS?" `
    -Subtitle "Captions, Monthly Content Calendars, Creative Hooks, Audience Research & Repurposing" `
    -Theme "Amber" `
    -BadgeText "PRACTITIONER PLAYBOOK"

Composite-Visual `
    -SourcePath (Join-Path $brainDir "claude_social_media_marketing_v3_1794808267777.jpg") `
    -OutputPath (Join-Path $baseDir "blog-1-how-to-use-claude-for-social-media-marketing\claude-social-workflow.jpg") `
    -Title "CLAUDE AI CONTENT REPURPOSING SPRINT PIPELINE" `
    -Subtitle "Decomposing Long-Form Video Transcripts & Podcasts into Platform-Ready Carousels & Threads" `
    -Theme "Indigo" `
    -BadgeText "SPRINT ARCHITECTURE"

# 3. BLOG 2 (AI Agents)
Composite-Visual `
    -SourcePath (Join-Path $brainDir "ai_agent_architecture_diagram_1794554902676.jpg") `
    -OutputPath (Join-Path $baseDir "blog-2-ai-agents-in-digital-marketing\hero-image.jpg") `
    -Title "AI AGENTS IN DIGITAL MARKETING: WHICH TASKS CAN YOU AUTOMATE?" `
    -Subtitle "Autonomous Market Surveillance, Dynamic Reporting, Inbound Routing & Micro-Budget Bidding" `
    -Theme "Slate" `
    -BadgeText "SYSTEMS TEARDOWN"

Composite-Visual `
    -SourcePath (Join-Path $brainDir "ai_agent_vs_traditional_chatbot_1794560973596.jpg") `
    -OutputPath (Join-Path $baseDir "blog-2-ai-agents-in-digital-marketing\ai-agents-marketing-loop.jpg") `
    -Title "AUTONOMOUS MARKETING PERCEPTION-ACTION CLOSED LOOP" `
    -Subtitle "How AI Agents Detect Signal Shifts, Reason Multi-Step Goals & Call APIs Within Guardrails" `
    -Theme "Emerald" `
    -BadgeText "CLOSED-LOOP WORKFLOW"

# 4. BLOG 3 (FIFA World Cup) - BRAND NEW SPORTS MARKETING WAR ROOM!
Composite-Visual `
    -SourcePath (Join-Path $brainDir "fifa_world_cup_2026_marketing_editorial_1794808222723.jpg") `
    -OutputPath (Join-Path $baseDir "blog-3-fifa-world-cup-2026-marketing-campaigns\hero-image.jpg") `
    -Title "FIFA WORLD CUP 2026 MARKETING CAMPAIGNS: HOW DID BRANDS WIN ATTENTION?" `
    -Subtitle "5 Strategic Moves: Host-City Co-Creation, 90-Second Agile Newsrooms, AR Filters & Flash Commerce" `
    -Theme "Crimson" `
    -BadgeText "SPORTS BUSINESS CASE STUDY"

Composite-Visual `
    -SourcePath (Join-Path $brainDir "fifa_2026_omnichannel_activation_command_center_1794810042994.jpg") `
    -OutputPath (Join-Path $baseDir "blog-3-fifa-world-cup-2026-marketing-campaigns\world-cup-marketing-framework.jpg") `
    -Title "OMNICHANNEL TOURNAMENT FAN ACTIVATION COMMAND CENTER" `
    -Subtitle "Connecting In-Stadium Live Emotion with Second-Screen Feeds & Instant Mobile Conversions" `
    -Theme "Navy" `
    -BadgeText "ACTIVATION COMMAND CENTER"

# 5. BLOG 4 (Google E-E-A-T)
Composite-Visual `
    -SourcePath (Join-Path $brainDir "google_eeat_seo_trust_editorial_1794808252841.jpg") `
    -OutputPath (Join-Path $baseDir "blog-4-what-is-google-e-e-a-t\hero-image.jpg") `
    -Title "WHAT IS GOOGLE E-E-A-T AND WHY DOES IT MATTER FOR WEBSITE TRUST?" `
    -Subtitle "Experience, Expertise, Authoritativeness & Trust: How Quality Evaluators Audit Digital Credibility" `
    -Theme "Navy" `
    -BadgeText "SEARCH QUALITY AUDIT"

Composite-Visual `
    -SourcePath (Join-Path $brainDir "google_eeat_seo_trust_shield_1794808230818.jpg") `
    -OutputPath (Join-Path $baseDir "blog-4-what-is-google-e-e-a-t\google-eeat-pillars-framework.jpg") `
    -Title "THE 4 STRUCTURAL PILLARS OF GOOGLE E-E-A-T SEARCH TRUST" `
    -Subtitle "Defensible Author Entities, Peer Citations & Transparent Security Anchoring Site Authority" `
    -Theme "Emerald" `
    -BadgeText "TRUST EQUATION ARCHITECTURE"

# 6. BLOG 5 (AI Generated Images) - BRAND NEW AI VISUAL AUDITING STUDIO!
Composite-Visual `
    -SourcePath (Join-Path $brainDir "ai_generated_images_marketers_guide_1794808242160.jpg") `
    -OutputPath (Join-Path $baseDir "blog-5-ai-generated-images-viral-marketers\hero-image.jpg") `
    -Title "AI-GENERATED IMAGES ARE GOING VIRAL: WHAT MUST MARKETERS KNOW?" `
    -Subtitle "Commercial Copyright Realities, Brand Authenticity Dilution, Quality Artifacts & Ethical Disclosure" `
    -Theme "Violet" `
    -BadgeText "EXECUTIVE RISK ADVISORY"

Composite-Visual `
    -SourcePath (Join-Path $brainDir "ai_marketing_governance_framework_1794810026062.jpg") `
    -OutputPath (Join-Path $baseDir "blog-5-ai-generated-images-viral-marketers\ai-image-governance-framework.jpg") `
    -Title "CORPORATE BRAND INTEGRITY & AI IMAGE GOVERNANCE FRAMEWORK" `
    -Subtitle "4-Stage Review Protocol: Ideation, Legal IP Audit, Human Art Direction & Transparent Release" `
    -Theme "Amber" `
    -BadgeText "GOVERNANCE DECISION PIPELINE"

# 7. BLOG 6 (PPC Trends 2027)
Composite-Visual `
    -SourcePath (Join-Path $brainDir "ppc_trends_2027_editorial_hero_v2_1794808271894.jpg") `
    -OutputPath (Join-Path $baseDir "blog-6-top-ppc-trends-of-2027\hero-image.jpg") `
    -Title "TOP PPC TRENDS OF 2027: 7 CHANGES MARKETERS MUST PREPARE FOR?" `
    -Subtitle "Conversational Query Ads, Predictive LTV Bidding, Clean First-Party Vaults & Incrementality Testing" `
    -Theme "Navy" `
    -BadgeText "INDUSTRY HORIZON FORECAST"

Composite-Visual `
    -SourcePath (Join-Path $brainDir "ppc_trends_2027_editorial_hero_1794808251673.jpg") `
    -OutputPath (Join-Path $baseDir "blog-6-top-ppc-trends-of-2027\ppc-2027-ecosystem-architecture.jpg") `
    -Title "THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM" `
    -Subtitle "How Machine Learning Connects First-Party Signal Vaults to Dynamic Real-Time Ad Assembly" `
    -Theme "Slate" `
    -BadgeText "CAMPAIGN ECOSYSTEM ARCHITECTURE"

Write-Host "`n=== ALL 14 DIVERSE VISUALS COMPOSITED WITH UNIQUE THEMES & BADGES ===" -ForegroundColor Green

