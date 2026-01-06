# https://github.com/Biblivre-org/Biblivre5x/

# install docker, ensure it uses hyper v backend
# run docker desktop
# "C:\Program Files\Docker\Docker\resources\bin\docker.exe" pull cleydyr/biblivre
Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\"
$target_path = "C:\Users\Aluno_CCJE\Desktop\inst_manual"
$filename1 = "Instalador_Biblivre_5.0.5.exe"
$filename2 = "Atualizador_Biblivre_5.1.31.exe"

New-Item -Path $target_path -ItemType Directory -Force

try 
{
    robocopy $source_path $target_path $filename1 /eta
    robocopy $source_path $target_path $filename2 /eta
}
catch 
{
    Write-Host "File copy error"
}