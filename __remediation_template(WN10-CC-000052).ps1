<#
.SYNOPSIS
I configured the ECC Curve Order policy by setting the EccCurves registry value to NistP384 and NistP256 in the correct order. This ensures that Windows uses strong elliptic curve cryptography (ECC) settings for SSL/TLS, enhancing security.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-02-16
    Last Modified   : 2025-02-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 2025-02-16
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000052).ps1 
#>

# Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set EccCurves to NistP384 and NistP256 in the correct order
$EccCurves = "NistP384", "NistP256"
Set-ItemProperty -Path $RegPath -Name "EccCurves" -Value $EccCurves -Type MultiString

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "EccCurves"
