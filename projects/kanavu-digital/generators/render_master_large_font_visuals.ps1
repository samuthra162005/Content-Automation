Add-Type -AssemblyName System.Drawing

$brainDir = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78"
$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16"

# ==============================================================================
# TOP BANNER DRAWING ENGINE (LARGE 40pt BOLD TITLE AT TOP)
# ==============================================================================
function Draw-MasterTopBanner {
    param (
        [System.Drawing.Graphics]$g,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$BadgeColorHex = "38BDF8",
        [bool]$IsDarkTheme = $true,
        [string]$ThemeHex = "1E40AF"
    )

    $maxWidth = 1780 # 70px left & right margins on 1920 canvas

    # Title Font: 40pt Bold
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]40, [System.Drawing.FontStyle]::Bold)
    $szTitle = $g.MeasureString($Title, $titleFont)
    
    $isTwoLines = $szTitle.Width -gt $maxWidth
    $bannerHeight = if ($isTwoLines) { 245 } else { 190 }

    if ($IsDarkTheme) {
        # Deep obsidian gradient banner at top
        $bannerBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
            [System.Drawing.Point]::new(0, 0),
            [System.Drawing.Point]::new(0, $bannerHeight + 50),
            [System.Drawing.Color]::FromArgb(252, 10, 15, 29),
            [System.Drawing.Color]::FromArgb(0, 10, 15, 29)
        )
        $g.FillRectangle($bannerBrush, 0, 0, 1920, $bannerHeight + 50)
        $bannerBrush.Dispose()

        # Accent top bar (5px)
        $accentColor = [System.Drawing.ColorTranslator]::FromHtml("#$BadgeColorHex")
        $accentBrush = [System.Drawing.SolidBrush]::new($accentColor)
        $g.FillRectangle($accentBrush, 0, 0, 1920, 5)
        $accentBrush.Dispose()

        # Category Badge Pill
        $badgeFont = [System.Drawing.Font]::new("Segoe UI", [float]12, [System.Drawing.FontStyle]::Bold)
        $badgeBrush = [System.Drawing.SolidBrush]::new($accentColor)
        $g.DrawString($BadgeText.ToUpper(), $badgeFont, $badgeBrush, 70, 20)
        $badgeBrush.Dispose()
        $badgeFont.Dispose()

        # Title text (40pt bold pure white with shadow)
        $titleColor = [System.Drawing.Color]::White
        $shadowBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(180, 0, 0, 0))
        $titleBrush = [System.Drawing.SolidBrush]::new($titleColor)

        if ($isTwoLines) {
            # Split title at colon or naturally
            $parts = $Title -split ':\s*', 2
            if ($parts.Count -eq 2) {
                $line1 = $parts[0] + ":"
                $line2 = $parts[1]
            } else {
                $words = $Title -split '\s+'
                $half = [int]($words.Count / 2)
                $line1 = ($words[0..($half-1)] -join " ")
                $line2 = ($words[$half..($words.Count-1)] -join " ")
            }
            $g.DrawString($line1, $titleFont, $shadowBrush, 72, 57)
            $g.DrawString($line1, $titleFont, $titleBrush, 70, 55)
            $g.DrawString($line2, $titleFont, $shadowBrush, 72, 117)
            $g.DrawString($line2, $titleFont, $titleBrush, 70, 115)

            $subFont = [System.Drawing.Font]::new("Segoe UI", [float]18, [System.Drawing.FontStyle]::Regular)
            $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#94A3B8"))
            $g.DrawString($Subtitle, $subFont, $shadowBrush, 71, 185)
            $g.DrawString($Subtitle, $subFont, $subBrush, 70, 184)
            $subBrush.Dispose()
            $subFont.Dispose()
        } else {
            $g.DrawString($Title, $titleFont, $shadowBrush, 72, 57)
            $g.DrawString($Title, $titleFont, $titleBrush, 70, 55)

            $subFont = [System.Drawing.Font]::new("Segoe UI", [float]19, [System.Drawing.FontStyle]::Regular)
            $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#94A3B8"))
            $g.DrawString($Subtitle, $subFont, $shadowBrush, 71, 126)
            $g.DrawString($Subtitle, $subFont, $subBrush, 70, 125)
            $subBrush.Dispose()
            $subFont.Dispose()
        }

        $shadowBrush.Dispose()
        $titleBrush.Dispose()
    } else {
        # Light Theme (2D Vector / Matrix)
        $bgBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))
        $g.FillRectangle($bgBrush, 0, 0, 1920, $bannerHeight)
        $bgBrush.Dispose()

        # Accent top bar (6px)
        $accentColor = [System.Drawing.ColorTranslator]::FromHtml("#$ThemeHex")
        $accentBrush = [System.Drawing.SolidBrush]::new($accentColor)
        $g.FillRectangle($accentBrush, 0, 0, 1920, 6)
        $accentBrush.Dispose()

        # Border line at bottom of header
        $borderPen = [System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 1)
        $g.DrawLine($borderPen, 0, $bannerHeight, 1920, $bannerHeight)
        $borderPen.Dispose()

        # Category Badge Pill
        $badgeFont = [System.Drawing.Font]::new("Segoe UI", [float]12, [System.Drawing.FontStyle]::Bold)
        $badgeBrush = [System.Drawing.SolidBrush]::new($accentColor)
        $g.DrawString($BadgeText.ToUpper(), $badgeFont, $badgeBrush, 70, 18)
        $badgeBrush.Dispose()
        $badgeFont.Dispose()

        # Title text (40pt bold obsidian #0F172A)
        $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#0F172A"))

        if ($isTwoLines) {
            $parts = $Title -split ':\s*', 2
            if ($parts.Count -eq 2) {
                $line1 = $parts[0] + ":"
                $line2 = $parts[1]
            } else {
                $words = $Title -split '\s+'
                $half = [int]($words.Count / 2)
                $line1 = ($words[0..($half-1)] -join " ")
                $line2 = ($words[$half..($words.Count-1)] -join " ")
            }
            $g.DrawString($line1, $titleFont, $titleBrush, 70, 50)
            $g.DrawString($line2, $titleFont, $titleBrush, 70, 110)

            $subFont = [System.Drawing.Font]::new("Segoe UI", [float]18, [System.Drawing.FontStyle]::Regular)
            $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#475569"))
            $g.DrawString($Subtitle, $subFont, $subBrush, 70, 180)
            $subBrush.Dispose()
            $subFont.Dispose()
        } else {
            $g.DrawString($Title, $titleFont, $titleBrush, 70, 50)

            $subFont = [System.Drawing.Font]::new("Segoe UI", [float]19, [System.Drawing.FontStyle]::Regular)
            $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#475569"))
            $g.DrawString($Subtitle, $subFont, $subBrush, 70, 120)
            $subBrush.Dispose()
            $subFont.Dispose()
        }
        $titleBrush.Dispose()
    }

    $titleFont.Dispose()
    return $bannerHeight
}

