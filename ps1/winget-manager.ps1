#Requires -RunAsAdministrator

function Write-Signature {
    Clear-Host
    Write-Host "** Equipe de TI"
    Write-Host "** CCJE / UFES"
    Write-Host ""

}
#todo: mysql, archivematica, biblivre
function EnsureLocalUserExists {
    param ([string]$username)
    
    $userExists = (Get-LocalUser).Name -Contains $username
    $password = ConvertTo-SecureString "TempPassword" -AsPlainText -Force
    if (-Not ($userExists))
    {
        Write-Host "Creating user: $username"
        New-LocalUser -Name $username -FullName $username -Password $password
        Set-LocalUser -Name $username -AccountNeverExpires
        Enable-LocalUser -Name $username
        $usersGroup = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-545")
        $group = $usersGroup.Translate([System.Security.Principal.NTAccount]).Value
        $group = $group.Split('\')[1]
        Add-LocalGroupMember -Group $group -Member $username
    }
    if (-Not(Test-Path -Path "C:\Users\$username")) # ensure user directories exists.
    {
        $cred = New-Object System.Management.Automation.PSCredential ($username, $password)
        Write-Host "Creating $username directories"
        Start-Process "cmd.exe" -Credential $cred -ArgumentList "/C" -LoadUserProfile
        
        Set-LocalUser -name $username -Password ([securestring]::new())
        Set-LocalUser -Name $username -UserMayChangePassword $false
        Set-LocalUser -Name $username -PasswordNeverExpires $true
    }
}

Write-Signature
$wg_version = ''
try
{
    $wg_version = winget --version
}
catch [System.Management.Automation.CommandNotFoundException]
{
    Write-Host "winget was not found."
    if (!(Test-Path '.\ps1\winget-dependencies\winget.msixbundle'))
    {
        Write-Host "winget.msixbundle not found. downloading it ..."
        powershell -File '.\ps1\download-winget.ps1'
    }
    Write-Host "installing winget ..."
    $wg_dependencies = '.\ps1\winget-dependencies\Microsoft.UI.Xaml.2.8.appx', '.\ps1\winget-dependencies\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64__8wekyb3d8bbwe.appx'
    Add-AppXPackage -Path '.\ps1\winget-dependencies\winget.msixbundle' -DependencyPath $wg_dependencies
    $wg_version = winget --version
}
catch
{
    Write-Host "error:"
    Write-Host $_
}

EnsureLocalUserExists -username "Aluno_CCJE"

if ($wg_version -ne '')
{
    winget settings --enable LocalManifestFiles
    winget settings --enable LocalArchiveMalwareScanOverride

    Write-Host "a valid winget installation was found: $wg_version"
    Write-Host ""
    $available_configs = "708", "701", "709", "debug"
    
    Write-Host "** config. encontradas:"
    Write-Host ($available_configs -join "`n")
    $lab_config = Read-Host "Digite a config. para instalar"
    
    if ($lab_config -ne '')
    {
        $lab_config.ToLower()
    }

    Import-Csv -Path '.\data\programas.csv' -Encoding utf8 | Foreach-Object {
        if ($_.ID_WINGET -ne '')
        {
            $prgm_configs = $_.CONFIG -split ";"
            if ($prgm_configs.Contains($lab_config))
            {

                Write-Signature
                Write-Host "** Configurando [" $lab_config "]"
                Write-Host "** Tentando instalar:" $_.NOME

                $wg_prgm_options = ''
                if ($_.OPTIONS -ne '')
                {
                    $wg_prgm_options = $_.OPTIONS
                }

                if ($_.ID_WINGET.StartsWith("local:"))
                {
                    $local_path = ".\manifests" + $_.ID_WINGET.Substring(6)
                    Write-Host "installing from local manifest:" $local_path
                    
                    winget install -m $local_path $wg_prgm_options --ignore-local-archive-malware-scan --accept-source-agreements --accept-package-agreements
                }
                elseif ($_.ID_WINGET.StartsWith("ps:"))
                {
                    $script_filepath = ".\ps1\" + $_.ID_WINGET.Substring(3)
                    Write-Host "custom installation script:" $script_filepath
                    powershell -File  $script_filepath
                }
                else
                {
                    winget install -e --id $_.ID_WINGET $wg_prgm_options --accept-source-agreements --accept-package-agreements
                }
            }
        }
    }
}
