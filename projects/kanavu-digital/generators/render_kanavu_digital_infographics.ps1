<#
.SYNOPSIS
    Generates high-resolution 1920x1080 (16:9) infographics for Kanavu Digital Marketing:
    1. hero-image.jpg (4 Essential Pillars of Digital Marketing Agency Selection)
    2. agency-comparison-matrix.jpg (Results-Driven Agency vs Traditional Advertising Vendor)
#>

Add-Type -AssemblyName System.Drawing

$targetDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-14\best-digital-marketing-agency-erode-kanavu-digital"

if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
}

function Add-RoundedRectangle($path, $x, $y, $w, $h, $r) {
    $d = $r * 2
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
}

# ==============================================================================
# INFOGRAPHIC 1: 4 Essential Pillars of Digital Marketing (hero-image.jpg)
# ==============================================================================
Write-Host "[KANAVU DIGITAL] Generating Figure 1: hero-image.jpg..."

$bmp1 = [System.Drawing.Bitmap]::new(1920, 1080)
$g1 = [System.Drawing.Graphics]::FromImage($bmp1)
$g1.Clear([System.Drawing.Color]::FromArgb(255, 255, 255)) # Pure white canvas
$g1.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g1.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g1.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g1.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Header Typography
$fTitle = [System.Drawing.Font]::new("Segoe UI", 40, [System.Drawing.FontStyle]::Bold)
$fSub = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Regular)
$bTitle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Slate 900
$bSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(26, 115, 232)) # Google Blue

$sfCenter = [System.Drawing.StringFormat]::new()
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
$sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

$g1.DrawString("SELECTING A DIGITAL MARKETING AGENCY IN ERODE", $fTitle, $bTitle, [System.Drawing.RectangleF]::new(40, 35, 1840, 60), $sfCenter)
$g1.DrawString("4 Essential Pillars: Local SEO, Paid Media, Conversion UX & ROI Analytics", $fSub, $bSub, [System.Drawing.RectangleF]::new(40, 100, 1840, 40), $sfCenter)

# 4 Cards Layout
$cardW = 430
$cardH = 790
$cardY = 170
$gap = 26
$startX = 50

$cards = @(
    @{
        Title = "Localized Technical SEO"
        Badge = "LOCAL SEARCH VISIBILITY"
        Color = [System.Drawing.Color]::FromArgb(26, 115, 232) # Google Blue
        Bg = [System.Drawing.Color]::FromArgb(240, 246, 255)
        Points = @(
            "Google Business Profile optimization",
            "High-authority regional NAP citations",
            "Local schema markup for Tamil Nadu",
            "High-intent 'Near Me' search capture",
            "Targets: Textiles, hospitals & retail"
        )
    },
    @{
        Title = "Intent-Driven Paid Media"
        Badge = "PERFORMANCE PPC"
        Color = [System.Drawing.Color]::FromArgb(234, 67, 53)  # Red
        Bg = [System.Drawing.Color]::FromArgb(254, 242, 242)
        Points = @(
            "High-intent Google Search keyword bidding",
            "Precision Meta B2B audience targeting",
            "Aggressive negative keyword filtering",
            "Direct B2B WhatsApp inquiry routing",
            "Targets: Lower acquisition costs"
        )
    },
    @{
        Title = "Conversion-Focused UX"
        Badge = "LANDING PAGE SPEED"
        Color = [System.Drawing.Color]::FromArgb(52, 168, 83)  # Emerald
        Bg = [System.Drawing.Color]::FromArgb(240, 253, 244)
        Points = @(
            "Sub-second mobile loading speeds",
            "Frictionless click-to-call enquiry buttons",
            "Google Helpful Content architecture",
            "Verified regional trust badges & proofs",
            "Targets: 2x to 4x visitor lead conversion"
        )
    },
    @{
        Title = "Multi-Touch ROI Analytics"
        Badge = "CLOSED-LOOP ATTRIBUTION"
        Color = [System.Drawing.Color]::FromArgb(147, 51, 234) # Purple
        Bg = [System.Drawing.Color]::FromArgb(250, 245, 255)
        Points = @(
            "24/7 transparent analytics dashboard",
            "Dynamic phone call & form tracking",
            "Closed-loop CAC and ROAS metrics",
            "Zero fabricated vanity impressions",
            "Targets: Verifiable revenue growth"
        )
    }
)

