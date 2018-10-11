//%attributes = {"publishedSoap":true}
  // VC4Dws_ObtenCodigoRemoto()
  // Por: Alberto Bachler K.: 24-02-15, 12:51:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_BLOB:C604($0)

C_BLOB:C604($x_blob)
C_TEXT:C284($t_codigo;$t_ruta)



If (False:C215)
	C_TEXT:C284(VC4Dws_ObtenCodigoRemoto ;$1)
End if 

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"ruta")
SOAP DECLARATION:C782($0;Is BLOB:K8:12;SOAP output:K46:2;"codigoRemoto")

$t_ruta:=$1

error:=0
$t_currentOnErrCall:=Method called on error:C704
ON ERR CALL:C155("ERR_EventoError")
METHOD GET CODE:C1190($t_ruta;$t_codigo;*)
ON ERR CALL:C155($t_currentOnErrCall)

If (error=0)
	TEXT TO BLOB:C554($t_codigo;$x_blob;UTF8 text without length:K22:17)
	
	$0:=$x_blob
End if 

