Import-Csv -Path "C:\temp\vscode.csv"| ForEach-Object {

$ObjectId = (Get-AzureADUser -ObjectId $_.Userprincipalname).ObjectId

If ($ObjectId) {

Add-AzureADGroupMember -ObjectId 34af50d0-3466-4c36-97c4-5a0c4386fcb7 -RefObjectId $($ObjectId) -ErrorAction SilentlyContinue

}

}
