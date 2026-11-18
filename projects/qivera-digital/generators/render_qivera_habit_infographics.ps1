<#
.SYNOPSIS
    Generates high-resolution 1920x1080 (16:9) infographics for Qivera Digital (HabitShare):
    1. hero-image.jpg (4 Behavioral Reinforcement Pillars)
    2. habit-friction-matrix.jpg (High-Friction vs Low-Friction Habit Architecture)
#>

Add-Type -AssemblyName System.Drawing

$targetDir = "d:\content\digital-marketing-skills\projects\qivera-digital\2026-11-14\how-to-stay-consistent-with-habits-when-motivation-fades"

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
# INFOGRAPHIC 1: 4 Behavioral Reinforcement Pillars (hero-image.jpg)
# ==============================================================================
Write-Host "[HABITSHARE] Generating Figure 1: hero-image.jpg..."

$bmp1 = [System.Drawing.Bitmap]::new(1920, 1080)
$g1 = [System.Drawing.Graphics]::FromImage($bmp1)
$g1.Clear([System.Drawing.Color]::FromArgb(255, 255, 255))
$g1.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g1.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g1.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g1.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$fTitle = [System.Drawing.Font]::new("Segoe UI", 40, [System.Drawing.FontStyle]::Bold)
$fSub = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Regular)
$bTitle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
$bSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(16, 185, 129)) # Emerald

$sfCenter = [System.Drawing.StringFormat]::new()
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
$sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

$g1.DrawString("HOW TO STAY CONSISTENT: 4 REINFORCEMENT PILLARS", $fTitle, $bTitle, [System.Drawing.RectangleF]::new(40, 35, 1840, 60), $sfCenter)
$g1.DrawString("Behavioral Systems That Sustain Daily Progress When Willpower Fades", $fSub, $bSub, [System.Drawing.RectangleF]::new(40, 100, 1840, 40), $sfCenter)

# 4 Cards Geometry
$cardW = 430
$cardH = 790
$cardY = 170
$gap = 26
$startX = 50

