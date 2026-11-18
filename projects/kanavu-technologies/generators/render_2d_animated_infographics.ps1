<#
.SYNOPSIS
    Generates high-resolution 1920x1080 (16:9) 2D illustrated/animated infographics for Kanavu Technologies.
    Matches the clean vector infographic benchmark:
    - Pure white canvas (#FFFFFF)
    - Centered top title + colored rounded pill badge
    - Illustrated vector core object on left (Laptop, AI Robot, Server Rack, Browser, Database, Phone, Shield)
    - Branching connector lines
    - Rounded pastel cards on right with white icon boxes and bold punchy text
#>

Add-Type -AssemblyName System.Drawing

$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-technologies\2026-11-18"

function Add-RoundedRectangle($path, $x, $y, $w, $h, $r) {
    $d = $r * 2
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
}

function Draw-TopHeader {
    param (
        [System.Drawing.Graphics]$g,
        [string]$Title,
        [string]$PillText,
        [string]$PillHex = "E11D48"
    )

    $sfCenter = [System.Drawing.StringFormat]::new()
    $sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
    $sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

    # Main Title
    $fTitle = [System.Drawing.Font]::new("Segoe UI", 40, [System.Drawing.FontStyle]::Bold)
    $bDark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
    $g.DrawString($Title, $fTitle, $bDark, [System.Drawing.RectangleF]::new(0, 42, 1920, 60), $sfCenter)

    # Highlight Pill Badge
    $fPill = [System.Drawing.Font]::new("Segoe UI", 25, [System.Drawing.FontStyle]::Bold)
    $szPill = $g.MeasureString($PillText, $fPill)
    $pillW = [Math]::Max(340, [int]($szPill.Width + 60))
    $pillH = 56
    $pillX = (1920 - $pillW) / 2
    $pillY = 114

    $pathPill = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $pathPill $pillX $pillY $pillW $pillH 28
    $bPill = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$PillHex"))
    $g.FillPath($bPill, $pathPill)

    $bWhite = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $g.DrawString($PillText, $fPill, $bWhite, [System.Drawing.RectangleF]::new($pillX, $pillY, $pillW, $pillH), $sfCenter)

    $fTitle.Dispose(); $bDark.Dispose(); $fPill.Dispose(); $bPill.Dispose(); $bWhite.Dispose(); $sfCenter.Dispose()
}

function Save-Infographic {
    param (
        [System.Drawing.Bitmap]$bmp,
        [string]$slug,
        [string]$filename
    )
    $dest = Join-Path $baseDir (Join-Path $slug $filename)
    $bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    Write-Output "Saved: $dest"
}

Write-Output "Infographic rendering framework initialized."

# =============================================================================
# 1. PILLAR HUB
# =============================================================================

# Image 1: Emerging Tech Adoption Lifecycle
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

Draw-TopHeader $g "Emerging Technologies for Modern Enterprise" "Strategic 2027 Roadmap" "2563EB"

# Left Illustration: 2D/3D Server Rack with Cloud & Gears
$lx = 140; $ly = 270; $lw = 580; $lh = 680

# Server Rack Cabinet
$rackPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $rackPath $lx $ly $lw $lh 28
$bRack = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(241, 245, 249))
$g.FillPath($bRack, $rackPath)
$pRack = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(203, 213, 225), 3)
$g.DrawPath($pRack, $rackPath)

# Rack Servers (4 server blades)
$bBlade = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59))
$bLedGreen = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(34, 197, 94))
$bLedBlue = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(59, 130, 246))
$fBlade = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$bWhite = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)

$bladeNames = @("CLOUD COMPUTE BLADE 01", "AI INFERENCE ENGINE 02", "ZERO-TRUST GATEWAY 03", "EDGE ROUTING NODE 04")
for ($i = 0; $i -lt 4; $i++) {
    $by = $ly + 50 + ($i * 145)
    $bldPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $bldPath ($lx + 35) $by ($lw - 70) 105 16
    $g.FillPath($bBlade, $bldPath)
    
    # LED lights
    $g.FillEllipse($bLedGreen, ($lx + 60), ($by + 48), 14, 14)
    $g.FillEllipse($bLedBlue, ($lx + 85), ($by + 48), 14, 14)
    
    # Text
    $g.DrawString($bladeNames[$i], $fBlade, $bWhite, ($lx + 120), ($by + 42))
}

# Branching connector lines
$pLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(37, 99, 235), 3.5)
$g.DrawLine($pLine, ($lx + $lw), 345, 910, 345)
$g.DrawLine($pLine, ($lx + $lw), 515, 910, 515)
$g.DrawLine($pLine, ($lx + $lw), 685, 910, 685)
$g.DrawLine($pLine, ($lx + $lw), 855, 910, 855)

# Right Cards (4 rounded pastel cards)
$stages = @(
    @{ Title = "1. Cloud Native Modernization"; Sub = "Microservices architecture eliminating monolithic single points of failure."; Bg = "E0F2FE"; Icon = "cloud"; Y = 265 },
    @{ Title = "2. Autonomous AI Agent Workflows"; Sub = "Self-directed agent swarms automating enterprise operational workflows."; Bg = "EDE9FE"; Icon = "brain"; Y = 435 },
    @{ Title = "3. Zero-Trust Cyber Resilience"; Sub = "Continuous identity token authentication and isolated security perimeters."; Bg = "DCFCE7"; Icon = "shield"; Y = 605 },
    @{ Title = "4. Edge Computing & Low Latency"; Sub = "Sub-10ms decentralized processing at global points of enterprise presence."; Bg = "FEF3C7"; Icon = "bolt"; Y = 775 }
)

$cardW = 870; $cardH = 140; $cardX = 910
$fCTitle = [System.Drawing.Font]::new("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)
$fCSub = [System.Drawing.Font]::new("Segoe UI", 13.5, [System.Drawing.FontStyle]::Regular)
$bDark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
$bSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(71, 85, 105))

foreach ($st in $stages) {
    $cPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $cPath $cardX $st.Y $cardW $cardH 20
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($st.Bg)"))
    $g.FillPath($bBg, $cPath)
    
    # White icon square
    $ibPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $ibPath ($cardX + 25) ($st.Y + 25) 90 90 14
    $g.FillPath($bWhite, $ibPath)
    
    # Draw icon
    $fIcon = [System.Drawing.Font]::new("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
    $bIcon = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(37, 99, 235))
    $sfC = [System.Drawing.StringFormat]::new()
    $sfC.Alignment = [System.Drawing.StringAlignment]::Center
    $sfC.LineAlignment = [System.Drawing.StringAlignment]::Center
    
    $sym = if ($st.Icon -eq "cloud") { "☁" } elseif ($st.Icon -eq "brain") { "⚙" } elseif ($st.Icon -eq "shield") { "🛡" } else { "⚡" }
    $g.DrawString($sym, $fIcon, $bIcon, [System.Drawing.RectangleF]::new(($cardX + 25), ($st.Y + 25), 90, 90), $sfC)
    
    # Text
    $g.DrawString($st.Title, $fCTitle, $bDark, ($cardX + 135), ($st.Y + 32))
    $g.DrawString($st.Sub, $fCSub, $bSub, ($cardX + 135), ($st.Y + 75))
}

$g.Dispose()
Save-Infographic $bmp "pillar-emerging-technologies-and-it-developments" "emerging_tech_adoption_lifecycle_2027.jpg"
$bmp.Dispose()


# Image 2: Legacy Monoliths vs Distributed Cloud Native (Side-by-side Illustrated Comparison)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::White)

Draw-TopHeader $g "Legacy Monolith vs Distributed Cloud" "Architecture Comparison" "059669"

