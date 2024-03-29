# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# File:    mikemarable_demo.ps1
# Version: 22.5.23.1
# Date:    23-May-2022
# Author:  Mike Marable
#
# 

# Version: 22.7.28.1
# Date:    27-July-2022
# Author:  Mike Marable
#
# Modified to work "real world" in my tenant


# Version:
# Date:
# Author:

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

<#
.SYNOPSIS
    
.DESCRIPTION
    
.PARAMETER RunType
    
.NOTES

.EXAMPLE

#>

Param()


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Functions

#----------------------------
FUNCTION Add-MAK
#----------------------------
    {
        [CmdletBinding()]
        param (
            [Parameter()]
            [String]$ProdKey
        )

        #Start-Process -FilePath C:\Windows\System32\wscript.exe -ArgumentList 'slmgr.vbs /ipk 12345-12345-12345-12345-12345' | Out-Null
        Write-Host -ForegroundColor DarkGray "Product Key: $ProdKey"
        Start-Process -FilePath C:\Windows\System32\wscript.exe -ArgumentList "slmgr.vbs /ipk $ProdKey" | Out-Null
        $ProcessId = (Get-Process -Name 'wscript').Id
        if ($ProcessId) {
            Wait-Process $ProcessId
        }
    }
    #End Add-MAK


# End of Functions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Start of Code

# =============================================================================
# Features to Demonstrate
# =============================================================================

#----------------------------
# Initialize
Write-Host -ForegroundColor DarkGray "OSDCloud Demo 22.5.25.4"
Invoke-Expression -Command (Invoke-RestMethod -Uri functions.osdcloud.com)
$Transcript = "$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-OSDCloud-MikeMarable.log"
$null = Start-Transcript -Path (Join-Path "$env:SystemRoot\Temp" $Transcript) -ErrorAction Ignore
# End Initialize


#----------------------------
# WinPE
IF ($env:SystemDrive -eq 'X:') 
    {
        osdcloud-StartWinPE -OSDCloud -KeyVault
        $null = Stop-Transcript
        Write-Host "====================" -ForegroundColor Green
        Write-Host "Starting OSDCloud..." -ForegroundColor Green
        Write-Host "====================" -ForegroundColor Green
        Start-OSDCloud -OSVersion 'Windows 10' -OSBuild 21H2 -OSEdition Pro -OSLicense Retail -OSLanguage en-us -SkipAutopilot -SkipODT
        # Reboot is needed
    }
# End WinPE

#----------------------------
# OOBE
if ($env:UserName -eq 'defaultuser0') 
    {
        osdcloud-StartOOBE -KeyVault -Autopilot
        Write-Host "=================================" -ForegroundColor Green
        Write-Host "Starting OSDCloud - OOBE Phase..." -ForegroundColor Green
        Write-Host "=================================" -ForegroundColor Green

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Authenticate to Azure" -ForegroundColor White
        Connect-AzAccount | Out-Null

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Time Zone Configuration" -ForegroundColor White
        osdcloud-SetWindowsDateTime

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Autopilot Registration" -ForegroundColor White
        $TestAutopilotProfile = osdcloud-TestAutopilotProfile
        IF ($TestAutopilotProfile -eq $true) 
            {
                Write-Host "Autopilot profile found!"
                osdcloud-ShowAutopilotProfile
            }
        ELSEIF ($TestAutopilotProfile -eq $false) 
            {
                Write-Host "Autopilot profile was not found.  Need to register!" -ForegroundColor Yellow
                # OSDCloud Tenant
                <#
                $AutopilotParams = @{
                    Online = $true
                    TenantId = '9bb5c0e5-f4bd-4048-b6cd-42db00a0bf3a'
                    AppId = '185ff278-1694-4f92-85c4-446d7c039377'
                    AppSecret = 'O.c8Q~WTmTT2B3aWtTjRolIzpBbNAOHVJ3g.ZdpX'
                    GroupTag = 'Enterprise'
                    Assign = $true
                }
                #>
                # Mike Marable Tenant
                $AutopilotParams = @{
                    Online = $true
                    TenantId = '0d6ed6ff-60a1-4940-8d9b-054be8d92114'
                    AppId = 'b99a064e-7379-46aa-a4f5-a3eda915598e'
                    AppSecret = 'fy-8Q~zoNBE4i9NO_Yub4FdZwyb2lvnLONHiEbLp' # Good until 28-July-2024
                    GroupTag = 'Mike'
                    Assign = $true
                }
                $Command = Get-WindowsAutoPilotInfo @AutopilotParams

                Write-Host -ForegroundColor Cyan 'Registering Device in Autopilot in new PowerShell window '
                $AutopilotProcess = Start-Process PowerShell.exe -ArgumentList "-Command $Command" -PassThru
                Write-Host -ForegroundColor Green "(Process Id $($AutopilotProcess.Id))"
            }
        ELSE 
            {
                Write-Warning 'Unable to determine if device is Autopilot registered'
            }        
        
        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Remove Universal Apps" -ForegroundColor White
        RemoveAppx -Name 'XBox','Skype'

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Install RSAT Components" -ForegroundColor White
        RSAT -Name 'ActiveDirectory','GroupPolicy'

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Update Drivers" -ForegroundColor White
        #Write-Host "Disabled for now to save time running" -ForegroundColor Cyan
        UpdateDrivers

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Update Windows" -ForegroundColor White
         Write-Host "Disabled for now to save time running" -ForegroundColor Cyan
        UpdateWindows

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "MAK Registration" -ForegroundColor White
        # MAK key (Key Vault)
        ##Add-MAK -ProdKey $(Get-AzKeyVaultSecret -VaultName MikeMarable -Name MAKProductKey -AsPlainText)

        Write-Host "=================================" -ForegroundColor Green
        Write-Host "Finished OSDCloud - OOBE Phase" -ForegroundColor Green
        Write-Host "=================================" -ForegroundColor Green
    }
# End OOBE

#----------------------------
# Full OS
# End Full OS


# End of Code
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

