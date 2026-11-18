Add-Type -AssemblyName System.Drawing

$brainDir = "C:\Users\Work\.gemini\antigravity\brain\1aa80c0c-09f8-445e-b7ac-01893e3d4c78"
$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16"

. (Join-Path $baseDir "generators\render_master_large_font_visuals.ps1")

# Render the brand new authentic PPC Ecosystem Architecture image!
Render-2DVectorLight `
    -SourcePath (Join-Path $brainDir "ppc_ai_campaign_ecosystem_2027_1794828075756.jpg") `
    -OutputPath (Join-Path $baseDir "blog-6-top-ppc-trends-of-2027\ppc-2027-ecosystem-architecture.jpg") `
    -Title "THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM" `
    -Subtitle "How Machine Learning Connects First-Party Signal Vaults to Dynamic Real-Time Ad Assembly" `
    -BadgeText "2D PPC DATA & AI CAMPAIGN ARCHITECTURE" `
    -ThemeHex "4F46E5"

Write-Host "New authentic PPC image rendered successfully to ppc-2027-ecosystem-architecture.jpg!"

