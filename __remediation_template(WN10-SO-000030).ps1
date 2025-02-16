<#
.SYNOPSIS
I enabled the "Force audit policy subcategory settings to override audit policy category settings" policy by setting the SCENoApplyLegacyAuditPolicy registry value to 1. This ensures that Windows enforces granular audit policies, improving security and compliance.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2024-02-16
    Last Modified   : 2024-02-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000030

.TESTED ON
    Date(s) Tested  : 2024-02-16
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-SO-000030).ps1 
#>

# Define registry path
$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set SCENoApplyLegacyAuditPolicy to 1 (Enable policy override)
Set-ItemProperty -Path $RegPath -Name "SCENoApplyLegacyAuditPolicy" -Value 1 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name "SCENoApplyLegacyAuditPolicy"