$cardW = 820; $cardH = 750; $cardY = 240
# Left: Legacy Monolith (Red Accent)
$lPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $lPath 100 $cardY $cardW $cardH 24
$bLBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(254, 242, 242)) # Light Red
$g.FillPath($bLBg, $lPath)
$pLBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(252, 165, 165), 3)
$g.DrawPath($pLBorder, $lPath)

# Red Title Badge
$fHdr = [System.Drawing.Font]::new("Segoe UI", 26, [System.Drawing.FontStyle]::Bold)
$bRed = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(220, 38, 38))
$g.DrawString("Legacy Monolithic Architecture", $fHdr, $bRed, 140, ($cardY + 40))

# Warning Triangle Icon
$triPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $triPath 140 ($cardY + 110) 90 90 18
$g.FillPath($bWhite, $triPath)
$fWarn = [System.Drawing.Font]::new("Segoe UI", 34, [System.Drawing.FontStyle]::Bold)
$g.DrawString("⚠️", $fWarn, $bRed, 150, ($cardY + 120))

$fDesc = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)
$bDark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
$g.DrawString("Centralized single point of failure where tightly coupled code causes cascading system outages and slow releases.", $fDesc, $bDark, [System.Drawing.RectangleF]::new(250, ($cardY + 120), 620, 80))

$legItems = @(
    "1. Catastrophic Blast Radius: One bug crashes entire application",
    "2. Rigid Release Freezes: 6 to 12 month deployment bottlenecks",
    "3. Vertical Scaling Limit: Forced into expensive idle server hardware",
    "4. Opaque Architecture: Spaghetti dependencies prevent tracing"
)
$iy = $cardY + 240
$fItem = [System.Drawing.Font]::new("Segoe UI", 17, [System.Drawing.FontStyle]::Bold)
foreach ($it in $legItems) {
    $rowPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $rowPath 140 $iy ($cardW - 80) 95 16
    $g.FillPath($bWhite, $rowPath)
    $g.DrawString($it, $fItem, $bDark, [System.Drawing.RectangleF]::new(165, ($iy + 28), ($cardW - 130), 55))
    $iy += 115
}

# Right: Distributed Cloud Native (Green Accent)
$rPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $rPath 1000 $cardY $cardW $cardH 24
$bRBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(240, 253, 244)) # Light Green
$g.FillPath($bRBg, $rPath)
$pRBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(134, 239, 172), 3)
$g.DrawPath($pRBorder, $rPath)

# Green Title Badge
$bGreen = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(22, 101, 52))
$g.DrawString("Distributed Cloud Native Mesh", $fHdr, $bGreen, 1040, ($cardY + 40))

# Green Checkmark Icon
$chkPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $chkPath 1040 ($cardY + 110) 90 90 18
$g.FillPath($bWhite, $chkPath)
$g.DrawString("✅", $fWarn, $bGreen, 1050, ($cardY + 120))

$g.DrawString("Isolated containerized microservices providing independent resilience, zero downtime updates, and elastic auto scaling.", $fDesc, $bDark, [System.Drawing.RectangleF]::new(1150, ($cardY + 120), 620, 80))

$cloudItems = @(
    "1. Fault-Isolated Pods: Single service failures never trigger downtime",
    "2. Continuous Deployment: Safely ship updates multiple times daily",
    "3. Dynamic Auto-Scaling: Horizontal elasticity on real traffic spikes",
    "4. End-to-End Tracing: Complete observability across distributed nodes"
)
$iy = $cardY + 240
foreach ($it in $cloudItems) {
    $rowPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $rowPath 1040 $iy ($cardW - 80) 95 16
    $g.FillPath($bWhite, $rowPath)
    $g.DrawString($it, $fItem, $bDark, [System.Drawing.RectangleF]::new(1065, ($iy + 28), ($cardW - 130), 55))
    $iy += 115
}

$g.Dispose()
Save-Infographic $bmp "pillar-emerging-technologies-and-it-developments" "legacy_vs_cloud_native_architecture_2027.jpg"
$bmp.Dispose()


# =============================================================================
# 2. BLOG 1: RAG VS LLM
# =============================================================================

# Image 1: How RAG Works (Vector Core + Branching Cards)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

Draw-TopHeader $g "How Retrieval-Augmented Generation Works" "RAG vs Traditional LLM" "0284C7"

# Left Illustration: Vector Neural Core + Database Cylinder
$lx = 140; $ly = 280; $lw = 580; $lh = 660

$corePath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $corePath $lx $ly $lw $lh 28
$bCore = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(240, 249, 255))
$g.FillPath($bCore, $corePath)
$pCore = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(186, 230, 253), 3)
$g.DrawPath($pCore, $corePath)

# Vector Database Cylinder Illustration
$cylX = $lx + 150; $cylY = $ly + 80; $cylW = 280; $cylH = 180
$bCyl = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(2, 132, 199))
$g.FillEllipse($bCyl, $cylX, $cylY, $cylW, 70)
$g.FillRectangle($bCyl, $cylX, ($cylY + 35), $cylW, 110)
$bCylDark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(3, 105, 161))
$g.FillEllipse($bCylDark, $cylX, ($cylY + 110), $cylW, 70)

$fCyl = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)
$sfC = [System.Drawing.StringFormat]::new()
$sfC.Alignment = [System.Drawing.StringAlignment]::Center
$sfC.LineAlignment = [System.Drawing.StringAlignment]::Center
$g.DrawString("VECTOR DATABASE", $fCyl, $bWhite, [System.Drawing.RectangleF]::new($cylX, ($cylY + 50), $cylW, 60), $sfC)

# Neural Node Brain Box below database
$aiBox = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $aiBox ($lx + 80) ($ly + 320) ($lw - 160) 260 20
$bAiBox = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59))
$g.FillPath($bAiBox, $aiBox)

$fAi = [System.Drawing.Font]::new("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$g.DrawString("LLM REASONING CORE", $fAi, $bWhite, [System.Drawing.RectangleF]::new(($lx + 80), ($ly + 350), ($lw - 160), 50), $sfC)
$fAiSub = [System.Drawing.Font]::new("Segoe UI", 15, [System.Drawing.FontStyle]::Regular)
$bMuted = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(148, 163, 184))
$g.DrawString("Dynamic Context Ingestion & Grounding", $fAiSub, $bMuted, [System.Drawing.RectangleF]::new(($lx + 80), ($ly + 410), ($lw - 160), 40), $sfC)

# Downward flow arrow from DB to LLM
$pFlow = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(14, 165, 233), 4)
$g.DrawLine($pFlow, ($lx + $lw/2), ($cylY + 180), ($lx + $lw/2), ($ly + 320))

# Branching connector lines to right cards
$pLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(2, 132, 199), 3.5)
$g.DrawLine($pLine, ($lx + $lw), 340, 890, 340)
$g.DrawLine($pLine, ($lx + $lw), 560, 890, 560)
$g.DrawLine($pLine, ($lx + $lw), 780, 890, 780)

# Right Cards (3 rounded cards)
$ragCards = @(
    @{ Title = "1. Vector Semantic Retrieval"; Sub = "Queries company knowledge vault for top-k relevant document chunks via cosine similarity."; Bg = "E0F2FE"; Sym = "🗄️"; Y = 250 },
    @{ Title = "2. Real-Time Prompt Augmentation"; Sub = "Injects verified enterprise records directly into the LLM system prompt at runtime."; Bg = "EDE9FE"; Sym = "📄"; Y = 470 },
    @{ Title = "3. Grounded Factual Output"; Sub = "Generates hallucination-free answers with transparent citations and source links."; Bg = "DCFCE7"; Sym = "✅"; Y = 690 }
)

