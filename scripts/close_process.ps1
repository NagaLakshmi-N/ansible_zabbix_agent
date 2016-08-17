param(
   [String] $process_name
)

$process = Get-Process $process_name -ErrorAction SilentlyContinue
if ($process) {
  $process.CloseMainWindow()
  if (!$process.HasExited) {
    $process | Stop-Process -Force
  }
}
