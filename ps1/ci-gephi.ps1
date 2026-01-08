# Archivematica CI
Write-Host "Instalando ARCHIVEMATICA"
Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\"
$target_path = "C:\Users\Aluno_CCJE\Desktop\inst_manual"
$filename = "gephi-0.10.1-windows-x64.exe"

try 
{
    robocopy $source_path $target_path $filename /eta
}
catch 
{
    Write-Host "File copy error"
}

$expr = ".\$target_path\$filename /VERYSILENT /NORESTART /ALLUSERS"

Invoke-Expression $expr