//%attributes = {"publishedSoap":true}
  //WSscripts_EliminaScript

C_TEXT:C284(vtws_ErrorString)
C_TEXT:C284($1;$t_llave)
C_TEXT:C284($3;$2;$t_dts;$t_uuid)

vtws_ErrorString:=""

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"llave")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"uuid")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"dts")
SOAP DECLARATION:C782(vtws_ErrorString;Is text:K8:3;SOAP output:K46:2;"result")

$t_llave:=$1
$t_uuid:=$2
$t_dts:=$3

If (ACTwp_GeneraKey ($t_dts)=$t_llave)
	READ WRITE:C146([CORP_Scripts:197])
	KRL_FindAndLoadRecordByIndex (->[CORP_Scripts:197]Auto_UUID:9;->$t_uuid;True:C214)
	If (ok=1)
		DELETE RECORD:C58([CORP_Scripts:197])
		vtws_ErrorString:=""
	Else 
		If (Records in selection:C76([CORP_Scripts:197])=1)
			vtws_ErrorString:="Registro bloqueado."
		Else 
			vtws_ErrorString:="Registro no existe."
		End if 
	End if 
	KRL_UnloadReadOnly (->[CORP_Scripts:197])
Else 
	vtws_ErrorString:="Llave no válida."
End if 