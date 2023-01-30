

# Check if the NuGet provider is already installed
if (Get-PackageProvider -Name NuGet -ListAvailable) {
    Write-Host "NuGet provider is already installed."
} else {
    # Install the NuGet provider
    Install-PackageProvider -Name NuGet -Force
}

# Check if the PSGallery repository is already trusted
if (Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue) {
    # Check if the PSGallery repository is already trusted
    if ((Get-PSRepository -Name PSGallery).Trusted) {
        Write-Host "PSGallery repository is already trusted."
    } else {
        # Trust the PSGallery repository
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    }
} else {
    # Register the PSGallery repository
    Register-PSRepository -Name PSGallery -SourceLocation "https://www.powershellgallery.com/api/v2/" -InstallationPolicy Trusted
}

# Check if the OSD module is already installed
if (Get-Module -Name OSD -ListAvailable) {
    Write-Host "OSD module is already installed."
} else {
    # Install the OSD module
    Install-Module -Name OSD -Force
}

# Import the OSD module
Import-Module -Name OSD

# Verify that the module was imported successfully
if (Get-Module -Name OSD -ListAvailable) {
    Write-Host "OSD module imported successfully."
} else {
    Write-Host "Failed to import OSD module."
}

