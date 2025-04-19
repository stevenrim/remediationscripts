<#
.SYNOPSIS
This script enables auditing of File Share failures using Advanced Audit Policy Configuration.

.NOTES
    Author          : Steven Rim
    LinkedIn        : linkedin.com/in/stevenrim/
    GitHub          : github.com/stevenrim
    Date Created    : 2025-02-22
    Last Modified   : 2025-02-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000081

.TESTED ON
    Date(s) Tested  : 2025-02-22
    Tested By       : Steven Rim
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.5486

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-AU-000081).ps1 
#>

# Define the audit policy category and subcategory
$auditCategory = "Object Access"
$auditSubcategory = "File Share"

# Check current audit settings
$currentAuditSetting = auditpol /get /subcategory:"$auditSubcategory" | Select-String "Failure"

# If auditing is not enabled, configure it
if ($currentAuditSetting -notmatch "Failure") {
    Write-Host "Enabling auditing for File Share failures..."
    auditpol /set /subcategory:"$auditSubcategory" /failure:enable
    Write-Host "File Share failure auditing has been enabled."
} else {
    Write-Host "File Share failure auditing is already enabled."
}

# Verify the change
$updatedAuditSetting = auditpol /get /subcategory:"$auditSubcategory"
Write-Host "Current Audit Policy for ${auditSubcategory}:`n$updatedAuditSetting"


