//%attributes = {}
  //FTP_DownDirectory

C_TEXT:C284($0;$1;$targetDir)
C_BOOLEAN:C305($success)

$targetDir:=FTP_GetPath ($1)

$success:=FTP_ChangeDirectory (vlFTP_ConectionID;$targetDir)

If ($success)
	FTP_SetCurrentDirPath (vItem;True:C214)
	$0:=FTP_GetCurrentDirPath 
Else 
	$0:=$1
End if 