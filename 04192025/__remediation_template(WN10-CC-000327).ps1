<#
.SYNOPSIS
This PowerShell script enables PowerShell Transcription logging by setting the EnableTranscripting registry key to 1 and defines a secure output directory for transcript files, ensuring audit trails are captured per DISA STIG guidance.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-04-19
    Last Modified   : 2025-04-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000327

.TESTED ON
    Date(s) Tested  : 2025-04-19
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000327).ps1 
#>

# Enables PowerShell Transcription to log command/script execution and sets a secure output directory

$registryPath = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'
$transcriptionEnabledValueName = 'EnableTranscripting'
$outputDirectoryValueName = 'OutputDirectory'
$secureLogPath = 'C:\Transcripts'  # Change this path to a central or secured location if needed

# Create registry key if it doesn't exist
If (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Enable transcription
New-ItemProperty -Path $registryPath -Name $transcriptionEnabledValueName -PropertyType DWord -Value 1 -Force | Out-Null

# Set secure output directory
New-ItemProperty -Path $registryPath -Name $outputDirectoryValueName -PropertyType String -Value





