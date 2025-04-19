<#
.SYNOPSIS
I enabled PowerShell Script Block Logging by setting the EnableScriptBlockLogging registry value to 1. This ensures that all PowerShell script blocks are logged, improving audit capabilities and security monitoring.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-02-16
    Last Modified   : 2025-02-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000326

.TESTED ON
    Date(s) Tested  : 2025-02-16
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000326).ps1 
#>

# Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Enable PowerShell Script Block Logging
Set-ItemProperty -Path $RegPath -Name "EnableScriptBlockLogging" -Value 1 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "EnableScriptBlockLogging"
