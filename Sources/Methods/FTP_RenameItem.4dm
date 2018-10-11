//%attributes = {}
  //FTP_RenameItem

C_LONGINT:C283($1;$FTP_ID)
C_TEXT:C284($2;$3;$currentPath;$newName)
$FTP_ID:=$1
$currentPathName:=$2
$newName:=$3
$newPathName:=vtDir+"/"+$newName

$error:=FTP_Rename ($FTP_ID;$currentPathName;$newPathName)
If ($error#0)
	CD_Dlog (0;IT_ErrorText ($error))
Else 
	C_BOOLEAN:C305($success)
	$success:=FTP_ChangeDirectory ($FTP_ID;vtDir)
End if 

