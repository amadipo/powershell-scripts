$UserName = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
remove-LocalGroupMember -Group "administrators" -Member $UserName


