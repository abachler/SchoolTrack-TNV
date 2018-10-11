//%attributes = {}
  //SYS_MoveDocument

C_BOOLEAN:C305($vb_eliminarArchivoExistente;$ok;$0)
C_TEXT:C284($srcPath;$dstPath;$folderPath)

$vb_eliminarArchivoExistente:=True:C214
$srcPath:=$1
$dstPath:=$2
If (Count parameters:C259>=3)
	$vb_eliminarArchivoExistente:=$3
End if 
$folderPath:=SYS_GetFolderNam ($dstPath)
If (SYS_TestPathName ($folderPath)<0)
	SYS_CreateFolder ($folderPath)
End if 
If ($vb_eliminarArchivoExistente)
	If (SYS_TestPathName ($dstPath)=1)
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		DELETE DOCUMENT:C159($dstPath)
		If (ok=1)
			$ok:=True:C214
		End if 
		EM_ErrorManager ("Clear")
	Else 
		$ok:=True:C214
	End if 
Else 
	$ok:=True:C214
End if 
If ($ok)
	If (SYS_TestPathName ($srcPath)>=0) & (SYS_TestPathName ($dstPath)<0)
		MOVE DOCUMENT:C540($srcPath;$dstPath)
	Else 
		$ok:=False:C215
	End if 
End if 
$0:=$ok