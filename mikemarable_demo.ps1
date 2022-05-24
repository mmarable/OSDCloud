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
#----------------------------



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
Write-Host -ForegroundColor DarkGray "OSDCloud Demo 22.5.23.1"
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
        
        Write-Host "---------------------------------" -ForegroundColor Gray
        Write-Host "Autopilot Registration" -ForegroundColor Gray
        # 1. Autopilot Register (registered application)
        # While that is running?
        Write-Host "---------------------------------" -ForegroundColor Gray
        Write-Host "Tinme Zone Configuration" -ForegroundColor Gray
        # 2. Time Zone setting (steal from David)
        Write-Host "---------------------------------" -ForegroundColor Gray
        Write-Host "Remove Universal Apps" -ForegroundColor Gray
        # 3. Remove Universal Apps
        Write-Host "---------------------------------" -ForegroundColor Gray
        Write-Host "Patching" -ForegroundColor Gray
        # 4. Patching
        Write-Host "---------------------------------" -ForegroundColor Gray
        Write-Host "MAK Registration" -ForegroundColor Gray
        # 5. MAK key (Key Vault)
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

