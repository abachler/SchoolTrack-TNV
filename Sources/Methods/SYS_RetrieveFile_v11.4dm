//%attributes = {}
  //SYS_RetrieveFile_v11

C_TEXT:C284($0)
C_LONGINT:C283(vl_DocumentSize;$docSize;$received)
C_BOOLEAN:C305($showProgress)
C_BLOB:C604($blob)

$folderServer:=$1
$fileName:=$2
$showProgress:=True:C214
$folderLocal:=""
Case of 
	: (Count parameters:C259=4)
		$folderLocal:=$3
		$showProgress:=$4
	: (Count parameters:C259=3)
		$folderLocal:=$3
End case 

If ($folderLocal="")
	  //$folderLocal:=<>syT_AttachedDocPath //JHB 20150923 No estaba respetando el parametro $localFolder
	$folderLocal:=Temporary folder:C486
End if 

$p:=IT_UThermometer (1;0;"Recuperando archivo desde el servidor...")
$dataFilePath:=sys_getRutaBaseDatos 
$filePath:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+$folderServer+Folder separator:K24:12+$filename
$blob:=KRL_GetFileFromServer ($filePath;True:C214)


$ref:=Create document:C266($folderLocal+$fileName)
  //$ref:=Create document(Temporary folder+$fileName)//JHB 20150923 No estaba respetando el parametro $localFolder
CLOSE DOCUMENT:C267($ref)
BLOB TO DOCUMENT:C526(document;$blob)
$p:=IT_UThermometer (-2;$p)

$0:=document