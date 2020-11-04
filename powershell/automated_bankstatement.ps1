the whole step for BS import in our deployment looks like following
$serverId = "%webServiceServer%".Split(".")[0].toUpper()
$path = "\\corp\DFS\Departments\FIS\Insurance\QA\qaenv_" + $serverId + "\BankStatements"
$importPath = "$path\Import"
$archivePath = "$path\Archive"
if(-not $(Test-Path "$($importPath)"))
{
    Write-Host "Creating folder for Bank Statements import "$importPath ", since it doesn't exist"
    New-Item $importPath -type directory
}
if(-not $(Test-Path "$($archivePath)"))
{
    Write-Host "Creating folder for Bank Statements import "$archivePath", since it doesn't exist"
    New-Item $archivePath -type directory
}
if ("%dbType%" -eq "Oracle") {
$scriptContent = @"
update ct_setting set STRING_VALUE='$importPath' where setting_id = 575;
delete from bj_setting where CODE_TABLE_ID = 'BANK_STATEMENTS_IMPORT';
insert into bj_setting (CODE_TABLE_ID, CODE_ID, SERVER_ID, DESCRIPTION, SETTING_VALUE)  values ('BANK_STATEMENTS_IMPORT', 'INPUT', '$serverId', 'BS import on QA servers', '$importPath');
insert into bj_setting (CODE_TABLE_ID, CODE_ID, SERVER_ID, DESCRIPTION, SETTING_VALUE)  values ('BANK_STATEMENTS_IMPORT', 'ARCHIVE', '$serverId', 'BS import on QA servers', '$archivePath');
commit;
"@
.\DB\OracleQuery.ps1 -oracleHost "%dbServer%" `
                     -pdbName "%dbNameFull%" `
                     -query $scriptContent
} else {
$scriptContent = @"
update ct_setting set STRING_VALUE='$importPath' where setting_id = 575;
delete from bj_setting where CODE_TABLE_ID = 'BANK_STATEMENTS_IMPORT';
insert into bj_setting (CODE_TABLE_ID, CODE_ID, SERVER_ID, DESCRIPTION, SETTING_VALUE)  values ('BANK_STATEMENTS_IMPORT', 'INPUT', '$serverId', 'BS import on QA servers', '$importPath');
insert into bj_setting (CODE_TABLE_ID, CODE_ID, SERVER_ID, DESCRIPTION, SETTING_VALUE)  values ('BANK_STATEMENTS_IMPORT', 'ARCHIVE', '$serverId', 'BS import on QA servers', '$archivePath');
GO
"@
.\DB\MSSQLQuery.ps1 -mssqlHost "%dbServer%" `
                    -dbName "%dbName%" `
                    -query $scriptContent
}