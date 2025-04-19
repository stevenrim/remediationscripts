<#
.SYNOPSIS
This PowerShell script ensures that only the built-in Administrators group has the "Force shutdown from a remote system" (SeRemoteShutdownPrivilege) user right, mitigating the risk of remote denial-of-service attacks.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-04-19
    Last Modified   : 2025-04-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-UR-000100

.TESTED ON
    Date(s) Tested  : 2025-04-19
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-UR-000100).ps1 
#>

# Define the user right and the SID for the Administrators group
$privilege = "SeRemoteShutdownPrivilege"
$adminSID = "*S-1-5-32-544"  # Built-in Administrators group

# Export the current security policy
secedit /export /cfg C:\Windows\Temp\secpol.cfg

# Update the privilege assignment
$configPath = "C:\Windows\Temp\secpol.cfg"
(Get-Content $configPath) |
    ForEach-Object {
        if ($_ -match "^$privilege") {
            "$privilege = $adminSID"
        } else {
            $_
        }
    } | Set-Content $configPath

# Apply the updated policy
secedit /configure /db secedit.sdb /cfg $configPath /areas USER_RIGHTS

# Clean up temp file
Remove-Item $configPath -Force

Write-Output "Remediation complete: '$privilege' is now restricted to the Administrators group only."









