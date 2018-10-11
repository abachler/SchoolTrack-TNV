//%attributes = {"publishedSoap":true}
  //WSscripts_ModificaScript

C_TEXT:C284(vtws_ErrorString)
C_TEXT:C284($1;$t_llave)
C_TEXT:C284($2;$t_uuid)
C_TEXT:C284($3;$t_dts;$t_desc)
C_BLOB:C604($4;$x_blob)

vtws_ErrorString:=""

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"llave")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"uuid")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"dts")
SOAP DECLARATION:C782($4;Is BLOB:K8:12;SOAP input:K46:1;"script")
SOAP DECLARATION:C782(vtws_ErrorString;Is text:K8:3;SOAP output:K46:2;"result")

$t_llave:=$1
$t_uuid:=$2
$t_dts:=$3
$x_blob:=$4

If (ACTwp_GeneraKey ($t_dts)=$t_llave)
	READ WRITE:C146([CORP_Scripts:197])
	QUERY:C277([CORP_Scripts:197];[CORP_Scripts:197]Auto_UUID:9=$t_uuid)
	If (Records in selection:C76([CORP_Scripts:197])=1)
		[CORP_Scripts:197]Script:2:=Convert to text:C1012($x_blob;"UTF-8")
		SAVE RECORD:C53([CORP_Scripts:197])
		vtws_ErrorString:=""
	Else 
		vtws_ErrorString:="Script con UUID "+$t_uuid+" no encontrado."
	End if 
	KRL_UnloadReadOnly (->[CORP_Scripts:197])
Else 
	vtws_ErrorString:="Llave no válida."
End if 