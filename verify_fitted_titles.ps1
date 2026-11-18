Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::new(100, 100)
$g = [System.Drawing.Graphics]::FromImage($bmp)

$titles = @(
  @{ Blog="Pillar Fig 1"; Title="TOP DIGITAL MARKETING COMPANY: HOW TO DRIVE SUSTAINABLE GROWTH?" },
  @{ Blog="Pillar Fig 2"; Title="THE OMNICHANNEL REVENUE GROWTH FLYWHEEL" },
  @{ Blog="Blog 1 Fig 1"; Title="HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS" },
  @{ Blog="Blog 1 Fig 2"; Title="CLAUDE AI CONTENT REPURPOSING SPRINT PIPELINE" },
  @{ Blog="Blog 2 Fig 1"; Title="AI AGENTS IN DIGITAL MARKETING: WHICH TASKS CAN YOU AUTOMATE?" },
  @{ Blog="Blog 2 Fig 2"; Title="AUTONOMOUS MARKETING PERCEPTION-ACTION CLOSED LOOP" },
  @{ Blog="Blog 3 Fig 1"; Title="FIFA WORLD CUP 2026 MARKETING CAMPAIGNS: 5 SMART MOVES" },
  @{ Blog="Blog 3 Fig 2"; Title="OMNICHANNEL TOURNAMENT FAN ACTIVATION COMMAND CENTER" },
  @{ Blog="Blog 4 Fig 1"; Title="WHAT IS GOOGLE E-E-A-T? WHY IT MATTERS FOR SEO TRUST" },
  @{ Blog="Blog 4 Fig 2"; Title="THE 4 STRUCTURAL PILLARS OF GOOGLE E-E-A-T SEARCH TRUST" },
  @{ Blog="Blog 5 Fig 1"; Title="AI-GENERATED IMAGES ARE GOING VIRAL: WHAT TO KNOW" },
  @{ Blog="Blog 5 Fig 2"; Title="CORPORATE BRAND INTEGRITY & AI IMAGE GOVERNANCE FRAMEWORK" },
  @{ Blog="Blog 6 Fig 1"; Title="TOP PPC TRENDS OF 2027: 7 CHANGES TO PREPARE FOR" },
  @{ Blog="Blog 6 Fig 2"; Title="THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM" }
)

$maxAvail = 1780
$allPass = $true

foreach ($t in $titles) {
  $font = [System.Drawing.Font]::new("Segoe UI", [float]27, [System.Drawing.FontStyle]::Bold)
  $sz = $g.MeasureString($t.Title, $font)
  $status = if ($sz.Width -le $maxAvail) { "[PASS] Fits comfortably" } else { $allPass = $false; "[FAIL] Over width" }
  Write-Host ("{0,-15}: Width={1,6:F1}px / {2}px {3}" -f $t.Blog, $sz.Width, $maxAvail, $status)
  $font.Dispose()
}

$g.Dispose()
$bmp.Dispose()

if ($allPass) { Write-Host "`nALL 14 TITLES FIT COMFORTABLY WITH ZERO TRUNCATION!" }
