New-Item -path "%localappdata%" -Name "Scripts" -ItemType "Directory" -Force
$file = "%localappdata%\Scripts\shot.ps1"
    New-Item -path "%localappdata%\Scripts\" -Name "shot.txt" -ItemType "File" -Force
    $j = '$os=Get-WmiObject win32_operatingsystem'
    $k = '$uptime = ((get-date) - ($os.ConvertToDateTime($os.lastbootuptime))).Days'
    $h = 'if ($uptime -ge  4) {'
    $l = 'Add-Type -AssemblyName PresentationFramework'
    $p = '$msgBoxInput =  [System.Windows.MessageBox]::Show("Czy chcesz Teraz wyłaczyć komputer? Restart komputera jest wymagany minimum raz na tydzień w celu zainstalowania aktualizacji przez organizację","Automatyczny restart","YesNo","Error")'
    $o = 'switch  ($msgBoxInput) {'
    $z = "'No' {"
    $x = '$voice = New-Object –COMObject “SAPI.SPVoice”'
    $f = '$voice.speak(“4 hours remaining until auto restart. `nAfter this time, the computer will turn off without warning!!!”)'
    $d = '$text = "Pozostały 4 godziny do automatycznego restartu. `nPo tym czasie komputer wyłączy się bez ostrzeżenia!!!"'
    $n = '$wshell = New-Object -ComObject Wscript.Shell '
    $a = '$Output = $wshell.Popup("$text",0 ,„Automatyczny Restart”, 0 + 48)'
    $w = 'Start-Sleep -Seconds 14400; Stop-Computer --quiet'
    $r = "}'Yes' {Stop-Computer}}}"
    $b = 'elseif ( $uptime -ge  6){'
    $c = '$voice = New-Object –COMObject “SAPI.SPVoice”'
    $y = '$voice.speak(“2 days remaining until auto restart!!!”)'
    $aa = '$text = "Nastapi automatyczny restart poniewaz komuter nie byl wylaczony od dluzszego czasu `nPozostaly 2 dni do automatycznego restartu."'
    $ab = '$wshell = New-Object -ComObject Wscript.Shell  '
    $ac = '$Output = $wshell.Popup("$text",0 ,„Automatyczny Restart”, 0 + 48) }'
    Add-Content -Path "%localappdata%\Scripts\shot.txt" -Value "$j `r`n$k `r`n$h `r`n$l `r`n$p `r`n$o `r`n$z `r`n$x `r`n$f `r`n$d `r`n$n `r`n$a `r`n$w `r`n$r `r`n$b `r`n$c `r`n$y `r`n$aa `r`n$ab `r`n$ac "
    Move-Item -Path "%localappdata%\Scripts\shot.txt" -Destination "%localappdata%\Scripts\shot.ps1" -Force

$file = '"%localappdata%\Scripts\shot.ps1"'
$A = New-ScheduledTaskAction -Execute "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe" -Argument "-NoProfile -NoLogo -NonInteractive -ExecutionPolicy Bypass -File $file "
$T = New-ScheduledTaskTrigger -Daily -At "10:00"
$P = New-ScheduledTaskPrincipal "NT AUTHORITY\SYSTEM" -RunLevel Highest
$S = New-ScheduledTaskSettingsSet  -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$D = New-ScheduledTask -Action $A -Principal $P -Trigger $T -Settings $S
Register-ScheduledTask Weekly_Shutdown -InputObject $D -Force
