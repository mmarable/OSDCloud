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
    Run the script as either a demo with comments or production without pauses
    Possible values are: Demo | Prod    
.NOTES

.EXAMPLE

#>

Param(
    [parameter(mandatory=$false)] 
    [ValidateSet("Demo","Prod")] 
    [String] $RunType = "Demo"

    )


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
# Key Vault
#   We can use this to secure the MAK key
# Cloud Scripts (this script)
# OOBE
#   Autopilot Register (registered application)
#   Time Zone setting (steal from David)
#   Patching
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
if ($env:SystemDrive -eq 'X:') {
    osdcloud-StartWinPE -OSDCloud -KeyVault
    #Write-Host -ForegroundColor Cyan "To start a new PowerShell session, type 'start powershell' and press enter"
    #Write-Host -ForegroundColor Cyan "Start-OSDCloud or Start-OSDCloudGUI can be run in the new PowerShell session"
    $null = Stop-Transcript
    #Start-OSDCloud -OSVersion 'Windows 10' -OSBuild 21H2 -OSEdition Enterprise -OSLicense Volume -SkipAutopilot -SkipODT -Restart
    Start-OSDCloud -OSVersion 'Windows 10' -OSBuild 21H2 -OSEdition Pro -OSLicense Retail -OSLanguage en-us -SkipAutopilot -SkipODT
}
# End WinPE

#----------------------------
# OOBE
# End OOBE

#----------------------------
# Full OS
# End Full OS


# End of Code
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

