Connect-AzureAD 
$group=Get-AzureADGroup -SearchString 'Update Git' 
$users=Get-AzureADGroupMember -ObjectId $Group.ObjectId -All $true #|where {$_.ObjectType -eq 'User'}
foreach($user in $users){
Remove-AzureADGroupMember -ObjectId $Group.ObjectId -MemberId $user.objectId
} 