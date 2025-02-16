<#
.SYNOPSIS
I configured Windows to audit failures for User Account Management activities. This ensures failed attempts to manage user accounts are logged for security monitoring.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2024-02-16
    Last Modified   : 2024-02-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000035

.TESTED ON
    Date(s) Tested  : 2024-02-16
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-AU-000035).ps1 
#>

# Ensure Advanced Audit Policy is enabled for User Account Management (Failure)
auditpol /set /subcategory:"User Account Management" /failure:enable

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
auditpol /get /subcategory:"User Account Management"