$cardW = 890; $cardH = 180; $cardX = 890
$fCTitle = [System.Drawing.Font]::new("Segoe UI", 23, [System.Drawing.FontStyle]::Bold)
$fCSub = [System.Drawing.Font]::new("Segoe UI", 15, [System.Drawing.FontStyle]::Regular)

foreach ($c in $ragCards) {
    $cPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $cPath $cardX $c.Y $cardW $cardH 22
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($c.Bg)"))
    $g.FillPath($bBg, $cPath)
    
    # White icon box
    $ibPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $ibPath ($cardX + 35) ($c.Y + 30) 120 120 18
    $g.FillPath($bWhite, $ibPath)
    
    $fSym = [System.Drawing.Font]::new("Segoe UI", 36, [System.Drawing.FontStyle]::Bold)
    $bSym = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(2, 132, 199))
    $g.DrawString($c.Sym, $fSym, $bSym, [System.Drawing.RectangleF]::new(($cardX + 35), ($c.Y + 30), 120, 120), $sfC)
    
    $g.DrawString($c.Title, $fCTitle, $bDark, ($cardX + 185), ($c.Y + 45))
    $g.DrawString($c.Sub, $fCSub, $bSub, [System.Drawing.RectangleF]::new(($cardX + 185), ($c.Y + 95), ($cardW - 210), 65))
}

$g.Dispose()
Save-Infographic $bmp "blog-1-rag-vs-llm" "rag_vs_traditional_llm_architecture_2027.jpg"
$bmp.Dispose()


# Image 2: RAG vs Standalone LLM Enterprise Decision Matrix
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::White)

Draw-TopHeader $g "Why Enterprises Standardize on RAG" "Enterprise Decision Matrix" "7C3AED"

$matrixCards = @(
    @{ Param = "Knowledge Recency"; LLM = "Static training cutoff date"; RAG = "Real-time sync with live enterprise data"; Bg = "E0F2FE"; Color = "0284C7" },
    @{ Param = "Hallucination Risk"; LLM = "High risk of plausible falsehoods"; RAG = "Zero hallucinations; verified source citations"; Bg = "DCFCE7"; Color = "16A34A" },
    @{ Param = "Access Control & Security"; LLM = "No document permission boundaries"; RAG = "Granular role-based access per data chunk"; Bg = "EDE9FE"; Color = "7C3AED" },
    @{ Param = "Inference & Training Cost"; LLM = "Multi-million dollar model retraining"; RAG = "Low compute cost via vector index updates"; Bg = "FEF3C7"; Color = "D97706" }
)

$w = 1720; $h = 160; $gap = 25; $startY = 240
$fP = [System.Drawing.Font]::new("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$fV = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)
$fVB = [System.Drawing.Font]::new("Segoe UI", 16.5, [System.Drawing.FontStyle]::Bold)

for ($i = 0; $i -lt 4; $i++) {
    $mc = $matrixCards[$i]
    $y = $startY + ($i * ($h + $gap))
    
    $p = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $p 100 $y $w $h 20
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($mc.Bg)"))
    $g.FillPath($bBg, $p)
    
    # Left parameter badge
    $bAcc = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($mc.Color)"))
    $g.FillRectangle($bAcc, 100, $y, 10, $h)
    
    $g.DrawString($mc.Param, $fP, $bDark, 140, ($y + 25))
    
    # Comparison pills
    $g.DrawString("Traditional LLM: ", $fVB, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(220, 38, 38)), 140, ($y + 85))
    $g.DrawString($mc.LLM, $fV, $bDark, 300, ($y + 85))
    
    $g.DrawString("RAG Solution: ", $fVB, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(22, 101, 52)), 850, ($y + 85))
    $g.DrawString($mc.RAG, $fVB, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(22, 101, 52)), 990, ($y + 85))
}

$g.Dispose()
Save-Infographic $bmp "blog-1-rag-vs-llm" "rag_enterprise_implementation_matrix_2027.jpg"
$bmp.Dispose()

# =============================================================================
# 3. BLOG 2: TYPES OF AI IN 2027
# =============================================================================

# Image 1: Four Core Types of AI (Friendly 2D AI Robot + Branching Cards)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

Draw-TopHeader $g "Four Core Types of Artificial Intelligence" "2027 Enterprise Taxonomy" "059669"

# Left Illustration: Friendly 2D AI Robot Core
$lx = 140; $ly = 270; $lw = 580; $lh = 680

# Outer Chassis
$botPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $botPath $lx $ly $lw $lh 28
$bBot = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(240, 253, 244))
$g.FillPath($bBot, $botPath)
$pBot = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(167, 243, 208), 3)
$g.DrawPath($pBot, $botPath)

# Robot Head / Screen
$headPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $headPath ($lx + 90) ($ly + 80) ($lw - 180) 240 24
$bHead = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59))
$g.FillPath($bHead, $headPath)

# Visor Glow
$visPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $visPath ($lx + 130) ($ly + 130) ($lw - 260) 100 20
$bVis = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(16, 185, 129))
$g.FillPath($bVis, $visPath)

# Visor Eyes (Smiling digital eyes)
$fEyes = [System.Drawing.Font]::new("Segoe UI", 48, [System.Drawing.FontStyle]::Bold)
$sfC = [System.Drawing.StringFormat]::new()
$sfC.Alignment = [System.Drawing.StringAlignment]::Center
$sfC.LineAlignment = [System.Drawing.StringAlignment]::Center
$g.DrawString("^  ^", $fEyes, $bWhite, [System.Drawing.RectangleF]::new(($lx + 130), ($ly + 125), ($lw - 260), 100), $sfC)

# Antenna on head
$pAnt = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(16, 185, 129), 6)
$g.DrawLine($pAnt, ($lx + $lw/2), ($ly + 80), ($lx + $lw/2), ($ly + 30))
$g.FillEllipse($bVis, ($lx + $lw/2 - 15), ($ly + 15), 30, 30)

# Robot Chest Badge
$fChest = [System.Drawing.Font]::new("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$bDark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
$g.DrawString("AUTONOMOUS AGENT CORE", $fChest, $bDark, [System.Drawing.RectangleF]::new(($lx + 40), ($ly + 380), ($lw - 80), 50), $sfC)

$fChestSub = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)
$bSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(71, 85, 105))
$g.DrawString("Multi-Tier Cognitive Architecture\nReactive → Predictive → Generative → Agentic", $fChestSub, $bSub, [System.Drawing.RectangleF]::new(($lx + 40), ($ly + 440), ($lw - 80), 80), $sfC)

# Branching connector lines to cards
$pLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(16, 185, 129), 3.5)
$g.DrawLine($pLine, ($lx + $lw), 345, 910, 345)
$g.DrawLine($pLine, ($lx + $lw), 515, 910, 515)
$g.DrawLine($pLine, ($lx + $lw), 685, 910, 685)
$g.DrawLine($pLine, ($lx + $lw), 855, 910, 855)

# Right Cards (4 rounded pastel cards)
$aiCards = @(
    @{ Title = "1. Reactive Automation Systems"; Sub = "Rule-based engines and deterministic solvers operating with zero memory retention."; Bg = "F1F5F9"; Sym = "⚙️"; Y = 265 },
    @{ Title = "2. Predictive Machine Learning"; Sub = "Supervised models for transaction fraud scoring, risk detection, and forecasting."; Bg = "E0F2FE"; Sym = "📊"; Y = 435 },
    @{ Title = "3. Multimodal Foundation Models"; Sub = "Large neural models synthesizing fluent language, technical code, and creative assets."; Bg = "EDE9FE"; Sym = "🧠"; Y = 605 },
    @{ Title = "4. Autonomous Agentic Swarms"; Sub = "Self-directed multi-agent networks executing complex multi-step corporate workflows."; Bg = "DCFCE7"; Sym = "🤖"; Y = 775 }
)

