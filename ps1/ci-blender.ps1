Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\blender-3.6.23-windows-x64.msi"

& msiexec.exe /i "$source_path" /qn ALLUSERS=1 | Write-Verbose