# ==============================================================================
# RENDER FORMATS (ALL WITH 40pt TITLE AT TOP)
# ==============================================================================

# 1. DARK FULL-BLEED / CINEMATIC PHOTOGRAPHY
function Render-DarkFullBleed {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$BadgeColorHex = "38BDF8"
    )
    Write-Host "Rendering Dark Full-Bleed: $OutputPath"
    $src = [System.Drawing.Image]::FromFile($SourcePath)
    $bmp = [System.Drawing.Bitmap]::new(1920, 1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $scale = [Math]::Max(1920 / $src.Width, 1080 / $src.Height)
    $drawW = [int]($src.Width * $scale)
    $drawH = [int]($src.Height * $scale)
    $offsetX = [int]((1920 - $drawW) / 2)
    $offsetY = [int]((1080 - $drawH) / 2)
    $g.DrawImage($src, $offsetX, $offsetY, $drawW, $drawH)
    $src.Dispose()

    Draw-MasterTopBanner -g $g -Title $Title -Subtitle $Subtitle -BadgeText $BadgeText -BadgeColorHex $BadgeColorHex -IsDarkTheme $true

    $g.Dispose()
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
}

# 2. 3D ISOMETRIC SCENE
function Render-3DIsometricScene {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$AccentHex = "38BDF8"
    )
    Write-Host "Rendering 3D Isometric Scene: $OutputPath"
    $src = [System.Drawing.Image]::FromFile($SourcePath)
    $bmp = [System.Drawing.Bitmap]::new(1920, 1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $g.Clear([System.Drawing.ColorTranslator]::FromHtml("#0A0F1D"))

    # Ambient glow in center
    $viewTop = 200
    $viewH = 880
    $scale = [Math]::Min(1800 / $src.Width, $viewH / $src.Height)
    $drawW = [int]($src.Width * $scale)
    $drawH = [int]($src.Height * $scale)
    $posX = [int]((1920 - $drawW) / 2)
    $posY = [int]($viewTop + ($viewH - $drawH) / 2)
    $g.DrawImage($src, $posX, $posY, $drawW, $drawH)
    $src.Dispose()

    Draw-MasterTopBanner -g $g -Title $Title -Subtitle $Subtitle -BadgeText $BadgeText -BadgeColorHex $AccentHex -IsDarkTheme $true

    $g.Dispose()
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
}

