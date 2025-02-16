<#
.SYNOPSIS
I disabled the convenience PIN sign-in by setting the AllowDomainPINLogon registry value to 0. This prevents domain-joined systems from using a PIN instead of traditional authentication, enhancing security by enforcing stronger credential requirements.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2024-02-16
    Last Modified   : 2024-02-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 2024-02-16
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000370).ps1 
#>

# Define registry path
$RegPath = "HKLM:\Software\Policies\Microsoft\Windows\System"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set AllowDomainPINLogon to 0 (Disable convenience PIN sign-in)
Set-ItemProperty -Path $RegPath -Name "AllowDomainPINLogon" -Value 0 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "AllowDomainPINLogon"