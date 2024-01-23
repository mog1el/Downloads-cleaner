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
        $destinationFolder = $path+"\PDFs"
        Move-Item -Path $file -Destination $destinationFolder -Force
        Write-Host "File moved to $destinationFolder"
    }
    elseif ($file -match '\.jpg' -or $file -match '\.jpg' -or $file -match '\.jpeg' -or $file -match '\.jpg' -or $file -match '\.png' -or $file -match '\.gif' -or $file -match '\.ico' -or $file -match '\.webp') {
        $destinationFolder = $path + "\Images"
        Move-Item -Path $file -Destination $destinationFolder -Force
        Write-Host "File moved to $destinationFolder"
    }
    else{
        $destinationFolder = $path + "\Rest"
        Move-Item -Path $file -Destination $destinationFolder -Force
        Write-Host "File moved to $destinationFolder"
    }
}

Register-ObjectEvent -InputObject $fileSystemWatcher -EventName "Created" -Action $action
Write-Host "Monitoring folder: $folderPath"
Write-Host "Press Ctrl+C to stop monitoring."
try {
    while ($true) {
        Start-Sleep -Seconds 1
    }
}
finally {
    Unregister-Event -SourceIdentifier $fileSystemWatcher.Created
    $fileSystemWatcher.Dispose()
    Write-Host "File system watcher stopped."
}
