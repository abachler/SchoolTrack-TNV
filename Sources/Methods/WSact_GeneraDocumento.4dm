//%attributes = {}
  //WSact_GeneraDocumento

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado;vlWS_tipoDTE;vlWS_folioDTE)
C_TEXT:C284(vtWS_glosa)
vlWS_estado:=0
vtWS_glosa:=""
vlWS_tipoDTE:=0
vlWS_folioDTE:=0

WEB SERVICE SET PARAMETER:C777("rutEmisor";$1)
WEB SERVICE SET PARAMETER:C777("codigoSucursal";$2)
WEB SERVICE SET PARAMETER:C777("txt";$3)

WSact_DTECallWebService ("doGeneracionDTE")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vlWS_estado;"estado")
	If (vlWS_estado=1)
		WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosa")
		WEB SERVICE GET RESULT:C779(vlWS_tipoDTE;"tipoDTE")
		WEB SERVICE GET RESULT:C779(vlWS_folioDTE;"folioDTE";*)
	Else 
		WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosa";*)
	End if 
	If (vlWS_estado=0)
		CD_Dlog (0;vtWS_glosa)
		SET TEXT TO PASTEBOARD:C523($3)
	End if 
End if 
$0:=vlWS_estado