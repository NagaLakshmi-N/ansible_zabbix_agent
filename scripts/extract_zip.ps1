param([string]$zipfile, [string]$outpath)
$shell = New-Object -ComObject shell.application

If (Test-Path $outpath){
  rm $outpath -Force -Recurse
}

md $outpath

$zip = $shell.NameSpace($zipfile)
foreach ($item in $zip.items()) {
  $shell.Namespace($outpath).CopyHere($item)
}
