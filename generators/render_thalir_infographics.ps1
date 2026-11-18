<#
.SYNOPSIS
    Generates high-resolution 1920x1080 (16:9) infographics for Thalir Kids Dental blog:
    1. hero-image.jpg (4-Type Pediatric Braces Options Grid)
    2. braces-comparison-matrix.jpg (Clinical Braces Decision Matrix)
#>

Add-Type -AssemblyName System.Drawing

$targetDir = "d:\content\digital-marketing-skills\projects\thalir-kids-dental\2026-11-13\types-of-braces-for-kids"

function Add-RoundedRectangle($path, $x, $y, $w, $h, $r) {
    $d = $r * 2
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
}

# ==============================================================================
# INFOGRAPHIC 1: 4-Type Pediatric Braces Options Grid
# ==============================================================================
Write-Host "[THALIR VISUAL] Generating Figure 1: hero-image.jpg..."

$bmp1 = [System.Drawing.Bitmap]::new(1920, 1080)
$g1 = [System.Drawing.Graphics]::FromImage($bmp1)
$g1.Clear([System.Drawing.Color]::FromArgb(255, 255, 255)) # Pure white background
$g1.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g1.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g1.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g1.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Header Typography
$fTitle = [System.Drawing.Font]::new("Segoe UI", 42, [System.Drawing.FontStyle]::Bold)
$fSub = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Regular)
$bTitle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Slate 900
$bSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(13, 148, 136))  # Teal

$sfCenter = [System.Drawing.StringFormat]::new()
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
$sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

$g1.DrawString("TYPES OF BRACES FOR KIDS: A COMPLETE PARENT GUIDE", $fTitle, $bTitle, [System.Drawing.RectangleF]::new(40, 35, 1840, 60), $sfCenter)
$g1.DrawString("Comparing Traditional Metal, Ceramic, Self-Ligating & Clear Aligners", $fSub, $bSub, [System.Drawing.RectangleF]::new(40, 100, 1840, 40), $sfCenter)

# 4 Cards Geometry
$cardW = 430
$cardH = 780
$cardY = 175
$gap = 26
$startX = 50

$cards = @(
    @{
        Title = "Traditional Metal"
        Badge = "MOST DURABLE"
        Color = [System.Drawing.Color]::FromArgb(37, 99, 235) # Blue
        Bg = [System.Drawing.Color]::FromArgb(240, 246, 255)
        Points = @(
            "High-grade stainless steel brackets",
            "Colorful rainbow elastic bands kids love",
            "Highest impact resistance for active play",
            "Gold standard for severe tooth misalignment",
            "Recommended Age: 7 to 12 years"
        )
    },
    @{
        Title = "Ceramic Brackets"
        Badge = "SUBTLE & DISCRETE"
        Color = [System.Drawing.Color]::FromArgb(219, 39, 119) # Rose Pink
        Bg = [System.Drawing.Color]::FromArgb(253, 242, 248)
        Points = @(
            "Translucent tooth-colored ceramic material",
            "Blends naturally with child's white enamel",
            "Zero metallic glare in school photos",
            "Smooth comfortable profile for lips",
            "Recommended Age: 10+ Preteens & Teens"
        )
    },
    @{
        Title = "Self-Ligating"
        Badge = "LOW FRICTION"
        Color = [System.Drawing.Color]::FromArgb(13, 148, 136) # Teal
        Bg = [System.Drawing.Color]::FromArgb(240, 253, 250)
        Points = @(
            "Built-in sliding clips hold archwire",
            "No rubber ligature elastics required",
            "Easier brushing & plaque control",
            "Fewer monthly adjustment visits needed",
            "Recommended Age: 9 to 14 years"
        )
    },
    @{
        Title = "Clear Aligners"
        Badge = "NEARLY INVISIBLE"
        Color = [System.Drawing.Color]::FromArgb(16, 185, 129) # Emerald
        Bg = [System.Drawing.Color]::FromArgb(236, 253, 245)
        Points = @(
            "Smooth custom transparent medical polymer",
            "100% removable for meals and brushing",
            "Zero food restrictions during treatment",
            "Requires 22 hours of daily wear discipline",
            "Recommended Age: 11+ Disciplined Kids"
        )
    }
)

