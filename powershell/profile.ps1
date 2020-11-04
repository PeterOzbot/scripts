# directory where my scripts are stored

$psdir="D:\Zapiski\powershell\autoload"  

# load all 'autoload' scripts

Get-ChildItem "${psdir}\*.ps1" | %{.$_} 

# set location

# Set-Location D:\

Write-Host "Custom PowerShell Environment Loaded" 
Write-Host "Zivjo Peter!"
