//%attributes = {"executedOnServer":true}
  // DOCL_guardaContenido(uuid:&T; blob:&X)
  // Por: Alberto Bachler: 17/09/13, 15:57:05
  //  ---------------------------------------------
  // guarda el contenido de un documento pasado en blob en el documento pasado en UUID
  // en v13 los documentos externos deben ser almacenados externamente a la BD activando la propiedad corespondiente para el campo [xShell_Libreria]xDocumento
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_recNum)
C_POINTER:C301($y_blob)
C_TEXT:C284($t_uuid)

If (False:C215)
	C_LONGINT:C283(DOCL_guardaContenido ;$0)
	C_TEXT:C284(DOCL_guardaContenido ;$1)
	C_POINTER:C301(DOCL_guardaContenido ;$2)
End if 

$t_uuid:=$1
$y_blob:=$2
$t_NombreDocumento:=$3

$l_recNum:=KRL_FindAndLoadRecordByIndex (->[DocumentLibrary:234]Auto_UUID:2;->$t_uuid;True:C214)
If (OK=1)
	[DocumentLibrary:234]Document_name:7:=$t_NombreDocumento
	[DocumentLibrary:234]Extension:6:=SYS_extensionDocumento ($t_NombreDocumento)
	If (Application version:C493>="13.3.@")
		[DocumentLibrary:234]Document_xContent:10:=$y_blob->
		SAVE RECORD:C53([DocumentLibrary:234])
	Else 
		SAVE RECORD:C53([DocumentLibrary:234])
		$t_rutaCarpeta:=sys_getRutaBaseDatos +"Document Library"+Folder separator:K24:12+[DocumentLibrary:234]refTabla:8+Folder separator:K24:12+[DocumentLibrary:234]refRegistro:1+Folder separator:K24:12
		SYS_CreateFolder ($t_rutaCarpeta)
		$t_rutaArchivo:=$t_rutaCarpeta+[DocumentLibrary:234]Auto_UUID:2+[DocumentLibrary:234]Extension:6
		$h_refArchivo:=Create document:C266($t_rutaArchivo)
		CLOSE DOCUMENT:C267($h_refArchivo)
		BLOB TO DOCUMENT:C526($t_rutaArchivo;$x_Blob)
	End if 
	READ ONLY:C145([DocumentLibrary:234])
	LOAD RECORD:C52([DocumentLibrary:234])
End if 

