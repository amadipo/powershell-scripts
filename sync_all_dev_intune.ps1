#Install-Module -Name Microsoft.Graph.Intune
#Import-Module -Name Microsoft.Graph.Intune

Connect-MSGraph -AdminConsent

$Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem, 'Windows')"
$Devices.count

Foreach ($Device in $Devices)
{
 
Invoke-IntuneManagedDeviceSyncDevice -managedDeviceId $Device.managedDeviceId
Write-Host "Sending Sync request to Device with DeviceID $($Device.managedDeviceId)" -ForegroundColor Yellow
 
}