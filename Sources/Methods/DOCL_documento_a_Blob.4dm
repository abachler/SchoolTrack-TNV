//%attributes = {"executedOnServer":true}
  // DOCL_documento_a_Blob()
  // Por: Alberto Bachler: 17/09/13, 13:38:52
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BLOB:C604($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_blob)
C_LONGINT:C283($l_numeroTabla)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_nombreDocumento;$t_refRegistro;$t_refTabla;$t_rutaCarpeta;$t_rutaDocumento)

If (False:C215)
	C_BLOB:C604(DOCL_documento_a_Blob ;$0)
	C_TEXT:C284(DOCL_documento_a_Blob ;$1)
End if 

$t_uuid:=$1
$l_recNum:=Find in field:C653([DocumentLibrary:234]Auto_UUID:2;$t_uuid)
If ($l_recNum>=0)
	READ ONLY:C145([DocumentLibrary:234])
	GOTO RECORD:C242([DocumentLibrary:234];$l_recNum)
	$t_refTabla:=[DocumentLibrary:234]refTabla:8
	$t_refRegistro:=[DocumentLibrary:234]refRegistro:1
	$t_nombreDocumento:=[DocumentLibrary:234]Auto_UUID:2+[DocumentLibrary:234]Extension:6
	
	
	$t_rutaCarpeta:=sys_getRutaBaseDatos +"Document Library"+Folder separator:K24:12+$t_refTabla+Folder separator:K24:12+$t_refRegistro+Folder separator:K24:12
	$t_rutaDocumento:=$t_rutaCarpeta+$t_nombreDocumento
	
	If (Test path name:C476($t_rutaDocumento)>=0)
		DOCUMENT TO BLOB:C525($t_rutaDocumento;$x_blob)
		$0:=$x_blob
	End if 
End if 

