Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap 1920, 1080
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$titles = @(
    "TOP DIGITAL MARKETING COMPANY: HOW TO DRIVE SUSTAINABLE GROWTH?",
    "THE OMNICHANNEL REVENUE GROWTH FLYWHEEL",
    "HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS",
    "CLAUDE AI CONTENT REPURPOSING SPRINT PIPELINE",
    "AI AGENTS IN DIGITAL MARKETING: WHICH TASKS CAN YOU AUTOMATE?",
    "AUTONOMOUS MARKETING PERCEPTION-ACTION CLOSED LOOP",
    "FIFA WORLD CUP 2026 MARKETING CAMPAIGNS: 5 SMART MOVES",
    "OMNICHANNEL TOURNAMENT FAN ACTIVATION COMMAND CENTER",
    "WHAT IS GOOGLE E-E-A-T? WHY IT MATTERS FOR SEO TRUST",
    "THE 4 STRUCTURAL PILLARS OF GOOGLE E-E-A-T SEARCH TRUST",
    "AI-GENERATED IMAGES ARE GOING VIRAL: WHAT TO KNOW",
    "CORPORATE BRAND INTEGRITY & AI IMAGE GOVERNANCE FRAMEWORK",
    "TOP PPC TRENDS OF 2027: 7 CHANGES TO PREPARE FOR",
    "THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM"
)

Write-Host "MEASURING 40pt BOLD TITLES (Max Width = 1780px):"
foreach ($t in $titles) {
    $f40 = [System.Drawing.Font]::new("Segoe UI", [float]40, [System.Drawing.FontStyle]::Bold)
    $sz40 = $g.MeasureString($t, $f40)
    $status = if ($sz40.Width -le 1780) { "FITS 1 LINE (PASS)" } else { "EXCEEDS 1780px" }
    Write-Host ("Width={0,6:F1}px : {1} : {2}" -f $sz40.Width, $status, $t)
    $f40.Dispose()
}

Write-Host "`nMEASURING 42pt BOLD TITLES (Max Width = 1780px):"
foreach ($t in $titles) {
    $f42 = [System.Drawing.Font]::new("Segoe UI", [float]42, [System.Drawing.FontStyle]::Bold)
    $sz42 = $g.MeasureString($t, $f42)
    $status = if ($sz42.Width -le 1780) { "FITS 1 LINE (PASS)" } else { "EXCEEDS 1780px" }
    Write-Host ("Width={0,6:F1}px : {1} : {2}" -f $sz42.Width, $status, $t)
    $f42.Dispose()
}

$g.Dispose()
$bmp.Dispose()
