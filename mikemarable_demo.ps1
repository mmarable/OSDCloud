# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# File:    mikemarable_demo.ps1
# Version: 22.5.23.1
# Date:    23-May-2022
# Author:  Mike Marable
#
# 

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
        #Invoke-Command {slmgr.vbs /ipk 12345-12345-12345-12345-12345}

        Start-Process -FilePath C:\Windows\System32\wscript.exe -ArgumentList 'slmgr.vbs /ipk 12345-12345-12345-12345-12345' | Out-Null
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

# Other?
# =============================================================================

#----------------------------
# Initialize
Write-Host -ForegroundColor DarkGray "OSDCloud Demo 22.5.24.6"
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
        Write-Host "=================================" -ForegroundColor Green
        Write-Host "Starting OSDCloud - OOBE Phase..." -ForegroundColor Green
        Write-Host "=================================" -ForegroundColor Green

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Tinme Zone Configuration" -ForegroundColor White
        #osdcloud-StartOOBE -DateTime
        osdcloud-SetWindowsDateTime

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Autopilot Registration" -ForegroundColor White
        # 1. Autopilot Register (registered application)
        # Check to see if there is already a profile assigned
        # If not, use the Registered Application to register
        $TestAutopilotProfile = osdcloud-TestAutopilotProfile
        IF ($TestAutopilotProfile -eq $true) 
            {
                Write-Host "Autopilot profile found!"
                osdcloud-ShowAutopilotProfile
            }
        ELSEIF ($TestAutopilotProfile -eq $false) 
            {
                Write-Host "Autopilot profile was not found.  Need to register!" -ForegroundColor Yellow
                #$AutopilotRegisterCommand = 'Get-WindowsAutopilotInfo -Online -GroupTag Enterprise -Assign'
                #$AutopilotRegisterProcess = osdcloud-AutopilotRegisterCommand -Command $AutopilotRegisterCommand;Start-Sleep -Seconds 30
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
        UpdateDrivers

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "Update Windows" -ForegroundColor White
        # Temp disable to save time with testing
        Write-Host "Disabled for now to save time running" -ForegroundColor Cyan
        ##UpdateWindows

        Write-Host "---------------------------------" -ForegroundColor White
        Write-Host "MAK Registration" -ForegroundColor White
        # 5. MAK key (Key Vault)
        Add-MAK

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

