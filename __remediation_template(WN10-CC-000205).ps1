<#
.SYNOPSIS
I configured the "Allow Telemetry" policy to "Enabled" with a value of 0 (Security). This setting ensures the lowest possible data collection, restricting telemetry to essential security updates while enhancing privacy and preventing unnecessary data transmission.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-02-16
    Last Modified   : 2025-02-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 2025-02-16
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000205).ps1 
#>

# Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set AllowTelemetry to 0 (Security) to restrict diagnostic data collection
Set-ItemProperty -Path $RegPath -Name "AllowTelemetry" -Value 0 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "AllowTelemetry"
