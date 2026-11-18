$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
  $doc = $word.Documents.Open('d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16\blog-4-what-is-google-e-e-a-t\What_Is_Google_EEAT_Why_It_Matters_for_SEO_and_Website_Trust.docx')
  Write-Host "Opened successfully!"
  Write-Host "InlineShapes count: $($doc.InlineShapes.Count)"
  for ($i = 1; $i -le $doc.InlineShapes.Count; $i++) {
    $ish = $doc.InlineShapes.Item($i)
    Write-Host "Shape $i : Type=$($ish.Type), Width=$($ish.Width), Height=$($ish.Height)"
  }
  $doc.Close([ref]0)
} catch {
  Write-Host "Error: $($_.Exception.Message)"
} finally {
  $word.Quit()
  [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}
