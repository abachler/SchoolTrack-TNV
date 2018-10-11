//%attributes = {}
  // RIN_InformeObsoleto()
  // Por: Alberto Bachler K.: 17-08-14, 11:48:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($l_Error)
C_TEXT:C284($t_ErrorWS;$t_uuid)


If (False:C215)
	C_LONGINT:C283(RIN_InformeObsoleto ;$0)
	C_TEXT:C284(RIN_InformeObsoleto ;$1)
End if 

$t_uuid:=$1
WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
WEB SERVICE SET PARAMETER:C777("nombreUsuario";<>tUSR_CurrentUserName)

$t_ErrorWS:=WS_CallIntranetWebService ("RINws_InformeObsoleto";True:C214)
If ($t_ErrorWS="")
	WEB SERVICE GET RESULT:C779($l_Error;"errorCode";*)
End if 

$0:=$l_Error