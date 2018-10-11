//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 06/10/15, 17:02:22
  // ----------------------------------------------------
  // Método: STWA2_OWC_processlogin_2
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
$ipAddressClient:=$4
$user:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"user")
$pass:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"password")
$persistente:=(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"signin_remember")="on")
$cultura:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"culture")
$mobile:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"mobile"))
$clasica:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"clasica")
$userID:=0
$profID:=0

vl_STWAloginResult:=STWA2_ProcessLogin ($user;$pass;->$userID;->$profID)

If (vl_STWAloginResult=0)
	$cookie:=STWA2_Session_SetSession ($userID;$profID;$persistente;$ipAddressClient;$cultura;$clasica)
	If ($mobile=0)
		WEB SET HTTP HEADER:C660($cookie)
		WEB SEND HTTP REDIRECT:C659("webaccess2")
	Else 
		If ($clasica="1")
			WEB SET HTTP HEADER:C660($cookie)
			WEB SEND HTTP REDIRECT:C659("webaccess2")
		Else 
			WEB SET HTTP HEADER:C660($cookie)
			WEB SEND HTTP REDIRECT:C659("m.webaccess2.shtml")
		End if 
	End if 
Else 
	If ((vl_STWAloginResult=-12) | (vl_STWAloginResult=-13) | (vl_STWAloginResult=-14))
		$cookie:=STWA2_Session_SetSession ($userID;$profID;$persistente;$ipAddressClient;$cultura;$clasica)
		WEB SET HTTP HEADER:C660($cookie)
	End if 
	WEB SEND FILE:C619("stwa/login.shtml")
End if 




  //$0:=$json
