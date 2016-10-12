# Allow ANY script to be executed. Very unsafe, must use only on development machines!
Set-ExecutionPolicy Unrestricted -Force

# I'm picky and want to remove all winrt apps after install. We can always install it back when needed.
# Source: http://www.technorms.com/16961/powershell-remove-metro-apps-windows-8
Get-AppxPackage -AllUsers | Remove-AppxPackage
Get-AppxProvisionedPackage -online | Remove-AppxProvisionedPackage -online

# Folder options
# Don't hide file extensions
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty $key HideFileExt 0 # 0 - not hide

# Restart Explorer
Stop-Process -processname Explorer