$cards = @(
    @{
        Title = "Friction Reduction"
        Badge = "ENVIRONMENT DESIGN"
        Color = [System.Drawing.Color]::FromArgb(16, 185, 129) # Emerald
        Bg = [System.Drawing.Color]::FromArgb(240, 253, 244)
        Points = @(
            "Eliminate startup resistance",
            "Prepare materials the night before",
            "Create obvious visual environmental cues",
            "Remove distraction obstacles",
            "Make desired habits effortless"
        )
    },
    @{
        Title = "Two-Minute Rule"
        Badge = "MICRO-COMMITMENT"
        Color = [System.Drawing.Color]::FromArgb(37, 99, 235)  # Blue
        Bg = [System.Drawing.Color]::FromArgb(240, 246, 255)
        Points = @(
            "Shrink habit to 120 seconds",
            "Focus exclusively on starting",
            "Read 1 page or put on running shoes",
            "Preserve your underlying identity",
            "Action precedes motivation"
        )
    },
    @{
        Title = "Never Miss Twice"
        Badge = "RESILIENCE PROTOCOL"
        Color = [System.Drawing.Color]::FromArgb(245, 158, 11)  # Amber
        Bg = [System.Drawing.Color]::FromArgb(254, 243, 199)
        Points = @(
            "Missing once is an anomaly",
            "Missing twice starts a bad habit",
            "Immediately rebound the next day",
            "Abbreviate instead of abandoning",
            "Maintain streak momentum"
        )
    },
    @{
        Title = "Peer Accountability"
        Badge = "SOCIAL REINFORCEMENT"
        Color = [System.Drawing.Color]::FromArgb(147, 51, 234) # Purple
        Bg = [System.Drawing.Color]::FromArgb(250, 245, 255)
        Points = @(
            "Share daily goals with trusted peers",
            "Track shared streaks in HabitShare",
            "Celebrate micro-milestones together",
            "Leverage positive social expectations",
            "Surround yourself with consistency"
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
$g1.DrawString("QIVERA DIGITAL • HABITSHARE SOCIAL HABIT TRACKER • BEHAVIORAL ARCHITECTURE", $fFoot, $bFoot, [System.Drawing.RectangleF]::new(40, 1010, 1840, 30), $sfCenter)

$outputPath1 = Join-Path $targetDir "hero-image.jpg"
$bmp1.Save($outputPath1, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g1.Dispose()
$bmp1.Dispose()
Write-Host "[HABITSHARE] Figure 1 saved: $outputPath1"

# ==============================================================================
# INFOGRAPHIC 2: Comparison Matrix (habit-friction-matrix.jpg)
# ==============================================================================
Write-Host "[HABITSHARE] Generating Figure 2: habit-friction-matrix.jpg..."

$bmp2 = [System.Drawing.Bitmap]::new(1920, 1080)
$g2 = [System.Drawing.Graphics]::FromImage($bmp2)
$g2.Clear([System.Drawing.Color]::FromArgb(255, 255, 255))
$g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g2.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g2.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g2.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$fTitle2 = [System.Drawing.Font]::new("Segoe UI", 38, [System.Drawing.FontStyle]::Bold)
$fSub2 = [System.Drawing.Font]::new("Segoe UI", 19, [System.Drawing.FontStyle]::Regular)
$bSub2 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(37, 99, 235))

$g2.DrawString("HIGH-FRICTION VS LOW-FRICTION HABIT DESIGN", $fTitle2, $bTitle, [System.Drawing.RectangleF]::new(40, 32, 1840, 58), $sfCenter)
$g2.DrawString("Comparing Motivation-Dependent Habits Against Resilient Behavioral Systems", $fSub2, $bSub2, [System.Drawing.RectangleF]::new(40, 94, 1840, 38), $sfCenter)

# Table Geometry
$tblX = 60
$tblY = 160
$tblW = 1800
$col1W = 380
$col2W = 710  # Resilient System (Green)
$col3W = 710  # Vulnerable System (Red/Slate)

$col1X = $tblX
$col2X = $tblX + $col1W
$col3X = $tblX + $col1W + $col2W

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
$g2.DrawString("DESIGN DIMENSION", $fHdr, $bWhite, [System.Drawing.RectangleF]::new($col1X, $tblY, $col1W - 10, $hH), $sfCenter)
$g2.DrawString("RESILIENT HABITS (SYSTEM-DRIVEN)", $fHdr, $bWhite, [System.Drawing.RectangleF]::new($col2X, $tblY, $col2W - 10, $hH), $sfCenter)
$g2.DrawString("VULNERABLE HABITS (MOTIVATION-DEPENDENT)", $fHdr, $bWhite, [System.Drawing.RectangleF]::new($col3X, $tblY, $col3W - 10, $hH), $sfCenter)

$rows = @(
    @{
        Metric = "Habit Scope"
        MetricSub = "Daily Target Threshold"
        Resilient = "Two-minute entry actions (read 1 page, 10 pushups). Preserves consistency and identity even when totally exhausted."
        Vulnerable = "Rigid, ambitious 60-minute workouts. Leads to immediate skipping and burnout on stressful workdays."
    },
    @{
        Metric = "Trigger Mechanism"
        MetricSub = "Cue & Environmental Setup"
        Resilient = "Engineered physical environment (clothes laid out, books open). Action is prompt-driven and nearly friction-free."
        Vulnerable = "Relying purely on mental willpower and spontaneous memory. High cognitive load causes rapid procrastination."
    },
    @{
        Metric = "Obstacle Handling"
        MetricSub = "Missed Session Response"
        Resilient = "Enforcing 'Never Miss Twice' protocol. Rebounds the very next day with an abbreviated session to keep identity."
        Vulnerable = "All-or-nothing perfectionism. Missing a single workout triggers defeatism and complete goal abandonment."
    },
    @{
        Metric = "Social Accountability"
        MetricSub = "Peer Commitment"
        Resilient = "Transparent shared streaks in HabitShare with close friends. Positive mutual check-ins keep commitments alive."
        Vulnerable = "Isolated personal promises kept secretly. Zero social consequence when quietly quitting."
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
    
    $pathM = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathM $col1X $currY ($col1W - 10) $rowH 12
    $bBgM = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
    $g2.FillPath($bBgM, $pathM)
    $pM = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 1.5)
    $g2.DrawPath($pM, $pathM)
    
    $g2.DrawString($row.Metric, $fRowTitle, $bTitle, [System.Drawing.RectangleF]::new($col1X + 20, $currY + 45, $col1W - 50, 40), $sfLeft)
    $g2.DrawString($row.MetricSub, $fRowSub, $bRowSub, [System.Drawing.RectangleF]::new($col1X + 20, $currY + 85, $col1W - 50, 30), $sfLeft)
    
    # Resilient Cell (Green)
    $pathA = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathA $col2X $currY ($col2W - 10) $rowH 12
    $bBgA = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(240, 253, 244))
    $g2.FillPath($bBgA, $pathA)
    $pA = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(5, 150, 105), 2.5)
    $g2.DrawPath($pA, $pathA)
    
    $bCheckBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(5, 150, 105))
    $g2.FillEllipse($bCheckBg, $col2X + 22, $currY + 24, 28, 28)
    $fCheck = [System.Drawing.Font]::new("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
    $g2.DrawString([char]0x2713, $fCheck, $bWhite, [System.Drawing.RectangleF]::new($col2X + 22, $currY + 24, 28, 28), $sfCenter)
    
    $bCellA = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(20, 83, 45))
    $g2.DrawString($row.Resilient, $fCell, $bCellA, [System.Drawing.RectangleF]::new($col2X + 65, $currY + 22, $col2W - 95, $rowH - 35), $sfLeft)
    
    # Vulnerable Cell (Red)
    $pathV = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathV $col3X $currY ($col3W - 10) $rowH 12
    $bBgV = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(254, 242, 242))
    $g2.FillPath($bBgV, $pathV)
    $pV = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(239, 68, 68), 1.5)
    $g2.DrawPath($pV, $pathV)
    
    $bCrossBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(239, 68, 68))
    $g2.FillEllipse($bCrossBg, $col3X + 22, $currY + 24, 28, 28)
    $g2.DrawString([char]0x2715, $fCheck, $bWhite, [System.Drawing.RectangleF]::new($col3X + 22, $currY + 24, 28, 28), $sfCenter)
    
    $bCellV = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(127, 29, 29))
    $g2.DrawString($row.Vulnerable, $fCell, $bCellV, [System.Drawing.RectangleF]::new($col3X + 65, $currY + 22, $col3W - 95, $rowH - 35), $sfLeft)
}

$g2.DrawString("QIVERA DIGITAL • HABITSHARE SOCIAL HABIT TRACKER • SYSTEM DESIGN STANDARDS", $fFoot, $bFoot, [System.Drawing.RectangleF]::new(40, 1010, 1840, 30), $sfCenter)

$outputPath2 = Join-Path $targetDir "habit-friction-matrix.jpg"
$bmp2.Save($outputPath2, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g2.Dispose()
$bmp2.Dispose()
Write-Host "[HABITSHARE] Figure 2 saved: $outputPath2"

