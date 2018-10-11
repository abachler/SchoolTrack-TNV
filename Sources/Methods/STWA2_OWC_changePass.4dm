//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:00:58
  // ----------------------------------------------------
  // Método: STWA2_OWC_changePass
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

$oldPass:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"oldPass")
$newPass:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"newPass")
$id:=STWA2_Session_GetUserSTID ($uuid)

If ($id>0)
	$rn:=Find in field:C653([xShell_Users:47]No:1;$id)
	If (KRL_GotoRecord (->[xShell_Users:47];$rn;True:C214))
		$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
		If ($oldPass=$storedPassword)
			[xShell_Users:47]xPass:13:=USR_EncryptPassWord ($newPass)
			[xShell_Users:47]PasswordVersion:10:=3
			If ([xShell_Users:47]Password_DaysToRenew:16>0)
				[xShell_Users:47]Password_ExpiresOn:11:=Current date:C33(*)+[xShell_Users:47]Password_DaysToRenew:16
			Else 
				[xShell_Users:47]Password_DaysToRenew:16:=0
				[xShell_Users:47]Password_ExpiresOn:11:=!00-00-00!
			End if 
			[xShell_Users:47]CambiarPassw_proximaSesion:26:=False:C215
			[xShell_Users:47]CambiarPassw_PrimeraSesion:25:=False:C215
			SAVE RECORD:C53([xShell_Users:47])
			LOG_RegisterEvt (__ ("El usuario cambio su contraseña en STWA.");0;0;[xShell_Users:47]No:1)
			
			KRL_UnloadReadOnly (->[xShell_Users:47])
			$json:=STWA2_JSON_SendError (0)
		Else 
			$json:=STWA2_JSON_SendError (-90000)
		End if 
	Else 
		$json:=STWA2_JSON_SendError (-90001)
	End if 
Else 
	$json:=STWA2_JSON_SendError (-90002)
End if 

$0:=$json
