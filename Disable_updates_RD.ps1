# Set-RegistryKey.ps1
$logFile = "C:\Packages\Logging\remote_desktop_Set-RegistryKey.log"
$registryPath = "HKLM:\Software\Microsoft\MSRDC\Policies"
$Name = "AutomaticUpdates"
$value = 0

# Start transcript
Start-Transcript -Path $logFile -Append

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Write-Output $logMessage
}

# Create log file directory if it doesn't exist
if (-not (Test-Path "C:\temp")) {
    New-Item -Path "C:\temp" -ItemType Directory -Force
}

Log-Message "Starting script execution."

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    Log-Message "Registry path $registryPath does not exist. Creating it."
    New-Item -Path $registryPath -Force
} else {
    Log-Message "Registry path $registryPath already exists."
}

# Set the registry key value
try {
    Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type DWord
    Log-Message "Successfully set $Name to $value at $registryPath."
} catch {
    Log-Message "Failed to set $Name to $value at $registryPath. Error: $_"
}

Log-Message "Script execution completed."

# Stop transcript
Stop-Transcript
