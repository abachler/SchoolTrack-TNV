//%attributes = {}
  //WSact_DTECallWebService
C_TEXT:C284($vt_method;$1;$vt_url)
C_LONGINT:C283($vl_proc)
C_BOOLEAN:C305($b_ambienteCertificacion)
C_BOOLEAN:C305($b_outManual;$vb_continuar)

$vt_method:=$1
If (Count parameters:C259>=2)
	$b_outManual:=$2
End if 

While (Semaphore:C143("ACT_ConsultaWSDTENet";300))
	DELAY PROCESS:C323(Current process:C322;20)
End while 

$b_ambienteCertificacion:=(Num:C11(PREF_fGet (0;"ACT_AMBIENTE_CERTIFICACION_SII";"1"))=1)

If ($b_ambienteCertificacion)
	  //$vt_url:="http://192.168.0.20:8080/dteNet/"
	$vt_url:="http://pruebas.dtecolegium.com/dteNet/"  //20140220 RCH Cambio la IP
	$vt_url:=PREF_fGet (0;"ACT_URLCERTDTENET";$vt_url)
Else 
	  //$vt_url:="http://192.168.0.21:8080/dteNet/"
	$vt_url:="http://www.dtecolegium.com:8080/dteNet/"
	  //$vt_url:="http://54.200.57.53:8080/dteNet/"
	$vt_url:=PREF_fGet (0;"ACT_URLDTENET";$vt_url)
End if 

  //20150911 RCH Se agrega valicación cuando se va a enviar a producción SII. El mensaje solo debería aparecer en bases no "servidor oficial".
  //If ($b_ambienteCertificacion)
  //  //If (Position("0.20";$vt_url)=0)
  //If ((Position("0.20";$vt_url)=0) & (Position("pruebas";$vt_url)=0))
  //C_BOOLEAN(<>bACTdtenet_avisado)
  //If (Not(<>bACTdtenet_avisado))
  //CD_Dlog (0;"La base tiene marcada la propiedad Ambiente de certificación y no está apuntando a la IP 20. Por favor verificar y detener el proceso en caso necesario...")
  //<>bACTdtenet_avisado:=True
  //End if 
  //End if 
  //End if 
$vb_continuar:=True:C214
C_BOOLEAN:C305(<>bACTdtenet_avisado)
If ($b_ambienteCertificacion)
	  //If (Position("0.20";$vt_url)=0)
	If ((Position:C15("0.20";$vt_url)=0) & (Position:C15("pruebas";$vt_url)=0))
		If (Not:C34(<>bACTdtenet_avisado))
			$l_resp:=CD_Dlog (0;"La base tiene marcada la propiedad Ambiente de certificación y no está apuntando al servidor de pruebas. Por favor verificar y detener el proceso en caso necesario.";"";"Continuar";"Detener")
			If ($l_resp=1)
				<>bACTdtenet_avisado:=True:C214
			Else 
				$vb_continuar:=False:C215
			End if 
		End if 
	End if 
Else 
	If (Not:C34(<>bXS_esServidorOficial))
		If (Not:C34(<>bACTdtenet_avisado))
			If (Not:C34(SN3_CheckNotColegium ))  //20151003 RCH Si no es Colegium, muestro mensaje.
				$l_resp:=CD_Dlog (0;"La base está apuntando al ambiente de PRODUCCIÓN del SII y la base de datos no está configurada como servidor oficial."+"\r\r"+"Si está haciendo pruebas detenga el proceso. Si efectivamente quiere emitir un documento válido para el SII presione continuar."+"\r\r"+"Si quiere que este mensaje no aparezca nuevamente, configure la base como servidor oficial.";"";"Continuar";"Detener")
				If ($l_resp=1)
					<>bACTdtenet_avisado:=True:C214
				Else 
					$vb_continuar:=False:C215
				End if 
			End if 
		End if 
	End if 
End if 

