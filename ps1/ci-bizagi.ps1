Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\BizagiModeler.msi"

& msiexec.exe /qn /i "$source_path" Lang = pt | Write-Verbose