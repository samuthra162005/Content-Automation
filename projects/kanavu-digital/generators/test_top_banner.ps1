Add-Type -AssemblyName System.Drawing

$brainDir = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78"
$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16"

function Draw-TopBanner {
    param (
        [System.Drawing.Graphics]$g,
        [string]$Title,
        [string]$Subtitle,
        [string]$BadgeText,
        [string]$BadgeColorHex = "38BDF8",
        [bool]$IsDarkTheme = $true,
        [string]$ThemeHex = "1E40AF"
    )

    $maxWidth = 1780 # 70px margins on 1920 canvas

    # Determine if title fits 1 line at 40pt
    $titleFont = [System.Drawing.Font]::new("Segoe UI", [float]40, [System.Drawing.FontStyle]::Bold)
    $szTitle = $g.MeasureString($Title, $titleFont)
    
    $isTwoLines = $szTitle.Width -gt $maxWidth
    $bannerHeight = if ($isTwoLines) { 240 } else { 190 }

    if ($IsDarkTheme) {
        # Deep obsidian gradient banner at top
        $bannerBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
            [System.Drawing.Point]::new(0, 0),
            [System.Drawing.Point]::new(0, $bannerHeight + 60),
            [System.Drawing.Color]::FromArgb(250, 10, 15, 29),
            [System.Drawing.Color]::FromArgb(0, 10, 15, 29)
        )
        $g.FillRectangle($bannerBrush, 0, 0, 1920, $bannerHeight + 60)
        $bannerBrush.Dispose()

        # Accent top bar (4px)
        $accentColor = [System.Drawing.ColorTranslator]::FromHtml("#$BadgeColorHex")
        $accentBrush = [System.Drawing.SolidBrush]::new($accentColor)
        $g.FillRectangle($accentBrush, 0, 0, 1920, 5)
        $accentBrush.Dispose()

        # Category Badge Pill
        $badgeFont = [System.Drawing.Font]::new("Segoe UI", [float]12, [System.Drawing.FontStyle]::Bold)
        $badgeBrush = [System.Drawing.SolidBrush]::new($accentColor)
        $g.DrawString($BadgeText.ToUpper(), $badgeFont, $badgeBrush, 70, 22)
        $badgeBrush.Dispose()
        $badgeFont.Dispose()

        # Title text (40pt bold pure white with shadow)
        $titleColor = [System.Drawing.Color]::White
        $shadowBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(160, 0, 0, 0))
        $titleBrush = [System.Drawing.SolidBrush]::new($titleColor)

        if ($isTwoLines) {
            # Split title at colon or naturally
            $parts = $Title -split ':\s*', 2
            if ($parts.Count -eq 2) {
                $line1 = $parts[0] + ":"
                $line2 = $parts[1]
            } else {
                # Split at natural midpoint
                $words = $Title -split '\s+'
                $half = [int]($words.Count / 2)
                $line1 = ($words[0..($half-1)] -join " ")
                $line2 = ($words[$half..($words.Count-1)] -join " ")
            }
            # Shadow
            $g.DrawString($line1, $titleFont, $shadowBrush, 72, 57)
            $g.DrawString($line1, $titleFont, $titleBrush, 70, 55)
            $g.DrawString($line2, $titleFont, $shadowBrush, 72, 117)
            $g.DrawString($line2, $titleFont, $titleBrush, 70, 115)

            # Subtitle at y=182
            $subFont = [System.Drawing.Font]::new("Segoe UI", [float]18, [System.Drawing.FontStyle]::Regular)
            $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#94A3B8"))
            $g.DrawString($Subtitle, $subFont, $shadowBrush, 71, 183)
            $g.DrawString($Subtitle, $subFont, $subBrush, 70, 182)
            $subBrush.Dispose()
            $subFont.Dispose()
        } else {
            # Single line 40pt title
            $g.DrawString($Title, $titleFont, $shadowBrush, 72, 57)
            $g.DrawString($Title, $titleFont, $titleBrush, 70, 55)

            # Subtitle at y=125
            $subFont = [System.Drawing.Font]::new("Segoe UI", [float]19, [System.Drawing.FontStyle]::Regular)
            $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#94A3B8"))
            $g.DrawString($Subtitle, $subFont, $shadowBrush, 71, 126)
            $g.DrawString($Subtitle, $subFont, $subBrush, 70, 125)
            $subBrush.Dispose()
            $subFont.Dispose()
        }

        $shadowBrush.Dispose()
        $titleBrush.Dispose()
    } else {
        # Light / 2D Vector theme
        $bgBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#FFFFFF"))
        $g.FillRectangle($bgBrush, 0, 0, 1920, $bannerHeight)
        $bgBrush.Dispose()

        # Accent top bar (6px)
        $accentColor = [System.Drawing.ColorTranslator]::FromHtml("#$ThemeHex")
        $accentBrush = [System.Drawing.SolidBrush]::new($accentColor)
        $g.FillRectangle($accentBrush, 0, 0, 1920, 6)
        $accentBrush.Dispose()

        # Border at bottom of banner
        $borderPen = [System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml("#E2E8F0"), 1)
        $g.DrawLine($borderPen, 0, $bannerHeight, 1920, $bannerHeight)
        $borderPen.Dispose()

        # Category Badge Pill
        $badgeFont = [System.Drawing.Font]::new("Segoe UI", [float]12, [System.Drawing.FontStyle]::Bold)
        $badgeBrush = [System.Drawing.SolidBrush]::new($accentColor)
        $g.DrawString($BadgeText.ToUpper(), $badgeFont, $badgeBrush, 70, 20)
        $badgeBrush.Dispose()
        $badgeFont.Dispose()

        # Title text (40pt bold obsidian #0F172A)
        $titleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#0F172A"))

        if ($isTwoLines) {
            $parts = $Title -split ':\s*', 2
            if ($parts.Count -eq 2) {
                $line1 = $parts[0] + ":"
                $line2 = $parts[1]
            } else {
                $words = $Title -split '\s+'
                $half = [int]($words.Count / 2)
                $line1 = ($words[0..($half-1)] -join " ")
                $line2 = ($words[$half..($words.Count-1)] -join " ")
            }
            $g.DrawString($line1, $titleFont, $titleBrush, 70, 52)
            $g.DrawString($line2, $titleFont, $titleBrush, 70, 112)

            $subFont = [System.Drawing.Font]::new("Segoe UI", [float]18, [System.Drawing.FontStyle]::Regular)
            $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#475569"))
            $g.DrawString($Subtitle, $subFont, $subBrush, 70, 178)
            $subBrush.Dispose()
            $subFont.Dispose()
        } else {
            $g.DrawString($Title, $titleFont, $titleBrush, 70, 52)

            $subFont = [System.Drawing.Font]::new("Segoe UI", [float]19, [System.Drawing.FontStyle]::Regular)
            $subBrush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml("#475569"))
            $g.DrawString($Subtitle, $subFont, $subBrush, 70, 122)
            $subBrush.Dispose()
            $subFont.Dispose()
        }
        $titleBrush.Dispose()
    }

    $titleFont.Dispose()
    return $bannerHeight
}

Write-Host "Helper Draw-TopBanner loaded successfully!"

