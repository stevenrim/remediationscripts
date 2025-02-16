<#
.SYNOPSIS
I configured BitLocker policies to require additional authentication at startup. This ensures that a TPM PIN or TPM key and PIN is required, enhancing security by preventing unauthorized access to encrypted drives. The settings were applied via the registry to enforce compliance.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2024-02-16
    Last Modified   : 2024-02-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10–00–000031

.TESTED ON
    Date(s) Tested  : 2024-02-16
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10–00–000031).ps1 
#>

# Define registry path for BitLocker policies
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set UseAdvancedStartup to 1 (Enable advanced startup options for BitLocker)
Set-ItemProperty -Path $RegPath -Name "UseAdvancedStartup" -Value 1 -Type DWord

# Set UseTPMPIN to 1 (Require startup PIN with TPM)
Set-ItemProperty -Path $RegPath -Name "UseTPMPIN" -Value 1 -Type DWord

# Set UseTPMKeyPIN to 1 (Require startup key and PIN with TPM)
Set-ItemProperty -Path $RegPath -Name "UseTPMKeyPIN" -Value 1 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name UseAdvancedStartup, UseTPMPIN, UseTPMKeyPIN