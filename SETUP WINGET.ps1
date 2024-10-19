Write-Output "Downloading WinGet and its dependencies..."

$itemlist = @(("Microsoft.VCLibs.x64.14.00.Desktop.appx", "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"), ("Microsoft.UI.Xaml.2.8.x64.appx", "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx"), ("Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle", "https://aka.ms/getwinget"))
$del = (Read-Host "Delete installation files? (y/N)").ToLower()

Clear-Host

for ($i = 0; $i -lt $itemlist.Length; $i++) {
    $item = $itemlist[$i]
    
    $filename = $item[0]
    $downloadurl = $item[1]

    # Write progress
    Write-Progress -Id 1 -Activity "Installing dependencies" -Status ("Installing item $($i + 1) of " + $itemlist.Length.ToString() + ' "' + $filename + '"') -PercentComplete (($i) / $itemlist.Length * 100)

    if (Test-Path $filename) {
        if ((Read-Host "Item $filename already exists. Would you like to download it and overwrite the file? (Y/n)").ToLower() -ne "n") {
            Remove-Item $filename
            Invoke-WebRequest -Uri $downloadurl -OutFile $filename
        }
    } else {
        Invoke-WebRequest -Uri $downloadurl -OutFile $filename
    }
    Add-AppxPackage $filename

    if ($del -eq "y") {
        Remove-Item $filename
    }
}
Write-Progress -Id 1 -Activity "Processing Items" -Status "Done" -PercentComplete 100
Pause
