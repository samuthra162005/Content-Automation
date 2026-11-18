Add-Type -AssemblyName System.Drawing

$brainDir = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78"
$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16"

# ==============================================================================
# VISUAL FORMAT A: FULL-BLEED CINEMATIC PHOTOGRAPHY
# Image fills 1920x1080 canvas; smooth dark gradient lower-third with crisp white title
# ==============================================================================
function Render-FormatA-Cinematic {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$BadgeColorHex = "F59E0B" # Amber/Gold
    )
    Write-Host "Rendering Format A (Cinematic Photo): $OutputPath"
    $src = [System.Drawing.Image]::FromFile($SourcePath)
    $bmp = [System.Drawing.Bitmap]::new(1920, 1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Draw full-bleed scaled image (cover)
    $scale = [Math]::Max(1920 / $src.Width, 1080 / $src.Height)
    $drawW = [int]($src.Width * $scale)
    $drawH = [int]($src.Height * $scale)
    $offsetX = [int]((1920 - $drawW) / 2)
    $offsetY = [int]((1080 - $drawH) / 2)
    $g.DrawImage($src, $offsetX, $offsetY, $drawW, $drawH)
    $src.Dispose()

    # Draw smooth dark gradient over bottom 280px
    $gradBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.Point]::new(0, 800),
        [System.Drawing.Point]::new(0, 1080),
        [System.Drawing.Color]::FromArgb(0, 10, 15, 29),
        [System.Drawing.Color]::FromArgb(235, 10, 15, 29)
    )
    $g.FillRectangle($gradBrush, 0, 800, 1920, 280)
    $gradBrush.Dispose()

    # Category Pill
    $bColor = [System.Drawing.ColorTranslator]::FromHtml("#$BadgeColorHex")
    $bBrush = [System.Drawing.SolidBrush]::new($bColor)
    $bFont = [System.Drawing.Font]::new("Segoe UI", [float]11, [System.Drawing.FontStyle]::Bold)
    $g.DrawString($BadgeText.ToUpper(), $bFont, $bBrush, 60, 860)
    $bBrush.Dispose()
    $bFont.Dispose()

    # Title
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]34, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $g.DrawString($Title, $titleFont, $titleBrush, 60, 890)
    $titleFont.Dispose()
    $titleBrush.Dispose()

    # Subtitle
    $subFont = [System.Drawing.Font]::new("Segoe UI", [float]16, [System.Drawing.FontStyle]::Regular)
    $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(203, 213, 225)) # Slate 300
    $g.DrawString($Subtitle, $subFont, $subBrush, 60, 945)
    $subFont.Dispose()
    $subBrush.Dispose()

    $g.Dispose()
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
}

