$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
  $doc = $word.Documents.Open('d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16\blog-4-what-is-google-e-e-a-t\What_Is_Google_EEAT_Why_It_Matters_for_SEO_and_Website_Trust.docx')
  $pdfPath = 'd:\content\digital-marketing-skills\test_blog4.pdf'
  $doc.ExportAsFixedFormat($pdfPath, 17) # 17 = wdExportFormatPDF
  Write-Host "PDF exported successfully to $pdfPath"
  $doc.Close([ref]0)
} catch {
  Write-Host "Error: $($_.Exception.Message)"
} finally {
  $word.Quit()
  [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}
