Get-LocalGroupMember -Group 'Administrators'
Get-LocalGroupMember -Group 'Administrators' | Where {$_.objectclass -like 'user'} | Remove-LocalGroupMember Administrators