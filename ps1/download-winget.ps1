if (-Not (Test-Path -Path "./ps1/winget-dependencies"))
{
    New-Item "./ps1/winget-dependencies" -ItemType Directory -ea 0
}

$latestWingetMsixBundleUri = "http://ccje-web/lab/winget.msixbundle"
#$latestWingetMsixBundleUri = $(Invoke-RestMethod https://api.github.com/repos/microsoft/winget-cli/releases/latest).assets.browser_download_url | Where-Object {$_.EndsWith(".msixbundle")}
Write-Information "downloading winget ..."
Invoke-WebRequest -Uri $latestWingetMsixBundleUri -OutFile "./ps1/winget-dependencies/winget.msixbundle"

if (-Not (Test-Path -Path "./ps1/winget-dependencies/Microsoft.UI.Xaml.2.8.appx"))
{
    Invoke-WebRequest -Uri "http://ccje-web/lab/Microsoft.UI.Xaml.2.8.appx" -OutFile "./ps1/winget-dependencies/Microsoft.UI.Xaml.2.8.appx"
}
if (-Not (Test-Path -Path "./ps1/winget-dependencies\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64__8wekyb3d8bbwe.appx"))
{
    Invoke-WebRequest -Uri "http://ccje-web/lab/Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64__8wekyb3d8bbwe.Appx" -OutFile "./ps1/winget-dependencies/Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64__8wekyb3d8bbwe.appx"
}