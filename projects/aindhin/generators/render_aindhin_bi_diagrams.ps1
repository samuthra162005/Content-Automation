<#
.SYNOPSIS
    Generates high-resolution 1920x1080 (16:9) technical diagrams for Aindhin:
    1. hero-image.jpg (Power BI vs Tableau Decision Framework)
    2. bi-tools-comparison-matrix.jpg (Power BI vs Tableau Feature Matrix)
#>

Add-Type -AssemblyName System.Drawing

$targetDir = "d:\content\digital-marketing-skills\projects\aindhin\2026-11-14\power-bi-vs-tableau-which-tool-should-you-learn-first"

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
# INFOGRAPHIC 1: Decision Framework (hero-image.jpg)
# ==============================================================================
Write-Host "[AINDHIN] Generating Figure 1: hero-image.jpg..."

$bmp1 = [System.Drawing.Bitmap]::new(1920, 1080)
$g1 = [System.Drawing.Graphics]::FromImage($bmp1)
$g1.Clear([System.Drawing.Color]::FromArgb(255, 255, 255))
$g1.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g1.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g1.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g1.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$fTitle = [System.Drawing.Font]::new("Segoe UI", 38, [System.Drawing.FontStyle]::Bold)
$fSub = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Regular)
$bTitle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
$bSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(37, 99, 235)) # Tech Cobalt

$sfCenter = [System.Drawing.StringFormat]::new()
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
$sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

$g1.DrawString("POWER BI VS TABLEAU: DECISION FRAMEWORK", $fTitle, $bTitle, [System.Drawing.RectangleF]::new(40, 35, 1840, 60), $sfCenter)
$g1.DrawString("Strategic Decision Guide for Aspiring Data Analysts & Business Intelligence Learners", $fSub, $bSub, [System.Drawing.RectangleF]::new(40, 100, 1840, 40), $sfCenter)

# Left Column: Microsoft Power BI (Width: 860) | Right Column: Tableau (Width: 860)
$colW = 860
$colH = 800
$colY = 170
$leftX = 65
$rightX = 995

# 1. Left Card: Power BI
$pathPBI = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pathPBI $leftX $colY $colW $colH 18
$bBgPBI = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
$pBdrPBI = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(217, 119, 6), 3) # Amber border
$g1.FillPath($bBgPBI, $pathPBI)
$g1.DrawPath($pBdrPBI, $pathPBI)

# Header Banner for Power BI
$pathHdrPBI = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pathHdrPBI ($leftX + 2) ($colY + 2) ($colW - 4) 85 16
$bHdrPBI = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(217, 119, 6))
$g1.FillPath($bHdrPBI, $pathHdrPBI)

$fCardTitle = [System.Drawing.Font]::new("Segoe UI", 26, [System.Drawing.FontStyle]::Bold)
$fCardSub = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)
$bWhite = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)

$g1.DrawString("MICROSOFT POWER BI", $fCardTitle, $bWhite, [System.Drawing.RectangleF]::new($leftX, ($colY + 12), $colW, 40), $sfCenter)
$g1.DrawString("Best for Fast Corporate Integration & Excel Users", $fCardSub, $bWhite, [System.Drawing.RectangleF]::new($leftX, ($colY + 50), $colW, 30), $sfCenter)

# Features inside Power BI card
$pbiFeatures = @(
    @{ Title = "DATA MODELING & ETL"; Desc = "Powered by Power Query (M code) and VertiPaq tabular database engine with DAX calculations." },
    @{ Title = "LEARNING CURVE"; Desc = "Natural transition for Excel users; shorter initial ramp-up for business reporting workflows." },
    @{ Title = "PRICING & LICENSING"; Desc = "Free Power BI Desktop application for offline authoring; affordable Pro licensing per user." },
    @{ Title = "ECOSYSTEM SYNERGY"; Desc = "Seamless integration with Microsoft 365, Teams, Azure Synapse, and SharePoint portals." },
    @{ Title = "MARKET DEMAND"; Desc = "High volume of open corporate reporting roles across mid-market and enterprise businesses." }
)

$fFeatTitle = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$fFeatDesc = [System.Drawing.Font]::new("Segoe UI", 14, [System.Drawing.FontStyle]::Regular)
$bFeatTitle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
$bFeatDesc = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(71, 85, 105))

$sfLeft = [System.Drawing.StringFormat]::new()
$sfLeft.Alignment = [System.Drawing.StringAlignment]::Near
$sfLeft.LineAlignment = [System.Drawing.StringAlignment]::Center

$featY = $colY + 110
foreach ($feat in $pbiFeatures) {
    # Small box container
    $boxPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $boxPath ($leftX + 25) $featY ($colW - 50) 115 10
    $boxBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $boxPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(226, 232, 240), 1.5)
    $g1.FillPath($boxBrush, $boxPath)
    $g1.DrawPath($boxPen, $boxPath)
    
    # Amber indicator dot
    $dotBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(217, 119, 6))
    $g1.FillEllipse($dotBrush, ($leftX + 45), ($featY + 22), 12, 12)
    
    $g1.DrawString($feat.Title, $fFeatTitle, $bFeatTitle, [System.Drawing.RectangleF]::new(($leftX + 68), ($featY + 14), ($colW - 120), 28), $sfLeft)
    $g1.DrawString($feat.Desc, $fFeatDesc, $bFeatDesc, [System.Drawing.RectangleF]::new(($leftX + 45), ($featY + 44), ($colW - 90), 60), $sfLeft)
    
    $featY += 132
}

