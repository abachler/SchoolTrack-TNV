//%attributes = {}
  //FTP_CreateDir

C_LONGINT:C283($1;$FTP_ID)
C_TEXT:C284($2;$3;$currentDir;$directoryName)
$FTP_ID:=$1
$currentDir:=$2
$directoryName:=$3

$error:=FTP_MakeDir ($FTP_ID;$currentDir+"/"+$directoryName)
If ($error#0)
	CD_Dlog (0;IT_ErrorText ($error))
Else 
	C_BOOLEAN:C305($success)
	$success:=FTP_ChangeDirectory ($FTP_ID;$currentDir)
End if 