$fCardTitle = [System.Drawing.Font]::new("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$fBadge = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$fPoint = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)
$bTextDark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59))
$bWhite = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)

for ($i = 0; $i -lt 4; $i++) {
    $c = $cards[$i]
    $cX = $startX + ($i * ($cardW + $gap))

    # Outer Card Path
    $pCard = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pCard $cX $cardY $cardW $cardH 24
    
    $bCardBg = [System.Drawing.SolidBrush]::new($c.Bg)
    $g1.FillPath($bCardBg, $pCard)
    
    $penCardBorder = [System.Drawing.Pen]::new($c.Color, 3)
    $g1.DrawPath($penCardBorder, $pCard)

    # Header Ribbon
    $pRibbon = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pRibbon ($cX + 20) ($cardY + 24) ($cardW - 40) 55 14
    $bRibbon = [System.Drawing.SolidBrush]::new($c.Color)
    $g1.FillPath($bRibbon, $pRibbon)
    $g1.DrawString($c.Title, $fCardTitle, $bWhite, [System.Drawing.RectangleF]::new($cX + 20, $cardY + 24, $cardW - 40, 55), $sfCenter)

    # Badge Pill
    $pBadge = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pBadge ($cX + ($cardW - 190)/2) ($cardY + 95) 190 32 10
    $bBadge = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 255, 255))
    $g1.FillPath($bBadge, $pBadge)
    $penBadge = [System.Drawing.Pen]::new($c.Color, 2)
    $g1.DrawPath($penBadge, $pBadge)
    $bBadgeText = [System.Drawing.SolidBrush]::new($c.Color)
    $g1.DrawString($c.Badge, $fBadge, $bBadgeText, [System.Drawing.RectangleF]::new($cX, $cardY + 95, $cardW, 32), $sfCenter)

    # Bullet Points
    $ptY = $cardY + 160
    foreach ($pt in $c.Points) {
        # Checkmark Icon
        $g1.FillEllipse($bRibbon, ($cX + 26), ($ptY + 6), 14, 14)
        
        $rectPt = [System.Drawing.RectangleF]::new(($cX + 52), $ptY, ($cardW - 74), 85)
        $sfLeft = [System.Drawing.StringFormat]::new()
        $sfLeft.Alignment = [System.Drawing.StringAlignment]::Near
        $g1.DrawString($pt, $fPoint, $bTextDark, $rectPt, $sfLeft)
        $ptY += 105
        $sfLeft.Dispose()
    }

    # Mascot Note on Card 1
    if ($i -eq 0) {
        $fNote = [System.Drawing.Font]::new("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
        $bChompy = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(217, 119, 6))
        $g1.DrawString("* Chompy's Favorite for Young Smiles!", $fNote, $bChompy, [System.Drawing.RectangleF]::new($cX + 20, $cardY + $cardH - 55, $cardW - 40, 35), $sfCenter)
        $fNote.Dispose()
        $bChompy.Dispose()
    }

    # Clean up card objects
    $pCard.Dispose()
    $pRibbon.Dispose()
    $pBadge.Dispose()
    $bCardBg.Dispose()
    $penCardBorder.Dispose()
    $bRibbon.Dispose()
    $bBadge.Dispose()
    $penBadge.Dispose()
    $bBadgeText.Dispose()
}

# Footer Banner
$pFoot = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pFoot 50 985 1820 65 14
$bFoot = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(241, 245, 249))
$g1.FillPath($bFoot, $pFoot)
$fFoot = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$bFootText = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(51, 65, 85))
$g1.DrawString("THALIR KIDS SPECIALITY DENTAL CLINIC, ERODE | Gentle Pediatric Orthodontics & Early Interception", $fFoot, $bFootText, [System.Drawing.RectangleF]::new(50, 985, 1820, 65), $sfCenter)

