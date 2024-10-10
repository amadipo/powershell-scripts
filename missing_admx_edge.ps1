# Define the path to the ADMXIngestion folder
$admxIngestionPath = "C:\ProgramData\Microsoft\PolicyManager\ADMXIngestion"

# Get the unique folder name inside ADMXIngestion
$uniqueFolder = Get-ChildItem -Path $admxIngestionPath | Where-Object { $_.PSIsContainer } | Select-Object -First 1

# Define the path to the microsoft_edgev117 folder inside the unique folder
$edgeFolderPath = Join-Path -Path $uniqueFolder.FullName -ChildPath "microsoft_edgev117"
$policyFilePath = Join-Path -Path $edgeFolderPath -ChildPath "Policy\microsoft_edgev117.admx"

# Check if the microsoft_edgev117 folder exists
if (-Not (Test-Path -Path $edgeFolderPath)) {
    # Create the microsoft_edgev117 folder and Policy subfolder
    New-Item -Path $edgeFolderPath -ItemType Directory
    New-Item -Path (Join-Path -Path $edgeFolderPath -ChildPath "Policy") -ItemType Directory

    # Copy the microsoft_edgev117.admx file to the Policy folder
    Copy-Item -Path ".\microsoft_edgev117.admx" -Destination $policyFilePath
}

# Check if the microsoft_edgev117.admx file exists in the Policy folder
if (Test-Path -Path $policyFilePath) {
    # Log success
    New-Item -Path "C:\temp\microsoft_edgev117OK.txt" -ItemType File -Force
} else {
    # Log failure
    New-Item -Path "C:\temp\microsoft_edgev117NOOK.txt" -ItemType File -Force
}
