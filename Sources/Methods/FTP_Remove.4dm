//%attributes = {}
  //FTP_Remove

C_LONGINT:C283($1;$FTP_ID)
C_TEXT:C284($2;$3;$targetDir;$currentDir)
C_LONGINT:C283($4;$type;$error)  // 1 for file, 0 for directory
C_BOOLEAN:C305($success)

$FTP_ID:=$1
$targetDir:=$2
$currentDir:=$3
$type:=$4

If ($error=0)
	If ($type=1)
		$error:=FTP_Delete ($FTP_ID;$targetDir)
	Else 
		$error:=FTP_RemoveDir ($FTP_ID;$targetDir)
	End if 
	If ($error#10000)  // Cancel by the user
		If ($error#0)
			CD_Dlog (0;IT_ErrorText ($error))
		Else 
			$success:=FTP_ChangeDirectory ($FTP_ID;$currentDir)
		End if 
	End if 
Else 
	CD_Dlog (0;IT_ErrorText ($error))
End if 