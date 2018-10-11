//%attributes = {}
  //WSact_GeneraLibrosContables

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado;vlWS_folioDTE)
C_TEXT:C284(vtWS_glosa)
vlWS_estado:=0
vtWS_glosa:=""

WEB SERVICE SET PARAMETER:C777("contribuyente";$1)
WEB SERVICE SET PARAMETER:C777("txt";$2)
WEB SERVICE SET PARAMETER:C777("operacion";$3)

WSact_DTECallWebService ("doIngresoIE")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vlWS_estado;"estadoProcesamiento")
	WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosaProcesamiento")
	WEB SERVICE GET RESULT:C779(vlWS_folioDTE;"correlativoIECV";*)
	If (vlWS_estado=0)
		CD_Dlog (0;vtWS_glosa)
	End if 
End if 
$0:=vlWS_estado