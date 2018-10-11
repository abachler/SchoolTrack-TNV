//%attributes = {}
  // Método: STWA2_OWC_obtieneLlaveEdunet
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:33:50
  // ----------------------------------------------------
  // Modificado por: Alberto Bachler Klein: 21-11-15, 13:10:43
  // Uso de Objeto 4D para generar json en reemplazo de plugin OAuth o componente JSON
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_OBJECT:C1216($ob_raiz)

C_POINTER:C301($y_objeto;$y_ParameterNames;$y_ParameterValues)
C_TEXT:C284($t_json;$t_jsonT;$t_llave;$t_nodo;$t_uuid;$t_url)


If (False:C215)
	C_TEXT:C284(STWA2_OWC_obtieneLlaveEdunet ;$0)
	C_TEXT:C284(STWA2_OWC_obtieneLlaveEdunet ;$1)
	C_POINTER:C301(STWA2_OWC_obtieneLlaveEdunet ;$2)
	C_POINTER:C301(STWA2_OWC_obtieneLlaveEdunet ;$3)
End if 

$t_uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$t_url:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"url")
If (True:C214)
	$t_llave:=STWA2_Edunet_Llaves ($t_url)
Else 
	$t_llave:="-1"
End if 
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$t_llave;"llave")
$t_json:=OB_Object2Json ($ob_raiz)
$0:=$t_json


