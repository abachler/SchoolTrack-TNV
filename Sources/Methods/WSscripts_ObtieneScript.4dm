//%attributes = {"publishedSoap":true}
  //WSscripts_ObtieneScript
  //20140627 RCH desde esta version…

C_TEXT:C284(vtws_ErrorString)
C_TEXT:C284($1;$t_llave)
C_TEXT:C284($2;$t_uuid)
C_TEXT:C284($3;$t_dts)
C_LONGINT:C283($err)
C_TEXT:C284($t_script)
C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)

vtws_ErrorString:=""

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"llave")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"uuid")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"dts")
SOAP DECLARATION:C782(vtws_ErrorString;Is text:K8:3;SOAP output:K46:2;"result")
SOAP DECLARATION:C782(xBlob;Is BLOB:K8:12;SOAP output:K46:2;"script")

$t_llave:=$1
$t_uuid:=$2
$t_dts:=$3

If (ACTwp_GeneraKey ($t_dts)=$t_llave)
	READ ONLY:C145([CORP_Scripts:197])
	QUERY:C277([CORP_Scripts:197];[CORP_Scripts:197]Auto_UUID:9=$t_uuid)
	If (Records in selection:C76([CORP_Scripts:197])=1)
		CONVERT FROM TEXT:C1011([CORP_Scripts:197]Script:2;"UTF-8";xBlob)
		vtws_ErrorString:=""
	Else 
		vtws_ErrorString:="Script con UUID "+$t_uuid+" no encontrado."
	End if 
	KRL_UnloadReadOnly (->[CORP_Scripts:197])
Else 
	vtws_ErrorString:="Llave no válida."
End if 
  //SET BLOB SIZE(xBlob;0)
