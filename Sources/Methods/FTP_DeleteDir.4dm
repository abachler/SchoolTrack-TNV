//%attributes = {}
  //FTP_DeleteDir

C_LONGINT:C283($1;$4;$FTP_ID;$uThermPid)
C_TEXT:C284($2;$3;$targetDir;$vItem)
C_LONGINT:C283($error)
C_BOOLEAN:C305($success)

$FTP_ID:=$1
$targetDir:=$2
$vItem:=$3
$uThermPid:=$4

ARRAY TEXT:C222(atDirectoryList;1)
ARRAY TEXT:C222(atFileList;0)
If (Length:C16(vtFTP_CurrentDirectory)>1)
	atDirectoryList{1}:=vtFTP_CurrentDirectory+"/"+$vItem
Else 
	atDirectoryList{1}:=$vItem
End if 
FTP_GetHostPaths ($FTP_ID;->atDirectoryList;->atFileList)
SORT ARRAY:C229(atDirectoryList;<)

For ($i;1;Size of array:C274(atFileList))
	$uThermPid:=IT_UThermometer (0;$uThermPid;__ ("Eliminando ")+atFileList{$i})
	$error:=FTP_Delete ($FTP_ID;atFileList{$i})
	If ($error#10000)  // Cancel by the user
		If ($error#0)
			CD_Dlog (0;IT_ErrorText ($error))
		End if 
	End if 
End for 

For ($i;1;Size of array:C274(atDirectoryList))
	$uThermPid:=IT_UThermometer (0;$uThermPid;__ ("Eliminando ")+atDirectoryList{$i})
	$error:=FTP_RemoveDir ($FTP_ID;atDirectoryList{$i})
	If ($error#10000)  // Cancel by the user
		If ($error#0)
			CD_Dlog (0;IT_ErrorText ($error))
		End if 
	End if 
End for 

$success:=FTP_ChangeDirectory ($FTP_ID;$2)
