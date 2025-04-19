<#
.SYNOPSIS
This PowerShell script configures the "Deny log on through Remote Desktop Services" (SeDenyRemoteInteractiveLogonRight) user right to block RDP access from the Guests group, Local accounts, and highly privileged domain groups (Domain Admins and Enterprise Admins), enhancing protection against unauthorized remote access and credential abuse.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-04-19
    Last Modified   : 2025-04-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-UR-000090

.TESTED ON
    Date(s) Tested  : 2025-04-19
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-UR-000090).ps1 
#>

# Define the user right and the list of SIDs for required groups
$privilege = "SeDenyRemoteInteractiveLogonRight"
$groupSIDs = @(
    "*S-1-5-32-546",  # Guests
    "*S-1-5-113",     # Local account
    "*S-1-5-21domain-519", # Domain Admins (replace with actual domain SID)
    "*S-1-5-21domain-519", # Enterprise Admins (same SID unless separate forest)
)

# IMPORTANT: Replace the above domain-based SIDs with actual values from your environment.
# You can retrieve these with: ([System.Security.Principal.NTAccount]"Domain Admins").Translate([System.Security.Principal.SecurityIdentifier]).Value

# Export current security policy
secedit /export /cfg C:\Windows\Temp\secpol.cfg

# Modify the privilege assignment
$configPath = "C:\Windows\Temp\secpol.cfg"
(Get-Content $configPath) |
    ForEach-Object {
        if ($_ -match "^$privilege") {
            "$privilege = $($groupSIDs -join ',')"
        } else {
            $_
        }
    } | Set-Content $configPath

# Apply updated policy
secedit /configure /db secedit.sdb /cfg $configPath /areas USER_RIGHTS

# Clean up
Remove-Item $configPath -Force

Write-Output "Remediation complete: '$privilege' set to deny RDP access to Guests, Local accounts, Domain Admins, and Enterprise Admins."











