//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:07:58
  // ----------------------------------------------------
  // Método: STWA2_OWC_changePass2
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

$pass:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"pass")
$code:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"code")
$rn:=KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]passRegenerationCode:23;->$code;True:C214)
If ($rn#-1)
	[xShell_Users:47]xPass:13:=USR_EncryptPassWord ($pass)
	[xShell_Users:47]passRegenerationCode:23:=""
	SAVE RECORD:C53([xShell_Users:47])
	KRL_UnloadReadOnly (->[xShell_Users:47])
	$json:=STWA2_JSON_SendError (0)
Else 
	  //error no existe codigo
	$json:=STWA2_JSON_SendError (-80003)
End if 
C_BLOB:C604($blob)
TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
WEB SEND RAW DATA:C815($blob;*)

$0:=$json