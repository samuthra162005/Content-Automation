<#
.SYNOPSIS
    Universal Brand-Aware Infographic Compositor & Typography Engine.
    Executes the Universal Brand-Aware Blog Illustration System across all projects.
#>

param (
    [string]$SourcePath,
    [string]$OutputPath,
    [string]$Title,
    [string]$Subtitle = "",
    [string]$Brand = "kanavu-technologies",
    [string]$BgColor = "",
    [string]$TitleColor = ""
)

Add-Type -AssemblyName System.Drawing

# Brand Theme Profiles
$BrandThemes = @{
    "thalir-kids-dental" = @{
        Bg = [System.Drawing.Color]::FromArgb(255, 255, 255)
        Title = [System.Drawing.Color]::FromArgb(15, 23, 42)
        Sub = [System.Drawing.Color]::FromArgb(13, 148, 136) # Teal
    }
    "little-natura" = @{
        Bg = [System.Drawing.Color]::FromArgb(255, 253, 247) # Warm cream
        Title = [System.Drawing.Color]::FromArgb(67, 40, 24)
        Sub = [System.Drawing.Color]::FromArgb(180, 83, 9)   # Amber
    }
    "kanavu-technologies" = @{
        Bg = [System.Drawing.Color]::FromArgb(255, 255, 255)
        Title = [System.Drawing.Color]::FromArgb(15, 23, 42) # Slate 900
        Sub = [System.Drawing.Color]::FromArgb(37, 99, 235)  # Vibrant Cobalt
    }
    "kanavu-digital" = @{
        Bg = [System.Drawing.Color]::FromArgb(255, 255, 255)
        Title = [System.Drawing.Color]::FromArgb(26, 115, 232) # Search Blue
        Sub = [System.Drawing.Color]::FromArgb(52, 168, 83)    # Emerald Green
    }
    "whats-score" = @{
        Bg = [System.Drawing.Color]::FromArgb(255, 255, 255)
        Title = [System.Drawing.Color]::FromArgb(10, 25, 47)  # Navy
        Sub = [System.Drawing.Color]::FromArgb(21, 128, 61)   # Court Green
    }
    "fortune-city-erode" = @{
        Bg = [System.Drawing.Color]::FromArgb(255, 253, 247) # Soft warm
        Title = [System.Drawing.Color]::FromArgb(15, 23, 42)
        Sub = [System.Drawing.Color]::FromArgb(217, 119, 6)   # Foodie Gold
    }
    "kanavu-school" = @{
        Bg = [System.Drawing.Color]::FromArgb(255, 251, 235) # Soft Ivory
        Title = [System.Drawing.Color]::FromArgb(29, 78, 216) # Royal Blue
        Sub = [System.Drawing.Color]::FromArgb(217, 119, 6)
    }
}

$theme = $BrandThemes[$Brand]
if (-not $theme) { $theme = $BrandThemes["kanavu-technologies"] }

if (-not (Test-Path $SourcePath)) {
    Write-Error "Source image not found: $SourcePath"
    exit 1
}

Write-Host "[BRAND VISUAL PIPELINE] Compositing for brand: $Brand"
Write-Host "  Source: $SourcePath"
Write-Host "  Destination: $OutputPath"

$srcImg = [System.Drawing.Image]::FromFile($SourcePath)

$targetW = 1920
$targetH = 1080
$bmp = [System.Drawing.Bitmap]::new($targetW, $targetH)
$g = [System.Drawing.Graphics]::FromImage($bmp)

$g.Clear($theme.Bg)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$hasSubtitle = ($Subtitle -and $Subtitle.Trim().Length -gt 0)
$bannerH = if ($hasSubtitle) { 180 } else { 130 }

# Maximize visual bounding box below banner
$availW = 1840
$availH = 1040 - $bannerH
$scale = [Math]::Min($availW / $srcImg.Width, $availH / $srcImg.Height)

$drawW = [int]($srcImg.Width * $scale)
$drawH = [int]($srcImg.Height * $scale)
$drawX = [int]((1920 - $drawW) / 2)
$drawY = [int]($bannerH + 10 + ($availH - $drawH) / 2)

$g.DrawImage($srcImg, $drawX, $drawY, $drawW, $drawH)
$srcImg.Dispose()

# Typography Layer (Large Bold Headline)
$fontSize = if ($Title.Length -gt 45) { 38 } elseif ($Title.Length -gt 32) { 42 } else { 46 }
$titleFont = [System.Drawing.Font]::new("Segoe UI", [float]$fontSize, [System.Drawing.FontStyle]::Bold)
$titleBrush = [System.Drawing.SolidBrush]::new($theme.Title)

$titleFormat = [System.Drawing.StringFormat]::new()
$titleFormat.Alignment = [System.Drawing.StringAlignment]::Center
$titleFormat.LineAlignment = [System.Drawing.StringAlignment]::Center

$titleRectH = if ($hasSubtitle) { 65 } else { 85 }
$titleRectY = if ($hasSubtitle) { 32 } else { 38 }
$titleRect = [System.Drawing.RectangleF]::new(40, $titleRectY, 1840, $titleRectH)
$g.DrawString($Title, $titleFont, $titleBrush, $titleRect, $titleFormat)

if ($hasSubtitle) {
    $subFont = [System.Drawing.Font]::new("Segoe UI", [float]20, [System.Drawing.FontStyle]::Regular)
    $subBrush = [System.Drawing.SolidBrush]::new($theme.Sub)
    $subRect = [System.Drawing.RectangleF]::new(40, 105, 1840, 45)
    $g.DrawString($Subtitle, $subFont, $subBrush, $subRect, $titleFormat)
    $subFont.Dispose()
    $subBrush.Dispose()
}

$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$encoderParams = [System.Drawing.Imaging.EncoderParameters]::new(1)
$encoderParams.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]95)

$tempFile = [System.IO.Path]::GetTempFileName() + ".jpg"
$bmp.Save($tempFile, $codec, $encoderParams)

$g.Dispose()
$bmp.Dispose()
$titleFont.Dispose()
$titleBrush.Dispose()

Copy-Item $tempFile $OutputPath -Force
Remove-Item $tempFile -Force
Write-Host "[BRAND VISUAL PIPELINE] Successfully exported 1920x1080 visual: $OutputPath"

