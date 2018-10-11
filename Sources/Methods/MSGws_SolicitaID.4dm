//%attributes = {}
  // WSmsg_Solicita_ID()
  // Por: Alberto Bachler: 12/06/13, 16:19:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283(vl_resultadoWS)

C_TEXT:C284($t_TextoError)

If (False:C215)
	C_LONGINT:C283(MSGws_SolicitaID ;$0)
End if 

$t_TextoError:=WS_CallIntranetWebService ("WSmsg_SolicitaID_out")
vl_resultadoWS:=-1

If ($t_textoError="")
	WEB SERVICE GET RESULT:C779(vl_resultadoWS;"resultado";*)
End if 

$0:=vl_resultadoWS

