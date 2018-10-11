//%attributes = {}
  //STWA2_OWC_deletefileguias
C_TEXT:C284($1;$0;$uuid;$t_valor)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_request)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
If (KRL_GotoRecord (->[xShell_Documents:91];$rn;False:C215))
	QUERY:C277([Asignaturas_Adjuntos:230];[Asignaturas_Adjuntos:230]ID:1=[xShell_Documents:91]RelatedID:2)
	$l_ok:=KRL_DeleteRecord (->[Asignaturas_Adjuntos:230])
	If ($l_ok=1)
		$t_valor:="delete"
		XDOC_RemoveAttachedDocument ($rn;"DocsGuias")
		$ob_request:=OB_Create 
		OB_SET ($ob_request;->$t_valor;"ok")
		$json:=OB_Object2Json ($ob_request;True:C214)
	Else 
		$json:=STWA2_JSON_SendError (-60006)
	End if 
	
Else 
	$json:=STWA2_JSON_SendError (-60006)
End if 

$0:=$json

