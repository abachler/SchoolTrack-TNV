//%attributes = {"executedOnServer":true}
  //xDOC_ReadExternalPicture

C_PICTURE:C286($pict)
C_BLOB:C604($blob)
C_TEXT:C284($folder;$fileName)
$folder:=$1
$fileName:=$2
$showProgress:=True:C214

If (Count parameters:C259=3)
	$showProgress:=$3
End if 


$folder:=Replace string:C233($folder;"\\";Folder separator:K24:12)
$folder:=Replace string:C233($folder;":";Folder separator:K24:12)
If (SYS_IsWindows )
	$folder:=Replace string:C233($folder;"\\\\";":\\")
End if 

$dataFilePath:=sys_getRutaBaseDatos 
$filePath:=$dataFilePath+"Archivos"+Folder separator:K24:12+$folder+Folder separator:K24:12+$filename
READ PICTURE FILE:C678($filePath;$pict)
$0:=$pict
