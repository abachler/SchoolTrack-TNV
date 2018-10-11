//%attributes = {"publishedSoap":true}
  //WSscripts_EjecutaScript

C_TEXT:C284(vtws_ErrorString)
C_TEXT:C284($1;$t_llave)
C_TEXT:C284($2;$t_uuid)
C_TEXT:C284($3;$t_dts)
C_LONGINT:C283($err)
C_TEXT:C284($t_script)

vtws_ErrorString:=""

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"llave")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"uuid")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"dts")
SOAP DECLARATION:C782(vtws_ErrorString;Is text:K8:3;SOAP output:K46:2;"result")

$t_llave:=$1
$t_uuid:=$2
$t_dts:=$3

If (ACTwp_GeneraKey ($t_dts)=$t_llave)
	READ ONLY:C145([CORP_Scripts:197])
	QUERY:C277([CORP_Scripts:197];[CORP_Scripts:197]Auto_UUID:9=$t_uuid)
	If (Records in selection:C76([CORP_Scripts:197])=1)
		$t_script:=[CORP_Scripts:197]Script:2
		
		  //20170125 RCH Se pasa a Process 4D tags
		C_TEXT:C284($t_salida;$t_script4Dtags)
		$t_script4Dtags:="<!--#4DCODE\r"+$t_script+"\r-->"
		PROCESS 4D TAGS:C816($t_script4Dtags;$t_salida)
		
	Else 
		vtws_ErrorString:="Script con UUID "+$t_uuid+" no encontrado."
	End if 
	KRL_UnloadReadOnly (->[CORP_Scripts:197])
Else 
	vtws_ErrorString:="Llave no válida."
End if 