//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:02:31
  // ----------------------------------------------------
  // Método: STWA2_OWC_search
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$json:=STWA2_GeneralSearch 

$0:=$json