# 3. 2D VECTOR / INFOGRAPHIC (LIGHT THEME)
function Render-2DVectorLight {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$ThemeHex = "1E40AF"
    )
    Write-Host "Rendering 2D Vector Light: $OutputPath"
    $src = [System.Drawing.Image]::FromFile($SourcePath)
    $bmp = [System.Drawing.Bitmap]::new(1920, 1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $g.Clear([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))

    # Left theme accent line
    $themeColor = [System.Drawing.ColorTranslator]::FromHtml("#$ThemeHex")
    $accentBrush = [System.Drawing.SolidBrush]::new($themeColor)
    $g.FillRectangle($accentBrush, 0, 0, 10, 1080)
    $accentBrush.Dispose()

    $bannerH = Draw-MasterTopBanner -g $g -Title $Title -Subtitle $Subtitle -BadgeText $BadgeText -IsDarkTheme $false -ThemeHex $ThemeHex

    $viewTop = $bannerH + 15
    $viewH = 1080 - $viewTop - 25
    $scale = [Math]::Min(1800 / $src.Width, $viewH / $src.Height)
    $drawW = [int]($src.Width * $scale)
    $drawH = [int]($src.Height * $scale)
    $posX = [int]((1920 - $drawW) / 2)
    $posY = [int]($viewTop + ($viewH - $drawH) / 2)

    # Clean white container card
    $cardBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $cardPen = [System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)
    $g.FillRectangle($cardBrush, $posX - 8, $posY - 8, $drawW + 16, $drawH + 16)
    $g.DrawRectangle($cardPen, $posX - 8, $posY - 8, $drawW + 16, $drawH + 16)
    $cardBrush.Dispose()
    $cardPen.Dispose()

    $g.DrawImage($src, $posX, $posY, $drawW, $drawH)
    $src.Dispose()

    $g.Dispose()
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
}

# 4. TECHNICAL WAR ROOM / COMMAND CENTER (DARK TELEMETRY)
function Render-WarRoomDashboard {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$ThemeHex = "06B6D4"
    )
    Write-Host "Rendering War Room Dashboard: $OutputPath"
    $src = [System.Drawing.Image]::FromFile($SourcePath)
    $bmp = [System.Drawing.Bitmap]::new(1920, 1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $g.Clear([System.Drawing.ColorTranslator]::FromHtml("#0B0F19"))

    $viewTop = 210
    $viewH = 850
    $scale = [Math]::Min(1840 / $src.Width, $viewH / $src.Height)
    $drawW = [int]($src.Width * $scale)
    $drawH = [int]($src.Height * $scale)
    $posX = [int]((1920 - $drawW) / 2)
    $posY = [int]($viewTop + ($viewH - $drawH) / 2)

    $borderPen = [System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml("#1E293B"), 2)
    $g.DrawRectangle($borderPen, $posX - 4, $posY - 4, $drawW + 8, $drawH + 8)
    $borderPen.Dispose()

    $g.DrawImage($src, $posX, $posY, $drawW, $drawH)
    $src.Dispose()

    Draw-MasterTopBanner -g $g -Title $Title -Subtitle $Subtitle -BadgeText $BadgeText -BadgeColorHex $ThemeHex -IsDarkTheme $true

    $g.Dispose()
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
}

# ==============================================================================
# RENDER ALL 14 VISUALS WITH 40pt TITLE AT TOP
# ==============================================================================

# 1. PILLAR HUB
Render-3DIsometricScene `
    -SourcePath (Join-Path $brainDir "erode_digital_marketing_agency_1794632782497.jpg") `
    -OutputPath (Join-Path $baseDir "pillar-top-digital-marketing-company-strategies-for-growth\hero-image.jpg") `
    -Title "TOP DIGITAL MARKETING COMPANY: HOW TO DRIVE SUSTAINABLE GROWTH?" `
    -Subtitle "5 Architectural Growth Pillars: Technical SEO, Paid Media, Content Moats, CRO & Attribution" `
    -BadgeText "3D ISOMETRIC GROWTH ARCHITECTURE" `
    -AccentHex "38BDF8"

