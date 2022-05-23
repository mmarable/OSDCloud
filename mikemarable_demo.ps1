Write-Host "This is a test" -ForegroundColor Green
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

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# File:    mikemarable_demo.ps1
# Version: 
# Date:    
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



# End of Functions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Start of Code


# End of Code
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

