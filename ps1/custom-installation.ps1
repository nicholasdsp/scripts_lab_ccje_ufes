
# custom installer: grabs .zip, extract to %appdata% (from username) /Local/CCJE/PRG_<program_name>, create desktop <program_name> symlink
function DoCustomInstall {
    param (
        [string]$url,
        [string]$program_name,
        [string]$exec_filename,
        [string]$username
      )
    if(Test-Path -Path "C:\Users\$username")
    {
        $program_root_dir = "C:\Users\$username\AppData\Local\CCJE"
        if (-Not (Test-Path -Path $program_root_dir))
        {
            New-Item -Path $program_root_dir -ItemType Directory -Force
        }
        Write-Host "HTTP request : $url"
        try 
        {
            Invoke-WebRequest -Uri $url -OutFile ($program_root_dir + "\$program_name.zip")
        }
        catch 
        {
            Write-Host "Erro: $($_.Exception.Response.StatusCode.value__)"
        }
        
        if (Test-Path -Path ($program_root_dir + "\$program_name.zip"))
        {
            Expand-Archive -Path ($program_root_dir + "\$program_name.zip") -DestinationPath "$program_root_dir\PRG_$program_name" -Force
            Write-Host "Installation will be performed at : $program_root_dir\PRG_$program_name"
            $shortcut_destination = "C:\Users\$username\Desktop\$program_name"
            if (-Not(Test-Path -Path $shortcut_destination -PathType Leaf))
            {
                $shortcut_source = "$program_root_dir\PRG_$program_name\$exec_filename"
                New-Item "$shortcut_destination" -ItemType SymbolicLink -Value $shortcut_source -Force
            }
        }
    }
    else
    {
        Write-Host "O username especificado [$username] não foi encontrado."
    }
}