Render-2DVectorLight `
    -SourcePath (Join-Path $brainDir "agency_vs_vendor_comparison_1794632789313.jpg") `
    -OutputPath (Join-Path $baseDir "pillar-top-digital-marketing-company-strategies-for-growth\omnichannel-growth-engine.jpg") `
    -Title "THE OMNICHANNEL REVENUE GROWTH FLYWHEEL" `
    -Subtitle "Synchronizing Inbound Search, Precision Paid Acquisition, Platform CRO & Closed-Loop Attribution" `
    -BadgeText "2D VECTOR PROCESS FLYWHEEL" `
    -ThemeHex "059669"

# 2. BLOG 1 (Claude SMM)
Render-DarkFullBleed `
    -SourcePath (Join-Path $brainDir "modern_creator_smm_workspace_1794810623130.jpg") `
    -OutputPath (Join-Path $baseDir "blog-1-how-to-use-claude-for-social-media-marketing\hero-image.jpg") `
    -Title "HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS" `
    -Subtitle "Captions, Monthly Content Calendars, Creative Hooks, Audience Research & Repurposing" `
    -BadgeText "REALISTIC CREATOR STUDIO PHOTOGRAPHY" `
    -BadgeColorHex "F59E0B"

Render-2DVectorLight `
    -SourcePath (Join-Path $brainDir "claude_social_media_marketing_v3_1794808267777.jpg") `
    -OutputPath (Join-Path $baseDir "blog-1-how-to-use-claude-for-social-media-marketing\claude-social-workflow.jpg") `
    -Title "CLAUDE AI CONTENT REPURPOSING SPRINT PIPELINE" `
    -Subtitle "Decomposing Long-Form Video Transcripts & Podcasts into Platform-Ready Carousels & Threads" `
    -BadgeText "2D SPRINT WORKFLOW PIPELINE" `
    -ThemeHex "4F46E5"

# 3. BLOG 2 (AI Agents)
Render-3DIsometricScene `
    -SourcePath (Join-Path $brainDir "ai_agent_vs_traditional_chatbot_1794560973596.jpg") `
    -OutputPath (Join-Path $baseDir "blog-2-ai-agents-in-digital-marketing\hero-image.jpg") `
    -Title "AI AGENTS IN DIGITAL MARKETING: WHICH TASKS CAN YOU AUTOMATE?" `
    -Subtitle "Autonomous Market Surveillance, Dynamic Reporting, Inbound Routing & Micro-Budget Bidding" `
    -BadgeText "3D AUTONOMOUS CONTROL ROOM" `
    -AccentHex "64748B"

Render-2DVectorLight `
    -SourcePath (Join-Path $brainDir "ai_agent_architecture_diagram_1794554902676.jpg") `
    -OutputPath (Join-Path $baseDir "blog-2-ai-agents-in-digital-marketing\ai-agents-marketing-loop.jpg") `
    -Title "AUTONOMOUS MARKETING PERCEPTION-ACTION CLOSED LOOP" `
    -Subtitle "How AI Agents Detect Signal Shifts, Reason Multi-Step Goals & Call APIs Within Guardrails" `
    -BadgeText "2D SYSTEM ARCHITECTURE DIAGRAM" `
    -ThemeHex "059669"

# 4. BLOG 3 (FIFA World Cup 2026) - DISTINCT HERO & FRAMEWORK!
Render-DarkFullBleed `
    -SourcePath (Join-Path $brainDir "fifa_world_cup_2026_marketing_editorial_1794808222723.jpg") `
    -OutputPath (Join-Path $baseDir "blog-3-fifa-world-cup-2026-marketing-campaigns\hero-image.jpg") `
    -Title "FIFA WORLD CUP 2026 MARKETING CAMPAIGNS: 5 SMART MOVES" `
    -Subtitle "Host-City Co-Creation, Sub-90-Second Agile Ads, Local AR Filters & Frictionless Commerce" `
    -BadgeText "CINEMATIC LIVE STADIUM PHOTOGRAPHY" `
    -BadgeColorHex "EF4444"

Render-WarRoomDashboard `
    -SourcePath (Join-Path $brainDir "fifa_2026_omnichannel_activation_command_center_1794810042994.jpg") `
    -OutputPath (Join-Path $baseDir "blog-3-fifa-world-cup-2026-marketing-campaigns\world-cup-marketing-framework.jpg") `
    -Title "OMNICHANNEL TOURNAMENT FAN ACTIVATION COMMAND CENTER" `
    -Subtitle "Connecting In-Stadium Live Emotion with Second-Screen Feeds & Instant Mobile Conversions" `
    -BadgeText "3D SPORTS MARKETING WAR ROOM" `
    -ThemeHex "38BDF8"

