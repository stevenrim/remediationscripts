<#
.SYNOPSIS
This PowerShell script disables Internet Explorer 11 as a standalone browser by setting the Group Policy registry value DisableIE to 1, aligning with Microsoft’s guidance and DISA STIG compliance.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-04-19
    Last Modified   : 2025-04-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000391

.TESTED ON
    Date(s) Tested  : 2025-04-19
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000391).ps1 
#>


# Disables Internet Explorer 11 as a standalone browser via Group Policy setting

$registryPath = 'HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Main'
$valueName = 'DisableIE'
$desiredValue = 1  # "Enabled" policy with "Never" as the option (1 = IE11 is disabled)

# Create registry key if it doesn't exist
If (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the DisableIE policy value
New-ItemProperty -Path $registryPath -Name $valueName -PropertyType DWord -Value $desiredValue -Force | Out-Null

Write-Output "Remediation complete: IE11 has been disabled as a standalone browser."




