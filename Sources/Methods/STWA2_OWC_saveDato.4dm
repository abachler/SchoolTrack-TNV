//%attributes = {}
  // Método: STWA2_OWC_saveDato
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 06/10/15, 17:03:58
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raizJson)
C_BOOLEAN:C305($b_verificado)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$ob_raizJson:=OB_Create 
If (STWA2_SaveDato ($y_ParameterNames;$y_ParameterValues;->$ob_raizJson))
	OB_SET_Text ($ob_raizJson;"";"ERR")
	$json:=OB_Object2Json ($ob_raizJson)
Else 
	$json:=STWA2_JSON_SendError (-70000)
End if 

$0:=$json