//%attributes = {"publishedSoap":true,"publishedWsdl":true}
  //WSscripts_Ejecuta

C_TEXT:C284(vtws_ErrorString)
C_TEXT:C284($1;$t_llave)
C_TEXT:C284($2;$t_dts)
C_BLOB:C604($3;$xBlob)
C_LONGINT:C283($err)
C_TEXT:C284($t_script)
C_TEXT:C284(vt_json;$t_errorScript)

vtws_ErrorString:=""
vt_json:=""
$t_errorScript:=""

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"llave")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"dts")
SOAP DECLARATION:C782($3;Is BLOB:K8:12;SOAP input:K46:1;"script")
SOAP DECLARATION:C782(vtws_ErrorString;Is text:K8:3;SOAP output:K46:2;"result")
SOAP DECLARATION:C782(vt_json;Is text:K8:3;SOAP output:K46:2;"json")  //20140630 RCH Si se quiere retornar algo, se debe llenar esta variable en el script

$t_llave:=$1
$t_dts:=$2
$xBlob:=$3

$b_ejecutado:=SERwa_Ejecuta ($t_llave;$t_dts;$xBlob;->$t_errorScript)
If (Not:C34($b_ejecutado))
	vtws_ErrorString:="Llave no válida."
End if 