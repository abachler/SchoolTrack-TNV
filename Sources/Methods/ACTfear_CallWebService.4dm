//%attributes = {}
C_TEXT:C284($t_URL;$t_servicio;$1)
C_LONGINT:C283($l_idRS)
C_TEXT:C284($t_nomPrefH)
C_TEXT:C284(<>tACT_URLHOMOLOGACION;<>tACT_URLPRODUCCION;<>tACT_URL_LOGIN_HOMOLOGACION;<>tACT_URL_LOGIN_PRODUCCION)

$t_servicio:=$1
$l_idRS:=$2

$t_nomPrefH:=ACTfear_OpcionesGenerales ("NombrePreferenciaHomologacion";->$l_idRS)
cs_ambienteHomologacion:=Num:C11(PREF_fGet (0;$t_nomPrefH;"1"))

If ((<>tACT_URLHOMOLOGACION="") | (<>tACT_URLPRODUCCION="") | (<>tACT_URL_LOGIN_HOMOLOGACION="") | (<>tACT_URL_LOGIN_PRODUCCION=""))
	ACTfear_OpcionesGenerales ("CargaConf";->$l_idRS)
End if 

If (cs_ambienteHomologacion=1)
	If ($t_servicio="loginCms")
		$t_URL:=<>tACT_URL_LOGIN_HOMOLOGACION
	Else 
		$t_URL:=<>tACT_URLHOMOLOGACION
	End if 
Else 
	If ($t_servicio="loginCms")
		$t_URL:=<>tACT_URL_LOGIN_PRODUCCION
	Else 
		$t_URL:=<>tACT_URLPRODUCCION
		$t_sopaACTION:="http://ar.gov.afip.dif.FEV1/"
	End if 
End if 

Case of 
	: ($t_servicio="loginCms")
		$t_soapAction:=""
		$t_nomEspacio:="http://wsaa.view.sua.dvadac.desein.afip.gov"
		
	Else 
		  //: ($t_servicio="FEDummy")
		  //: ($t_servicio="FEParamGetPtosVenta")
		$t_soapAction:="http://ar.gov.afip.dif.FEV1/"+$t_servicio
		$t_nomEspacio:="http://ar.gov.afip.dif.FEV1/"
		
		  //Else 
		  //$t_soapAction:=""
		  //$t_nomEspacio:=""
End case 

  //"FEDummy"
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FEDummy";"FEDummy";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)

  //loginCms
  //WEB SERVICE CALL("https://wsaahomo.afip.gov.ar/ws/services/LoginCms";"";"loginCms";"http://wsaa.view.sua.dvadac.desein.afip.gov";Web Service Manual)
  //WEB SERVICE CALL("https://wsaahomo.afip.gov.ar/ws/services/LoginCms";"";"loginCms";"http://wsaa.view.sua.dvadac.desein.afip.gov";Web Service Manual)

  //FEParamGetPtosVenta
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FEParamGetPtosVenta";"FEParamGetPtosVenta";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)

  //FECAESolicitar
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FECAESolicitar";"FECAESolicitar";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)

  //FECompConsultar
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FECompConsultar";"FECompConsultar";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)

  //FECompUltimoAutorizado
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FECompUltimoAutorizado";"FECompUltimoAutorizado";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)

  //FEParamGetTiposCbte
  //WEB SERVICE CALL("https://wswhomo.afip.gov.ar/wsfev1/service.asmx";"http://ar.gov.afip.dif.FEV1/FEParamGetTiposCbte";"FEParamGetTiposCbte";"http://ar.gov.afip.dif.FEV1/";Web Service Manual)

  //20150803 RCH Se atrapan errores
C_TEXT:C284($t_method)
$t_method:=Method called on error:C704
ON ERR CALL:C155("WS_ErrorHandler")
vtWS_ErrorNum:=""
vtWS_ErrorString:=""

WEB SERVICE CALL:C778($t_URL;$t_soapAction;$t_servicio;$t_nomEspacio;Web Service manual:K48:4)

ON ERR CALL:C155($t_method)
