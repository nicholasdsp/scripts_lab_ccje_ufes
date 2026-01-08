Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\googlechromestandaloneenterprise64.msi"

& msiexec.exe /i "$source_path" /qn | Write-Verbose