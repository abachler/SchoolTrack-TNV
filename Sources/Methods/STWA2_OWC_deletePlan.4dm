//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:52:56
  // ----------------------------------------------------
  // Método: STWA2_OWC_deletePlan
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
If (KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$rn;True:C214))
	$del:=STR_DeleteRecord (->[Asignaturas_PlanesDeClases:169])
	If ($del=1)
		$ob_raiz:=OB_Create 
		OB_SET_Text ($ob_raiz;"ok";"delete")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text ($jsonT;"delete";"ok")
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	Else 
		$json:=STWA2_JSON_SendError (-60004)
	End if 
Else 
	$json:=STWA2_JSON_SendError (-60003)
End if 

$0:=$json