# Connect to AzureAD
Connect-AzureAD

# Get CSV content
$CSVrecords = Import-Csv C:\Temp\jobtitle.csv 

# Create arrays for skipped and failed users
$SkippedUsers = @()
$FailedUsers = @()

# Loop trough CSV records
foreach ($CSVrecord in $CSVrecords) {
    $upn = $CSVrecord.user
    $user = Get-AzureADUser -Filter "userPrincipalName eq '$upn'"  
    if ($user) {
        try{
        $user | Set-AzureADUser -jobtitle $CSVrecord.jobtitle
        } catch {
        $FailedUsers += $upn
        Write-Warning "$upn user found, but FAILED to update."
        }
    }
    else {
        Write-Warning "$upn not found, skipped"
        $SkippedUsers += $upn
    }
}

# Array skipped users
# $SkippedUsers

# Array failed users
# $FailedUsers