$cardW = 870; $cardH = 140; $cardX = 910
$fCTitle = [System.Drawing.Font]::new("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)
$fCSub = [System.Drawing.Font]::new("Segoe UI", 13.5, [System.Drawing.FontStyle]::Regular)

foreach ($c in $aiCards) {
    $cPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $cPath $cardX $c.Y $cardW $cardH 20
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($c.Bg)"))
    $g.FillPath($bBg, $cPath)
    
    # White icon square
    $ibPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $ibPath ($cardX + 25) ($c.Y + 25) 90 90 14
    $g.FillPath($bWhite, $ibPath)
    
    $fSym = [System.Drawing.Font]::new("Segoe UI", 26, [System.Drawing.FontStyle]::Bold)
    $g.DrawString($c.Sym, $fSym, $bDark, [System.Drawing.RectangleF]::new(($cardX + 25), ($c.Y + 25), 90, 90), $sfC)
    
    $g.DrawString($c.Title, $fCTitle, $bDark, ($cardX + 135), ($c.Y + 32))
    $g.DrawString($c.Sub, $fCSub, $bSub, [System.Drawing.RectangleF]::new(($cardX + 135), ($c.Y + 75), ($cardW - 150), 55))
}

$g.Dispose()
Save-Infographic $bmp "blog-2-types-of-ai-in-2027" "types_of_ai_evolutionary_taxonomy_2027.jpg"
$bmp.Dispose()


# Image 2: Real-World Enterprise AI Applications (4 Illustrated Departmental Cards)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::White)

Draw-TopHeader $g "Real-World Enterprise AI Applications" "Cross-Industry Deployments" "4F46E5"

$appCards = @(
    @{ Title = "1. Customer Operations"; Sub = "Autonomous Support Agents"; Desc = "Multi-turn autonomous resolvers handling tier-1 and tier-2 customer support inquiries with direct CRM synchronization."; Bg = "E0F2FE"; Sym = "🎧"; X = 100; Y = 250 },
    @{ Title = "2. Software Engineering"; Sub = "Autonomous Developer Workflows"; Desc = "Intelligent coding assistants accelerating delivery via automated test synthesis, neural code review, and instant documentation."; Bg = "EDE9FE"; Sym = "💻"; X = 980; Y = 250 },
    @{ Title = "3. Supply Chain Logistics"; Sub = "Predictive Fulfillment Networks"; Desc = "Algorithmic forecasting models dynamically optimizing warehouse inventory, shipping routes, and supplier disruptions."; Bg = "DCFCE7"; Sym = "🚚"; X = 100; Y = 620 },
    @{ Title = "4. Financial Risk & Compliance"; Sub = "Algorithmic Governance Engines"; Desc = "Real-time transaction fraud scoring engines analyzing millions of events per second with auditable compliance trails."; Bg = "FEF3C7"; Sym = "🛡️"; X = 980; Y = 620 }
)

$w = 840; $h = 330
$fTitle = [System.Drawing.Font]::new("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$fSub = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$fDesc = [System.Drawing.Font]::new("Segoe UI", 15, [System.Drawing.FontStyle]::Regular)

foreach ($c in $appCards) {
    $p = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $p $c.X $c.Y $w $h 24
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($c.Bg)"))
    $g.FillPath($bBg, $p)
    
    # White icon box
    $ibPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $ibPath ($c.X + 35) ($c.Y + 35) 90 90 18
    $g.FillPath($bWhite, $ibPath)
    
    $fSym = [System.Drawing.Font]::new("Segoe UI", 30, [System.Drawing.FontStyle]::Bold)
    $g.DrawString($c.Sym, $fSym, $bDark, [System.Drawing.RectangleF]::new(($c.X + 35), ($c.Y + 35), 90, 90), $sfC)
    
    $g.DrawString($c.Title, $fTitle, $bDark, ($c.X + 150), ($c.Y + 40))
    $g.DrawString($c.Sub, $fSub, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(79, 70, 229)), ($c.X + 150), ($c.Y + 80))
    
    $g.DrawString($c.Desc, $fDesc, $bDark, [System.Drawing.RectangleF]::new(($c.X + 35), ($c.Y + 155), ($w - 70), 140))
}

$g.Dispose()
Save-Infographic $bmp "blog-2-types-of-ai-in-2027" "real_world_ai_enterprise_applications_2027.jpg"
$bmp.Dispose()


# =============================================================================
# 4. BLOG 3: BEST FRONTEND FRAMEWORKS FOR ENTERPRISE IN 2027
# =============================================================================

# Image 1: Top Frontend Frameworks (Web Browser Window + 3 Branching Cards)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

Draw-TopHeader $g "Top Frontend Frameworks for Enterprise" "React vs Angular vs Vue" "2563EB"

# Left Illustration: Modern Web Browser Window
$lx = 140; $ly = 280; $lw = 580; $lh = 660

$brwPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $brwPath $lx $ly $lw $lh 24
$bBrw = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59))
$g.FillPath($bBrw, $brwPath)

# Browser Title Bar (3 dots)
$g.FillEllipse([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(239, 68, 68)), ($lx + 30), ($ly + 25), 16, 16)
$g.FillEllipse([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(245, 158, 11)), ($lx + 55), ($ly + 25), 16, 16)
$g.FillEllipse([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(34, 197, 94)), ($lx + 80), ($ly + 25), 16, 16)

# URL bar
$urlPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $urlPath ($lx + 120) ($ly + 18) ($lw - 150) 30 12
$bUrl = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(51, 65, 85))
$g.FillPath($bUrl, $urlPath)
$fUrl = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Regular)
$g.DrawString("https://enterprise.portal/dashboard", $fUrl, $bWhite, ($lx + 135), ($ly + 22))

# Inner Browser Content
$inPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $inPath ($lx + 20) ($ly + 65) ($lw - 40) ($lh - 85) 16
$bIn = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
$g.FillPath($bIn, $inPath)

# UI Elements inside browser (Charts, cards)
$fUi = [System.Drawing.Font]::new("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$g.DrawString("ENTERPRISE UI", $fUi, $bDark, ($lx + 50), ($ly + 100))

# Mock interactive widgets
$g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(224, 242, 254)), ($lx + 50), ($ly + 160), 220, 130)
$g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(254, 242, 242)), ($lx + 290), ($ly + 160), 220, 130)
$g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(240, 253, 244)), ($lx + 50), ($ly + 320), 460, 240)

# Branching connector lines to right cards
$pLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(37, 99, 235), 3.5)
$g.DrawLine($pLine, ($lx + $lw), 340, 890, 340)
$g.DrawLine($pLine, ($lx + $lw), 560, 890, 560)
$g.DrawLine($pLine, ($lx + $lw), 780, 890, 780)

# Right Cards (3 rounded cards)
$fwCards = @(
    @{ Title = "1. React 19+ & Next.js"; Sub = "React Server Components (RSC), unmatched global developer talent pool, and flexible ecosystem architecture."; Bg = "E0F2FE"; Sym = "⚛️"; Y = 250 },
    @{ Title = "2. Angular 19+ Enterprise"; Sub = "Batteries-included enterprise framework with strict TypeScript enforcement, native dependency injection, and RxJS."; Bg = "FEE2E2"; Sym = "🛡️"; Y = 470 },
    @{ Title = "3. Vue 3.5+ & Nuxt"; Sub = "Fine-grained reactive signals core, intuitive Composition API, and rapid developer onboarding with minimal overhead."; Bg = "DCFCE7"; Sym = "⚡"; Y = 690 }
)

