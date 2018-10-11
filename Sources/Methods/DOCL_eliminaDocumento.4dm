//%attributes = {"executedOnServer":true}
  // DOCL_eliminaDocumento()
  // Por: Alberto Bachler: 17/09/13, 13:39:08
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_numeroTabla)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_nombreDocumento;$t_refRegistro;$t_refTabla;$t_rutaCarpeta;$t_rutaDocumento)

If (False:C215)
	C_LONGINT:C283(DOCL_eliminaDocumento ;$0)
	C_POINTER:C301(DOCL_eliminaDocumento ;$1)
	C_TEXT:C284(DOCL_eliminaDocumento ;$2)
	C_TEXT:C284(DOCL_eliminaDocumento ;$3)
End if 

$y_tabla:=$1
$t_refRegistro:=$2
$t_nombreDocumento:=$3

$l_numeroTabla:=Table:C252($y_tabla)
$t_refTabla:=String:C10($t_refTabla)

$t_rutaCarpeta:=sys_getRutaBaseDatos +"Document Library"+Folder separator:K24:12+$t_refTabla+Folder separator:K24:12+$t_refRegistro+Folder separator:K24:12
$t_rutaDocumento:=$t_rutaCarpeta+$t_nombreDocumento

OK:=1
If (Test path name:C476($t_rutaDocumento)=Is a document:K24:1)
	DELETE DOCUMENT:C159($t_rutaDocumento)
End if 

$0:=OK

