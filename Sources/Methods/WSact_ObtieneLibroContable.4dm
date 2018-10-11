//%attributes = {}
  //WSact_ObtieneLibroContable

C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado;vlWS_tipoDTE;vlWS_folioDTE)
C_TEXT:C284(vtWS_glosa)
C_TEXT:C284(vtWS_xml)
vlWS_estado:=0
vtWS_glosa:=""

WEB SERVICE SET PARAMETER:C777("rutEmisor";$1)
WEB SERVICE SET PARAMETER:C777("tipoOperacion";$2)
WEB SERVICE SET PARAMETER:C777("correlativoInterno";$3)

WSact_DTECallWebService ("doObtieneIE")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vlWS_estado;"estadoProcesamiento")
	If (vlWS_estado=1)
		WEB SERVICE GET RESULT:C779(vtWS_xml;"xml")
	End if 
	WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosaProcesamiento";*)
End if 
$0:=vlWS_estado