if (Test-Path -Path "C:\Users\Aluno_CCJE")
{
    if (Test-Path -Path "C:\Program Files\WinGet\Links")
    {
        Get-ChildItem -Path "C:\Program Files\WinGet\Links" -File | ForEach-Object 
        {
            Write-Host "Criando atalho para: $($_.Name)"
            
            $shorcutDestination = "C:\Users\Aluno_CCJE\Desktop\" + $_.Name
            if (Test-Path -Path $shorcutDestination)
            {
                Write-Host "Atalho existe."
            }
            else 
            {
                $shortcutTarget = (Get-Item -Path $_.Name).Target
                New-Item -Path $shorcutDestination -ItemType SymbolicLink -Value $shortcutTarget -Force
            }
        }
    }
}
else 
{
    Write-Host "Aluno_CCJE não encontrado."
}