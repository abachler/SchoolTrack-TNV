//%attributes = {}
  //WSact_CargaActeco

C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado)
C_TEXT:C284(vtWS_glosa)
vlWS_estado:=0
vtWS_glosa:=""

WEB SERVICE SET PARAMETER:C777("contribuyente";$1)
WEB SERVICE SET PARAMETER:C777("acteco";$2)

  //CALL WEB SERVICE("http://192.168.0.21:80/dteNet/CargaActecosService";"http://dtenet.colegium.com/CargaActecos/doCargaActecos";"doCargaActecos";"http://dtenet.colegium.com/CargaActecos/";Web Service Manual)
WSact_DTECallWebService ("doCargaActecos")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vlWS_estado;"estadoProcesamiento")
	WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosaProcesamiento";*)
	If (vlWS_estado=0)
		CD_Dlog (0;vtWS_glosa)
	End if 
End if 
$0:=vlWS_estado
