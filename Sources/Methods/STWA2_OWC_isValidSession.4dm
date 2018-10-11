//%attributes = {}
  // Método: STWA2_OWC_isValidSession
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:09:28
  // ----------------------------------------------------
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_sesionValida)
C_POINTER:C301($y_ParameterNames;$y_ParameterValues)
C_TEXT:C284($at_ParameterNames;$at_ParameterValues;$t_json;$t_refJson;$t_uuid)


If (False:C215)
	C_TEXT:C284(STWA2_OWC_isValidSession ;$0)
	C_TEXT:C284(STWA2_OWC_isValidSession ;$1)
	C_POINTER:C301(STWA2_OWC_isValidSession ;$2)
	C_POINTER:C301(STWA2_OWC_isValidSession ;$3)
End if 

$t_uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

If (Application version:C493>="15@")
	$t_uuid:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"UUID")
	$b_sesionValida:=STWA2_Session_IsSessionValid ($t_uuid)
	
	
	C_OBJECT:C1216($ob_raiz)
	OB_SET_Text ($ob_raiz;String:C10(Num:C11($b_sesionValida));"valida")
	$t_json:=OB_Object2Json ($ob_raiz)
	
Else 
	
End if 
TEXT TO BLOB:C554($t_json;$x_blob;UTF8 text without length:K22:17)
WEB SEND RAW DATA:C815($x_blob;*)

$0:=$t_json