$cardW = 890; $cardH = 180; $cardX = 890
$fCTitle = [System.Drawing.Font]::new("Segoe UI", 23, [System.Drawing.FontStyle]::Bold)
$fCSub = [System.Drawing.Font]::new("Segoe UI", 15, [System.Drawing.FontStyle]::Regular)

foreach ($c in $fwCards) {
    $cPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $cPath $cardX $c.Y $cardW $cardH 22
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($c.Bg)"))
    $g.FillPath($bBg, $cPath)
    
    $ibPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $ibPath ($cardX + 35) ($c.Y + 30) 120 120 18
    $g.FillPath($bWhite, $ibPath)
    
    $fSym = [System.Drawing.Font]::new("Segoe UI", 36, [System.Drawing.FontStyle]::Bold)
    $g.DrawString($c.Sym, $fSym, $bDark, [System.Drawing.RectangleF]::new(($cardX + 35), ($c.Y + 30), 120, 120), $sfC)
    
    $g.DrawString($c.Title, $fCTitle, $bDark, ($cardX + 185), ($c.Y + 45))
    $g.DrawString($c.Sub, $fCSub, $bSub, [System.Drawing.RectangleF]::new(($cardX + 185), ($c.Y + 95), ($cardW - 210), 65))
}

$g.Dispose()
Save-Infographic $bmp "blog-3-best-frontend-frameworks-enterprise-2027" "react_angular_vue_enterprise_matrix_2027.jpg"
$bmp.Dispose()


# Image 2: Enterprise Frontend Scalability Blueprint (4-Tier Horizontal Architecture)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::White)

Draw-TopHeader $g "Enterprise Frontend Scalability Blueprint" "4-Tier Web Architecture" "0D9488"

$archTiers = @(
    @{ Tier = "Tier 1: Global Edge CDN Caching"; Desc = "Cloudflare and AWS edge proxies delivering static assets with sub-10ms global TTFB latency."; Bg = "E0F2FE"; Color = "0284C7" },
    @{ Tier = "Tier 2: Server-Side Rendering (SSR)"; Desc = "React Server Components and Nuxt server engines pre-rendering dynamic HTML for zero layout shifts."; Bg = "EEF2FF"; Color = "4F46E5" },
    @{ Tier = "Tier 3: Distributed State & Island Hydration"; Desc = "Selective client island hydration and fine-grained reactive signals syncing state without main-thread blocking."; Bg = "FAF5FF"; Color = "7C3AED" },
    @{ Tier = "Tier 4: Backend Microservices & BFF Gateway"; Desc = "Secure API gateways aggregating GraphQL and REST microservices with rate-limited JWT tokens."; Bg = "F0FDF4"; Color = "16A34A" }
)

$w = 1720; $h = 160; $gap = 25; $startY = 240
$fTier = [System.Drawing.Font]::new("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$fTierDesc = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)

for ($i = 0; $i -lt 4; $i++) {
    $tr = $archTiers[$i]
    $y = $startY + ($i * ($h + $gap))
    
    $p = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $p 100 $y $w $h 20
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($tr.Bg)"))
    $g.FillPath($bBg, $p)
    
    $bAcc = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($tr.Color)"))
    $g.FillRectangle($bAcc, 100, $y, 10, $h)
    
    $g.DrawString($tr.Tier, $fTier, $bDark, 140, ($y + 35))
    $g.DrawString($tr.Desc, $fTierDesc, $bSub, [System.Drawing.RectangleF]::new(140, ($y + 85), ($w - 180), 55))
}

$g.Dispose()
Save-Infographic $bmp "blog-3-best-frontend-frameworks-enterprise-2027" "enterprise_frontend_scalability_blueprint_2027.jpg"
$bmp.Dispose()

# =============================================================================
# 5. BLOG 4: AI IN CUSTOM WEB APPLICATION DEVELOPMENT
# =============================================================================

# Image 1: How AI Accelerates Web Dev (Developer Workstation + 4 Branching Cards)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

Draw-TopHeader $g "How AI Accelerates Custom Web Development" "Modern Developer Workflow" "7C3AED"

# Left Illustration: Dual-Monitor Developer Workstation
$lx = 140; $ly = 270; $lw = 580; $lh = 680

$wsPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $wsPath $lx $ly $lw $lh 28
$bWs = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(245, 243, 255))
$g.FillPath($bWs, $wsPath)
$pWs = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(221, 214, 254), 3)
$g.DrawPath($pWs, $wsPath)

# Monitor 1 (Main IDE Screen)
$m1Path = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $m1Path ($lx + 50) ($ly + 60) ($lw - 100) 280 18
$bM1 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59))
$g.FillPath($bM1, $m1Path)

$fCode = [System.Drawing.Font]::new("Consolas", 15, [System.Drawing.FontStyle]::Regular)
$bCodeGreen = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(52, 211, 153))
$g.DrawString("// AI Neural Code Scaffolding`nconst schema = createEnterpriseSchema();`nawait api.generateSyntheticTests();`nreturn deployToEdgeCluster();", $fCode, $bCodeGreen, ($lx + 70), ($ly + 80))

# Stand for Monitor 1
$g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(100, 116, 139)), ($lx + $lw/2 - 20), ($ly + 340), 40, 50)
$g.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(71, 85, 105)), ($lx + $lw/2 - 60), ($ly + 390), 120, 15)

# Copilot Assistant Badge below monitor
$badgePath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $badgePath ($lx + 80) ($ly + 440) ($lw - 160) 180 20
$bCopilot = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(124, 58, 237))
$g.FillPath($bCopilot, $badgePath)

$fCp = [System.Drawing.Font]::new("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$sfC = [System.Drawing.StringFormat]::new()
$sfC.Alignment = [System.Drawing.StringAlignment]::Center
$sfC.LineAlignment = [System.Drawing.StringAlignment]::Center
$g.DrawString("AI COPILOT RUNTIME", $fCp, $bWhite, [System.Drawing.RectangleF]::new(($lx + 80), ($ly + 465), ($lw - 160), 50), $sfC)
$fCpSub = [System.Drawing.Font]::new("Segoe UI", 15, [System.Drawing.FontStyle]::Regular)
$g.DrawString("Automating Repetitive Engineering Tasks", $fCpSub, $bWhite, [System.Drawing.RectangleF]::new(($lx + 80), ($ly + 525), ($lw - 160), 40), $sfC)

# Branching connector lines to right cards
$pLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(124, 58, 237), 3.5)
$g.DrawLine($pLine, ($lx + $lw), 345, 910, 345)
$g.DrawLine($pLine, ($lx + $lw), 515, 910, 515)
$g.DrawLine($pLine, ($lx + $lw), 685, 910, 685)
$g.DrawLine($pLine, ($lx + $lw), 855, 910, 855)

# Right Cards (4 rounded cards)
$devCards = @(
    @{ Title = "1. Neural Code & Schema Scaffolding"; Sub = "Generates complete database schemas, API routers, and UI components in minutes."; Bg = "E0F2FE"; Sym = "</>"; Y = 265 },
    @{ Title = "2. Synthetic Test Suite Generation"; Sub = "Automates unit, integration, and E2E regression suites directly from API contracts."; Bg = "DBEAFE"; Sym = "🧪"; Y = 435 },
    @{ Title = "3. Neural PR Review & Static Checks"; Sub = "Instant pre-review analysis detecting vulnerabilities, leaks, and architecture deviations."; Bg = "EDE9FE"; Sym = "🔍"; Y = 605 },
    @{ Title = "4. Autonomous CI/CD Edge Deployment"; Sub = "Automated container builds, edge deployment, and instant synthetic health probes."; Bg = "DCFCE7"; Sym = "🚀"; Y = 775 }
)

