<#
.SYNOPSIS
I configured the "Prevent enabling lock screen camera" policy to Enabled by setting the NoLockScreenCamera registry value to 1. This ensures that the lock screen camera feature is disabled, enhancing security and preventing unauthorized access.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2024-02-16
    Last Modified   : 2024-02-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 2024-02-16
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000005).ps1 
#>

# Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Check if the device has a camera
$CameraExists = Get-PnpDevice -Class Camera -ErrorAction SilentlyContinue

if ($CameraExists) {
    # Ensure the registry path exists
    If (!(Test-Path $RegPath)) {
        New-Item -Path $RegPath -Force
    }

    # Set the NoLockScreenCamera value to 1 (Disable lock screen camera)
    Set-ItemProperty -Path $RegPath -Name "NoLockScreenCamera" -Value 1 -Type DWord

    # Force Group Policy update to apply changes
    gpupdate /force

    # Verify the configuration
    Get-ItemProperty -Path $RegPath -Name "NoLockScreenCamera"
} else {
    Write-Output "No camera detected. This setting is Not Applicable (NA)."
}