$heroPath = Join-Path $targetDir "hero-image.jpg"
$bmp1.Save($heroPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g1.Dispose()
$bmp1.Dispose()
Write-Host "  -> Exported: $heroPath"

# ==============================================================================
# INFOGRAPHIC 2: Children's Braces Comparison Matrix
# ==============================================================================
Write-Host "[THALIR VISUAL] Generating Figure 2: braces-comparison-matrix.jpg..."

$bmp2 = [System.Drawing.Bitmap]::new(1920, 1080)
$g2 = [System.Drawing.Graphics]::FromImage($bmp2)
$g2.Clear([System.Drawing.Color]::FromArgb(255, 255, 255))
$g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g2.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g2.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g2.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Header
$g2.DrawString("CHILDREN'S BRACES COMPARISON MATRIX", $fTitle, $bTitle, [System.Drawing.RectangleF]::new(40, 35, 1840, 60), $sfCenter)
$g2.DrawString("Durability, Visibility, Cleaning Ease & Best Age for Each Pediatric Option", $fSub, $bSub, [System.Drawing.RectangleF]::new(40, 100, 1840, 40), $sfCenter)

# Table Dimensions
$tblX = 60
$tblY = 175
$tblW = 1800
$tblH = 780
$colW0 = 340
$colW = 365

# Outer Table Container
$pTbl = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pTbl $tblX $tblY $tblW $tblH 20
$bTblBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
$g2.FillPath($bTblBg, $pTbl)
$penTbl = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 2)
$g2.DrawPath($penTbl, $pTbl)

# Header Row
$pHdr = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pHdr $tblX $tblY $tblW 105 20
$bHdr = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Slate 900
$g2.FillPath($bHdr, $pHdr)

$fTh = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)
$fTd = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)
$fTdBold = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)

$g2.DrawString("CLINICAL DIMENSION", $fTh, $bWhite, [System.Drawing.RectangleF]::new($tblX, $tblY, $colW0, 105), $sfCenter)
$g2.DrawString("TRADITIONAL METAL", $fTh, $bWhite, [System.Drawing.RectangleF]::new($tblX + $colW0, $tblY, $colW, 105), $sfCenter)
$g2.DrawString("CERAMIC BRACES", $fTh, $bWhite, [System.Drawing.RectangleF]::new($tblX + $colW0 + $colW, $tblY, $colW, 105), $sfCenter)
$g2.DrawString("SELF-LIGATING", $fTh, $bWhite, [System.Drawing.RectangleF]::new($tblX + $colW0 + ($colW * 2), $tblY, $colW, 105), $sfCenter)
$g2.DrawString("CLEAR ALIGNERS", $fTh, $bWhite, [System.Drawing.RectangleF]::new($tblX + $colW0 + ($colW * 3), $tblY, $colW, 105), $sfCenter)

# Table Rows Data
$rows = @(
    @{
        Label = "Material & Build"
        C1 = "Surgical Stainless Steel`nUltra-strong alloy"
        C2 = "Polycrystalline Ceramic`nTooth-colored composite"
        C3 = "Low-Friction Metal`nSlide-door mechanism"
        C4 = "Medical-Grade Polymer`nSmooth clear plastic"
    },
    @{
        Label = "Durability & Impact"
        C1 = "HIGHEST DURABILITY`nImpact-proof for play"
        C2 = "MODERATE DURABILITY`nMay chip on hard foods"
        C3 = "HIGH DURABILITY`nSturdy bracket profile"
        C4 = "HIGH DURABILITY`nCrack-resistant trays"
    },
    @{
        Label = "Aesthetic Visibility"
        C1 = "High Visibility`nCustom rainbow bands"
        C2 = "Very Low Visibility`nBlends with enamel"
        C3 = "Moderate Visibility`nCompact metal profile"
        C4 = "NEAR ZERO VISIBILITY`nNearly invisible in use"
    },
    @{
        Label = "Daily Oral Hygiene"
        C1 = "Needs careful flossing`nOrthodontic brush helpful"
        C2 = "Avoid dark curries`nGentle flossing required"
        C3 = "Easier plaque removal`nNo rubber elastics"
        C4 = "SIMPLEST HYGIENE`nRemove to brush & floss"
    },
    @{
        Label = "Ideal Age & Best For"
        C1 = "Ages 7 to 12`nComplex bite issues"
        C2 = "Ages 10+ Preteens`nImage-conscious kids"
        C3 = "Ages 9 to 14`nMild/moderate crowding"
        C4 = "Ages 11+ Disciplined`nMild bite corrections"
    }
)

