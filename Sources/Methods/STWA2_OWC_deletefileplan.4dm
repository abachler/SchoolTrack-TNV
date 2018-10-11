//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:54:09
  // ----------------------------------------------------
  // Método: STWA2_OWC_deletefileplan
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
If (KRL_GotoRecord (->[xShell_Documents:91];$rn;False:C215))
	XDOC_RemoveAttachedDocument ($rn)
	$ob_raiz:=OB_Create 
	OB_SET_Text ($ob_raiz;"ok";"delete")
	$json:=OB_Object2Json ($ob_raiz)
	
Else 
	$json:=STWA2_JSON_SendError (-60006)
End if 

$0:=$json