for ($i = 0; $i -lt $cards.Count; $i++) {
    $c = $cards[$i]
    $x = $startX + ($i * ($cardW + $gap))
    
    # Card Container
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $path $x $cardY $cardW $cardH 20
    
    $bBg = [System.Drawing.SolidBrush]::new($c.Bg)
    $g1.FillPath($bBg, $path)
    
    $pBorder = [System.Drawing.Pen]::new($c.Color, 3)
    $g1.DrawPath($pBorder, $path)
    
    # Top Accent Strip
    $pathStrip = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $d = 40
    $pathStrip.AddArc($x, $cardY, $d, $d, 180, 90)
    $pathStrip.AddArc($x + $cardW - $d, $cardY, $d, $d, 270, 90)
    $pathStrip.AddLine($x + $cardW, $cardY + 16, $x, $cardY + 16)
    $pathStrip.CloseFigure()
    $bStrip = [System.Drawing.SolidBrush]::new($c.Color)
    $g1.FillPath($bStrip, $pathStrip)
    
    # Badge Pill
    $bW = 280
    $bH = 34
    $bX = $x + ($cardW - $bW) / 2
    $bY = $cardY + 36
    $pathBadge = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathBadge $bX $bY $bW $bH 17
    $g1.FillPath($bStrip, $pathBadge)
    
    $fBadge = [System.Drawing.Font]::new("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
    $bWhite = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $g1.DrawString($c.Badge, $fBadge, $bWhite, [System.Drawing.RectangleF]::new($bX, $bY, $bW, $bH), $sfCenter)
    
    # Card Title
    $fCTitle = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)
    $bCTitle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
    $g1.DrawString($c.Title, $fCTitle, $bCTitle, [System.Drawing.RectangleF]::new($x + 15, $cardY + 88, $cardW - 30, 60), $sfCenter)
    
    # Horizontal Divider Line
    $pDiv = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 1.5)
    $g1.DrawLine($pDiv, $x + 30, $cardY + 160, $x + $cardW - 30, $cardY + 160)
    
    # Points
    $ptY = $cardY + 185
    $fPt = [System.Drawing.Font]::new("Segoe UI", 13, [System.Drawing.FontStyle]::Regular)
    $bPt = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(51, 65, 85))
    
    $sfLeft = [System.Drawing.StringFormat]::new()
    $sfLeft.Alignment = [System.Drawing.StringAlignment]::Near
    $sfLeft.LineAlignment = [System.Drawing.StringAlignment]::Center
    
    foreach ($pt in $c.Points) {
        # Bullet circle
        $bBullet = [System.Drawing.SolidBrush]::new($c.Color)
        $g1.FillEllipse($bBullet, $x + 28, $ptY + 8, 14, 14)
        
        # Checkmark / Inner Dot
        $g1.FillEllipse($bWhite, $x + 32, $ptY + 12, 6, 6)
        
        # Text
        $rectText = [System.Drawing.RectangleF]::new($x + 54, $ptY, $cardW - 75, 78)
        $g1.DrawString($pt, $fPt, $bPt, $rectText, $sfLeft)
        
        $ptY += 88
    }
    
    # Bottom Verified Badge Tag
    $tagH = 40
    $tagY = $cardY + $cardH - 58
    $tagW = $cardW - 60
    $tagX = $x + 30
    $pathTag = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathTag $tagX $tagY $tagW $tagH 10
    $bTag = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 255, 255))
    $g1.FillPath($bTag, $pathTag)
    $pTag = [System.Drawing.Pen]::new($c.Color, 1.5)
    $g1.DrawPath($pTag, $pathTag)
    
    $fTag = [System.Drawing.Font]::new("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
    $bTagText = [System.Drawing.SolidBrush]::new($c.Color)
    $g1.DrawString("Verified ROI Discipline", $fTag, $bTagText, [System.Drawing.RectangleF]::new($tagX, $tagY, $tagW, $tagH), $sfCenter)
}

# Footer Attribution
$fFoot = [System.Drawing.Font]::new("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)
$bFoot = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(100, 116, 139))
$g1.DrawString("KANAVU DIGITAL MARKETING • EVIDENCE-BASED SEARCH & PERFORMANCE MARKETING • ERODE, TN", $fFoot, $bFoot, [System.Drawing.RectangleF]::new(40, 1010, 1840, 30), $sfCenter)

