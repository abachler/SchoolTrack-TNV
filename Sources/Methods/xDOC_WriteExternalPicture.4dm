//%attributes = {"executedOnServer":true}
  //xDOC_WriteExternalPicture


C_PICTURE:C286($pict;$1)
C_BLOB:C604($blob)
C_TEXT:C284($folder;$fileName;$format;$2;$3;$4)
C_BOOLEAN:C305($showProgress;$5)
$pict:=$1
$folder:=$2
$fileName:=$3
$format:=PICT_GetDefaultFormat 
$extension:=PICT_GetDefaultExtension 
Case of 
	: (Count parameters:C259=4)
		$format:=$4
	: (Count parameters:C259=5)
		$format:=$4
		$showProgress:=$5
	Else 
		$showProgress:=True:C214
End case 


$fileName:=Replace string:C233($fileName;$extension+$extension;$extension)

$folder:=Replace string:C233($folder;"\\";Folder separator:K24:12)
$folder:=Replace string:C233($folder;":";Folder separator:K24:12)
If (SYS_IsWindows )
	$folder:=Replace string:C233($folder;"\\\\";":\\")
End if 

$dataFilePath:=sys_getRutaBaseDatos 
$folderPath:=$dataFilePath+"Archivos"+Folder separator:K24:12+$folder
SYS_CreatePath ($folderPath)
$filePath:=$dataFilePath+"Archivos"+Folder separator:K24:12+$folder+Folder separator:K24:12+$filename
WRITE PICTURE FILE:C680($filePath;$pict;".jpg")