$cardW = 870; $cardH = 140; $cardX = 910
$fCTitle = [System.Drawing.Font]::new("Segoe UI", 21, [System.Drawing.FontStyle]::Bold)
$fCSub = [System.Drawing.Font]::new("Segoe UI", 13.5, [System.Drawing.FontStyle]::Regular)

foreach ($c in $devCards) {
    $cPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $cPath $cardX $c.Y $cardW $cardH 20
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($c.Bg)"))
    $g.FillPath($bBg, $cPath)
    
    # White icon square
    $ibPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $ibPath ($cardX + 25) ($c.Y + 25) 90 90 14
    $g.FillPath($bWhite, $ibPath)
    
    $fSym = [System.Drawing.Font]::new("Segoe UI", 26, [System.Drawing.FontStyle]::Bold)
    $bSym = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(124, 58, 237))
    $g.DrawString($c.Sym, $fSym, $bSym, [System.Drawing.RectangleF]::new(($cardX + 25), ($c.Y + 25), 90, 90), $sfC)
    
    $g.DrawString($c.Title, $fCTitle, $bDark, ($cardX + 135), ($c.Y + 32))
    $g.DrawString($c.Sub, $fCSub, $bSub, [System.Drawing.RectangleF]::new(($cardX + 135), ($c.Y + 75), ($cardW - 150), 55))
}

$g.Dispose()
Save-Infographic $bmp "blog-4-ai-custom-web-application-development" "ai_powered_web_development_lifecycle_2027.jpg"
$bmp.Dispose()


# Image 2: Developer Sprint Velocity Comparison (4 Cards with Velocity Badges)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::White)

Draw-TopHeader $g "Developer Velocity: Traditional vs AI" "Sprint Productivity Benchmarks" "059669"

$velCards = @(
    @{ Phase = "Boilerplate & CRUD Setup"; Trad = "16 to 24 hours of manual schema & endpoint coding"; AI = "2 to 3 hours with guided neural scaffolding"; Speed = "8x Faster"; Bg = "E0F2FE"; BadgeBg = "0284C7" },
    @{ Phase = "Unit & Integration Test Suites"; Trad = "8 to 12 hours writing repetitive mocks and fixtures"; AI = "1 to 2 hours via automated synthetic generation"; Speed = "6x Faster"; Bg = "EDE9FE"; BadgeBg = "7C3AED" },
    @{ Phase = "PR Review & Vulnerability Triaging"; Trad = "24 to 48 hours waiting for asynchronous team reviews"; AI = "Sub-5 minute automated architectural pre-checks"; Speed = "Instant"; Bg = "FEF3C7"; BadgeBg = "D97706" },
    @{ Phase = "End-to-End Feature Delivery Cycle"; Trad = "2 to 3 weeks for full sprint feature validation"; AI = "3 to 5 days with AI-accelerated continuous delivery"; Speed = "4x Faster"; Bg = "DCFCE7"; BadgeBg = "16A34A" }
)

$w = 1720; $h = 160; $gap = 25; $startY = 240
$fPhase = [System.Drawing.Font]::new("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$fTxt = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)
$fTxtB = [System.Drawing.Font]::new("Segoe UI", 16.5, [System.Drawing.FontStyle]::Bold)
$fSpd = [System.Drawing.Font]::new("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)

for ($i = 0; $i -lt 4; $i++) {
    $vc = $velCards[$i]
    $y = $startY + ($i * ($h + $gap))
    
    $p = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $p 100 $y $w $h 20
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($vc.Bg)"))
    $g.FillPath($bBg, $p)
    
    # Left Phase Title
    $g.DrawString($vc.Phase, $fPhase, $bDark, 140, ($y + 35))
    
    # Comparison Lines
    $g.DrawString("Manual: ", $fTxtB, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(220, 38, 38)), 140, ($y + 85))
    $g.DrawString($vc.Trad, $fTxt, $bDark, 230, ($y + 85))
    
    $g.DrawString("AI-Assisted: ", $fTxtB, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(22, 101, 52)), 820, ($y + 85))
    $g.DrawString($vc.AI, $fTxtB, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(22, 101, 52)), 940, ($y + 85))
    
    # Right Speed Badge Pill
    $bW = 200; $bH = 50; $bX = 100 + $w - $bW - 40; $bY = $y + 55
    $bPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $bPath $bX $bY $bW $bH 25
    $bBadgeBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($vc.BadgeBg)"))
    $g.FillPath($bBadgeBrush, $bPath)
    $g.DrawString($vc.Speed, $fSpd, $bWhite, [System.Drawing.RectangleF]::new($bX, $bY, $bW, $bH), $sfC)
}

$g.Dispose()
Save-Infographic $bmp "blog-4-ai-custom-web-application-development" "developer_velocity_traditional_vs_ai_2027.jpg"
$bmp.Dispose()


# =============================================================================
# 6. BLOG 5: SLM VS LLM IN 2027
# =============================================================================

# Image 1: Small vs Large Language Models in 2027 (Side-by-side Illustrated Comparison)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::White)

Draw-TopHeader $g "Small vs Large Language Models in 2027" "Compute & Parameter Comparison" "0284C7"

$cardW = 820; $cardH = 750; $cardY = 240

# Left Card: Small Language Models (SLM) - Smartphone & Edge Icon
$lPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $lPath 100 $cardY $cardW $cardH 24
$bLBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(240, 249, 255)) # Sky Blue
$g.FillPath($bLBg, $lPath)
$pLBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(186, 230, 253), 3)
$g.DrawPath($pLBorder, $lPath)

$bBlue = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(3, 105, 161))
$g.DrawString("Small Language Models (SLM)", $fHdr, $bBlue, 140, ($cardY + 40))

# Phone / Edge Icon Box
$phPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $phPath 140 ($cardY + 110) 90 90 18
$g.FillPath($bWhite, $phPath)
$g.DrawString("📱⚡", $fWarn, $bBlue, 145, ($cardY + 120))

$g.DrawString("Compact neural models designed for local edge deployment, high privacy, and sub-50ms ultra-low latency.", $fDesc, $bDark, [System.Drawing.RectangleF]::new(250, ($cardY + 120), 620, 80))

$slmItems = @(
    "1. Compact Scale: 3 Billion to 14 Billion optimized parameters",
    "2. Edge Hardware: Executes locally on mobile chips and CPU servers",
    "3. Ultra-Low Latency: Sub-50ms inference for real-time applications",
    "4. Total Privacy: 100% on-premise execution with zero data egress"
)
$iy = $cardY + 240
foreach ($it in $slmItems) {
    $rowPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $rowPath 140 $iy ($cardW - 80) 95 16
    $g.FillPath($bWhite, $rowPath)
    $g.DrawString($it, $fItem, $bDark, [System.Drawing.RectangleF]::new(165, ($iy + 28), ($cardW - 130), 55))
    $iy += 115
}

# Right Card: Large Language Models (LLM) - Cloud Server & Brain Icon
$rPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $rPath 1000 $cardY $cardW $cardH 24
$bRBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(245, 243, 255)) # Light Purple
$g.FillPath($bRBg, $rPath)
$pRBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(221, 214, 254), 3)
$g.DrawPath($pRBorder, $rPath)

$bPurple = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(109, 40, 217))
$g.DrawString("Large Language Models (LLM)", $fHdr, $bPurple, 1040, ($cardY + 40))

# Server / Brain Icon Box
$srvPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $srvPath 1040 ($cardY + 110) 90 90 18
$g.FillPath($bWhite, $srvPath)
$g.DrawString("🧠☁️", $fWarn, $bPurple, 1045, ($cardY + 120))

$g.DrawString("Massive general-purpose foundation systems excelling at complex multi-turn logic, synthesis, and reasoning.", $fDesc, $bDark, [System.Drawing.RectangleF]::new(1150, ($cardY + 120), 620, 80))

