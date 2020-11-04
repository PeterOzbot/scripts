function global:GET-CLIENT {

PARAM([STRING]$type="sql",[STRING]$version="rc", [STRING]$copy="doNotCopy")

Write-Output ("Type: " + $type)
Write-Output ("Version: " + $version)
Write-Output ("Will copy new version: " + $copy)

# build paths
$to = "C:\Clients\"
$from = "\\corp\dfs\Departments\FIS\Insurance\AdInsure.Clients\"

$name = "Basic"
$runFolder = ""
if($type.ToLower() -eq "sql"){
    $name = $name+"-"
}
else{
    $name = $name+"-Oracle-"
}

$name = $name+$version.ToLower()
$zipName = $name + ".zip"

# if we copy new version
if($copy -ne "doNotCopy") {

	# deleting old files
	$delete = ($to + $name)
	if(test-path $delete){
		Write-Output ("Brisem: " + $delete)
		remove-item $delete -Recurse
	}
	$zipDelete = ($to + $zipName)
	if(test-path $zipDelete){
		Write-Output ("Brisem: " + $zipDelete)
		remove-item $zipDelete
	}

	# copying new files
	$from = $from + $zipName;
	Write-Output ("Kopiram iz: " + $from)
	Copy-Item $from $to
	
	# extracting zip
	Microsoft.PowerShell.Archive\Expand-Archive  "$to$zipName" -DestinationPath "$to$name"
}

# run
$runPath = $to + $name + $runFolder+"\Adacta.IIS.Client.exe"
Write-Output ("Zaganjam: " + $runPath)
Invoke-Item $runPath

}