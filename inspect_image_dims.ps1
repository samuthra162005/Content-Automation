Add-Type -AssemblyName System.Drawing

$baseDir = "d:\content\digital-marketing-skills\projects\kanavu-digital\2026-11-16"
$folders = Get-ChildItem -Path $baseDir -Directory | Where-Object { $_.Name -ne "outputs" }

foreach ($f in $folders) {
  Write-Host "=========================================="
  Write-Host "FOLDER: $($f.Name)"
  Write-Host "=========================================="
  $jpgs = Get-ChildItem -Path $f.FullName -Filter "*.jpg"
  foreach ($j in $jpgs) {
    $img = [System.Drawing.Image]::FromFile($j.FullName)
    Write-Host ("  File: {0} ({1}x{2})" -f $j.Name, $img.Width, $img.Height)
    $img.Dispose()
  }
}
