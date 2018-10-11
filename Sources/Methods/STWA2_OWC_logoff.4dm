//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:01:26
  // ----------------------------------------------------
  // Método: STWA2_OWC_logoff
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_OBJECT:C1216($ob_raiz)
C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

STWA2_Session_UnsetSession ($uuid)
$ob_raiz:=OB_Create 
OB_SET_Text ($ob_raiz;"CerrarSesion";"OK")
$json:=OB_Object2Json ($ob_raiz)

$0:=$json