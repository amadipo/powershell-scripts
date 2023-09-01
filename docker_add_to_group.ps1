$member = $(Get-WMIObject -class Win32_ComputerSystem | select username).username 
add-LocalGroupMember -Group "docker-users" -Member $member