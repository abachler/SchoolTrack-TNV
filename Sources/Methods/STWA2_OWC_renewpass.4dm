//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:08:19
  // ----------------------------------------------------
  // Método: STWA2_OWC_renewpass
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

$code:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"c")
$cultura:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"cul")
READ ONLY:C145([xShell_Users:47])
$rn:=KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]passRegenerationCode:23;->$code)
If ($rn#-1)
	$expiration_ts:=ST_RigthChars ($code;14)
	$currentTS:=DTS_MakeFromDateTime 
	If ($expiration_ts>=$currentTS)
		vtstwa_code:=$code
		vtstwa_cultura:=$cultura
		vtstwa_error:="0"
		WEB SEND FILE:C619("stwa/passRequest.shtml")
	Else 
		KRL_ReloadInReadWriteMode (->[xShell_Users:47])
		[xShell_Users:47]passRegenerationCode:23:=""
		SAVE RECORD:C53([xShell_Users:47])
		KRL_UnloadReadOnly (->[xShell_Users:47])
		vtstwa_code:=""
		vtstwa_cultura:=$cultura
		vtstwa_error:="-80002"
		WEB SEND FILE:C619("stwa/passRequest.shtml")
	End if 
Else 
	vtstwa_code:=""
	vtstwa_cultura:=$cultura
	vtstwa_error:="-80003"
	WEB SEND FILE:C619("stwa/passRequest.shtml")
End if 
