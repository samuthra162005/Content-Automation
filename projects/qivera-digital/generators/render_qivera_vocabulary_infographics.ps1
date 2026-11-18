<#
.SYNOPSIS
    Generates high-resolution 1920x1080 (16:9) infographics for Qivera Digital (LexiRef):
    1. hero-image.jpg (10 Daily Habits to Expand Your Vocabulary)
    2. vocabulary-learning-framework.jpg (The 4-Stage Vocabulary Retention Loop)
#>

Add-Type -AssemblyName System.Drawing

$targetDir = "d:\content\digital-marketing-skills\projects\qivera-digital\2026-11-14\how-to-improve-vocabulary-10-simple-daily-habits"

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
# INFOGRAPHIC 1: 10 Daily Habits (hero-image.jpg)
# ==============================================================================
Write-Host "[QIVERA] Generating Figure 1: hero-image.jpg..."

$bmp1 = [System.Drawing.Bitmap]::new(1920, 1080)
$g1 = [System.Drawing.Graphics]::FromImage($bmp1)
$g1.Clear([System.Drawing.Color]::FromArgb(255, 255, 255))
$g1.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g1.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g1.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g1.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$fTitle = [System.Drawing.Font]::new("Segoe UI", 40, [System.Drawing.FontStyle]::Bold)
$fSub = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Regular)
$bTitle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Slate 900
$bSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(37, 99, 235))  # Blue

$sfCenter = [System.Drawing.StringFormat]::new()
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
$sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

$g1.DrawString("10 DAILY HABITS TO EXPAND YOUR VOCABULARY", $fTitle, $bTitle, [System.Drawing.RectangleF]::new(40, 35, 1840, 60), $sfCenter)
$g1.DrawString("Practical Routines for Contextual Reading, Word Decoding & Active Retention", $fSub, $bSub, [System.Drawing.RectangleF]::new(40, 100, 1840, 40), $sfCenter)

# 4 Cards Geometry
$cardW = 430
$cardH = 790
$cardY = 170
$gap = 26
$startX = 50

$cards = @(
    @{
        Title = "Contextual Input"
        Badge = "EXPOSURE & LISTENING"
        Color = [System.Drawing.Color]::FromArgb(37, 99, 235) # Blue
        Bg = [System.Drawing.Color]::FromArgb(240, 246, 255)
        Points = @(
            "Read diverse essays & fiction (15m)",
            "Listen to articulate podcasts",
            "Encounter unfamiliar words in context",
            "Avoid isolated memorization lists",
            "Highlight descriptive metaphors"
        )
    },
    @{
        Title = "Structural Analysis"
        Badge = "ETYMOLOGY & ROOTS"
        Color = [System.Drawing.Color]::FromArgb(16, 185, 129) # Emerald
        Bg = [System.Drawing.Color]::FromArgb(240, 253, 244)
        Points = @(
            "Deconstruct Greek & Latin roots",
            "Unlock 10+ words from one root",
            "Identify recurring prefixes & suffixes",
            "Inspect morphological word families",
            "Infer meanings before lookup"
        )
    },
    @{
        Title = "Active Production"
        Badge = "WRITING & SPEECH"
        Color = [System.Drawing.Color]::FromArgb(245, 158, 11) # Amber
        Bg = [System.Drawing.Color]::FromArgb(254, 243, 199)
        Points = @(
            "Maintain a personal sentence journal",
            "Use new words in daily conversation",
            "Substitute vague, generic adjectives",
            "Deliver 2-minute spoken recaps",
            "Transition words to active speech"
        )
    },
    @{
        Title = "Memory Retention"
        Badge = "SPACED RETRIEVAL"
        Color = [System.Drawing.Color]::FromArgb(147, 51, 234) # Purple
        Bg = [System.Drawing.Color]::FromArgb(250, 245, 255)
        Points = @(
            "Spaced repetition review intervals",
            "2-minute bedtime memory glance",
            "Solve crossword & anagram puzzles",
            "Review personalized LexiRef lists",
            "Consolidate long-term recall"
        )
    }
)

