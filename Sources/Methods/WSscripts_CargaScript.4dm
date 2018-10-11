//%attributes = {"publishedSoap":true}
  //WSscripts_CargaScript

C_TEXT:C284(vtws_ErrorString)
C_TEXT:C284($1;$t_llave)
C_BLOB:C604($2;$x_blob)
C_TEXT:C284($3;$t_dts;$t_desc)

vtws_ErrorString:=""

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"llave")
SOAP DECLARATION:C782($2;Is BLOB:K8:12;SOAP input:K46:1;"script")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"dts")
SOAP DECLARATION:C782($4;Is text:K8:3;SOAP input:K46:1;"descripcion")
SOAP DECLARATION:C782(vtws_ErrorString;Is text:K8:3;SOAP output:K46:2;"result")

$t_llave:=$1
$x_blob:=$2
$t_dts:=$3
$t_desc:=$4

If (ACTwp_GeneraKey ($t_dts)=$t_llave)
	CREATE RECORD:C68([CORP_Scripts:197])
	[CORP_Scripts:197]ID_Script:1:=0  //id script intranet
	[CORP_Scripts:197]Descripcion:10:=$t_desc
	[CORP_Scripts:197]Script:2:=Convert to text:C1012($x_blob;"UTF-8")
	SAVE RECORD:C53([CORP_Scripts:197])
	vtws_ErrorString:="ok:"+String:C10([CORP_Scripts:197]Auto_UUID:9)
	KRL_UnloadReadOnly (->[CORP_Scripts:197])
Else 
	vtws_ErrorString:="Llave no válida."
End if 