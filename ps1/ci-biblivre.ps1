Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

$source_path = "\\ccje-smb2\lc_guest\biblivre"
$target_path = "C:\Users\Aluno_CCJE\Desktop\inst_manual"
$filename1 = "apache-tomcat-7.0.70.exe"
$filename2 = "httpd-2.2.25.msi"
$filename3 = "postgresql-9.1.23-1-x64.exe"
$filename4 = "Atualizador_Biblivre_5.1.31.exe"
$filename5 = "Instalador_Biblivre_5.0.5.exe"

New-Item -Path $target_path -ItemType Directory -Force

try 
{
    robocopy $source_path $target_path $filename1 /eta
    robocopy $source_path $target_path $filename2 /eta
    robocopy $source_path $target_path $filename3 /eta
    robocopy $source_path $target_path $filename4 /eta
    robocopy $source_path $target_path $filename5 /eta
}
catch 
{
    Write-Host "File copy error"
}

$instl_fullpath = Join-Path $target_path $filename3

if (Test-Path $instl_fullpath)
{
    Write-Host "Installing postgres [1/3]"
    $pw = ConvertTo-SecureString "abracadabra" -AsPlainText -Force
    New-LocalUser -Name "postgres" -Password $pw -PasswordNeverExpires -UserMayNotChangePassword
    if (Get-LocalGroup -Name "Usuários" -ErrorAction SilentlyContinue)
    {
        Remove-LocalGroupMember -Group "Usuários" -Member "postgres" -ErrorAction SilentlyContinue
    }
    if (Get-LocalGroup -Name "Users" -ErrorAction SilentlyContinue)
    {
        Remove-LocalGroupMember -Group "Users" -Member "postgres" -ErrorAction SilentlyContinue
    }
    Start-Process -FilePath $instl_fullpath -ArgumentList "--mode unattended --servicepassword abracadabra --superpassword abracadabra --unattendedmodeui none" -Wait
}
else 
{
    Write-Host "postgres not found"
    exit
}

$instl_fullpath = Join-Path $target_path $filename1

if (Test-Path $instl_fullpath)
{
    Write-Host "Installing tomcat [2/3]"
    Start-Process -FilePath $instl_fullpath -ArgumentList "/S" -Wait
}
else 
{
    Write-Host "tomcat not found"
    exit    
}
$instl_fullpath = Join-Path $target_path $filename2

if (Test-Path $instl_fullpath)
{
    Write-Host "Installing apache [3/3]"
    Start-Process -FilePath "msiexec" -ArgumentList "/i `"$instl_fullpath`" ALLUSERS=1 SERVERADMIN=equipe@biblivre.org.br SERVERNAME=localhost SERVERDOMAIN=localhost SERVERPORT=80 /QB-" -Wait
}
else 
{
    Write-Host "apache not found"
    exit    
}
$instl_fullpath = Join-Path $target_path $filename5

if (Test-Path $instl_fullpath)
{
    Start-Process -FilePath $instl_fullpath
}