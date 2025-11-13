# Archivematica CI
Write-Host "Instalando ARCHIVEMATICA"
Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\"
$target_path = "C:\Users\Aluno_CCJE\Desktop\"
$filename = "Archivematica 1-12-0.ova"

try 
{
    robocopy $source_path $target_path $filename /eta
}
catch 
{
    Write-Host "File copy error"
}