for ($i = 0; $i -lt $cards.Count; $i++) {
    $c = $cards[$i]
    $x = $startX + ($i * ($cardW + $gap))
    
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $path $x $cardY $cardW $cardH 20
    $bBg = [System.Drawing.SolidBrush]::new($c.Bg)
    $g1.FillPath($bBg, $path)
    
    $pBorder = [System.Drawing.Pen]::new($c.Color, 3)
    $g1.DrawPath($pBorder, $path)
    
    # Header strip
    $bStrip = [System.Drawing.SolidBrush]::new($c.Color)
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
    
    $fCTitle = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)
    $bCTitle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
    $g1.DrawString($c.Title, $fCTitle, $bCTitle, [System.Drawing.RectangleF]::new($x + 15, $cardY + 88, $cardW - 30, 60), $sfCenter)
    
    $pDiv = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 1.5)
    $g1.DrawLine($pDiv, $x + 30, $cardY + 160, $x + $cardW - 30, $cardY + 160)
    
    $ptY = $cardY + 185
    $fPt = [System.Drawing.Font]::new("Segoe UI", 13.5, [System.Drawing.FontStyle]::Regular)
    $bPt = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(51, 65, 85))
    
    $sfLeft = [System.Drawing.StringFormat]::new()
    $sfLeft.Alignment = [System.Drawing.StringAlignment]::Near
    $sfLeft.LineAlignment = [System.Drawing.StringAlignment]::Center
    
    foreach ($pt in $c.Points) {
        $bBullet = [System.Drawing.SolidBrush]::new($c.Color)
        $g1.FillEllipse($bBullet, $x + 28, $ptY + 8, 14, 14)
        $g1.FillEllipse($bWhite, $x + 32, $ptY + 12, 6, 6)
        
        $rectText = [System.Drawing.RectangleF]::new($x + 54, $ptY, $cardW - 75, 78)
        $g1.DrawString($pt, $fPt, $bPt, $rectText, $sfLeft)
        $ptY += 88
    }
}

$fFoot = [System.Drawing.Font]::new("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)
$bFoot = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(100, 116, 139))
$g1.DrawString("QIVERA DIGITAL • LEXIREF VOCABULARY REFERENCE • COGNITIVE LEARNING SYSTEM", $fFoot, $bFoot, [System.Drawing.RectangleF]::new(40, 1010, 1840, 30), $sfCenter)

$outputPath1 = Join-Path $targetDir "hero-image.jpg"
$bmp1.Save($outputPath1, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g1.Dispose()
$bmp1.Dispose()
Write-Host "[QIVERA] Figure 1 saved: $outputPath1"

# ==============================================================================
# INFOGRAPHIC 2: 4-Stage Retention Loop (vocabulary-learning-framework.jpg)
# ==============================================================================
Write-Host "[QIVERA] Generating Figure 2: vocabulary-learning-framework.jpg..."

$bmp2 = [System.Drawing.Bitmap]::new(1920, 1080)
$g2 = [System.Drawing.Graphics]::FromImage($bmp2)
$g2.Clear([System.Drawing.Color]::FromArgb(255, 255, 255))
$g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g2.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g2.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g2.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$fTitle2 = [System.Drawing.Font]::new("Segoe UI", 38, [System.Drawing.FontStyle]::Bold)
$fSub2 = [System.Drawing.Font]::new("Segoe UI", 19, [System.Drawing.FontStyle]::Regular)
$bSub2 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(16, 185, 129))

$g2.DrawString("THE 4-STAGE VOCABULARY RETENTION LOOP", $fTitle2, $bTitle, [System.Drawing.RectangleF]::new(40, 32, 1840, 58), $sfCenter)
$g2.DrawString("How Words Transition from Passive Recognition to Permanent Fluency", $fSub2, $bSub2, [System.Drawing.RectangleF]::new(40, 94, 1840, 38), $sfCenter)