$rY = $tblY + 105
$rowH = 135
$penLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(226, 232, 240), 1)

for ($r = 0; $r -lt $rows.Count; $r++) {
    $row = $rows[$r]
    $rowBg = if ($r % 2 -eq 0) { [System.Drawing.Color]::FromArgb(255, 255, 255) } else { [System.Drawing.Color]::FromArgb(248, 250, 252) }
    $bRowBg = [System.Drawing.SolidBrush]::new($rowBg)
    $g2.FillRectangle($bRowBg, $tblX + 2, $rY, $tblW - 4, $rowH)
    $bRowBg.Dispose()

    # Dimension Label (Column 0)
    $rectL = [System.Drawing.RectangleF]::new($tblX + 20, $rY, $colW0 - 40, $rowH)
    $g2.DrawString($row.Label, $fTdBold, $bTitle, $rectL, $sfCenter)

    # Columns 1 to 4
    $rect1 = [System.Drawing.RectangleF]::new($tblX + $colW0 + 10, $rY, $colW - 20, $rowH)
    $rect2 = [System.Drawing.RectangleF]::new($tblX + $colW0 + $colW + 10, $rY, $colW - 20, $rowH)
    $rect3 = [System.Drawing.RectangleF]::new($tblX + $colW0 + ($colW * 2) + 10, $rY, $colW - 20, $rowH)
    $rect4 = [System.Drawing.RectangleF]::new($tblX + $colW0 + ($colW * 3) + 10, $rY, $colW - 20, $rowH)

    $bText = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59))
    $g2.DrawString($row.C1, $fTd, $bText, $rect1, $sfCenter)
    $g2.DrawString($row.C2, $fTd, $bText, $rect2, $sfCenter)
    $g2.DrawString($row.C3, $fTd, $bText, $rect3, $sfCenter)
    $g2.DrawString($row.C4, $fTd, $bText, $rect4, $sfCenter)
    $bText.Dispose()

    # Horizontal Divider
    if ($r -lt ($rows.Count - 1)) {
        $g2.DrawLine($penLine, $tblX, ($rY + $rowH), ($tblX + $tblW), ($rY + $rowH))
    }
    $rY += $rowH
}

# Footer Note
$pFoot2 = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pFoot2 60 975 1800 65 14
$bFoot2 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(230, 244, 234)) # Soft mint
$g2.FillPath($bFoot2, $pFoot2)
$bFootText2 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(13, 148, 136))
$g2.DrawString("AAO GUIDANCE: Initial Pediatric Orthodontic Screening Recommended by Age 7 | Thalir Kids Dental Clinic, Erode", $fFoot, $bFootText2, [System.Drawing.RectangleF]::new(60, 975, 1800, 65), $sfCenter)

$matrixPath = Join-Path $targetDir "braces-comparison-matrix.jpg"
$bmp2.Save($matrixPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g2.Dispose()
$bmp2.Dispose()
Write-Host "  -> Exported: $matrixPath"

Write-Host "=== THALIR INFOGRAPHICS GENERATION COMPLETE ==="

