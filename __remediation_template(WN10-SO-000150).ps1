<#
.SYNOPSIS
This script restricts anonymous access to shared resources by modifying the Group Policy settings via the registry.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-02-22
    Last Modified   : 2025-02-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000150

.TESTED ON
    Date(s) Tested  : 2025-02-22
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-SO-000150).ps1 
#>

# Define the registry path and required values
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$registryName = "RestrictAnonymous"
$expectedValue = 1  # 1 = Restrict anonymous enumeration of shares

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    Write-Host "Registry path not found. Creating path: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Get the current value of the setting
$currentValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName

# Apply the setting if not already set
if ($currentValue -ne $expectedValue) {
    Write-Host "Restricting anonymous enumeration of shares..."
    Set-ItemProperty -Path $registryPath -Name $registryName -Value $expectedValue -Type DWord
    Write-Host "Anonymous enumeration of shares has been restricted successfully."
} else {
    Write-Host "Anonymous enumeration of shares is already restricted."
}

# Verify the change
$updatedValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName
Write-Host "Current policy value: $updatedValue (Expected: $expectedValue)"


