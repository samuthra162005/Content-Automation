<#
.SYNOPSIS
    Universal Blog Image Generator & Infographic Typography Compositor.
    Follows Universal Master Prompt V4 Visual Standards:
    - Exact 16:9 widescreen canvas (1920 x 1080)
    - Solid pure white (#FFFFFF) background
    - Effective canvas usage with balanced margins (no tiny shrunken graphics)
    - Prominent bold title rendered inside the image itself (65-85px title, 22-28px subtitle)
    - Anti-aliased high-contrast typography (Slate 900 / Cobalt / Slate 600)
    - High-quality bicubic interpolation
#>

param (
    [string]$SourcePath,
    [string]$OutputPath,
    [string]$Title,
    [string]$Subtitle = "",
    [int]$CanvasWidth = 1920,
    [int]$CanvasHeight = 1080
)

Add-Type -AssemblyName System.Drawing

function Render-UniversalInfographic {
    param (
        [string]$Src,
        [string]$Dst,
        [string]$HeadTitle,
        [string]$SubTitle
    )

    if (-not (Test-Path $Src)) {
        Write-Error "Source image not found: $Src"
        return
    }

    Write-Host "[VISUAL COMPOSITOR] Processing: $Src -> $Dst"

    $srcImg = [System.Drawing.Image]::FromFile($Src)

    $targetW = 1920
    $targetH = 1080
    $bmp = [System.Drawing.Bitmap]::new($targetW, $targetH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)

    # Clean pure white background
    $g.Clear([System.Drawing.Color]::White)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Typography banner parameters
    $hasSubtitle = ($SubTitle -and $SubTitle.Trim().Length -gt 0)
    $bannerHeight = if ($hasSubtitle) { 180 } else { 130 }
    
    # Calculate scale to maximize diagram size without excessive white margins
    # Available area: X: 40 to 1880 (W: 1840), Y: ($bannerHeight + 10) to 1050 (H: 1040 - $bannerHeight)
    $availW = 1840
    $availH = 1040 - $bannerHeight
    $scaleW = $availW / $srcImg.Width
    $scaleH = $availH / $srcImg.Height
    $scale = [Math]::Min($scaleW, $scaleH)

    $drawW = [int]($srcImg.Width * $scale)
    $drawH = [int]($srcImg.Height * $scale)
    $drawX = [int]((1920 - $drawW) / 2)
    $drawY = [int]($bannerHeight + 10 + ($availH - $drawH) / 2)

    # Render base diagram
    $g.DrawImage($srcImg, $drawX, $drawY, $drawW, $drawH)
    $srcImg.Dispose()

    # Dynamic Title Sizing (65px to 80px target depending on string length)
    $fontSize = if ($HeadTitle.Length -gt 45) { 38 } elseif ($HeadTitle.Length -gt 32) { 42 } else { 46 }
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]$fontSize, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Slate 900
    
    $titleFormat = [System.Drawing.StringFormat]::new()
    $titleFormat.Alignment = [System.Drawing.StringAlignment]::Center
    $titleFormat.LineAlignment = [System.Drawing.StringAlignment]::Center

    $titleRectH = if ($hasSubtitle) { 65 } else { 85 }
    $titleRectY = if ($hasSubtitle) { 32 } else { 38 }
    $titleRect = [System.Drawing.RectangleF]::new(40, $titleRectY, 1840, $titleRectH)
    $g.DrawString($HeadTitle, $titleFont, $titleBrush, $titleRect, $titleFormat)

    # Subtitle if present
    if ($hasSubtitle) {
        $subFont = [System.Drawing.Font]::new("Segoe UI", [float]20, [System.Drawing.FontStyle]::Regular)
        $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(71, 85, 105)) # Slate 600
        $subRect = [System.Drawing.RectangleF]::new(40, 105, 1840, 45)
        $g.DrawString($SubTitle, $subFont, $subBrush, $subRect, $titleFormat)
        $subFont.Dispose()
        $subBrush.Dispose()
    }

    # Save with high-quality JPEG encoder (95%)
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $encoderParams = [System.Drawing.Imaging.EncoderParameters]::new(1)
    $encoderParams.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]95)

    $tempFile = [System.IO.Path]::GetTempFileName() + ".jpg"
    $bmp.Save($tempFile, $codec, $encoderParams)

    $g.Dispose()
    $bmp.Dispose()
    $titleFont.Dispose()
    $titleBrush.Dispose()

    # Safe write
    Copy-Item $tempFile $Dst -Force
    Remove-Item $tempFile -Force
    Write-Host "[VISUAL COMPOSITOR] Saved 1920x1080 16:9 infographic: $Dst"
}

if ($SourcePath -and $OutputPath -and $Title) {
    Render-UniversalInfographic -Src $SourcePath -Dst $OutputPath -HeadTitle $Title -SubTitle $Subtitle
}

