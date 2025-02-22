<#
.SYNOPSIS
This script configures the system to enforce a 15-minute inactivity timeout before locking the screen.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2024-02-22
    Last Modified   : 2024-02-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000070

.TESTED ON
    Date(s) Tested  : 2024-02-22
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-SO-000070).ps1 
#>

# Define the registry path and required values
$registryPath = "HKCU:\Control Panel\Desktop"
$screenSaverActive = "ScreenSaverActive"
$screenSaveTimeOut = "ScreenSaveTimeOut"
$screenSaverSecure = "ScreenSaverIsSecure"
$expectedTimeout = 900  # 15 minutes (900 seconds)

# Ensure the screen saver is active
Set-ItemProperty -Path $registryPath -Name $screenSaverActive -Value "1"

# Set the screen saver timeout to 15 minutes
Set-ItemProperty -Path $registryPath -Name $screenSaveTimeOut -Value "$expectedTimeout"

# Ensure the system locks when the screen saver activates
Set-ItemProperty -Path $registryPath -Name $screenSaverSecure -Value "1"

Write-Host "Screen saver timeout and lock settings have been configured successfully."

# Verify the changes
$timeoutSet = Get-ItemProperty -Path $registryPath -Name $screenSaveTimeOut
Write-Host "Current Timeout: $($timeoutSet.ScreenSaveTimeOut) seconds (Expected: 900 seconds)"