$llmItems = @(
    "1. Massive Scale: 70 Billion to 400+ Billion deep parameters",
    "2. Cloud Infrastructure: Multi-node GPU data center clusters",
    "3. High Cognitive Reasoning: Complex logic, coding, and synthesis",
    "4. Higher Resource Costs: Significant API tokens & cloud latency"
)
$iy = $cardY + 240
foreach ($it in $llmItems) {
    $rowPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $rowPath 1040 $iy ($cardW - 80) 95 16
    $g.FillPath($bWhite, $rowPath)
    $g.DrawString($it, $fItem, $bDark, [System.Drawing.RectangleF]::new(1065, ($iy + 28), ($cardW - 130), 55))
    $iy += 115
}

$g.Dispose()
Save-Infographic $bmp "blog-5-slm-vs-llm-2027" "slm_vs_llm_compute_and_parameter_comparison_2027.jpg"
$bmp.Dispose()


# Image 2: SLM vs LLM Enterprise Model Selection Framework
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::White)

Draw-TopHeader $g "Enterprise Model Selection Framework" "When to Choose SLM vs LLM" "059669"

$selCards = @(
    @{ UseCase = "On-Device & Mobile Offline Applications"; Model = "SLM (Small Language Model)"; Rat = "Zero cloud latency, offline functionality, and complete device privacy."; Bg = "E0F2FE"; Color = "0284C7" },
    @{ UseCase = "Complex Multi-Turn Strategic Reasoning"; Model = "LLM (Large Language Model)"; Rat = "Broad general knowledge, advanced cross-domain logic, and synthesis."; Bg = "EDE9FE"; Color = "7C3AED" },
    @{ UseCase = "Regulated Healthcare & Financial Services"; Model = "SLM (Small Language Model)"; Rat = "Air-gapped on-premise execution guaranteeing strict regulatory data control."; Bg = "DCFCE7"; Color = "16A34A" },
    @{ UseCase = "Multilingual Creative Content & Translation"; Model = "LLM (Large Language Model)"; Rat = "Exceptional nuance, poetic fluency, and comprehensive language mastery."; Bg = "EEF2FF"; Color = "4F46E5" }
)

$w = 1720; $h = 160; $gap = 25; $startY = 240

for ($i = 0; $i -lt 4; $i++) {
    $sc = $selCards[$i]
    $y = $startY + ($i * ($h + $gap))
    
    $p = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $p 100 $y $w $h 20
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($sc.Bg)"))
    $g.FillPath($bBg, $p)
    
    # Left accent bar
    $bAcc = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($sc.Color)"))
    $g.FillRectangle($bAcc, 100, $y, 10, $h)
    
    $g.DrawString($sc.UseCase, $fPhase, $bDark, 140, ($y + 35))
    
    $g.DrawString("Recommended: ", $fTxtB, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)), 140, ($y + 85))
    $g.DrawString($sc.Model, $fTxtB, $bAcc, 290, ($y + 85))
    
    $g.DrawString($sc.Rat, $fTxt, $bDark, 720, ($y + 85))
}

$g.Dispose()
Save-Infographic $bmp "blog-5-slm-vs-llm-2027" "slm_vs_llm_enterprise_deployment_matrix_2027.jpg"
$bmp.Dispose()


# =============================================================================
# 7. BLOG 6: WHY DID MICROSOFT OUTLOOK GO DOWN?
# =============================================================================

# Image 1: EXACT MATCH TO USER'S REFERENCE INFOGRAPHIC
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

Draw-TopHeader $g "What Caused the Microsoft Outlook" "Global Outage?" "E11D48"

# Left Side: Illustrated Vector Laptop
$lx = 140; $ly = 320; $lw = 580; $lh = 460

# Laptop Screen Lid (Dark Slate)
$lidPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $lidPath $lx $ly $lw ($lh - 60) 24
$bLid = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 41, 59))
$g.FillPath($bLid, $lidPath)

# Laptop Screen Inner Display
$scrPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $scrPath ($lx + 20) ($ly + 20) ($lw - 40) ($lh - 100) 14
$bScr = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(248, 250, 252))
$g.FillPath($bScr, $scrPath)

# Inner Screen: Outlook Logo + Alert
$outPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $outPath ($lx + 150) ($ly + 65) 75 75 14
$bOut = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(0, 114, 214))
$g.FillPath($bOut, $outPath)
$fOut = [System.Drawing.Font]::new("Segoe UI", 36, [System.Drawing.FontStyle]::Bold)
$g.DrawString("O", $fOut, $bWhite, [System.Drawing.RectangleF]::new(($lx + 150), ($ly + 65), 75, 75), $sfC)

$fOutTxt = [System.Drawing.Font]::new("Segoe UI", 28, [System.Drawing.FontStyle]::Bold)
$bOutTxt = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(0, 114, 214))
$sfLeft = [System.Drawing.StringFormat]::new()
$sfLeft.Alignment = [System.Drawing.StringAlignment]::Near
$sfLeft.LineAlignment = [System.Drawing.StringAlignment]::Center
$g.DrawString("Outlook", $fOutTxt, $bOutTxt, ($lx + 240), ($ly + 102), $sfLeft)

# Red Warning Triangle
$triY = $ly + 165
$p1 = [System.Drawing.Point]::new(($lx + $lw/2), $triY)
$p2 = [System.Drawing.Point]::new(($lx + $lw/2 - 45), ($triY + 70))
$p3 = [System.Drawing.Point]::new(($lx + $lw/2 + 45), ($triY + 70))
$bWarn = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(239, 68, 68))
$g.FillPolygon($bWarn, @($p1, $p2, $p3))
$fEx = [System.Drawing.Font]::new("Segoe UI", 32, [System.Drawing.FontStyle]::Bold)
$g.DrawString("!", $fEx, $bWhite, [System.Drawing.RectangleF]::new(($lx + $lw/2 - 25), ($triY + 12), 50, 60), $sfC)

# Red Pill: "Service Unavailable"
$subW = 320; $subH = 46; $subX = $lx + ($lw - $subW)/2; $subY = $triY + 85
$pathSub = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $pathSub $subX $subY $subW $subH 23
$g.FillPath($bWarn, $pathSub)
$fSubPill = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$g.DrawString("Service Unavailable", $fSubPill, $bWhite, [System.Drawing.RectangleF]::new($subX, $subY, $subW, $subH), $sfC)

# Laptop Base (Silver Keyboard Base)
$basePath = [System.Drawing.Drawing2D.GraphicsPath]::new()
$basePath.AddLine(($lx - 40), ($ly + $lh - 55), ($lx + $lw + 40), ($ly + $lh - 55))
$basePath.AddLine(($lx + $lw + 20), ($ly + $lh - 15), ($lx - 20), ($ly + $lh - 15))
$basePath.CloseFigure()
$bBase = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(203, 213, 225))
$g.FillPath($bBase, $basePath)

$lipPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $lipPath ($lx - 30) ($ly + $lh - 20) ($lw + 60) 20 8
$bLip = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(148, 163, 184))
$g.FillPath($bLip, $lipPath)

# Branching Connector Lines
$pLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(14, 116, 144), 3.5)
$g.DrawLine($pLine, ($lx + $lw), ($ly + 200), ($lx + $lw + 60), ($ly + 200))
$g.DrawLine($pLine, ($lx + $lw + 60), 340, ($lx + $lw + 60), 780)
$g.DrawLine($pLine, ($lx + $lw + 60), 340, 890, 340)
$g.DrawLine($pLine, ($lx + $lw + 60), 560, 890, 560)
$g.DrawLine($pLine, ($lx + $lw + 60), 780, 890, 780)

