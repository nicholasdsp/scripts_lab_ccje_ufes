# Scripts LAB CCJE/UFES

Equipe de TI
CCJE/UFES

```powershell
$dpath = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path
Invoke-WebRequest -Uri "https://github.com/nicholasdsp/scripts_lab_ccje_ufes/archive/refs/heads/master.zip" -OutFile ($dpath + "\scripts_lab_ccje_ufes.zip")
Expand-Archive -Path ($dpath + "\scripts_lab_ccje_ufes.zip") -DestinationPath $dpath -Force
```
