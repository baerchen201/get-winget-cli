@echo off
cls

echo "Installing winget from local file..."
powershell /Command "Add-AppxProvisionedPackage -PackagePath Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -LicensePath 76fba573f02545629706ab99170237bc_License1.xml -Online -DependencyPackagePath .\Microsoft.UI.Xaml.2.8.x64.appx,.\Microsoft.VCLibs.x64.14.00.Desktop.appx"

pause