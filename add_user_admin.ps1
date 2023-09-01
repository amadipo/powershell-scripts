$UserName = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
Net localgroup administrators "$UserName" /add