# ==============================================================================
# VISUAL FORMAT B: 3D ISOMETRIC & CRYSTAL HOLOGRAPHIC
# Rich dark gradient canvas (#0B132B), glowing 3D depth, top-right badge, futuristic
# ==============================================================================
function Render-FormatB-3DIsometric {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$AccentHex = "38BDF8" # Sky Blue
    )
    Write-Host "Rendering Format B (3D Isometric): $OutputPath"
    $src = [System.Drawing.Image]::FromFile($SourcePath)
    $bmp = [System.Drawing.Bitmap]::new(1920, 1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Dark cyber canvas gradient
    $bgBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.Point]::new(0, 0),
        [System.Drawing.Point]::new(0, 1080),
        [System.Drawing.ColorTranslator]::FromHtml("#0B132B"),
        [System.Drawing.ColorTranslator]::FromHtml("#1C2541")
    )
    $g.FillRectangle($bgBrush, 0, 0, 1920, 1080)
    $bgBrush.Dispose()

    # Draw 3D Illustration centered with ambient glow frame
    $availW = 1800
    $availH = 880
    $scale = [Math]::Min($availW / $src.Width, $availH / $src.Height)
    $drawW = [int]($src.Width * $scale)
    $drawH = [int]($src.Height * $scale)
    $posX = [int]((1920 - $drawW) / 2)
    $posY = 50

    # Soft ambient glow behind 3D render
    $accentColor = [System.Drawing.ColorTranslator]::FromHtml("#$AccentHex")
    $pen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(60, $accentColor.R, $accentColor.G, $accentColor.B), 2)
    $g.DrawRectangle($pen, $posX - 4, $posY - 4, $drawW + 8, $drawH + 8)
    $pen.Dispose()

    $g.DrawImage($src, $posX, $posY, $drawW, $drawH)
    $src.Dispose()

    # Bottom Sleek Dark Glass Bar
    $barBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(240, 11, 19, 43))
    $g.FillRectangle($barBrush, 0, 940, 1920, 140)
    $barBrush.Dispose()

    # Top accent line
    $lineBrush = [System.Drawing.SolidBrush]::new($accentColor)
    $g.FillRectangle($lineBrush, 0, 938, 1920, 3)
    $lineBrush.Dispose()

    # Category Badge Pill
    $bBrush = [System.Drawing.SolidBrush]::new($accentColor)
    $bFont = [System.Drawing.Font]::new("Segoe UI", [float]10, [System.Drawing.FontStyle]::Bold)
    $g.DrawString($BadgeText.ToUpper(), $bFont, $bBrush, 60, 955)
    $bBrush.Dispose()
    $bFont.Dispose()

    # Title
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]26, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $g.DrawString($Title, $titleFont, $titleBrush, 60, 980)
    $titleFont.Dispose()
    $titleBrush.Dispose()

    # Subtitle
    $subFont = [System.Drawing.Font]::new("Segoe UI", [float]15, [System.Drawing.FontStyle]::Regular)
    $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(148, 163, 184))
    $g.DrawString($Subtitle, $subFont, $subBrush, 60, 1025)
    $subFont.Dispose()
    $subBrush.Dispose()

    $g.Dispose()
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
}

# ==============================================================================
# VISUAL FORMAT C: 2D VECTOR INFOGRAPHIC / PIPELINE
# Crisp high-contrast editorial canvas (#F8FAFC), vector cards, clean top typography
# ==============================================================================
function Render-FormatC-2DVector {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$ThemeHex = "059669" # Emerald
    )
    Write-Host "Rendering Format C (2D Vector): $OutputPath"
    $src = [System.Drawing.Image]::FromFile($SourcePath)
    $bmp = [System.Drawing.Bitmap]::new(1920, 1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Crisp background
    $g.Clear([System.Drawing.ColorTranslator]::FromHtml("#F8FAFC"))

    # Left colored vertical accent indicator
    $themeColor = [System.Drawing.ColorTranslator]::FromHtml("#$ThemeHex")
    $accentBrush = [System.Drawing.SolidBrush]::new($themeColor)
    $g.FillRectangle($accentBrush, 0, 0, 12, 1080)
    $accentBrush.Dispose()

    # Top Header area
    $bFont = [System.Drawing.Font]::new("Segoe UI", [float]11, [System.Drawing.FontStyle]::Bold)
    $bBrush = [System.Drawing.SolidBrush]::new($themeColor)
    $g.DrawString($BadgeText.ToUpper(), $bFont, $bBrush, 60, 30)
    $bFont.Dispose()
    $bBrush.Dispose()

    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]32, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#0F172A"))
    $g.DrawString($Title, $titleFont, $titleBrush, 60, 60)
    $titleFont.Dispose()
    $titleBrush.Dispose()

    $subFont = [System.Drawing.Font]::new("Segoe UI", [float]16, [System.Drawing.FontStyle]::Bold)
    $subBrush = [System.Drawing.SolidBrush]::new($themeColor)
    $g.DrawString($Subtitle, $subFont, $subBrush, 60, 110)
    $subFont.Dispose()
    $subBrush.Dispose()

    # Draw 2D Vector diagram in clean framed card
    $availW = 1800
    $availH = 880
    $scale = [Math]::Min($availW / $src.Width, $availH / $src.Height)
    $drawW = [int]($src.Width * $scale)
    $drawH = [int]($src.Height * $scale)
    $posX = [int]((1920 - $drawW) / 2)
    $posY = 160

    # Subtle card shadow
    $shadowBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(20, 0, 0, 0))
    $g.FillRectangle($shadowBrush, $posX + 4, $posY + 4, $drawW, $drawH)
    $shadowBrush.Dispose()

    $cardBorder = [System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 2)
    $g.DrawRectangle($cardBorder, $posX, $posY, $drawW, $drawH)
    $cardBorder.Dispose()

    $g.DrawImage($src, $posX, $posY, $drawW, $drawH)
    $src.Dispose()

    $g.Dispose()
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
}

