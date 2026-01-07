Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\BizagiModeler.msi"

& msiexec.exe /i "$source_path" /qn Lang=pt ISSETUPDRIVEN=1 | Write-Verbose