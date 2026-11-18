$word = New-Object -ComObject Word.Application
$word.Visible = $false

$docs = @(
  "Top_Digital_Marketing_Company_Strategies_for_Growth.docx",
  "How_to_Use_Claude_for_Social_Media_Marketing.docx",
  "AI_Agents_in_Digital_Marketing_5_Tasks_You_Can_Automate.docx",
  "FIFA_World_Cup_2026_Marketing_Campaigns.docx",
  "What_Is_Google_EEAT_Why_It_Matters_for_SEO_and_Website_Trust.docx",
  "AI_Generated_Images_Are_Going_Viral_Marketer_Guide.docx",
  "Top_PPC_Trends_of_2027_7_Changes_to_Prepare_For.docx"
)

$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16\outputs"

foreach ($d in $docs) {
  $p = Join-Path $baseDir $d
  try {
    $doc = $word.Documents.Open($p)
    $shapes = $doc.InlineShapes.Count
    Write-Host "[OK] $d - Opened successfully! InlineShapes: $shapes"
    $doc.Close([ref]0)
  } catch {
    Write-Host "[ERROR] $d - Failed to open: $($_.Exception.Message)"
  }
}

$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
