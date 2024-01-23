$path = Get-Content -Path .\directory.txt
New-Item -ItemType Directory -Path $path -Name "PDFs"
New-Item -ItemType Directory -Path $path -Name "Images"
New-Item -ItemType Directory -Path $path -Name "Rest"

$fileSystemWatcher = New-Object System.IO.FileSystemWatcher
$fileSystemWatcher.Path = $path
$fileSystemWatcher.EnableRaisingEvents = $true
Write-Host "hehe"

$action = {
    $changeType = $Event.SourceEventArgs.ChangeType
    $file = $Event.SourceEventArgs.FullPath
    Write-Host "Change detected: $changeType - $file"
    if ($file -match '\.pdf$') {
        $destinationFolder = $path+"PDFs"
        Move-Item -Path $file -Destination $destinationFolder -Force
        Write-Host "File moved to $destinationFolder"
    }
}