Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\GraphDB_Desktop-10.1.4.msi"

msiexec /qn /i "$source_path" MSIINSTALLPERUSER=1