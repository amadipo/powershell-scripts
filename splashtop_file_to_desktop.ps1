#download splashtop DS STREAM custom client to user's desktop
$url = "https://cloudbuild.splashtop.eu/247A32856400B3A10356C0A0AE1A7A26/4XSL5H33XYRXEU/d3437b6771ab8ae6cf10e18f05d71ae6/3.5.8.0/SplashtopSOS_Win_v3.5.8.0_4XSL5H33XYRXEU.exe"
$desktop = [Environment]::GetFolderPath("Desktop")
$dest = "$desktop\IT remote help.exe"


 If (Test-Path -Path $dest) {
Break
 }
Else {
Invoke-WebRequest -Uri $url -OutFile $dest
}
