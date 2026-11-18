Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::new(100, 100)
$g = [System.Drawing.Graphics]::FromImage($bmp)

$titles = @(
  @{ Blog="Pillar Fig 1"; Format="B"; Font=26; Title="TOP DIGITAL MARKETING COMPANY: HOW TO DRIVE SUSTAINABLE GROWTH?" },
  @{ Blog="Pillar Fig 2"; Format="C"; Font=32; Title="THE OMNICHANNEL REVENUE GROWTH FLYWHEEL" },
  @{ Blog="Blog 1 Fig 1"; Format="A"; Font=34; Title="HOW TO USE CLAUDE FOR SOCIAL MEDIA MARKETING: 7 TASKS?" },
  @{ Blog="Blog 1 Fig 2"; Format="C"; Font=32; Title="CLAUDE AI CONTENT REPURPOSING SPRINT PIPELINE" },
  @{ Blog="Blog 2 Fig 1"; Format="B"; Font=26; Title="AI AGENTS IN DIGITAL MARKETING: WHICH TASKS CAN YOU AUTOMATE?" },
  @{ Blog="Blog 2 Fig 2"; Format="C"; Font=32; Title="AUTONOMOUS MARKETING PERCEPTION-ACTION CLOSED LOOP" },
  @{ Blog="Blog 3 Fig 1"; Format="A"; Font=34; Title="FIFA WORLD CUP 2026 MARKETING CAMPAIGNS: HOW DID BRANDS WIN ATTENTION?" },
  @{ Blog="Blog 3 Fig 2"; Format="D"; Font=28; Title="OMNICHANNEL TOURNAMENT FAN ACTIVATION COMMAND CENTER" },
  @{ Blog="Blog 4 Fig 1"; Format="C"; Font=32; Title="WHAT IS GOOGLE E-E-A-T AND WHY DOES IT MATTER FOR WEBSITE TRUST?" },
  @{ Blog="Blog 4 Fig 2"; Format="B"; Font=26; Title="THE 4 STRUCTURAL PILLARS OF GOOGLE E-E-A-T SEARCH TRUST" },
  @{ Blog="Blog 5 Fig 1"; Format="D"; Font=28; Title="AI-GENERATED IMAGES ARE GOING VIRAL: WHAT MUST MARKETERS KNOW?" },
  @{ Blog="Blog 5 Fig 2"; Format="C"; Font=32; Title="CORPORATE BRAND INTEGRITY AND AI IMAGE GOVERNANCE FRAMEWORK" },
  @{ Blog="Blog 6 Fig 1"; Format="B"; Font=26; Title="TOP PPC TRENDS OF 2027: 7 CHANGES MARKETERS MUST PREPARE FOR?" },
  @{ Blog="Blog 6 Fig 2"; Format="C"; Font=32; Title="THE 2027 AI-POWERED PPC CAMPAIGN ECOSYSTEM" }
)

foreach ($t in $titles) {
  $font = [System.Drawing.Font]::new("Segoe UI", [float]$t.Font, [System.Drawing.FontStyle]::Bold)
  $size = $g.MeasureString($t.Title, $font)
  $maxAvail = 1920 - 120 # 1800px max safe width
  $status = if ($size.Width -gt $maxAvail) { "[CUT OFF! Over by $([int]($size.Width - $maxAvail))px]" } else { "[OK Fit]" }
  Write-Host ("{0,-15} (Format {1}, {2}pt): Width={3,6:F1}px / 1800px {4}" -f $t.Blog, $t.Format, $t.Font, $size.Width, $status)
  $font.Dispose()
}

$g.Dispose()
$bmp.Dispose()
