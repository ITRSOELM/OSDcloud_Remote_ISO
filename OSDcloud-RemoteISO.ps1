

# Check if the NuGet provider is already installed
if (Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue) {
    Write-Host "NuGet provider is already installed."
} else {
    # Install the NuGet provider
    Write-Host "Installing NuGet provider"
    Install-PackageProvider -Name NuGet -Force
}

# Check if the PSGallery repository is already trusted
if (Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue) {
    # Check if the PSGallery repository is already trusted
    if ((Get-PSRepository -Name PSGallery).Trusted) {
        Write-Host "PSGallery repository is already trusted."
    } else {
        # Trust the PSGallery repository
        Write-Host "Set Repository trust for PSGallery"
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    }
} else {
    # Register the PSGallery repository
    Register-PSRepository -Name PSGallery -SourceLocation "https://www.powershellgallery.com/api/v2/" -InstallationPolicy Trusted
}

Write-Host "Set ExecutionPolicy to Bypass for Process"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process


# Check if the OSD module is already installed
if (Get-Module -Name OSD -ListAvailable) {
    Write-Host "OSD module is already installed."
} else {
    # Install the OSD module
    Write-host "Installing OSD module"
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


$disks = Get-Disk | Where-Object BusType -eq USB
foreach ($disk in $disks) {
    if (($disk.Size / 1GB) -gt 7 -and ($disk.Size / 1GB) -lt 200) {
        Write-Output "USB drive found"
    }
    else {
        Write-Output "No suitable USB drive found."
        Exit
    }
}

Write-host "Creating OSDCloud USB with ISO from URL"
New-OSDCloudUSB -fromIsoUrl https://cmsaas.itrelation.dk/OSDCloud_Noprompt.iso