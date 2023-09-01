#download splashtop custom client to user's desktop
$url = ""
$desktop = [Environment]::GetFolderPath("Desktop")
$dest = "$desktop\IT remote help.exe"


 If (Test-Path -Path $dest) {
Break
 }
Else {
Invoke-WebRequest -Uri $url -OutFile $dest
}