# 2. Right Card: Tableau
$pathTab = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pathTab $rightX $colY $colW $colH 18
$bBgTab = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
$pBdrTab = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(37, 99, 235), 3) # Cobalt border
$g1.FillPath($bBgTab, $pathTab)
$g1.DrawPath($pBdrTab, $pathTab)

# Header Banner for Tableau
$pathHdrTab = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pathHdrTab ($rightX + 2) ($colY + 2) ($colW - 4) 85 16
$bHdrTab = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(37, 99, 235))
$g1.FillPath($bHdrTab, $pathHdrTab)

$g1.DrawString("SALESFORCE TABLEAU", $fCardTitle, $bWhite, [System.Drawing.RectangleF]::new($rightX, ($colY + 12), $colW, 40), $sfCenter)
$g1.DrawString("Best for Advanced Exploratory Visuals & Visual Analytics", $fCardSub, $bWhite, [System.Drawing.RectangleF]::new($rightX, ($colY + 50), $colW, 30), $sfCenter)

# Features inside Tableau card
$tabFeatures = @(
    @{ Title = "VISUAL ANALYTICS ENGINE"; Desc = "Proprietary VizQL engine translates visual drag-and-drop actions into direct database queries." },
    @{ Title = "CUSTOM VISUAL FREEDOM"; Desc = "Granular shelf control, dual axes, bespoke chart types, and rich interactive graphic storytelling." },
    @{ Title = "PRICING & LICENSING"; Desc = "Tableau Public is free for open web portfolios; Tableau Desktop requires higher tier subscription." },
    @{ Title = "ECOSYSTEM SYNERGY"; Desc = "Deep integration with Salesforce CRM, multi-cloud data warehouses, and Snowflake instances." },
    @{ Title = "MARKET DEMAND"; Desc = "Strong prestige demand among senior visual analytics specialists and large research enterprises." }
)

$featY = $colY + 110
foreach ($feat in $tabFeatures) {
    # Small box container
    $boxPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $boxPath ($rightX + 25) $featY ($colW - 50) 115 10
    $boxBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $boxPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(226, 232, 240), 1.5)
    $g1.FillPath($boxBrush, $boxPath)
    $g1.DrawPath($boxPen, $boxPath)
    
    # Cobalt indicator dot
    $dotBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(37, 99, 235))
    $g1.FillEllipse($dotBrush, ($rightX + 45), ($featY + 22), 12, 12)
    
    $g1.DrawString($feat.Title, $fFeatTitle, $bFeatTitle, [System.Drawing.RectangleF]::new(($rightX + 68), ($featY + 14), ($colW - 120), 28), $sfLeft)
    $g1.DrawString($feat.Desc, $fFeatDesc, $bFeatDesc, [System.Drawing.RectangleF]::new(($rightX + 45), ($featY + 44), ($colW - 90), 60), $sfLeft)
    
    $featY += 132
}

# Footer Brand Banner
$fFooter = [System.Drawing.Font]::new("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
$bFooter = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(100, 116, 139))
$g1.DrawString("AINDHIN DATA ANALYTICS ACADEMY  |  PRACTICAL BUSINESS INTELLIGENCE CURRICULUM", $fFooter, $bFooter, [System.Drawing.RectangleF]::new(40, 1025, 1840, 30), $sfCenter)

$img1Path = Join-Path $targetDir "hero-image.jpg"
$bmp1.Save($img1Path, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp1.Dispose()
$g1.Dispose()
Write-Host "[SUCCESS] Generated Figure 1: $img1Path"


# ==============================================================================
# INFOGRAPHIC 2: Feature Matrix Diagram (bi-tools-comparison-matrix.jpg)
# ==============================================================================
Write-Host "[AINDHIN] Generating Figure 2: bi-tools-comparison-matrix.jpg..."

$bmp2 = [System.Drawing.Bitmap]::new(1920, 1080)
$g2 = [System.Drawing.Graphics]::FromImage($bmp2)
$g2.Clear([System.Drawing.Color]::FromArgb(255, 255, 255))
$g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g2.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g2.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g2.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$g2.DrawString("POWER BI VS TABLEAU FEATURE MATRIX", $fTitle, $bTitle, [System.Drawing.RectangleF]::new(40, 35, 1840, 60), $sfCenter)
$g2.DrawString("In-Depth Capability Breakdown Across Architecture, Workflow, and Career Readiness", $fSub, $bSub, [System.Drawing.RectangleF]::new(40, 100, 1840, 40), $sfCenter)

# Table Container (Width: 1780, Height: 810)
$tblX = 70
$tblY = 170
$tblW = 1780
$tblH = 810

$tblPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $tblPath $tblX $tblY $tblW $tblH 16
$bTblBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
$pTblBdr = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 2)
$g2.FillPath($bTblBg, $tblPath)
$g2.DrawPath($pTblBdr, $tblPath)

