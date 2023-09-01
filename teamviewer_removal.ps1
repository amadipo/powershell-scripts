$AllApps    = Get-ItemProperty "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

        # Find the one named TeamViewer.
        $TeamViewer = $AllApps | Where-Object {$_.DisplayName -Like "TeamViewer*"}

        # When you install an app, the uninstall information is saved in the registry.
        # TeamViewer's is just an .exe, so run it, with a hidden window, and the /S (silent) switch.
        Start-Process -FilePath ($TeamViewer.UninstallString) -ArgumentList "/S" -WindowStyle Hidden