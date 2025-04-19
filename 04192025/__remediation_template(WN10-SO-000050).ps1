<#
.SYNOPSIS
This PowerShell script ensures that the system allows automatic computer account password changes by setting the DisablePasswordChange registry value to 0.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-04-19
    Last Modified   : 2025-04-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000050

.TESTED ON
    Date(s) Tested  : 2025-04-19
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-SO-000050).ps1 
#>

# Ensures computer account password changes are enabled
$registryPath = 'HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters'
$valueName = 'DisablePasswordChange'
$desiredValue = 0

# Create the registry key if it doesn't exist
If (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value to 0
New-ItemProperty -Path $registryPath -Name $valueName -PropertyType DWord -Value $desiredValue -Force | Out-Null

Write-Output "Remediation complete: '$valueName' set to $desiredValue in $registryPath"