# ==============================================================================
# VISUAL FORMAT D: SPLIT-SCREEN COMPARISON & TELEMETRY LAB
# Dual card aesthetic, dark header, high contrast analysis panels
# ==============================================================================
function Render-FormatD-SplitScreen {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$ThemeHex = "7C3AED" # Violet
    )
    Write-Host "Rendering Format D (Split-Screen / Telemetry Lab): $OutputPath"
    $src = [System.Drawing.Image]::FromFile($SourcePath)
    $bmp = [System.Drawing.Bitmap]::new(1920, 1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Neutral high-tech background
    $g.Clear([System.Drawing.ColorTranslator]::FromHtml("#0F172A"))

    # Draw illustration scaled
    $availW = 1820
    $availH = 880
    $scale = [Math]::Min($availW / $src.Width, $availH / $src.Height)
    $drawW = [int]($src.Width * $scale)
    $drawH = [int]($src.Height * $scale)
    $posX = [int]((1920 - $drawW) / 2)
    $posY = 40

    $g.DrawImage($src, $posX, $posY, $drawW, $drawH)
    $src.Dispose()

    # Bottom Telemetry Bar
    $barBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(235, 15, 23, 42))
    $g.FillRectangle($barBrush, 0, 940, 1920, 140)
    $barBrush.Dispose()

    $themeColor = [System.Drawing.ColorTranslator]::FromHtml("#$ThemeHex")
    $lineBrush = [System.Drawing.SolidBrush]::new($themeColor)
    $g.FillRectangle($lineBrush, 0, 938, 1920, 3)
    $lineBrush.Dispose()

    # Category Pill
    $bBrush = [System.Drawing.SolidBrush]::new($themeColor)
    $bFont = [System.Drawing.Font]::new("Segoe UI", [float]11, [System.Drawing.FontStyle]::Bold)
    $g.DrawString($BadgeText.ToUpper(), $bFont, $bBrush, 60, 955)
    $bBrush.Dispose()
    $bFont.Dispose()

    # Title
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]28, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $g.DrawString($Title, $titleFont, $titleBrush, 60, 980)
    $titleFont.Dispose()
    $titleBrush.Dispose()

    # Subtitle
    $subFont = [System.Drawing.Font]::new("Segoe UI", [float]15, [System.Drawing.FontStyle]::Regular)
    $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(148, 163, 184))
    $g.DrawString($Subtitle, $subFont, $subBrush, 60, 1025)
    $subFont.Dispose()
    $subBrush.Dispose()

    $g.Dispose()
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
}

# ==============================================================================
# EXECUTE BESPOKE 2D, 3D & CINEMATIC RENDERING FOR ALL 14 IMAGES
# ==============================================================================

# 1. PILLAR
Render-FormatB-3DIsometric `
    -SourcePath (Join-Path $brainDir "erode_digital_marketing_agency_1794632782497.jpg") `
    -OutputPath (Join-Path $baseDir "pillar-top-digital-marketing-company-strategies-for-growth\hero-image.jpg") `
    -Title "TOP DIGITAL MARKETING COMPANY: HOW TO DRIVE SUSTAINABLE GROWTH?" `
    -Subtitle "5 Architectural Growth Pillars: Technical SEO, Paid Media, Content Moats, CRO and Attribution" `
    -BadgeText "3D ISOMETRIC GROWTH ARCHITECTURE" `
    -AccentHex "38BDF8"

Render-FormatC-2DVector `
    -SourcePath (Join-Path $brainDir "agency_vs_vendor_comparison_1794632789313.jpg") `
    -OutputPath (Join-Path $baseDir "pillar-top-digital-marketing-company-strategies-for-growth\omnichannel-growth-engine.jpg") `
    -Title "THE OMNICHANNEL REVENUE GROWTH FLYWHEEL" `
    -Subtitle "Synchronizing Inbound Search, Precision Paid Acquisition, Platform CRO and Closed-Loop Attribution" `
    -BadgeText "2D VECTOR PROCESS FLYWHEEL" `
    -ThemeHex "059669"

