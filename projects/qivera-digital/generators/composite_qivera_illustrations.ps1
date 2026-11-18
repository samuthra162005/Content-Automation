Add-Type -AssemblyName System.Drawing

function Composite-Illustration {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle,
        [string]$SubtitleColorHex = "2563EB",
        [string]$FooterText = "QIVERA DIGITAL • EVIDENCE-BASED LEARNING & HABIT FORMATION"
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

