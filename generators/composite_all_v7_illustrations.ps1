Add-Type -AssemblyName System.Drawing

function Composite-Illustration {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$SubtitleColorHex = "2563EB",
        [string]$FooterText = "EVIDENCE-BASED LEARNING & ANALYTICS"
    )

    Write-Host "Compositing illustration: $SourcePath -> $OutputPath"
    if (-not (Test-Path $SourcePath)) {
        Write-Error "Source file does not exist: $SourcePath"
        return
    }

    $srcImg = [System.Drawing.Image]::FromFile($SourcePath)

    $targetW = 1920
    $targetH = 1080
    $bmp = [System.Drawing.Bitmap]::new($targetW, $targetH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    
    $g.Clear([System.Drawing.Color]::White)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Extra Large Bold Title (44pt)
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]44, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Slate 900
    $titleFormat = [System.Drawing.StringFormat]::new()
    $titleFormat.Alignment = [System.Drawing.StringAlignment]::Center
    $titleFormat.LineAlignment = [System.Drawing.StringAlignment]::Center

    $titleRect = [System.Drawing.RectangleF]::new(40, 20, 1840, 65)
    $g.DrawString($Title, $titleFont, $titleBrush, $titleRect, $titleFormat)

    # Large Bold Subtitle (22pt)
    if ($Subtitle -and $Subtitle.Trim().Length -gt 0) {
        $subColor = [System.Drawing.ColorTranslator]::FromHtml("#" + $SubtitleColorHex)
        $subFont = [System.Drawing.Font]::new("Segoe UI", [float]22, [System.Drawing.FontStyle]::Bold)
        $subBrush = [System.Drawing.SolidBrush]::new($subColor)
        $subRect = [System.Drawing.RectangleF]::new(40, 88, 1840, 45)
        $g.DrawString($Subtitle, $subFont, $subBrush, $subRect, $titleFormat)
        $subFont.Dispose()
        $subBrush.Dispose()
    }

    # Illustration positioning (Y: 145 to 1035, available H: 890, available W: 1840)
    $availW = 1840
    $availH = 890
    $scaleW = $availW / $srcImg.Width
    $scaleH = $availH / $srcImg.Height
    $scale = [Math]::Min($scaleW, $scaleH)

    $drawW = [int]($srcImg.Width * $scale)
    $drawH = [int]($srcImg.Height * $scale)
    $drawX = [int]((1920 - $drawW) / 2)
    $drawY = [int](145 + ($availH - $drawH) / 2)

    # Soft border around illustration
    $borderPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(226, 232, 240), 2)
    $g.DrawRectangle($borderPen, $drawX - 2, $drawY - 2, $drawW + 4, $drawH + 4)
    $borderPen.Dispose()

    # Draw the rich AI illustration
    $g.DrawImage($srcImg, $drawX, $drawY, $drawW, $drawH)
    $srcImg.Dispose()

    # Subtle footer branding
    $footFont = [System.Drawing.Font]::new("Segoe UI", [float]12, [System.Drawing.FontStyle]::Bold)
    $footBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(148, 163, 184))
    $footRect = [System.Drawing.RectangleF]::new(40, 1045, 1840, 25)
    $g.DrawString($FooterText, $footFont, $footBrush, $footRect, $titleFormat)
    $footFont.Dispose()
    $footBrush.Dispose()

    # Save as JPEG with 95 quality
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $encoderParams = [System.Drawing.Imaging.EncoderParameters]::new(1)
    $encoderParams.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]95)

    $outDir = [System.IO.Path]::GetDirectoryName($OutputPath)
    if (-not (Test-Path $outDir)) {
        New-Item -ItemType Directory -Path $outDir -Force | Out-Null
    }

    $tempPath = [System.IO.Path]::GetTempFileName() + ".jpg"
    $bmp.Save($tempPath, $codec, $encoderParams)

    $g.Dispose()
    $bmp.Dispose()
    $titleFont.Dispose()
    $titleBrush.Dispose()

    Move-Item -Path $tempPath -Destination $OutputPath -Force
    Write-Host "[SUCCESS] Saved composited visual: $OutputPath"
}

# ==============================================================================
# BLOG 1: Qivera Digital - LexiRef Vocabulary Blog
# ==============================================================================
Write-Host "--- COMPOSITING BLOG 1: LEXIREF VOCABULARY ---" -ForegroundColor Cyan
$b1HeroSrc = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\qivera_vocabulary_habits_editorial_v2_1794639184230.jpg"
$b1HeroDst = "d:\content\digital-marketing-skills\projects\qivera-digital\2026-11-14\how-to-improve-vocabulary-10-simple-daily-habits\hero-image.jpg"
Composite-Illustration -SourcePath $b1HeroSrc -OutputPath $b1HeroDst -Title "HOW TO IMPROVE VOCABULARY: 10 SIMPLE DAILY HABITS?" -Subtitle "Evidence-Based Contextual Reading, Spaced Retrieval & Etymology with LexiRef" -SubtitleColorHex "2563EB" -FooterText "QIVERA DIGITAL • LEXIREF VOCABULARY MASTERY FRAMEWORK"

$b1Fig2Src = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\qivera_etymology_memory_editorial_1794639146300.jpg"
$b1Fig2Dst = "d:\content\digital-marketing-skills\projects\qivera-digital\2026-11-14\how-to-improve-vocabulary-10-simple-daily-habits\vocabulary-learning-framework.jpg"
Composite-Illustration -SourcePath $b1Fig2Src -OutputPath $b1Fig2Dst -Title "ETYMOLOGY & SPACED REPETITION LEARNING SYSTEM" -Subtitle "How Greek and Latin Morpheme Roots Accelerate Long-Term Word Retention" -SubtitleColorHex "D97706" -FooterText "QIVERA DIGITAL • LEXIREF VOCABULARY MASTERY FRAMEWORK"

