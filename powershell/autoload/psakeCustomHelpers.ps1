function global:psake {

PARAM([STRING]$version="rc", [STRING]$buildFolderName="build")

# build path
$path = "C:\_SVN\" + $version + "\" + $buildFolderName
Write-Output ("Path: " + $path)

# go to path
Set-Location $path

# execute startup
Invoke-Expression "./start"
}

function global:psake-build {

PARAM([STRING]$version="rc", [STRING]$buildFolderName="build")

# build path
$path = "C:\_SVN\" + $version + "\" + $buildFolderName
Write-Output ("Path: " + $path)

# go to path
Set-Location $path

# execute startup
Invoke-Expression "./start"

# execute clean and build
Invoke-Expression "invoke-psake clean; invoke-psake build;"

}