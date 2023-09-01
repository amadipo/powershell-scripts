Connect-AzureAD
Get-AzureADGroup -Filter "DisplayName eq 'Update citrix'"

#get device ID (windows) to csv
Get-AzureADDevice -All 0 -Top 1000 -Filter "startswith(DeviceOSType,'Windows')" | select  DisplayName, ObjectID| Export-Csv -path "C:\temp\test.csv"

Get-AzureADGroup -Filter "DisplayName eq 'Update Pulse Secure'"
Get-AzureADGroupMember -ObjectId 0ddaa18c-bf65-4af4-9f8c-411ab6ad1d32
#add objects to group based on csv objectID column
Import-Csv C:\temp\citrix.csv | ForEach-Object {
          Add-AzureADGroupMember -ObjectId "b169a92e-4b47-4be8-b3dd-043f041c514a" -RefObjectId $_.ObjectID
    }
#liczenie obiektow w grupie
(Get-AzureADGroupMember -ObjectId "b169a92e-4b47-4be8-b3dd-043f041c514a" -all 1).count

#remove objects to group based on csv objectID column
Import-Csv C:\temp\chrome.csv | ForEach-Object {
          remove-AzureADGroupMember -ObjectId "14547284-f639-4e70-aaf6-86fa83d5e196" -MemberId $_.ObjectID
    }
#liczenie obiektow w grupie
(Get-AzureADGroupMember -ObjectId "b169a92e-4b47-4be8-b3dd-043f041c514a" -all 1).count
#exchange online
Connect-ExchangeOnline
Get-Mailbox -Identity “vacation_cal@airiverspzoo.onmicrosoft.com” | Format-List
Set-CalendarProcessing -Identity vacation_uop@fremint.com  -AllowConflicts $True
Import-Module ExchangeOnlineManagement; Get-Module ExchangeOnlineManagement
Update-Module -Name ExchangeOnlineManagement
