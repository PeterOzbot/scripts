function global:RUN-CLIENT {

# get current path
$currentPath = (Get-Item -Path ".\").FullName

# get root directory
$currentRootPath =  Split-Path -Path $currentPath -Parent

# run
$runPath = $currentRootPath + "\Implementations\Basic\Applications\AdInsure.Basic.ClientApp\bin\Debug\Adacta.IIS.Client.exe"
Write-Output ("Zaganjam: " + $runPath)
Invoke-Item $runPath

}

