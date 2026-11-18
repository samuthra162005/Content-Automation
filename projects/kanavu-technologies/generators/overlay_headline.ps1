Add-Type -AssemblyName System.Drawing

function Add-InfographicHeadline {
    param (
        [string]$SourcePath,
        [string]$OutputPath,
        [string]$Title,
        [string]$Subtitle
    )

    Write-Host "Processing: $SourcePath -> $OutputPath"
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

    # Title Banner zone: top 180px
    # Calculate source scaling to fit below the banner (Y: 200 to 1040, available H: 840, available W: 1840)
    $availW = 1840
    $availH = 840
    $scaleW = $availW / $srcImg.Width
    $scaleH = $availH / $srcImg.Height
    $scale = [Math]::Min($scaleW, $scaleH)

    $drawW = [int]($srcImg.Width * $scale)
    $drawH = [int]($srcImg.Height * $scale)
    $drawX = [int]((1920 - $drawW) / 2)
    $drawY = [int](200 + ($availH - $drawH) / 2)

    $g.DrawImage($srcImg, $drawX, $drawY, $drawW, $drawH)
    $srcImg.Dispose()

    # Draw Title
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]44, [System.Drawing.FontStyle]::Bold)
    $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 23, 42)) # Slate 900
    $titleFormat = [System.Drawing.StringFormat]::new()
    $titleFormat.Alignment = [System.Drawing.StringAlignment]::Center
    $titleFormat.LineAlignment = [System.Drawing.StringAlignment]::Center

    $titleRect = [System.Drawing.RectangleF]::new(40, 35, 1840, 65)
    $g.DrawString($Title, $titleFont, $titleBrush, $titleRect, $titleFormat)

    # Draw Subtitle if present
    if ($Subtitle -and $Subtitle.Trim().Length -gt 0) {
        $subFont = [System.Drawing.Font]::new("Segoe UI", [float]20, [System.Drawing.FontStyle]::Regular)
        $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(71, 85, 105)) # Slate 600
        $subRect = [System.Drawing.RectangleF]::new(40, 105, 1840, 45)
        $g.DrawString($Subtitle, $subFont, $subBrush, $subRect, $titleFormat)
        $subFont.Dispose()
        $subBrush.Dispose()
    }

    # Save as JPEG with 95 quality
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $encoderParams = [System.Drawing.Imaging.EncoderParameters]::new(1)
    $encoderParams.Param[0] = [System.Drawing.Imaging.EncoderParameter]::new([System.Drawing.Imaging.Encoder]::Quality, [long]95)

    # Use a temporary file to prevent lock collision
    $tempPath = [System.IO.Path]::GetTempFileName() + ".jpg"
    $bmp.Save($tempPath, $codec, $encoderParams)

    $g.Dispose()
    $bmp.Dispose()
    $titleFont.Dispose()
    $titleBrush.Dispose()

    Copy-Item $tempPath $OutputPath -Force
    Remove-Item $tempPath -Force
    Write-Host "Successfully generated: $OutputPath"
}

# 1. Blog 5: Food Delivery App Architecture
Add-InfographicHeadline `
    -SourcePath "d:\content\digital-marketing-skills\projects\kanavu-technologies\2026-11-13\blog-5-food-delivery-app-development\food-delivery-app-architecture.jpg" `
    -OutputPath "d:\content\digital-marketing-skills\projects\kanavu-technologies\2026-11-13\blog-5-food-delivery-app-development\hero-image.jpg" `
    -Title "FOOD DELIVERY APPLICATION ARCHITECTURE" `
    -Subtitle "Three-Sided System: Consumer App, Kitchen Portal & Driver Dispatch"

# 2. Blog 6: Autonomous AI Agent Architecture Loop
Add-InfographicHeadline `
    -SourcePath "d:\content\digital-marketing-skills\projects\kanavu-technologies\2026-11-13\blog-6-what-is-an-ai-agent\what-is-an-ai-agent-architecture-loop.jpg" `
    -OutputPath "d:\content\digital-marketing-skills\projects\kanavu-technologies\2026-11-13\blog-6-what-is-an-ai-agent\hero-image.jpg" `
    -Title "AUTONOMOUS AI AGENT OPERATIONAL CONTROL LOOP" `
    -Subtitle "Perception, LLM Reasoning Core & Tool Execution Modules"

# 3. Blog 1: Cloudflare Pages Deployment Flow
Add-InfographicHeadline `
    -SourcePath "d:\content\digital-marketing-skills\projects\kanavu-technologies\2026-11-13\blog-1-free-website-hosting-cloudflare-pages\cloudflare-pages-deployment-flow.jpg" `
    -OutputPath "d:\content\digital-marketing-skills\projects\kanavu-technologies\2026-11-13\blog-1-free-website-hosting-cloudflare-pages\cloudflare-pages-deployment-flow.jpg" `
    -Title "CLOUDFLARE PAGES 4-STEP DEPLOYMENT PIPELINE" `
    -Subtitle "Automated Git Continuous Integration, Edge Build & Global Distribution"

# 4. Blog 4: Textile Swatch Filter UI
Add-InfographicHeadline `
    -SourcePath "d:\content\digital-marketing-skills\projects\kanavu-technologies\2026-11-13\blog-4-textile-industry-website-development\textile-swatch-filter-ui.jpg" `
    -OutputPath "d:\content\digital-marketing-skills\projects\kanavu-technologies\2026-11-13\blog-4-textile-industry-website-development\textile-swatch-filter-ui.jpg" `
    -Title "B2B TEXTILE SWATCH ORDERING PORTAL" `
    -Subtitle "Technical Fabric Specifications, GSM Filters & Wholesale Sample Requests"