$outputPath1 = Join-Path $targetDir "hero-image.jpg"
$bmp1.Save($outputPath1, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g1.Dispose()
$bmp1.Dispose()
Write-Host "[KANAVU DIGITAL] Figure 1 saved successfully: $outputPath1"

# ==============================================================================
# INFOGRAPHIC 2: Comparison Matrix (agency-comparison-matrix.jpg)
# ==============================================================================
Write-Host "[KANAVU DIGITAL] Generating Figure 2: agency-comparison-matrix.jpg..."

$bmp2 = [System.Drawing.Bitmap]::new(1920, 1080)
$g2 = [System.Drawing.Graphics]::FromImage($bmp2)
$g2.Clear([System.Drawing.Color]::FromArgb(255, 255, 255)) # Pure white canvas
$g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g2.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g2.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g2.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Header Typography
$fTitle2 = [System.Drawing.Font]::new("Segoe UI", 38, [System.Drawing.FontStyle]::Bold)
$fSub2 = [System.Drawing.Font]::new("Segoe UI", 19, [System.Drawing.FontStyle]::Regular)
$bSub2 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(16, 185, 129)) # Emerald

$g2.DrawString("RESULTS-DRIVEN AGENCY VS TRADITIONAL MARKETING VENDOR", $fTitle2, $bTitle, [System.Drawing.RectangleF]::new(40, 32, 1840, 58), $sfCenter)
$g2.DrawString("Key Strategic Differences in Attribution, Technical SEO, Transparency & Business Growth", $fSub2, $bSub2, [System.Drawing.RectangleF]::new(40, 94, 1840, 38), $sfCenter)

# Table Geometry
$tblX = 60
$tblY = 160
$tblW = 1800
$col1W = 380  # Metric Column
$col2W = 710  # Results-Driven Agency Column
$col3W = 710  # Traditional Vendor Column

# Table Column Header Coordinates
$col1X = $tblX
$col2X = $tblX + $col1W
$col3X = $tblX + $col1W + $col2W

# Header Row
$hH = 70
$pathH1 = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pathH1 $col1X $tblY ($col1W - 10) $hH 12
$bH1 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
$g2.FillPath($bH1, $pathH1)

$pathH2 = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pathH2 $col2X $tblY ($col2W - 10) $hH 12
$bH2 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(5, 150, 105)) # Emerald Green
$g2.FillPath($bH2, $pathH2)

$pathH3 = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pathH3 $col3X $tblY ($col3W - 10) $hH 12
$bH3 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(71, 85, 105)) # Slate 600
$g2.FillPath($bH3, $pathH3)

$fHdr = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$g2.DrawString("EVALUATION CRITERIA", $fHdr, $bWhite, [System.Drawing.RectangleF]::new($col1X, $tblY, $col1W - 10, $hH), $sfCenter)
$g2.DrawString("RESULTS-DRIVEN AGENCY (KANAVU STANDARD)", $fHdr, $bWhite, [System.Drawing.RectangleF]::new($col2X, $tblY, $col2W - 10, $hH), $sfCenter)
$g2.DrawString("TRADITIONAL ADVERTISING VENDOR", $fHdr, $bWhite, [System.Drawing.RectangleF]::new($col3X, $tblY, $col3W - 10, $hH), $sfCenter)

# Comparison Data Rows
$rows = @(
    @{
        Metric = "Search Engine Strategy"
        MetricSub = "Google Visibility & SEO"
        Agency = "Comprehensive technical SEO, localized schema markup, Core Web Vitals optimization, and long-term organic authority building."
        Vendor = "Speculative keyword stuffing, unindexed static web pages, or no organic search presence beyond a basic business name search."
    },
    @{
        Metric = "Performance Attribution"
        MetricSub = "Lead & Revenue Tracking"
        Agency = "Real-time multi-touch attribution, dynamic call tracking, closed-loop lead logging, and verified ROAS analytics dashboards."
        Vendor = "Superficial vanity metrics (likes, impressions, follower counts) with zero sales pipeline visibility or revenue accountability."
    },
    @{
        Metric = "Campaign Customization"
        MetricSub = "Industry Relevance"
        Agency = "Tailored commercial funnels engineered specifically for Erode textiles, healthcare clinics, retail, and manufacturing sectors."
        Vendor = "One-size-fits-all generic templates and generic festival greeting posters with zero targeted commercial messaging."
    },
    @{
        Metric = "Conversion Optimization"
        MetricSub = "Website & Landing UX"
        Agency = "High-speed mobile landing pages, frictionless WhatsApp inquiry funnels, clear calls-to-action, and continuous A/B testing."
        Vendor = "Slow, outdated brochure websites without tracking pixels, contact forms that break, or mobile responsiveness."
    }
)