If ($vb_continuar)
	
	$vb_continuar:=True:C214
	Case of 
		: ($vt_method="doCargaCertificado")
			$vt_url:=$vt_url+"CargaCertificadoService"
			$vt_nomEspacio:="http://dtenet.colegium.com/CargaCertificado/"
			
		: ($vt_method="doAsociaSignatario")
			$vt_url:=$vt_url+"AsociaSignatarioService"
			$vt_nomEspacio:="http://dtenet.colegium.com/AsociaSignatario/"
			
		: ($vt_method="doCargaActecos")
			$vt_url:=$vt_url+"CargaActecosService"
			$vt_nomEspacio:="http://dtenet.colegium.com/CargaActecos/"
			
		: ($vt_method="doCargaCAF")
			$vt_url:=$vt_url+"CargaCAFService"
			$vt_nomEspacio:="http://dtenet.colegium.com/CargaCAF/"
			
		: ($vt_method="doCargaPropiedadesContribuyente")
			$vt_url:=$vt_url+"CargaPropiedadesContribuyenteService"
			$vt_nomEspacio:="http://dtenet.colegium.com/CargaPropiedadesContribuyente/"
			
		: ($vt_method="doIngresaSucursal")
			$vt_url:=$vt_url+"IngresaSucursalService"
			$vt_nomEspacio:="http://dtenet.colegium.com/IngresaSucursal/"
			
		: ($vt_method="doIngresaContribuyente")
			$vt_url:=$vt_url+"IngresaContribuyenteService"
			$vt_nomEspacio:="http://dtenet.colegium.com/IngresaContribuyente/"
			
		: ($vt_method="doEnvioIE")
			$vt_url:=$vt_url+"EnvioIEService"
			$vt_nomEspacio:="http://dtenet.colegium.com/EnvioIE/"
			
		: ($vt_method="doObtieneIE")
			$vt_url:=$vt_url+"ObtieneIEService"
			$vt_nomEspacio:="http://dtenet.colegium.com/ObtieneIE/"
			
		: ($vt_method="doFoliosDisponibles")
			$vt_url:=$vt_url+"FoliosDisponiblesService"
			$vt_nomEspacio:="http://dtenet.colegium.com/FoliosDisponibles/"
			
		: ($vt_method="doConsultaDTE")
			$vt_url:=$vt_url+"ConsultaDTEService"
			$vt_nomEspacio:="http://dtenet.colegium.com/ConsultaDTE/"
			
		: ($vt_method="doObtieneDTE")
			$vt_url:=$vt_url+"ObtieneDTEService"
			$vt_nomEspacio:="http://dtenet.colegium.com/ObtieneDTE/"
			
		: ($vt_method="doAprobacionDTE")
			$vt_url:=$vt_url+"AprobacionDTEService"
			$vt_nomEspacio:="http://dtenet.colegium.com/AprobacionDTE/"
			
			  //***** DTE
		: ($vt_method="doGeneracionDTE")
			$vt_url:=$vt_url+"GeneracionDTEService"
			$vt_nomEspacio:="http://dtenet.colegium.com/GeneracionDTE/"
			
		: ($vt_method="doIngresoIE")
			$vt_url:=$vt_url+"IngresoIEService"
			$vt_nomEspacio:="http://dtenet.colegium.com/IngresoIE/"
			
		: ($vt_method="doGeneracionBoleta")
			$vt_url:=$vt_url+"GeneracionBoletaService"
			$vt_nomEspacio:="http://dtenet.colegium.com/GeneracionBoleta/"
			
		: ($vt_method="doEnviarSII")
			$vt_url:=$vt_url+"EnviarSIIService"
			$vt_nomEspacio:="http://dtenet.colegium.com/EnviarSII/"
			
		: ($vt_method="doCargaContribuyentesElectronicos")
			$vt_url:=$vt_url+"CargaContribuyentesElectronicosService"
			$vt_nomEspacio:="http://dtenet.colegium.com/CargaContribuyentesElectronicos/"
			
		Else 
			$vb_continuar:=False:C215
			CD_Dlog (0;"Error Servicio no definido.")
			
	End case 
	
	If ($vb_continuar)
		$vt_soapAction:=$vt_nomEspacio+$vt_method
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		
		$vl_proc:=IT_UThermometer (1;0;"Contactándose con Colegium...")
		Case of 
			: ($b_outManual)
				WEB SERVICE CALL:C778($vt_url;$vt_soapAction;$vt_method;$vt_nomEspacio;Web Service manual out:K48:3)
			Else 
				WEB SERVICE CALL:C778($vt_url;$vt_soapAction;$vt_method;$vt_nomEspacio;Web Service dynamic:K48:1)
		End case 
		IT_UThermometer (-2;$vl_proc)
		
		EM_ErrorManager ("Clear")
	End if 
End if 
CLEAR SEMAPHORE:C144("ACT_ConsultaWSDTENet")