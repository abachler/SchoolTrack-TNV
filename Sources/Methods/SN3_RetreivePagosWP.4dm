//%attributes = {}
  //SN3_RetreivePagosWP


  //SN3_RetreivePagosWP
C_TEXT:C284($t_json)
C_DATE:C307($d_fecha)

$methodCalledOnError:=Method called on error:C704
ON ERR CALL:C155("WS_ErrorHandler")
If (True:C214)
	$d_fecha:=$1
	
	  //$t_fecha:=String(Day of($d_fecha);"00")+"/"+String(Month of($d_fecha);"00")+"-"+String(Year of($d_fecha))
	
	$t_fecha:=ACTwp_ObtieneStringDesdeFecha ($d_fecha)
	  //$t_fechaT:=!30-04-2014!
	
	WEB SERVICE SET PARAMETER:C777("rol";<>gRolBD)
	WEB SERVICE SET PARAMETER:C777("codigopais";<>vtXS_CountryCode)
	WEB SERVICE SET PARAMETER:C777("finicio";$t_fecha)
	WEB SERVICE SET PARAMETER:C777("ftermino";$t_fecha)
	  //SET WEB SERVICE PARAMETER("ftermino";$t_fechaT)
	
	$vl_pID:=IT_UThermometer (1;0;__ ("Interrogando SchoolNet...");-1)
	$err:=SN3_CallWebService ("sn3ws_PagoOnline_proceso.obtiene_transacciones")
	IT_UThermometer (-2;$vl_pID)
	If ($err="")
		WEB SERVICE GET RESULT:C779($t_json;"resultado";*)
		LOG_RegisterEvt ("Servicio retorna pagos SN para día "+String:C10($d_fecha)+". Respuesta: "+$t_json+".")  //20180614 RCH
	Else 
		LOG_RegisterEvt ("Error al consultar a SN los pagos Webpay para el día: "+String:C10($d_fecha)+". Error: "+$err+".")
	End if 
	  //SET TEXT TO PASTEBOARD($t_json)
Else 
	  // Modificado por: Alexis Bustamante (10-06-2017)
	  //ticket 179869
	  //cambio de plugin
	
	
	C_OBJECT:C1216($ob_raiz;$ob_temp)
	ARRAY OBJECT:C1221($ob_registros;0)
	
	C_LONGINT:C283($vl_id;$vl_idrelfamiliar;$vl_enviadoST)
	C_TEXT:C284($t_avisos;$vt_fecha;$vt_estado)
	
	$ob_raiz:=OB_Create 
	$ob_temp:=OB_Create 
	
	$vl_id:=76
	$t_avisos:="22457,23445"
	$vl_idrelfamiliar:=10
	$vr_montototal:=200000
	$vt_fecha:="2013-06-07 22:30:52"
	$vt_estado:="APROBADO"
	$vl_enviadoST:=0
	
	OB_SET ($ob_temp;->$vl_id;"id")
	OB_SET ($ob_temp;->$t_avisos;"avisos")
	OB_SET ($ob_temp;->$vl_idrelfamiliar;"idrelfamiliar")
	OB_SET ($ob_temp;->$vr_montototal;"montototal")
	OB_SET ($ob_temp;->$vt_fecha;"fecha")
	OB_SET ($ob_temp;->$vt_estado;"estado")
	OB_SET ($ob_temp;->$vl_enviadoST;"enviadoST")
	
	APPEND TO ARRAY:C911($ob_registros;$ob_temp)
	CLEAR VARIABLE:C89($ob_temp)
	
	
	
	
	
	$vl_id:=75
	$t_avisos:="22456,33445"
	$vl_idrelfamiliar:=8
	$vr_montototal:=105678
	$vt_fecha:="2013-06-06 22:30:52"
	$vt_estado:="RECHAZADO"
	$vl_enviadoST:=1
	
	$ob_temp:=OB_Create 
	OB_SET ($ob_temp;->$vl_id;"id")
	OB_SET ($ob_temp;->$t_avisos;"avisos")
	OB_SET ($ob_temp;->$vl_idrelfamiliar;"idrelfamiliar")
	OB_SET ($ob_temp;->$vr_montototal;"montototal")
	OB_SET ($ob_temp;->$vt_fecha;"fecha")
	OB_SET ($ob_temp;->$vt_estado;"estado")
	OB_SET ($ob_temp;->$vl_enviadoST;"enviadoST")
	
	APPEND TO ARRAY:C911($ob_registros;$ob_temp)
	CLEAR VARIABLE:C89($ob_temp)
	
	  //agrego Arreglo de OB a OB raiz
	OB_SET ($ob_raiz;->$ob_registros;"registros")
	$t_json:=OB_Object2Json ($ob_raiz)
	
End if 
ON ERR CALL:C155($methodCalledOnError)
$0:=$t_json