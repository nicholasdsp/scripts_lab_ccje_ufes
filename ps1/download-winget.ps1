$latestWingetMsixBundleUri = $(Invoke-RestMethod https://api.github.com/repos/microsoft/winget-cli/releases/latest).assets.browser_download_url | Where-Object {$_.EndsWith(".msixbundle")}
Write-Information "downloading winget ..."
Invoke-WebRequest -Uri $latestWingetMsixBundleUri -OutFile "./ps1/winget-dependencies/winget.msixbundle"