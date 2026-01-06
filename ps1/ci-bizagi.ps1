Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\"
$target_path = "C:\Users\Aluno_CCJE\Desktop\inst_manual"
$filename1 = "BizagiModelerSetup_4.1.0002.exe"

New-Item -Path $target_path -ItemType Directory -Force

try 
{
    robocopy $source_path $target_path $filename1 /eta
}
catch 
{
    Write-Host "File copy error"
}