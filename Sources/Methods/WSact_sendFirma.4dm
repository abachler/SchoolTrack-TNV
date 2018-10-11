//%attributes = {}
  //WSact_sendFirma

C_TEXT:C284($1)
C_BLOB:C604($2)
C_TEXT:C284($3)
C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado)
C_TEXT:C284(vtWS_glosa)
vlWS_estado:=0
vtWS_glosa:=""


WEB SERVICE SET PARAMETER:C777("rutPersona";$1)
WEB SERVICE SET PARAMETER:C777("certificado";$2)
WEB SERVICE SET PARAMETER:C777("claveCertificado";$3)

WSact_DTECallWebService ("doCargaCertificado")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vlWS_estado;"estadoProcesamiento")
	WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosaProcesamiento";*)
	If (vlWS_estado=0)
		CD_Dlog (0;vtWS_glosa)
	Else 
		C_DATE:C307(vdrs_fechaVencimiento)
		vdrs_fechaVencimiento:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(vtWS_glosa;9;2));Num:C11(Substring:C12(vtWS_glosa;6;2));Num:C11(Substring:C12(vtWS_glosa;1;4)))
	End if 
End if 
$0:=vlWS_estado