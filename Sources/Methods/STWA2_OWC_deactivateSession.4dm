//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:00:13
  // ----------------------------------------------------
  // Método: STWA2_OWC_deactivateSession
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

READ WRITE:C146([STWA2_SessionManager:290])
QUERY:C277([STWA2_SessionManager:290];[STWA2_SessionManager:290]Auto_UUID:1=$uuid)
[STWA2_SessionManager:290]Activa:7:=False:C215
SAVE RECORD:C53([STWA2_SessionManager:290])
KRL_UnloadReadOnly (->[STWA2_SessionManager:290])
$json:=STWA2_JSON_SendError (0)

$0:=$json