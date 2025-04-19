<#
.SYNOPSIS
This PowerShell script removes any existing portproxy configurations to ensure Windows 10 is not vulnerable to man-in-the-middle attacks via port redirection.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-04-19
    Last Modified   : 2025-04-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000395

.TESTED ON
    Date(s) Tested  : 2025-04-19
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-00-000395).ps1 
#>

# Remove all portproxy IPv4 to IPv4 TCP entries
$portproxyOutput = netsh interface portproxy show all

if ($portproxyOutput -notmatch "There are no ports currently configured") {
    netsh interface portproxy reset
    Write-Output "All portproxy entries have been removed."
} else {
    Write-Output "No portproxy entries found. System is already compliant."
}