# 5. BLOG 4 (Google E-E-A-T)
Render-2DVectorLight `
    -SourcePath (Join-Path $brainDir "google_eeat_seo_trust_editorial_1794808252841.jpg") `
    -OutputPath (Join-Path $baseDir "blog-4-what-is-google-e-e-a-t\hero-image.jpg") `
    -Title "WHAT IS GOOGLE E-E-A-T? WHY IT MATTERS FOR SEO TRUST" `
    -Subtitle "Experience, Expertise, Authoritativeness & Trust: How Quality Evaluators Audit Digital Credibility" `
    -BadgeText "2D SEARCH QUALITY AUDITOR ILLUSTRATION" `
    -ThemeHex "1E40AF"

Render-3DIsometricScene `
    -SourcePath (Join-Path $brainDir "google_eeat_seo_trust_shield_1794808230818.jpg") `
    -OutputPath (Join-Path $baseDir "blog-4-what-is-google-e-e-a-t\google-eeat-pillars-framework.jpg") `
    -Title "THE 4 STRUCTURAL PILLARS OF GOOGLE E-E-A-T SEARCH TRUST" `
    -Subtitle "Defensible Author Entities, Peer Citations & Transparent Security Anchoring Site Authority" `
    -BadgeText "3D CRYSTAL TRUST SHIELD" `
    -AccentHex "10B981"

# 6. BLOG 5 (AI-Generated Images)
Render-DarkFullBleed `
    -SourcePath (Join-Path $brainDir "ai_generated_images_marketers_guide_1794808242160.jpg") `
    -OutputPath (Join-Path $baseDir "blog-5-ai-generated-images-viral-marketers\hero-image.jpg") `
    -Title "AI-GENERATED IMAGES ARE GOING VIRAL: WHAT TO KNOW" `
    -Subtitle "Commercial Copyright Realities, Brand Authenticity Dilution, Quality Artifacts & Disclosure" `
    -BadgeText "STUDIO PHOTOGRAPHY VS SYNTHETIC AI" `
    -BadgeColorHex "8B5CF6"

Render-2DVectorLight `
    -SourcePath (Join-Path $brainDir "ai_marketing_governance_framework_1794810026062.jpg") `
    -OutputPath (Join-Path $baseDir "blog-5-ai-generated-images-viral-marketers\ai-image-governance-framework.jpg") `
    -Title "CORPORATE BRAND INTEGRITY & AI IMAGE GOVERNANCE FRAMEWORK" `
    -Subtitle "4-Stage Review Protocol: Ideation, Legal IP Audit, Human Art Direction & Transparent Release" `
    -BadgeText "2D GOVERNANCE DECISION FLOWCHART" `
    -ThemeHex "D97706"

# 7. BLOG 6 (PPC Trends 2027)
Render-3DIsometricScene `
    -SourcePath (Join-Path $brainDir "ppc_trends_2027_editorial_hero_v2_1794808271894.jpg") `
    -OutputPath (Join-Path $baseDir "blog-6-top-ppc-trends-of-2027\hero-image.jpg") `
    -Title "TOP PPC TRENDS OF 2027: 7 CHANGES TO PREPARE FOR" `
    -Subtitle "Conversational Query Ads, Predictive LTV Bidding, Clean First-Party Vaults & Incrementality Testing" `
    -BadgeText "3D NEURAL BIDDING CONTROL ROOM" `
    -AccentHex "38BDF8"

Render-2DVectorLight `
    -SourcePath (Join-Path $brainDir "ppc_ai_campaign_ecosystem_2027_1794828075756.jpg") `
    -OutputPath (Join-Path $baseDir "blog-6-top-ppc-trends-of-2027\ppc-2027-ecosystem-architecture.jpg") `
    -Title "THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM" `
    -Subtitle "How Machine Learning Connects First-Party Signal Vaults to Dynamic Real-Time Ad Assembly" `
    -BadgeText "2D AI-POWERED PPC CAMPAIGN ECOSYSTEM" `
    -ThemeHex "4F46E5"

Write-Host "`n=========================================================================="
Write-Host "SUCCESS: ALL 14 IMAGES RENDERED WITH LARGE 40pt TITLES AT THE TOP!"
Write-Host "=========================================================================="