# Right Side: 3 Illustrated Pastel Cards
$cards = @(
    @{ Title = "An Undetected Software Bug"; Bg = [System.Drawing.Color]::FromArgb(224, 242, 254); IconType = "bug"; Y = 250 },
    @{ Title = "Increased Microsoft Teams Traffic"; Bg = [System.Drawing.Color]::FromArgb(237, 233, 254); IconType = "teams"; Y = 470 },
    @{ Title = "Reduced Server Capacity"; Bg = [System.Drawing.Color]::FromArgb(220, 252, 231); IconType = "server"; Y = 690 }
)

$cardW = 900; $cardH = 180; $cardX = 890
$fCardTitle = [System.Drawing.Font]::new("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)

foreach ($c in $cards) {
    $cPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $cPath $cardX $c.Y $cardW $cardH 24
    $bCardBg = [System.Drawing.SolidBrush]::new($c.Bg)
    $g.FillPath($bCardBg, $cPath)
    
    $ibX = $cardX + 35; $ibY = $c.Y + 30; $ibS = 120
    $ibPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $ibPath $ibX $ibY $ibS $ibS 18
    $g.FillPath($bWhite, $ibPath)
    
    if ($c.IconType -eq "bug") {
        $fCode = [System.Drawing.Font]::new("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
        $bCode = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(2, 132, 199))
        $g.DrawString("</>", $fCode, $bCode, ($ibX + 15), ($ibY + 40))
        $bBug = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(220, 38, 38))
        $g.FillEllipse($bBug, ($ibX + 70), ($ibY + 42), 34, 34)
    } elseif ($c.IconType -eq "teams") {
        $tBox = [System.Drawing.Drawing2D.GraphicsPath]::new()
        Add-RoundedRectangle $tBox ($ibX + 18) ($ibY + 35) 45 45 10
        $bT = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(98, 100, 167))
        $g.FillPath($bT, $tBox)
        $fT = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)
        $g.DrawString("T", $fT, $bWhite, [System.Drawing.RectangleF]::new(($ibX + 18), ($ibY + 35), 45, 45), $sfC)
        $bBar = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(124, 58, 237))
        $g.FillRectangle($bBar, ($ibX + 75), ($ibY + 55), 10, 25)
        $g.FillRectangle($bBar, ($ibX + 90), ($ibY + 40), 10, 40)
    } elseif ($c.IconType -eq "server") {
        $bSrv = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42))
        $g.FillRectangle($bSrv, ($ibX + 20), ($ibY + 30), 55, 16)
        $g.FillRectangle($bSrv, ($ibX + 20), ($ibY + 52), 55, 16)
        $g.FillRectangle($bSrv, ($ibX + 20), ($ibY + 74), 55, 16)
        $bArr = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(220, 38, 38))
        $g.FillEllipse($bArr, ($ibX + 85), ($ibY + 45), 28, 28)
        $fArr = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
        $g.DrawString("v", $fArr, $bWhite, [System.Drawing.RectangleF]::new(($ibX + 85), ($ibY + 45), 28, 28), $sfC)
    }
    
    $g.DrawString($c.Title, $fCardTitle, $bDark, ($cardX + 185), ($c.Y + 68), $sfLeft)
}

$g.Dispose()
Save-Infographic $bmp "blog-6-why-did-microsoft-outlook-go-down" "microsoft_outlook_outage_telemetry_timeline_2026.jpg"
$bmp.Dispose()


# Image 2: Enterprise Cloud Email Resilience Architecture (Shield on Left + 3 Failover Cards)
$bmp = [System.Drawing.Bitmap]::new(1920, 1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::White)

Draw-TopHeader $g "Enterprise Cloud Email Resilience Architecture" "Disaster Recovery Strategy" "2563EB"

# Left Illustration: Enterprise Cloud Shield
$lx = 140; $ly = 280; $lw = 580; $lh = 660

$shCard = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $shCard $lx $ly $lw $lh 28
$bShBg = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(239, 246, 255))
$g.FillPath($bShBg, $shCard)
$pShBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(191, 219, 254), 3)
$g.DrawPath($pShBorder, $shCard)

# Giant Shield Illustration
$shPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
$shX = $lx + 140; $shY = $ly + 90; $shW = 300; $shH = 340
$shPath.AddLine($shX, $shY, ($shX + $shW), $shY)
$shPath.AddLine(($shX + $shW), ($shY + $shH * 0.6), ($shX + $shW/2), ($shY + $shH))
$shPath.AddLine(($shX + $shW/2), ($shY + $shH), $shX, ($shY + $shH * 0.6))
$shPath.CloseFigure()
$bShield = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(37, 99, 235))
$g.FillPath($bShield, $shPath)

# White checkmark in shield
$fChk = [System.Drawing.Font]::new("Segoe UI", 60, [System.Drawing.FontStyle]::Bold)
$g.DrawString("🛡️", $fChk, $bWhite, [System.Drawing.RectangleF]::new($shX, ($shY + 80), $shW, 140), $sfC)

$fShTxt = [System.Drawing.Font]::new("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$g.DrawString("HIGH-AVAILABILITY CLOUD", $fShTxt, $bDark, [System.Drawing.RectangleF]::new(($lx + 40), ($ly + 470), ($lw - 80), 50), $sfC)
$fShSub = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)
$g.DrawString("Zero-Downtime Out-of-Band Relay", $fShSub, $bSub, [System.Drawing.RectangleF]::new(($lx + 40), ($ly + 530), ($lw - 80), 40), $sfC)

# Branching connector lines to right cards
$pLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(37, 99, 235), 3.5)
$g.DrawLine($pLine, ($lx + $lw), 340, 890, 340)
$g.DrawLine($pLine, ($lx + $lw), 560, 890, 560)
$g.DrawLine($pLine, ($lx + $lw), 780, 890, 780)

# Right Cards (3 rounded cards)
$resCards = @(
    @{ Title = "1. Secondary MX Spooling Queues"; Sub = "Autonomous third-party mail queues holding inbound messages during cloud provider outages."; Bg = "E0F2FE"; Sym = "📥"; Y = 250 },
    @{ Title = "2. Out-of-Band Standby Webmail"; Sub = "Independent webmail interface allowing executive and operational communication during blackouts."; Bg = "EDE9FE"; Sym = "✉️"; Y = 470 },
    @{ Title = "3. Automated DNS Health Failover"; Sub = "Continuous synthetic login probes triggering automated DNS traffic redirection in under 60 seconds."; Bg = "DCFCE7"; Sym = "🔄"; Y = 690 }
)

foreach ($c in $resCards) {
    $cPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $cPath $cardX $c.Y $cardW $cardH 22
    $bBg = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#$($c.Bg)"))
    $g.FillPath($bBg, $cPath)
    
    $ibPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    Add-RoundedRectangle $ibPath ($cardX + 35) ($c.Y + 30) 120 120 18
    $g.FillPath($bWhite, $ibPath)
    
    $fSym = [System.Drawing.Font]::new("Segoe UI", 36, [System.Drawing.FontStyle]::Bold)
    $g.DrawString($c.Sym, $fSym, $bDark, [System.Drawing.RectangleF]::new(($cardX + 35), ($c.Y + 30), 120, 120), $sfC)
    
    $g.DrawString($c.Title, $fCTitle, $bDark, ($cardX + 185), ($c.Y + 45))
    $g.DrawString($c.Sub, $fCSub, $bSub, [System.Drawing.RectangleF]::new(($cardX + 185), ($c.Y + 95), ($cardW - 210), 65))
}

$g.Dispose()
Save-Infographic $bmp "blog-6-why-did-microsoft-outlook-go-down" "enterprise_cloud_email_resilience_architecture_2026.jpg"
$bmp.Dispose()

Write-Output "All 14 2D animated/illustrated infographics generated successfully!"