# ==============================================================================
# BLOG 2: Qivera Digital - HabitShare Consistency Blog
# ==============================================================================
Write-Host "--- COMPOSITING BLOG 2: HABITSHARE CONSISTENCY ---" -ForegroundColor Cyan
$b2HeroSrc = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\qivera_habit_consistency_editorial_1794639165859.jpg"
$b2HeroDst = "d:\content\digital-marketing-skills\projects\qivera-digital\2026-11-14\how-to-stay-consistent-with-habits-when-motivation-fades\hero-image.jpg"
Composite-Illustration -SourcePath $b2HeroSrc -OutputPath $b2HeroDst -Title "HOW TO STAY CONSISTENT WITH HABITS WHEN MOTIVATION FADES?" -Subtitle "Replacing Volatile Motivation with Environmental Systems & Shared Accountability" -SubtitleColorHex "059669" -FooterText "QIVERA DIGITAL • HABITSHARE SOCIAL HABIT TRACKING"

$b2Fig2Src = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\qivera_habit_friction_accountability_editorial_v2_1794639170449.jpg"
$b2Fig2Dst = "d:\content\digital-marketing-skills\projects\qivera-digital\2026-11-14\how-to-stay-consistent-with-habits-when-motivation-fades\habit-friction-matrix.jpg"
Composite-Illustration -SourcePath $b2Fig2Src -OutputPath $b2Fig2Dst -Title "THE HABIT FRICTION & ACCOUNTABILITY MATRIX" -Subtitle "Lowering Starting Barriers and Sharing Progress with HabitShare Streaks" -SubtitleColorHex "D97706" -FooterText "QIVERA DIGITAL • HABITSHARE SOCIAL HABIT TRACKING"

# ==============================================================================
# BLOG 3: Aindhin - SQL for Beginners
# ==============================================================================
Write-Host "--- COMPOSITING BLOG 3: SQL FOR BEGINNERS ---" -ForegroundColor Cyan
$b3HeroSrc = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\aindhin_bi_analytics_workflow_editorial_v2_1794639180386.jpg"
$b3HeroDst = "d:\content\digital-marketing-skills\projects\aindhin\2026-11-14\sql-for-beginners-basic-queries-every-data-analyst-should-know\hero-image.jpg"
Composite-Illustration -SourcePath $b3HeroSrc -OutputPath $b3HeroDst -Title "SQL FOR BEGINNERS: WHICH BASIC QUERIES MUST YOU KNOW?" -Subtitle "How Relational Database Queries Transform Raw Records into Analytical Insights" -SubtitleColorHex "2563EB" -FooterText "AINDHIN DATA ANALYTICS ACADEMY • SQL QUERY FOUNDATIONS"

$b3Fig2Src = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\aindhin_sql_joins_diagram_editorial_1794639163335.jpg"
$b3Fig2Dst = "d:\content\digital-marketing-skills\projects\aindhin\2026-11-14\sql-for-beginners-basic-queries-every-data-analyst-should-know\sql-joins-diagram.jpg"
Composite-Illustration -SourcePath $b3Fig2Src -OutputPath $b3Fig2Dst -Title "RELATIONAL DATABASE SQL JOINS ARCHITECTURE" -Subtitle "Visualizing INNER, LEFT, RIGHT, and FULL OUTER Data Join Operations" -SubtitleColorHex "06B6D4" -FooterText "AINDHIN DATA ANALYTICS ACADEMY • SQL QUERY FOUNDATIONS"

# ==============================================================================
# BLOG 4: Aindhin - Power BI vs Tableau
# ==============================================================================
Write-Host "--- COMPOSITING BLOG 4: POWER BI VS TABLEAU ---" -ForegroundColor Cyan
$b4HeroSrc = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\aindhin_powerbi_vs_tableau_decision_editorial_1794639160739.jpg"
$b4HeroDst = "d:\content\digital-marketing-skills\projects\aindhin\2026-11-14\power-bi-vs-tableau-which-tool-should-you-learn-first\hero-image.jpg"
Composite-Illustration -SourcePath $b4HeroSrc -OutputPath $b4HeroDst -Title "POWER BI VS TABLEAU: WHICH TOOL SHOULD YOU LEARN FIRST?" -Subtitle "Comparing Microsoft Power BI and Tableau for Aspiring Data Analysts" -SubtitleColorHex "2563EB" -FooterText "AINDHIN DATA ANALYTICS ACADEMY • BUSINESS INTELLIGENCE CURRICULUM"

$b4Fig2Src = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\aindhin_bi_analytics_workflow_editorial_1794639160558.jpg"
$b4Fig2Dst = "d:\content\digital-marketing-skills\projects\aindhin\2026-11-14\power-bi-vs-tableau-which-tool-should-you-learn-first\bi-tools-comparison-matrix.jpg"
Composite-Illustration -SourcePath $b4Fig2Src -OutputPath $b4Fig2Dst -Title "END-TO-END BUSINESS INTELLIGENCE WORKFLOW" -Subtitle "From Raw Database Extraction to ETL Modeling and Executive Dashboards" -SubtitleColorHex "059669" -FooterText "AINDHIN DATA ANALYTICS ACADEMY • BUSINESS INTELLIGENCE CURRICULUM"

Write-Host "=== ALL 8 ILLUSTRATIONS COMPOSITED SUCCESSFULLY ===" -ForegroundColor Green

