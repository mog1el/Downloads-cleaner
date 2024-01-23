$path = Get-Content -Path .\directory.txt

$fileSystemWatcher = New-Object System.IO.FileSystemWatcher
$fileSystemWatcher.Path = $path
$fileSystemWatcher.EnableRaisingEvents = $true
Write-Host "hehe"