# 2. BLOG 1 (Claude SMM)
Render-FormatA-Cinematic `
    -SourcePath (Join-Path $brainDir "modern_creator_smm_workspace_1794810623130.jpg") `
    -OutputPath (Join-Path $baseDir "blog-1-how-to-use-claude-for-social-media-marketing\hero-image.jpg") `
    -Title "HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS?" `
    -Subtitle "Captions, Monthly Content Calendars, Creative Hooks, Audience Research and Repurposing" `
    -BadgeText "REALISTIC CREATOR STUDIO PHOTOGRAPHY" `
    -BadgeColorHex "F59E0B"

Render-FormatC-2DVector `
    -SourcePath (Join-Path $brainDir "claude_social_media_marketing_v3_1794808267777.jpg") `
    -OutputPath (Join-Path $baseDir "blog-1-how-to-use-claude-for-social-media-marketing\claude-social-workflow.jpg") `
    -Title "CLAUDE AI CONTENT REPURPOSING SPRINT PIPELINE" `
    -Subtitle "Decomposing Long-Form Video Transcripts and Podcasts into Platform-Ready Carousels and Threads" `
    -BadgeText "2D SPRINT WORKFLOW PIPELINE" `
    -ThemeHex "4F46E5"

# 3. BLOG 2 (AI Agents)
Render-FormatB-3DIsometric `
    -SourcePath (Join-Path $brainDir "ai_agent_vs_traditional_chatbot_1794560973596.jpg") `
    -OutputPath (Join-Path $baseDir "blog-2-ai-agents-in-digital-marketing\hero-image.jpg") `
    -Title "AI AGENTS IN DIGITAL MARKETING: WHICH TASKS CAN YOU AUTOMATE?" `
    -Subtitle "Autonomous Market Surveillance, Dynamic Reporting, Inbound Routing and Micro-Budget Bidding" `
    -BadgeText "3D AUTONOMOUS CONTROL ROOM" `
    -AccentHex "64748B"

Render-FormatC-2DVector `
    -SourcePath (Join-Path $brainDir "ai_agent_architecture_diagram_1794554902676.jpg") `
    -OutputPath (Join-Path $baseDir "blog-2-ai-agents-in-digital-marketing\ai-agents-marketing-loop.jpg") `
    -Title "AUTONOMOUS MARKETING PERCEPTION-ACTION CLOSED LOOP" `
    -Subtitle "How AI Agents Detect Signal Shifts, Reason Multi-Step Goals and Call APIs Within Guardrails" `
    -BadgeText "2D SYSTEM ARCHITECTURE DIAGRAM" `
    -ThemeHex "059669"

# 4. BLOG 3 (FIFA World Cup 2026)
Render-FormatA-Cinematic `
    -SourcePath (Join-Path $brainDir "fifa_world_cup_2026_marketing_editorial_1794808222723.jpg") `
    -OutputPath (Join-Path $baseDir "blog-3-fifa-world-cup-2026-marketing-campaigns\hero-image.jpg") `
    -Title "FIFA WORLD CUP 2026 MARKETING CAMPAIGNS: HOW DID BRANDS WIN ATTENTION?" `
    -Subtitle "5 Strategic Moves: Host-City Co-Creation, 90-Second Agile Newsrooms, AR Filters and Flash Commerce" `
    -BadgeText "CINEMATIC LIVE STADIUM PHOTOGRAPHY" `
    -BadgeColorHex "EF4444"

Render-FormatD-SplitScreen `
    -SourcePath (Join-Path $brainDir "fifa_2026_omnichannel_activation_command_center_1794810042994.jpg") `
    -OutputPath (Join-Path $baseDir "blog-3-fifa-world-cup-2026-marketing-campaigns\world-cup-marketing-framework.jpg") `
    -Title "OMNICHANNEL TOURNAMENT FAN ACTIVATION COMMAND CENTER" `
    -Subtitle "Connecting In-Stadium Live Emotion with Second-Screen Feeds and Instant Mobile Conversions" `
    -BadgeText "3D SPORTS MARKETING WAR ROOM" `
    -ThemeHex "38BDF8"

