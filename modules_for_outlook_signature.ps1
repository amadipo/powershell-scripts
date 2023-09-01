# Install NuGet Package Provider
Install-PackageProvider -Name MSGraph -MinimumVersion 2.8.5.201 -Scope AllUsers -Force
# Install AzureAD module to retrieve the user information
Install-Module -Name AzureAD -Scope AllUsers -Force