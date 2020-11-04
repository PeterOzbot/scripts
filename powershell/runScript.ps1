Import-Module SqlPs -DisableNameChecking

function global:RUN-SCRIPT {
PARAM([STRING]$serverInstance="localhost",[STRING]$database="AdInsure_Clean_Unicode", [STRING]$path="C:\_GIT\Database\sql\")

	Write-Output ("Server Instance: " + $serverInstance)
	Write-Output ("Database: " + $database)
	Write-Output ("Path: " + $path)

	# first get core script
	$corePath = $path + "Core\"
	Write-Output ("Running core scripts:" + $corePath)
	$coreScriptFolders = Get-ChildItem $corePath

	Foreach ($scriptFolder in $coreScriptFolders)
	{
		$scriptFolderPath = $corePath + $scriptFolder
		$coreScripts = Get-ChildItem $scriptFolderPath
		
		Foreach ($script in $coreScripts)
		{
			$scriptPath = $corePath + $scriptFolder + "\" + $script
			Write-Output ("Running:" + $scriptPath)
			Invoke-Sqlcmd -InputFile $scriptPath -ServerInstance $serverInstance -Database $database -OutputSqlErrors $true -Verbose -QueryTimeout 30
		}
	}
	
	# now implementation
	$implementationPath = $path + "Implementation.Basic\"
	Write-Output ("Running implementation scripts: " + $implementationPath)
	$implementationScriptFolders = Get-ChildItem $implementationPath

	Foreach ($scriptFolder in $implementationScriptFolders)
	{
		$scriptFolderPath = $implementationPath + $scriptFolder
		$implementationScripts = Get-ChildItem $scriptFolderPath
		
		Foreach ($script in $implementationScripts)
		{
			$scriptPath = $implementationPath + $scriptFolder + "\" + $script
			Write-Output ("Running:" + $scriptPath)
			Invoke-Sqlcmd -InputFile $scriptPath -ServerInstance $serverInstance -Database $database -OutputSqlErrors $true -Verbose -QueryTimeout 30
		}
	}
}

