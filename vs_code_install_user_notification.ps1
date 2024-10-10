Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Drawing

# Check for running code.exe processes
$processes = Get-Process -Name "code" -ErrorAction SilentlyContinue
$vsCodeProcesses = Get-Process | Where-Object { $_.MainWindowTitle -like "*Visual Studio Code*" }

if ($processes -or $vsCodeProcesses) {
    # Create the popup window
    $window = New-Object System.Windows.Window
    $window.Title = "Visual Studio Code Update"
    $window.SizeToContent = "WidthAndHeight"
    $window.WindowStartupLocation = "CenterScreen"
    $window.Topmost = $true
    $window.ResizeMode = "NoResize"
    $window.WindowStyle = "None"

    # Create the message text
    $message = New-Object System.Windows.Controls.TextBlock
    $message.Text = "Hi Kulakeep user!`nVisual Studio Code will be updated to the newer version soon. Please save your work and press OK to proceed.`nIf no action will be done, update will be forced in 5 minutes."
    $message.Margin = "10"
    $message.TextWrapping = "Wrap"

    # Create the OK button
    $okButton = New-Object System.Windows.Controls.Button
    $okButton.Content = "OK"
    $okButton.Margin = "10"
    $okButton.Add_Click({
        $window.DialogResult = $true
        $window.Close()
    })

    # Create the timer button
    $timerButton = New-Object System.Windows.Controls.Button
    $timerButton.Content = "OK (Auto in 5 min)"
    $timerButton.Margin = "10"
    $timerButton.Add_Click({
        $window.DialogResult = $true
        $window.Close()
    })

    # Create a timer to auto-click the timer button after 5 minutes
    $timer = New-Object System.Windows.Threading.DispatcherTimer
    $timer.Interval = [TimeSpan]::FromMinutes(5)
    $timer.Add_Tick({
        $timerButton.RaiseEvent([System.Windows.RoutedEventArgs]::new([System.Windows.Controls.Primitives.ButtonBase]::ClickEvent))
        $timer.Stop()
    })
    $timer.Start()

    # Load the logo image
    $logoPath = ".\logo.png"
    $logo = New-Object System.Windows.Controls.Image
    $bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
    $bitmap.BeginInit()
    $bitmap.UriSource = [Uri]::new((Resolve-Path $logoPath).Path)
    $bitmap.EndInit()
    $logo.Source = $bitmap
    $logo.Height = 100
    $logo.Margin = "10"

    # Create a stack panel to hold the logo, message, and buttons
    $stackPanel = New-Object System.Windows.Controls.StackPanel
    $stackPanel.Children.Add($logo)
    $stackPanel.Children.Add($message)
    $stackPanel.Children.Add($okButton)
    $stackPanel.Children.Add($timerButton)

    # Set the content of the window to the stack panel
    $window.Content = $stackPanel

    # Show the window
    $window.ShowDialog() | Out-Null

    # Check the result of the dialog
    if ($window.DialogResult -eq $true) {
        # Terminate VS Code processes
        if ($processes) {
            $processes | ForEach-Object { $_.Kill() }
            Write-Output "VS Code processes terminated."
        }
        if ($vsCodeProcesses) {
            $vsCodeProcesses | ForEach-Object { $_.Kill() }
            Write-Output "Visual Studio Code processes terminated."
        }

        # Execute the installation of Visual Studio Code
        $installerPath = ".\VSCodeSetup-x64-1.94.1.exe"
        $installerArgs = "/VERYSILENT /NORESTART /MERGETASKS=!runcode"
        Start-Process -FilePath $installerPath -ArgumentList $installerArgs -Wait
        Write-Output "VS Code installation started."
    }
} else {
    # No VS Code processes found, proceed with the installation
    Write-Output "No VS Code processes found. Proceeding with installation."

    # Execute the installation of Visual Studio Code
    $installerPath = ".\VSCodeSetup-x64-1.94.1.exe"
    $installerArgs = "/VERYSILENT /NORESTART /MERGETASKS=!runcode"
    Start-Process -FilePath $installerPath -ArgumentList $installerArgs -Wait
    Write-Output "VS Code installation started."
}
