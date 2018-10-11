//%attributes = {}
  // MÉTODO: xDOC_Picture_SaveToFile
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/03/11, 09:27:11
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // xDOC_Picture_SaveToFile()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1;$uuid;$2;$fileName;$3;$codec)
$uuid:=$1
$fileName:=""
$codec:=".jpg"

Case of 
	: (Count parameters:C259=2)
		$filename:=$2
		
	: (Count parameters:C259=3)
		$filename:=$2
		$codec:=$3
		
End case 



  // CODIGO PRINCIPAL
$ref:=Create document:C266($fileName;$codec)
If (OK=1)
	CLOSE DOCUMENT:C267($ref)
	
	$blob:=xDOC_Picture_GetBlob ($uuid)
	BLOB TO PICTURE:C682($blob;$Picture;".jpg")
	WRITE PICTURE FILE:C680(document;$picture;$codec)
	
End if 
