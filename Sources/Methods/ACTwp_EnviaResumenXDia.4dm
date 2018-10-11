//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 26-05-14, 10:07:28
  // ----------------------------------------------------
  // Método: ACTwp_EnviaResumenXDia
  // Descripción
  // Metodo que envia resumen del dia de los pagos webpay
  //
  // Parámetros
  // ----------------------------------------------------



C_DATE:C307($d_fecha;$1)
C_BOOLEAN:C305($b_ejecutado;$0)

C_TEXT:C284($methodCalledOnError;$t_json;$json)
C_TEXT:C284($err)

C_LONGINT:C283($vl_pID)

C_DATE:C307($d_fechaRevisada)

ACTcfg_OpcionesRazonesSociales ("LoadConfig")

$d_fecha:=$1
$d_fechaRevisada:=DTS_GetDate (PREF_fGet (0;"ACT_DTS_REVISIONDIARIA_WEBPAY"))

If (($d_fecha<=$d_fechaRevisada) & ($d_fecha<=Add to date:C393(Current date:C33(*);0;0;-1)) & ($d_fechaRevisada#!00-00-00!) & (SMTP_VerifyEmailAddress ([ACT_RazonesSociales:279]contacto_eMail:15;False:C215)#""))  //solo se envia mail hasta la fecha revisada en SN y fecha menor a la actual
	
	$json:=ACTwp_GeneraJSONPagos ($d_fecha)
	
	  //Llamado WS que envia mail
	$methodCalledOnError:=Method called on error:C704
	ON ERR CALL:C155("WS_ErrorHandler")
	WEB SERVICE SET PARAMETER:C777("rol";<>gRolBD)
	WEB SERVICE SET PARAMETER:C777("codigopais";<>vtXS_CountryCode)
	WEB SERVICE SET PARAMETER:C777("datos";$json)
	$vl_pID:=IT_UThermometer (1;0;__ ("Interrogando SchoolNet...");-1)
	$err:=SN3_CallWebService ("sn3ws_PagoOnline_proceso.envia_correo")
	IT_UThermometer (-2;$vl_pID)
	If ($err="")
		WEB SERVICE GET RESULT:C779($t_json;"resultado";*)
		If (ok=1)
			C_OBJECT:C1216($ob;$ob_Estado)
			  // Modificado por: Alexis Bustamante (12-06-2017)
			  //TICKET 179869
			  //Quitar Plugins
			$ob:=OB_Create 
			$ob_Estado:=OB_Create 
			$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
			OB_GET ($ob;->$ob_Estado;"estado")
			C_REAL:C285($r_procesado)
			C_TEXT:C284($root;$nodeErr;$nodeErrCod;$t_respuesta)
			OB_GET ($ob_Estado;->$r_procesado;"codigo")
			
			C_REAL:C285($r_procesado)
			C_TEXT:C284($root;$nodeErr;$nodeErrCod;$t_respuesta)
			  //$root:=JSON Parse text ($t_json)
			  //$nodeErr:=JSON Get child by name ($root;"estado")
			  //$nodeErrCod:=JSON Get child by name ($nodeErr;"codigo")
			  //$r_procesado:=JSON Get real ($nodeErrCod)
			If ($r_procesado=0)
				$b_ejecutado:=True:C214
			Else 
				  //$nodeErrCod:=JSON Get child by name ($nodeErr;"descripcion")
				  //$t_respuesta:=JSON Get text ($nodeErrCod)
				OB_GET ($ob_Estado;->$t_respuesta;"descripcion")
				
				LOG_RegisterEvt ("Error en envío de eMail con Pagos Webpay para el día: "+String:C10($d_fecha)+": Error: "+String:C10($r_procesado)+": "+$t_respuesta+".")
			End if 
			  //JSON CLOSE ($root)
		Else 
			LOG_RegisterEvt ("Error al intentar enviar a SN el resumen de los pagos Webpay para el día: "+String:C10($d_fecha)+". No fue posible obtener la respuesta.")
		End if 
	Else 
		LOG_RegisterEvt ("Error al intentar enviar a SN el resumen de los pagos Webpay para el día: "+String:C10($d_fecha)+". Error: "+$err+".")
	End if 
	ON ERR CALL:C155($methodCalledOnError)
End if 
$0:=$b_ejecutado