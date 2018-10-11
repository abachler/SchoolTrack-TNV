//%attributes = {"executedOnServer":true}
  //xDOC_RemoveExternalPicture

C_TEXT:C284($folder;$1;$fileName;$2)
$folder:=$1
$fileName:=$2

$folder:=Replace string:C233($folder;"\\";Folder separator:K24:12)
$folder:=Replace string:C233($folder;":";Folder separator:K24:12)
If (SYS_IsWindows )
	$folder:=Replace string:C233($folder;"\\\\";":\\")
End if 

$dataFilePath:=sys_getRutaBaseDatos 
$folderPath:=$dataFilePath+"Archivos"+Folder separator:K24:12+$folder
$filePath:=$folderPath+Folder separator:K24:12+$filename
If (SYS_TestPathName ($filePath)=Is a document:K24:1)
	DELETE DOCUMENT:C159($filePath)
End if 
