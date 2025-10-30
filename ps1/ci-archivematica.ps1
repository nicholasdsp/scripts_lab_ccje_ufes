# Archivematica CI

Write-Host "Instalando ARCHIVEMATICA"

$url = "http://ccje-web/lab/Archivematica 1-12-0.ova"
$target_path = "C:\Users\Aluno_CCJE\Desktop\Archivematica 1-12-0.ova"
try 
{
    Invoke-WebRequest -Uri $url -OutFile ($target_path)
}
catch 
{
    Write-Host "Erro: $($_.Exception.Response.StatusCode.value__)"
}