//%attributes = {}
  // ACTabc_CreaDocumento()
  //
  //
  // modificado por: Alberto Bachler Klein: 26-12-16, 12:34:36
  // modificado por: Patricio Aliaga Retamal: 20-05-17, 14:34:02
  // Se agrega tercer parametro, para poder indicar la extension del archivo generado. Si se omite por defecto sera txt
  // -----------------------------------------------------------
C_TIME:C306($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_error;$t_metodoOnErr;$t_nombreDocumento;$t_rutaCarpeta;$t_rutaDocumento;$tipodoc)


If (False:C215)
	C_TIME:C306(ACTabc_CreaDocumento ;$0)
	C_TEXT:C284(ACTabc_CreaDocumento ;$1)
	C_TEXT:C284(ACTabc_CreaDocumento ;$2)
End if 

C_TEXT:C284(vtACT_document)

$t_rutaCarpeta:=$1
$t_nombreDocumento:=$2

If (Count parameters:C259>2)
	$tipodoc:=$3
Else 
	$tipodoc:=""
End if 

ok:=1

If ($t_rutaCarpeta#"")
	$t_rutaDocumento:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+$t_rutaCarpeta+Folder separator:K24:12+$t_nombreDocumento
Else 
	$t_rutaDocumento:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+$t_nombreDocumento
End if 
CREATE FOLDER:C475($t_rutaDocumento;*)

$t_metodoOnErr:=Method called on error:C704
ON ERR CALL:C155("ERR_EventoError")
SYS_DeleteFile ($t_rutaDocumento)

If (ok=1)
	If ($tipodoc#"")
		$h_refDocumento:=Create document:C266($t_rutaDocumento;$tipodoc)
		vtACT_document:=$t_rutaDocumento
	Else 
		$h_refDocumento:=Create document:C266($t_rutaDocumento;"TEXT")
		vtACT_document:=$t_rutaDocumento
	End if 
	
Else 
	vtACT_document:=""
End if 

If (ERROR=0)
	$0:=$h_refDocumento
	OK:=1
Else 
	$t_error:=ERR_LogExecutionError 
	ModernUI_Notificacion (__ ("Error de ejecución");$t_error)
	OK:=0
End if 


ON ERR CALL:C155($t_metodoOnErr)