# 4 Horizontal Workflow Steps
$steps = @(
    @{
        Num = "01"
        Title = "Encounter in Context"
        Subtitle = "Natural Reading"
        Color = [System.Drawing.Color]::FromArgb(37, 99, 235)
        Bg = [System.Drawing.Color]::FromArgb(240, 246, 255)
        Desc = "Read challenging fiction and analytical essays. Highlight unfamiliar words without disrupting reading immersion."
    },
    @{
        Num = "02"
        Title = "Decode Roots & Suffixes"
        Subtitle = "Morphology Check"
        Color = [System.Drawing.Color]::FromArgb(16, 185, 129)
        Bg = [System.Drawing.Color]::FromArgb(240, 253, 244)
        Desc = "Deconstruct Greek and Latin root components in LexiRef. Form associative memory anchors with known word families."
    },
    @{
        Num = "03"
        Title = "Record Personal Sentences"
        Subtitle = "Active Context"
        Color = [System.Drawing.Color]::FromArgb(245, 158, 11)
        Bg = [System.Drawing.Color]::FromArgb(254, 243, 199)
        Desc = "Write the word in an original sentence directly relevant to your daily work or thoughts. Avoid isolated definitions."
    },
    @{
        Num = "04"
        Title = "Active Spaced Retrieval"
        Subtitle = "Permanent Recall"
        Color = [System.Drawing.Color]::FromArgb(147, 51, 234)
        Bg = [System.Drawing.Color]::FromArgb(250, 245, 255)
        Desc = "Review at expanding intervals (1d, 3d, 7d). Speak the word aloud in conversation to cement long-term fluency."
    }
)

$sW = 425
$sH = 750
$sY = 175
$sGap = 30
$sStartX = 55

for ($s = 0; $s -lt $steps.Count; $s++) {
    $step = $steps[$s]
    $x = $sStartX + ($s * ($sW + $sGap))
    
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $path $x $sY $sW $sH 20
    $bBg = [System.Drawing.SolidBrush]::new($step.Bg)
    $g2.FillPath($bBg, $path)
    $pBorder = [System.Drawing.Pen]::new($step.Color, 3)
    $g2.DrawPath($pBorder, $path)
    
    # Step Number Circle
    $cSize = 80
    $cX = $x + ($sW - $cSize) / 2
    $cY = $sY + 40
    $bCircle = [System.Drawing.SolidBrush]::new($step.Color)
    $g2.FillEllipse($bCircle, $cX, $cY, $cSize, $cSize)
    $fNum = [System.Drawing.Font]::new("Segoe UI", 26, [System.Drawing.FontStyle]::Bold)
    $g2.DrawString($step.Num, $fNum, $bWhite, [System.Drawing.RectangleF]::new($cX, $cY, $cSize, $cSize), $sfCenter)
    
    # Step Title
    $fSTitle = [System.Drawing.Font]::new("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)
    $g2.DrawString($step.Title, $fSTitle, $bTitle, [System.Drawing.RectangleF]::new($x + 20, $sY + 150, $sW - 40, 60), $sfCenter)
    
    # Step Subtitle Badge
    $fSSub = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $bSubText = [System.Drawing.SolidBrush]::new($step.Color)
    $g2.DrawString($step.Subtitle.ToUpper(), $fSSub, $bSubText, [System.Drawing.RectangleF]::new($x + 20, $sY + 215, $sW - 40, 30), $sfCenter)
    
    $pDiv = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 1.5)
    $g2.DrawLine($pDiv, $x + 30, $sY + 260, $x + $sW - 30, $sY + 260)
    
    # Description
    $fDesc = [System.Drawing.Font]::new("Segoe UI", 14, [System.Drawing.FontStyle]::Regular)
    $bDesc = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(51, 65, 85))
    $rectDesc = [System.Drawing.RectangleF]::new($x + 28, $sY + 290, $sW - 56, 380)
    $g2.DrawString($step.Desc, $fDesc, $bDesc, $rectDesc, $sfCenter)
    
    # Arrow between cards
    if ($s -lt $steps.Count - 1) {
        $arrX = $x + $sW + 4
        $arrY = $sY + ($sH / 2) - 15
        $fArr = [System.Drawing.Font]::new("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
        $bArr = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(148, 163, 184))
        $g2.DrawString([char]0x2192, $fArr, $bArr, [System.Drawing.RectangleF]::new($arrX, $arrY, 22, 35), $sfCenter)
    }
}

$g2.DrawString("QIVERA DIGITAL • LEXIREF VOCABULARY REFERENCE • COGNITIVE RETENTION FRAMEWORK", $fFoot, $bFoot, [System.Drawing.RectangleF]::new(40, 1010, 1840, 30), $sfCenter)

$outputPath2 = Join-Path $targetDir "vocabulary-learning-framework.jpg"
$bmp2.Save($outputPath2, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g2.Dispose()
$bmp2.Dispose()
Write-Host "[QIVERA] Figure 2 saved: $outputPath2"

