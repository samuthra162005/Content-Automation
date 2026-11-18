<#
.SYNOPSIS
    Generates high-resolution 1920x1080 (16:9) technical diagrams for Aindhin:
    1. hero-image.jpg (SQL Query Execution Order & Core Syntax)
    2. sql-joins-diagram.jpg (Relational Database SQL JOINs Architecture)
#>

Add-Type -AssemblyName System.Drawing

$targetDir = "d:\content\digital-marketing-skills\projects\aindhin\2026-11-14\sql-for-beginners-basic-queries-every-data-analyst-should-know"

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
# INFOGRAPHIC 1: Execution Order & Syntax (hero-image.jpg)
# ==============================================================================
Write-Host "[AINDHIN] Generating Figure 1: hero-image.jpg..."

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
$bSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(2, 132, 199)) # Sky Blue

$sfCenter = [System.Drawing.StringFormat]::new()
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
$sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

$g1.DrawString("SQL QUERY EXECUTION ORDER & CORE SYNTAX", $fTitle, $bTitle, [System.Drawing.RectangleF]::new(40, 35, 1840, 60), $sfCenter)
$g1.DrawString("Understanding How Relational Database Engines Process Data Instructions", $fSub, $bSub, [System.Drawing.RectangleF]::new(40, 100, 1840, 40), $sfCenter)

# 4 Wide Clause Columns
$cardW = 430
$cardH = 790
$cardY = 170
$gap = 26
$startX = 50

