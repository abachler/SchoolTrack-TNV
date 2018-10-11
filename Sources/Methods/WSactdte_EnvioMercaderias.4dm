//%attributes = {}
  //WSactdte_EnvioMercaderias

C_TEXT:C284($1;$2)
C_REAL:C285($3;$4)
C_TEXT:C284($5;$6;$7)

C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado)
C_TEXT:C284(vtWS_glosa)

vlWS_estado:=0
vtWS_glosa:=""

WEB SERVICE SET PARAMETER:C777("rutEmisor";$1)
WEB SERVICE SET PARAMETER:C777("rutReceptor";$2)
WEB SERVICE SET PARAMETER:C777("tipoDTE";$3)
WEB SERVICE SET PARAMETER:C777("folioDTE";$4)
WEB SERVICE SET PARAMETER:C777("tipoAprobacion";$5)


WEB SERVICE SET PARAMETER:C777("nombreAprobador";$6)
WEB SERVICE SET PARAMETER:C777("recinto";$7)

WEB SERVICE SET PARAMETER:C777("montoTotal";$8)

WEB SERVICE SET PARAMETER:C777("fechaEmision";$9)

WSact_DTECallWebService ("doAprobacionDTE")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vlWS_estado;"estadoProcesamiento")
	WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosaProcesamiento";*)
	If (vlWS_estado=0)
		CD_Dlog (0;vtWS_glosa)
	End if 
End if 

$0:=vlWS_estado