$rowY = $tblY + $hH + 15
$rowH = 170
$rowGap = 16

$fRowTitle = [System.Drawing.Font]::new("Segoe UI", 17, [System.Drawing.FontStyle]::Bold)
$fRowSub = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Regular)
$bRowSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(100, 116, 139))
$fCell = [System.Drawing.Font]::new("Segoe UI", 13.5, [System.Drawing.FontStyle]::Regular)

for ($r = 0; $r -lt $rows.Count; $r++) {
    $row = $rows[$r]
    $currY = $rowY + ($r * ($rowH + $rowGap))
    
    # 1. Metric Cell
    $pathM = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathM $col1X $currY ($col1W - 10) $rowH 12
    $bBgM = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
    $g2.FillPath($bBgM, $pathM)
    $pM = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 1.5)
    $g2.DrawPath($pM, $pathM)
    
    $g2.DrawString($row.Metric, $fRowTitle, $bTitle, [System.Drawing.RectangleF]::new($col1X + 20, $currY + 45, $col1W - 50, 40), $sfLeft)
    $g2.DrawString($row.MetricSub, $fRowSub, $bRowSub, [System.Drawing.RectangleF]::new($col1X + 20, $currY + 85, $col1W - 50, 30), $sfLeft)
    
    # 2. Results-Driven Agency Cell (Green Tinted & Highlighted)
    $pathA = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathA $col2X $currY ($col2W - 10) $rowH 12
    $bBgA = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(240, 253, 244))
    $g2.FillPath($bBgA, $pathA)
    $pA = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(5, 150, 105), 2.5)
    $g2.DrawPath($pA, $pathA)
    
    # Checkmark Badge
    $bCheckBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(5, 150, 105))
    $g2.FillEllipse($bCheckBg, $col2X + 22, $currY + 24, 28, 28)
    $fCheck = [System.Drawing.Font]::new("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
    $g2.DrawString([char]0x2713, $fCheck, $bWhite, [System.Drawing.RectangleF]::new($col2X + 22, $currY + 24, 28, 28), $sfCenter)
    
    # Text
    $bCellA = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(20, 83, 45))
    $g2.DrawString($row.Agency, $fCell, $bCellA, [System.Drawing.RectangleF]::new($col2X + 65, $currY + 22, $col2W - 95, $rowH - 35), $sfLeft)
    
    # 3. Traditional Vendor Cell (Neutral Gray / Red Tint)
    $pathV = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathV $col3X $currY ($col3W - 10) $rowH 12
    $bBgV = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(254, 242, 242))
    $g2.FillPath($bBgV, $pathV)
    $pV = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(239, 68, 68), 1.5)
    $g2.DrawPath($pV, $pathV)
    
    # Cross Badge
    $bCrossBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(239, 68, 68))
    $g2.FillEllipse($bCrossBg, $col3X + 22, $currY + 24, 28, 28)
    $g2.DrawString([char]0x2715, $fCheck, $bWhite, [System.Drawing.RectangleF]::new($col3X + 22, $currY + 24, 28, 28), $sfCenter)
    
    # Text
    $bCellV = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(127, 29, 29))
    $g2.DrawString($row.Vendor, $fCell, $bCellV, [System.Drawing.RectangleF]::new($col3X + 65, $currY + 22, $col3W - 95, $rowH - 35), $sfLeft)
}

# Footer Attribution
$g2.DrawString("KANAVU DIGITAL MARKETING • EVIDENCE-BASED MARKETING STANDARDS • ERODE, TAMIL NADU", $fFoot, $bFoot, [System.Drawing.RectangleF]::new(40, 1010, 1840, 30), $sfCenter)

$outputPath2 = Join-Path $targetDir "agency-comparison-matrix.jpg"
$bmp2.Save($outputPath2, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g2.Dispose()
$bmp2.Dispose()
Write-Host "[KANAVU DIGITAL] Figure 2 saved successfully: $outputPath2"