# 5. BLOG 4 (Google E-E-A-T)
Render-FormatC-2DVector `
    -SourcePath (Join-Path $brainDir "google_eeat_seo_trust_editorial_1794808252841.jpg") `
    -OutputPath (Join-Path $baseDir "blog-4-what-is-google-e-e-a-t\hero-image.jpg") `
    -Title "WHAT IS GOOGLE E-E-A-T AND WHY DOES IT MATTER FOR WEBSITE TRUST?" `
    -Subtitle "Experience, Expertise, Authoritativeness and Trust: How Quality Evaluators Audit Digital Credibility" `
    -BadgeText "2D SEARCH QUALITY AUDITOR ILLUSTRATION" `
    -ThemeHex "1E40AF"

Render-FormatB-3DIsometric `
    -SourcePath (Join-Path $brainDir "google_eeat_seo_trust_shield_1794808230818.jpg") `
    -OutputPath (Join-Path $baseDir "blog-4-what-is-google-e-e-a-t\google-eeat-pillars-framework.jpg") `
    -Title "THE 4 STRUCTURAL PILLARS OF GOOGLE E-E-A-T SEARCH TRUST" `
    -Subtitle "Defensible Author Entities, Peer Citations and Transparent Security Anchoring Site Authority" `
    -BadgeText "3D CRYSTAL TRUST SHIELD" `
    -AccentHex "10B981"

# 6. BLOG 5 (AI-Generated Images)
Render-FormatD-SplitScreen `
    -SourcePath (Join-Path $brainDir "ai_generated_images_marketers_guide_1794808242160.jpg") `
    -OutputPath (Join-Path $baseDir "blog-5-ai-generated-images-viral-marketers\hero-image.jpg") `
    -Title "AI-GENERATED IMAGES ARE GOING VIRAL: WHAT MUST MARKETERS KNOW?" `
    -Subtitle "Commercial Copyright Realities, Brand Authenticity Dilution, Quality Artifacts and Ethical Disclosure" `
    -BadgeText "STUDIO PHOTOGRAPHY VS SYNTHETIC AI" `
    -ThemeHex "8B5CF6"

Render-FormatC-2DVector `
    -SourcePath (Join-Path $brainDir "ai_marketing_governance_framework_1794810026062.jpg") `
    -OutputPath (Join-Path $baseDir "blog-5-ai-generated-images-viral-marketers\ai-image-governance-framework.jpg") `
    -Title "CORPORATE BRAND INTEGRITY AND AI IMAGE GOVERNANCE FRAMEWORK" `
    -Subtitle "4-Stage Review Protocol: Ideation, Legal IP Audit, Human Art Direction and Transparent Release" `
    -BadgeText "2D GOVERNANCE DECISION FLOWCHART" `
    -ThemeHex "D97706"

# 7. BLOG 6 (PPC Trends 2027)
Render-FormatB-3DIsometric `
    -SourcePath (Join-Path $brainDir "ppc_trends_2027_editorial_hero_v2_1794808271894.jpg") `
    -OutputPath (Join-Path $baseDir "blog-6-top-ppc-trends-of-2027\hero-image.jpg") `
    -Title "TOP PPC TRENDS OF 2027: 7 CHANGES MARKETERS MUST PREPARE FOR?" `
    -Subtitle "Conversational Query Ads, Predictive LTV Bidding, Clean First-Party Vaults and Incrementality Testing" `
    -BadgeText "3D NEURAL BIDDING CONTROL ROOM" `
    -AccentHex "38BDF8"

Render-FormatC-2DVector `
    -SourcePath (Join-Path $brainDir "cloudflare_pages_deployment_flow_v2_1794554014614.jpg") `
    -OutputPath (Join-Path $baseDir "blog-6-top-ppc-trends-of-2027\ppc-2027-ecosystem-architecture.jpg") `
    -Title "THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM" `
    -Subtitle "How Machine Learning Connects First-Party Signal Vaults to Dynamic Real-Time Ad Assembly" `
    -BadgeText "2D SERVER-SIDE DATA ARCHITECTURE" `
    -ThemeHex "475569"

Write-Host "ALL 14 BESPOKE 2D, 3D & CINEMATIC VISUALS SUCCESSFULLY GENERATED!"

