<#
.SYNOPSIS
I configured the Application event log size to 32,768 KB (32 MB) or greater. This ensures sufficient log storage to prevent data loss and maintain a comprehensive audit trail for security monitoring.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2024-02-16
    Last Modified   : 2024-02-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 2024-02-16
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-AU-000500).ps1 
#>

# Define registry path for Application Event Log Policy
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set the Maximum Log Size (KB) to 32,768
Set-ItemProperty -Path $RegPath -Name "MaxSize" -Value 32768 -Type DWord

# Enable the policy by ensuring the setting is applied via Group Policy
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "MaxSize"