$cards = @(
    @{
        Step = "STEP 1 & 2"
        Title = "FROM & WHERE"
        Badge = "SOURCE & FILTER"
        Color = [System.Drawing.Color]::FromArgb(2, 132, 199) # Sky Blue
        Bg = [System.Drawing.Color]::FromArgb(240, 249, 255)
        Points = @(
            "FROM identifies target data tables",
            "JOIN merges relational datasets",
            "WHERE filters rows before grouping",
            "Discards irrelevant records early",
            "Code: WHERE order_status = 'Shipped'"
        )
    },
    @{
        Step = "STEP 3 & 4"
        Title = "GROUP BY & HAVING"
        Badge = "AGGREGATE METRICS"
        Color = [System.Drawing.Color]::FromArgb(16, 185, 129) # Emerald
        Bg = [System.Drawing.Color]::FromArgb(240, 253, 244)
        Points = @(
            "GROUP BY categorizes rows by keys",
            "Applies SUM, COUNT, AVG, MAX, MIN",
            "HAVING filters aggregated sums",
            "Operates strictly on grouped data",
            "Code: HAVING SUM(revenue) > 10000"
        )
    },
    @{
        Step = "STEP 5"
        Title = "SELECT & ALIAS"
        Badge = "COLUMN PROJECTION"
        Color = [System.Drawing.Color]::FromArgb(139, 92, 246) # Violet
        Bg = [System.Drawing.Color]::FromArgb(245, 243, 255)
        Points = @(
            "Extracts requested column values",
            "Computes mathematical expressions",
            "Applies column aliases with AS",
            "Avoids unnecessary wildcard * bloat",
            "Code: SELECT region, SUM(sales) AS rev"
        )
    },
    @{
        Step = "STEP 6"
        Title = "ORDER BY & LIMIT"
        Badge = "SORT & RESTRICT"
        Color = [System.Drawing.Color]::FromArgb(245, 158, 11)  # Amber
        Bg = [System.Drawing.Color]::FromArgb(254, 243, 199)
        Points = @(
            "ORDER BY sorts results ASC / DESC",
            "Executes after SELECT projection",
            "LIMIT restricts returned row counts",
            "Essential for Top-N business reports",
            "Code: ORDER BY rev DESC LIMIT 10;"
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
$g1.DrawString("AINDHIN • DATA ANALYTICS CERTIFICATION COURSE • ANSI SQL QUERY STANDARDS", $fFoot, $bFoot, [System.Drawing.RectangleF]::new(40, 1010, 1840, 30), $sfCenter)

$outputPath1 = Join-Path $targetDir "hero-image.jpg"
$bmp1.Save($outputPath1, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g1.Dispose()
$bmp1.Dispose()
Write-Host "[AINDHIN] Figure 1 saved: $outputPath1"

# ==============================================================================
# INFOGRAPHIC 2: SQL JOIN Types Architecture (sql-joins-diagram.jpg)
# ==============================================================================
Write-Host "[AINDHIN] Generating Figure 2: sql-joins-diagram.jpg..."

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

$g2.DrawString("RELATIONAL DATABASE SQL JOINS ARCHITECTURE", $fTitle2, $bTitle, [System.Drawing.RectangleF]::new(40, 32, 1840, 58), $sfCenter)
$g2.DrawString("Visualizing Table Intersections: INNER JOIN, LEFT JOIN & FULL OUTER JOIN", $fSub2, $bSub2, [System.Drawing.RectangleF]::new(40, 94, 1840, 38), $sfCenter)

# 3 Wide Cards
$jW = 560
$jH = 750
$jY = 175
$jGap = 40
$jStartX = 80

$joins = @(
    @{
        Type = "INNER JOIN"
        Badge = "MATCHING INTERSECTION"
        Color = [System.Drawing.Color]::FromArgb(2, 132, 199)
        Bg = [System.Drawing.Color]::FromArgb(240, 249, 255)
        Syntax = "SELECT c.name, o.total FROM customers c INNER JOIN orders o ON c.id = o.customer_id;"
        Use = "Returns strictly the records that exist in BOTH tables. Excludes customers who have placed zero orders and unassigned orders."
        Rule = "Key Rule: Primary Key = Foreign Key Match"
    },
    @{
        Type = "LEFT JOIN"
        Badge = "ALL LEFT + MATCHED RIGHT"
        Color = [System.Drawing.Color]::FromArgb(16, 185, 129)
        Bg = [System.Drawing.Color]::FromArgb(240, 253, 244)
        Syntax = "SELECT c.name, o.total FROM customers c LEFT JOIN orders o ON c.id = o.customer_id;"
        Use = "Preserves 100% of rows from Table A (Left). If Table B has no match, outputs NULL. Crucial for detecting churned users."
        Rule = "Key Rule: Table A Always Fully Retained"
    },
    @{
        Type = "FULL OUTER JOIN"
        Badge = "COMPLETE MERGE + NULLS"
        Color = [System.Drawing.Color]::FromArgb(139, 92, 246)
        Bg = [System.Drawing.Color]::FromArgb(245, 243, 255)
        Syntax = "SELECT c.name, o.total FROM customers c FULL OUTER JOIN orders o ON c.id = o.customer_id;"
        Use = "Returns all rows from both tables. Matches where possible, and fills missing values with NULLs on either side."
        Rule = "Key Rule: Complete Relational Audit"
    }
)

for ($j = 0; $j -lt $joins.Count; $j++) {
    $item = $joins[$j]
    $x = $jStartX + ($j * ($jW + $jGap))
    
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $path $x $jY $jW $jH 20
    $bBg = [System.Drawing.SolidBrush]::new($item.Bg)
    $g2.FillPath($bBg, $path)
    $pBorder = [System.Drawing.Pen]::new($item.Color, 3)
    $g2.DrawPath($pBorder, $path)
    
    # Venn diagram circles illustration
    $vY = $jY + 45
    $vRad = 110
    $vC1X = $x + ($jW / 2) - 50
    $vC2X = $x + ($jW / 2) + 50
    
    $bGrayCircle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(180, 226, 232, 240))
    $bActiveCircle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(200, $item.Color.R, $item.Color.G, $item.Color.B))
    
    if ($item.Type -eq "INNER JOIN") {
        $g2.FillEllipse($bGrayCircle, $vC1X - $vRad/2, $vY, $vRad, $vRad)
        $g2.FillEllipse($bGrayCircle, $vC2X - $vRad/2, $vY, $vRad, $vRad)
        # Center intersection
        $pathIntersect = [System.Drawing.Drawing2D.GraphicsPath]::new()
        $pathIntersect.AddEllipse($vC1X - $vRad/2, $vY, $vRad, $vRad)
        $reg = [System.Drawing.Region]::new($pathIntersect)
        $path2 = [System.Drawing.Drawing2D.GraphicsPath]::new()
        $path2.AddEllipse($vC2X - $vRad/2, $vY, $vRad, $vRad)
        $reg.Intersect($path2)
        $g2.FillRegion($bActiveCircle, $reg)
    } elseif ($item.Type -eq "LEFT JOIN") {
        $g2.FillEllipse($bActiveCircle, $vC1X - $vRad/2, $vY, $vRad, $vRad)
        $g2.FillEllipse($bGrayCircle, $vC2X - $vRad/2, $vY, $vRad, $vRad)
        $pathIntersect = [System.Drawing.Drawing2D.GraphicsPath]::new()
        $pathIntersect.AddEllipse($vC1X - $vRad/2, $vY, $vRad, $vRad)
        $reg = [System.Drawing.Region]::new($pathIntersect)
        $path2 = [System.Drawing.Drawing2D.GraphicsPath]::new()
        $path2.AddEllipse($vC2X - $vRad/2, $vY, $vRad, $vRad)
        $reg.Intersect($path2)
        $g2.FillRegion($bActiveCircle, $reg)
    } else {
        $g2.FillEllipse($bActiveCircle, $vC1X - $vRad/2, $vY, $vRad, $vRad)
        $g2.FillEllipse($bActiveCircle, $vC2X - $vRad/2, $vY, $vRad, $vRad)
    }
    
    $pCircle = [System.Drawing.Pen]::new($item.Color, 2)
    $g2.DrawEllipse($pCircle, $vC1X - $vRad/2, $vY, $vRad, $vRad)
    $g2.DrawEllipse($pCircle, $vC2X - $vRad/2, $vY, $vRad, $vRad)
    
    # Title & Badge
    $fJTitle = [System.Drawing.Font]::new("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
    $g2.DrawString($item.Type, $fJTitle, $bTitle, [System.Drawing.RectangleF]::new($x + 20, $jY + 185, $jW - 40, 45), $sfCenter)
    
    $fJSub = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $bJSub = [System.Drawing.SolidBrush]::new($item.Color)
    $g2.DrawString($item.Badge, $fJSub, $bJSub, [System.Drawing.RectangleF]::new($x + 20, $jY + 235, $jW - 40, 30), $sfCenter)
    
    # Syntax Code Box
    $codeBoxH = 110
    $codeBoxY = $jY + 285
    $pathCode = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathCode ($x + 25) $codeBoxY ($jW - 50) $codeBoxH 10
    $bCodeBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Dark slate
    $g2.FillPath($bCodeBg, $pathCode)
    
    $fCode = [System.Drawing.Font]::new("Consolas", 11.5, [System.Drawing.FontStyle]::Regular)
    $bCodeText = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(226, 232, 240))
    $rectCode = [System.Drawing.RectangleF]::new($x + 35, $codeBoxY + 10, $jW - 70, $codeBoxH - 20)
    $g2.DrawString($item.Syntax, $fCode, $bCodeText, $rectCode, $sfCenter)
    
    # Practical Use Explanation
    $fUse = [System.Drawing.Font]::new("Segoe UI", 13.5, [System.Drawing.FontStyle]::Regular)
    $bUse = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(51, 65, 85))
    $rectUse = [System.Drawing.RectangleF]::new($x + 30, $jY + 420, $jW - 60, 200)
    $g2.DrawString($item.Use, $fUse, $bUse, $rectUse, $sfCenter)
    
    # Bottom Rule Badge
    $fRule = [System.Drawing.Font]::new("Segoe UI", 11.5, [System.Drawing.FontStyle]::Bold)
    $g2.DrawString($item.Rule, $fRule, $bJSub, [System.Drawing.RectangleF]::new($x + 20, $jY + 685, $jW - 40, 35), $sfCenter)
}

$g2.DrawString("AINDHIN • DATA ANALYTICS CERTIFICATION COURSE • RELATIONAL DATABASE ARCHITECTURE", $fFoot, $bFoot, [System.Drawing.RectangleF]::new(40, 1010, 1840, 30), $sfCenter)

$outputPath2 = Join-Path $targetDir "sql-joins-diagram.jpg"
$bmp2.Save($outputPath2, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g2.Dispose()
$bmp2.Dispose()
Write-Host "[AINDHIN] Figure 2 saved: $outputPath2"

