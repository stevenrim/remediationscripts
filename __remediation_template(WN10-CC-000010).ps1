<#
.SYNOPSIS
This script disables lock screen slide shows by modifying the Group Policy settings via the registry.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2024-02-22
    Last Modified   : 2024-02-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 2024-02-22
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000010).ps1 
#>

# Define the registry path and required values
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$registryName = "NoLockScreenSlideshow"
$expectedValue = 1  # 1 = Disabled, 0 = Enabled

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    Write-Host "Registry path not found. Creating path: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Get the current value of the setting
$currentValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName

# Apply the setting if not already set
if ($currentValue -ne $expectedValue) {
    Write-Host "Disabling slide shows on the lock screen..."
    Set-ItemProperty -Path $registryPath -Name $registryName -Value $expectedValue -Type DWord
    Write-Host "Lock screen slide shows have been disabled successfully."
} else {
    Write-Host "Lock screen slide shows are already disabled."
}

# Verify the change
$updatedValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName
Write-Host "Current policy value: $updatedValue (Expected: $expectedValue)"