# Header Row
$colDimW = 380
$colPbiW = 700
$colTabW = 700

$hdrPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $hdrPath ($tblX + 2) ($tblY + 2) ($tblW - 4) 80 14
$bHdr = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Deep Navy
$g2.FillPath($bHdr, $hdrPath)

$fTh = [System.Drawing.Font]::new("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$g2.DrawString("EVALUATION CRITERIA", $fTh, $bWhite, [System.Drawing.RectangleF]::new($tblX + 30, $tblY + 22, $colDimW - 30, 40), $sfLeft)
$g2.DrawString("MICROSOFT POWER BI", $fTh, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(251, 191, 36)), [System.Drawing.RectangleF]::new($tblX + $colDimW + 40, $tblY + 22, $colPbiW - 40, 40), $sfLeft)
$g2.DrawString("SALESFORCE TABLEAU", $fTh, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(147, 197, 253)), [System.Drawing.RectangleF]::new($tblX + $colDimW + $colPbiW + 40, $tblY + 22, $colTabW - 40, 40), $sfLeft)

# 5 Comparative Rows
$rows = @(
    @{
        Criteria = "Data Modeling & ETL"
        PBI = "Built-in Power Query engine for transformation; VertiPaq tabular star schema; DAX calculation formulas."
        Tab = "Visual relationships and physical joins in Tableau Prep; optimized for pre-modeled relational databases."
    },
    @{
        Criteria = "Visual Customization"
        PBI = "Standard clean visual library with AppSource extensions; fast template deployment for executives."
        Tab = "Unrivaled creative freedom with dual axes, customized shelves, and bespoke geographical mapping."
    },
    @{
        Criteria = "Formula Language"
        PBI = "DAX (Data Analysis Expressions) - powerful row and filter context; steep learning curve for advanced metrics."
        Tab = "Tableau Calculated Fields and LOD (Level of Detail) expressions - intuitive syntax for visual exploration."
    },
    @{
        Criteria = "Cost & Accessibility"
        PBI = "100% Free Power BI Desktop for local development; highly affordable Pro user licensing for organizations."
        Tab = "Free Tableau Public for open portfolios; higher cost per Creator license for private enterprise work."
    },
    @{
        Criteria = "Recommended First Step"
        PBI = "Choose first if you want faster corporate hiring, work with Excel, or build standard operational reports."
        Tab = "Choose first if your goal is advanced visual storytelling, graphic design analytics, or research roles."
    }
)

$rowY = $tblY + 84
$rowH = 140

$fRowCrit = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$fRowBody = [System.Drawing.Font]::new("Segoe UI", 14, [System.Drawing.FontStyle]::Regular)
$bRowCrit = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59))
$bRowBody = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(51, 65, 85))

for ($i = 0; $i -lt $rows.Count; $i++) {
    $row = $rows[$i]
    $isEven = ($i % 2 -eq 0)
    
    if ($isEven) {
        $rowBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    } else {
        $rowBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(241, 245, 249))
    }
    
    $g2.FillRectangle($rowBg, ($tblX + 2), $rowY, ($tblW - 4), $rowH)
    
    # Separator Line
    $pLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(226, 232, 240), 1)
    $g2.DrawLine($pLine, ($tblX + 2), ($rowY + $rowH), ($tblX + $tblW - 2), ($rowY + $rowH))
    
    # Criteria
    $critRect = [System.Drawing.RectangleF]::new($tblX + 30, $rowY + 20, $colDimW - 40, $rowH - 40)
    $g2.DrawString($row.Criteria, $fRowCrit, $bRowCrit, $critRect, $sfLeft)
    
    # Power BI Column
    $pbiRect = [System.Drawing.RectangleF]::new($tblX + $colDimW + 40, $rowY + 15, $colPbiW - 60, $rowH - 30)
    $g2.DrawString($row.PBI, $fRowBody, $bRowBody, $pbiRect, $sfLeft)
    
    # Tableau Column
    $tabRect = [System.Drawing.RectangleF]::new($tblX + $colDimW + $colPbiW + 40, $rowY + 15, $colTabW - 60, $rowH - 30)
    $g2.DrawString($row.Tab, $fRowBody, $bRowBody, $tabRect, $sfLeft)
    
    $rowY += $rowH
}

# Footer Brand Banner
$g2.DrawString("AINDHIN DATA ANALYTICS ACADEMY  |  POWER BI & TABLEAU COMPREHENSIVE TRAINING", $fFooter, $bFooter, [System.Drawing.RectangleF]::new(40, 1025, 1840, 30), $sfCenter)

$img2Path = Join-Path $targetDir "bi-tools-comparison-matrix.jpg"
$bmp2.Save($img2Path, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp2.Dispose()
$g2.Dispose()
Write-Host "[SUCCESS] Generated Figure 2: $img2Path"

