//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:10:43
  // ----------------------------------------------------
  // Método: STWA2_OWC_processUUIDlogin
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
$mobile:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"mobile"))
$clasica:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"clasica")
If (STWA2_Session_IsSessionValid ($uuid))
	STWA2_Session_Reactivate ($uuid)
	If ($mobile=0)
		WEB SEND HTTP REDIRECT:C659("webaccess2")
	Else 
		If ($clasica="1")
			WEB SEND HTTP REDIRECT:C659("webaccess2")
		Else 
			WEB SEND HTTP REDIRECT:C659("m.webaccess2.shtml")
		End if 
	End if 
Else 
	$cookie:="Set-Cookie: stwa2=UUID="+$uuid+"; expires="+String:C10(Add to date:C393(Current date:C33;-1;0;0);Date RFC 1123:K1:11)
	WEB SET HTTP HEADER:C660($cookie)
	WEB SEND HTTP REDIRECT:C659("login.shtml")
End if 


$0:=$json