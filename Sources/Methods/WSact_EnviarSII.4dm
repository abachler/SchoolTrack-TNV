//%attributes = {}
  //WSact_EnviarSII

C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado)
C_TEXT:C284(vtWS_glosa)
C_TEXT:C284($1)
vlWS_estado:=0
vtWS_glosa:=""

WEB SERVICE SET PARAMETER:C777("rutEmisor";$1)

WSact_DTECallWebService ("doEnviarSII")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vlWS_estado;"estadoProcesamiento")
	WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosaProcesamiento";*)
	If (vlWS_estado=0)
		  //Log_Event(0;0;vtWS_glosa;True)
	End if 
End if 
$0:=vlWS_estado
