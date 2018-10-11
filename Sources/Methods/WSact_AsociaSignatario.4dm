//%attributes = {}
  //WSact_AsociaSignatario 

C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado)
C_TEXT:C284(vtWS_glosa)
vlWS_estado:=0
vtWS_glosa:=""

WEB SERVICE SET PARAMETER:C777("rutContribuyente";$1)
WEB SERVICE SET PARAMETER:C777("sucursal";$2)
WEB SERVICE SET PARAMETER:C777("rutSignatario";$3)

WSact_DTECallWebService ("doAsociaSignatario")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vlWS_estado;"estadoProcesamiento")
	WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosaProcesamiento";*)
	If (vlWS_estado=0)
		CD_Dlog (0;vtWS_glosa)
	End if 
End if 
$0:=vlWS_estado