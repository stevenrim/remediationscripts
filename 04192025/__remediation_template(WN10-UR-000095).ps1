<#
.SYNOPSIS
This PowerShell script removes all user or group assignments from the "Enable computer and user accounts to be trusted for delegation" (SeEnableDelegationPrivilege) user right, as required for DISA STIG compliance.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-04-19
    Last Modified   : 2025-04-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-UR-000095

.TESTED ON
    Date(s) Tested  : 2025-04-19
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-UR-000095).ps1 
#>

# Define the user right
$privilege = "SeEnableDelegationPrivilege"

# Export the current security policy
secedit /export /cfg C:\Windows\Temp\secpol.cfg

# Remove all assignments to the privilege
$configPath = "C:\Windows\Temp\secpol.cfg"
(Get-Content $configPath) |
    ForEach-Object {
        if ($_ -match "^$privilege") {
            "$privilege ="
        } else {
            $_
        }
    } | Set-Content $configPath

# Apply the updated policy
secedit /configure /db secedit.sdb /cfg $configPath /areas USER_RIGHTS

# Clean up temp file
Remove-Item $configPath -Force

Write-Output "Remediation complete: '$privilege' is now defined with no entries."










