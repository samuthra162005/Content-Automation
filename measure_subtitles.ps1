Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::new(100, 100)
$g = [System.Drawing.Graphics]::FromImage($bmp)

$subtitles = @(
  @{ Blog="Pillar Fig 1"; Format="B"; Font=15; Sub="5 Architectural Growth Pillars: Technical SEO, Paid Media, Content Moats, CRO and Attribution" },
  @{ Blog="Pillar Fig 2"; Format="C"; Font=16; Sub="Synchronizing Inbound Search, Precision Paid Acquisition, Platform CRO and Closed-Loop Attribution" },
  @{ Blog="Blog 1 Fig 1"; Format="A"; Font=16; Sub="Captions, Monthly Content Calendars, Creative Hooks, Audience Research and Repurposing" },
  @{ Blog="Blog 1 Fig 2"; Format="C"; Font=16; Sub="Decomposing Long-Form Video Transcripts and Podcasts into Platform-Ready Carousels and Threads" },
  @{ Blog="Blog 2 Fig 1"; Format="B"; Font=15; Sub="Autonomous Market Surveillance, Dynamic Reporting, Inbound Routing and Micro-Budget Bidding" },
  @{ Blog="Blog 2 Fig 2"; Format="C"; Font=16; Sub="How AI Agents Detect Signal Shifts, Reason Multi-Step Goals and Call APIs Within Guardrails" },
  @{ Blog="Blog 3 Fig 1"; Format="A"; Font=16; Sub="5 Strategic Moves: Host-City Co-Creation, 90-Second Agile Newsrooms, AR Filters and Flash Commerce" },
  @{ Blog="Blog 3 Fig 2"; Format="D"; Font=15; Sub="Connecting In-Stadium Live Emotion with Second-Screen Feeds and Instant Mobile Conversions" },
  @{ Blog="Blog 4 Fig 1"; Format="C"; Font=16; Sub="Experience, Expertise, Authoritativeness and Trust: How Quality Evaluators Audit Digital Credibility" },
  @{ Blog="Blog 4 Fig 2"; Format="B"; Font=15; Sub="Defensible Author Entities, Peer Citations and Transparent Security Anchoring Site Authority" },
  @{ Blog="Blog 5 Fig 1"; Format="D"; Font=15; Sub="Commercial Copyright Realities, Brand Authenticity Dilution, Quality Artifacts and Ethical Disclosure" },
  @{ Blog="Blog 5 Fig 2"; Format="C"; Font=16; Sub="4-Stage Review Protocol: Ideation, Legal IP Audit, Human Art Direction and Transparent Release" },
  @{ Blog="Blog 6 Fig 1"; Format="B"; Font=15; Sub="Conversational Query Ads, Predictive LTV Bidding, Clean First-Party Vaults and Incrementality Testing" },
  @{ Blog="Blog 6 Fig 2"; Format="C"; Font=16; Sub="How Machine Learning Connects First-Party Signal Vaults to Dynamic Real-Time Ad Assembly" }
)

foreach ($s in $subtitles) {
  $font = [System.Drawing.Font]::new("Segoe UI", [float]$s.Font, [System.Drawing.FontStyle]::Regular)
  $size = $g.MeasureString($s.Sub, $font)
  $maxAvail = 1800
  $status = if ($size.Width -gt $maxAvail) { "[CUT OFF! Over by $([int]($size.Width - $maxAvail))px]" } else { "[OK Fit]" }
  Write-Host ("{0,-15} (Sub {1}pt): Width={2,6:F1}px / 1800px {3}" -f $s.Blog, $s.Font, $size.Width, $status)
  $font.Dispose()
}

$g.Dispose()
$bmp.Dispose()
