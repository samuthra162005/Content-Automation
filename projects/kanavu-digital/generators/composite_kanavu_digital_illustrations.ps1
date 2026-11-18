Add-Type -AssemblyName System.Drawing

function Composite-Illustration {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$SubtitleColorHex = "1A73E8"
    )

    Write-Host "Compositing illustration: $SourcePath -> $OutputPath"
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

    # Title zone: Y = 25 to 145
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]40, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Slate 900
    $titleFormat = [System.Drawing.StringFormat]::new()
    $titleFormat.Alignment = [System.Drawing.StringAlignment]::Center
    $titleFormat.LineAlignment = [System.Drawing.StringAlignment]::Center

    $titleRect = [System.Drawing.RectangleF]::new(40, 25, 1840, 60)
    $g.DrawString($Title, $titleFont, $titleBrush, $titleRect, $titleFormat)

    # Subtitle
    if ($Subtitle -and $Subtitle.Trim().Length -gt 0) {
        $subColor = [System.Drawing.ColorTranslator]::FromHtml("#" + $SubtitleColorHex)
        $subFont = [System.Drawing.Font]::new("Segoe UI", [float]20, [System.Drawing.FontStyle]::Regular)
        $subBrush = [System.Drawing.SolidBrush]::new($subColor)
        $subRect = [System.Drawing.RectangleF]::new(40, 85, 1840, 42)
        $g.DrawString($Subtitle, $subFont, $subBrush, $subRect, $titleFormat)
        $subFont.Dispose()
        $subBrush.Dispose()
    }

    # Illustration positioning (Y: 145 to 1045, available H: 900, available W: 1840)
    $availW = 1840
    $availH = 900
    $scaleW = $availW / $srcImg.Width
    $scaleH = $availH / $srcImg.Height
    $scale = [Math]::Min($scaleW, $scaleH)

    $drawW = [int]($srcImg.Width * $scale)
    $drawH = [int]($srcImg.Height * $scale)
    $drawX = [int]((1920 - $drawW) / 2)
    $drawY = [int](145 + ($availH - $drawH) / 2)

    # Soft subtle border around illustration
    $borderPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(226, 232, 240), 2)
    $g.DrawRectangle($borderPen, $drawX - 2, $drawY - 2, $drawW + 4, $drawH + 4)
    $borderPen.Dispose()

    # Draw the rich illustration
    $g.DrawImage($srcImg, $drawX, $drawY, $drawW, $drawH)
    $srcImg.Dispose()

    # Subtle footer branding
    $footFont = [System.Drawing.Font]::new("Segoe UI", [float]11, [System.Drawing.FontStyle]::Regular)
    $footBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(148, 163, 184))
    $footRect = [System.Drawing.RectangleF]::new(40, 1052, 1840, 24)
    $g.DrawString("KANAVU DIGITAL MARKETING • EVIDENCE-BASED PERFORMANCE MARKETING • ERODE, TAMIL NADU", $footFont, $footBrush, $footRect, $titleFormat)
    $footFont.Dispose()
    $footBrush.Dispose()

    # Save as JPEG with 95 quality
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $encoderParams = [System.Drawing.Imaging.EncoderParameters]::new(1)
    $encoderParams.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]95)

    $tempPath = [System.IO.Path]::GetTempFileName() + ".jpg"
    $bmp.Save($tempPath, $codec, $encoderParams)

    $g.Dispose()
    $bmp.Dispose()
    $titleFont.Dispose()
    $titleBrush.Dispose()

    Move-Item -Path $tempPath -Destination $OutputPath -Force
    Write-Host "Saved successfully: $OutputPath"
}

$fig1Source = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\erode_digital_marketing_agency_1794632782497.jpg"
$fig1Dest = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-14\best-digital-marketing-agency-erode-kanavu-digital\hero-image.jpg"
Composite-Illustration -SourcePath $fig1Source -OutputPath $fig1Dest -Title "SELECTING A DIGITAL MARKETING AGENCY IN ERODE" -Subtitle "4 Essential Pillars: Local SEO, Paid Media, Conversion UX & ROI Analytics" -SubtitleColorHex "1A73E8"

$fig2Source = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78\agency_vs_vendor_comparison_1794632789313.jpg"
$fig2Dest = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-14\best-digital-marketing-agency-erode-kanavu-digital\agency-comparison-matrix.jpg"
Composite-Illustration -SourcePath $fig2Source -OutputPath $fig2Dest -Title "RESULTS-DRIVEN AGENCY VS TRADITIONAL MARKETING VENDOR" -Subtitle "Key Strategic Differences in Attribution, Technical SEO, Transparency & Business Growth" -SubtitleColorHex "059669"

