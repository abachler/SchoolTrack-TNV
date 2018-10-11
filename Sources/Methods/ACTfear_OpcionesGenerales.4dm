//%attributes = {}
  //ACTfear_OpcionesGenerales
C_TEXT:C284($vt_accion;$1;$vt_nombrePref;$0;$t_retorno)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2)
C_LONGINT:C283($l_offSet)
C_BLOB:C604($xBlob)
C_REAL:C285($r_idRS)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

If (<>gCountryCode="ar")  //20150709 RCH
	Case of 
		: ($vt_accion="CargaConf")
			C_LONGINT:C283(cs_ambienteHomologacion)
			C_REAL:C285(vrACT_PuntoDeVenta)
			C_TEXT:C284(vtACT_rutaCertificado;vtACT_rutaLLavePrivada;vtACT_passLLavePrivada;vtACT_rutaScript;vtACT_workstation)
			C_TEXT:C284(<>tACT_URLHOMOLOGACION;<>tACT_URLPRODUCCION;<>tACT_URL_LOGIN_HOMOLOGACION;<>tACT_URL_LOGIN_PRODUCCION)
			C_TEXT:C284(vtACT_errorPHPExec)
			C_TEXT:C284(vtACT_CUIT)
			
			C_TEXT:C284(vtACT_rutaCertificadoORG;vtACT_rutaLLavePrivadaORG;vtACT_passLLavePrivadaORG;vtACT_CUIT)
			
			  //20161202 RCH
			C_TEXT:C284($tACT_URLHOMOLOGACION;$tACT_URLPRODUCCION)
			$tACT_URLHOMOLOGACION:="https://wswhomo.afip.gov.ar/wsfev1/service.asmx"
			$tACT_URLPRODUCCION:="https://servicios1.afip.gov.ar/wsfev1/service.asmx"
			
			$r_idRS:=$vy_pointer1->
			
			  //<>tACT_URLHOMOLOGACION:="https://wswhomo.afip.gov.ar/wsfev1/service.asmx"
			  //<>tACT_URLPRODUCCION:="https://servicios1.afip.gov.ar/wsfev1/service.asmx"
			<>tACT_URLHOMOLOGACION:=$tACT_URLHOMOLOGACION
			<>tACT_URLPRODUCCION:=$tACT_URLPRODUCCION
			
			<>tACT_URL_LOGIN_HOMOLOGACION:="https://wsaahomo.afip.gov.ar/ws/services/LoginCms"
			<>tACT_URL_LOGIN_PRODUCCION:="https://wsaa.afip.gov.ar/ws/services/LoginCms"
			
			vtACT_rutaCertificado:=""
			vtACT_rutaLLavePrivada:=""
			vtACT_passLLavePrivada:=""
			vtACT_rutaScript:=""
			vrACT_PuntoDeVenta:=0
			cs_ambienteHomologacion:=1
			vtACT_workstation:=""
			vtACT_errorPHPExec:=""
			vtACT_CUIT:=""
			cs_asignarFolio:=1  //SE ASIGNAN NUMEROS PARA AR
			ACTfear_OpcionesGenerales ("armaBlob";->$xBlob)
			
			$xBlob:=PREF_fGetBlob (0;"ACT_PREFERENCIAS_FE_AR_IDRS_"+String:C10($r_idRS);$xBlob)
			
			ACTfear_OpcionesGenerales ("desarmaBlob";->$xBlob)
			vtACT_rutaCertificadoORG:=vtACT_rutaCertificado
			vtACT_rutaLLavePrivadaORG:=vtACT_rutaLLavePrivada
			vtACT_passLLavePrivadaORG:=vtACT_passLLavePrivada
			
			If (<>tACT_URLHOMOLOGACION="")
				<>tACT_URLHOMOLOGACION:=$tACT_URLHOMOLOGACION
			End if 
			If (<>tACT_URLPRODUCCION="")
				<>tACT_URLPRODUCCION:=$tACT_URLPRODUCCION
			End if 
			
			$t_nomPrefH:=ACTfear_OpcionesGenerales ("NombrePreferenciaHomologacion";->$r_idRS)
			
			cs_ambienteHomologacion:=Num:C11(PREF_fGet (0;$t_nomPrefH;String:C10(cs_ambienteHomologacion)))
			
			ACTfear_OpcionesGenerales ("ValidaConsumoWS")
			
		: ($vt_accion="ValidaConsumoWS")
			
			C_TEXT:C284($t_rutaExtras;$t_rutaScriptPHP;$t_dirCert;$t_dirKey)
			  // Modificado por: Saúl Ponce (07-03-2017) Ticket Nº 176499, la ruta del script cambió con el cambio de rutas
			  // $t_rutaExtras:=Get 4D folder(_O_Extras folder)
			  // $t_rutaScriptPHP:=$t_rutaExtras+"ResourcesACT"+Folder separator+"FEAR"+Folder separator+"SCRIPT_FE_AR.php"
			$t_rutaScriptPHP:=ACTfear_OpcionesGenerales ("ObtieneRutaScriptPHP")
			
			If (vtACT_rutaCertificado#"")
				$t_dirCert:=SYS_GetParentNme (vtACT_rutaCertificado)
			End if 
			If (vtACT_rutaLLavePrivada#"")
				$t_dirKey:=SYS_GetParentNme (vtACT_rutaLLavePrivada)
			End if 
			
			vtACT_errorPHPExec:=""
			Case of 
				: (vtACT_CUIT="")
					vtACT_errorPHPExec:="La CUIT no ha sido ingresada."
				: (vtACT_rutaCertificado="")
					vtACT_errorPHPExec:="El certificado no ha sido configurado."
				: (vtACT_rutaLLavePrivada="")
					vtACT_errorPHPExec:="El archivo con la clave privada no ha sido configurado."
				: (Test path name:C476(vtACT_rutaCertificado)#Is a document:K24:1)
					vtACT_errorPHPExec:="El certificado no fue encontrado en la ruta configurada."
				: (Test path name:C476(vtACT_rutaLLavePrivada)#Is a document:K24:1)
					vtACT_errorPHPExec:="El archivo con la llave privada no fue encontrado en la ruta configurada."
				: ($t_dirCert#$t_dirKey)
					vtACT_errorPHPExec:="El certificado y la llave deben estar en el mismo directorio."
				: (Test path name:C476($t_rutaScriptPHP)#Is a document:K24:1)
					vtACT_errorPHPExec:="No fue posible encontrar la ruta al script."
			End case 
			
		: ($vt_accion="armaBlob")
			$l_offSet:=BLOB_Variables2Blob ($vy_pointer1;0;-><>tACT_URLHOMOLOGACION;-><>tACT_URLPRODUCCION;->vtACT_rutaCertificado;->vtACT_rutaLLavePrivada;->vtACT_passLLavePrivada;->vtACT_rutaScript;->vrACT_PuntoDeVenta;->cs_ambienteHomologacion;->vtACT_workstation;->vtACT_CUIT)
			
		: ($vt_accion="desarmaBlob")
			$l_offSet:=BLOB_Blob2Vars ($vy_pointer1;0;-><>tACT_URLHOMOLOGACION;-><>tACT_URLPRODUCCION;->vtACT_rutaCertificado;->vtACT_rutaLLavePrivada;->vtACT_passLLavePrivada;->vtACT_rutaScript;->vrACT_PuntoDeVenta;->cs_ambienteHomologacion;->vtACT_workstation;->vtACT_CUIT)
			
		: ($vt_accion="GuardaBlob")
			$r_idRS:=$vy_pointer1->
			$t_nomPrefH:=ACTfear_OpcionesGenerales ("NombrePreferenciaHomologacion";->$r_idRS)
			
			  //si cambia algun dato, regenero el archivo PHP a ejecutar
			If ((vtACT_rutaCertificadoORG#vtACT_rutaCertificado) | (vtACT_rutaLLavePrivadaORG#vtACT_rutaLLavePrivada) | (vtACT_passLLavePrivadaORG#vtACT_passLLavePrivada))
				vtACT_rutaScript:=""
				ACTfear_OpcionesGenerales ("ValidaConsumoWS")
				
				C_TEXT:C284($t_rutaScriptPHP)
				  // Modificado por: Saúl Ponce (07-03-2017) Ticket Nº 176499, la ruta del script cambió con el cambio de rutas
				  // $t_rutaScriptPHP:=Get 4D folder(_O_Extras folder)+"ResourcesACT"+SYS_FolderDelimiter +"FEAR"+SYS_FolderDelimiter +"SCRIPT_FE_AR.php"
				$t_rutaScriptPHP:=ACTfear_OpcionesGenerales ("ObtieneRutaScriptPHP")
				
				If (vtACT_errorPHPExec="")
					DOCUMENT TO BLOB:C525($t_rutaScriptPHP;$xBlob)
					$t_script:=Convert to text:C1012($xBlob;"UTF-8")
					$t_script:=Replace string:C233($t_script;"ACT_RUTACERTIFICADO";SYS_Path2FileName (vtACT_rutaCertificado))
					$t_script:=Replace string:C233($t_script;"ACT_RUTALLAVEPRIVADA";SYS_Path2FileName (vtACT_rutaLLavePrivada))
					$t_script:=Replace string:C233($t_script;"ACT_PALABRACLAVE";vtACT_passLLavePrivada)
					$t_script:=Replace string:C233($t_script;"ACT_SERVICIO";"wsfe")
					
					  //vtACT_rutaScript:=SYS_GetParentNme (vtACT_rutaCertificado)+"scriptPHP.php"
					vtACT_rutaScript:=SYS_GetParentNme (vtACT_rutaCertificado)+"scriptPHP"+String:C10($r_idRS)+".php"  //20161220 RCH
					CONVERT FROM TEXT:C1011($t_script;"UTF-8";$xBlob)
					BLOB TO DOCUMENT:C526(vtACT_rutaScript;$xBlob)
				End if 
				
			End if 
			
			ACTfear_OpcionesGenerales ("armaBlob";->$xBlob)
			PREF_SetBlob (0;"ACT_PREFERENCIAS_FE_AR_IDRS_"+String:C10($r_idRS);$xBlob)
			PREF_Set (0;$t_nomPrefH;String:C10(cs_ambienteHomologacion))
			
			
		: ($vt_accion="SetObjetosConf")
			OBJECT SET FONT:C164(vtACT_passLLavePrivada;"%Password")
			OBJECT SET VISIBLE:C603(*;"vt_TRA";False:C215)
			
		: ($vt_accion="ObtieneNombrePreferencia")
			C_LONGINT:C283($l_idRS)
			C_TEXT:C284($t_ws)
			$l_idRS:=$vy_pointer1->
			$t_ws:=$vy_pointer2->
			$t_retorno:="ACT_WS_DTE_AR_loginCms_IDRS_"+String:C10($l_idRS)+"_Service_"+$t_ws
			
		: ($vt_accion="NombrePreferenciaHomologacion")
			C_LONGINT:C283($l_idRS)
			$l_idRS:=$vy_pointer1->
			$t_retorno:="ACT_FE_AR_AMBIENTEHOMOLOGACION_"+String:C10($l_idRS)
			
		: ($vt_accion="ValidaFechaEmision")
			$t_retorno:="1"
			If ($vy_pointer1->#!00-00-00!)
				If ((<>gCountryCode="ar") & (cs_emitirCFDI=1))
					C_LONGINT:C283($l_records)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>$vy_pointer1->;*)
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215;*)
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($l_records>0)
						CD_Dlog (0;__ ("No es posible emitir un documento digital para una fecha anterior a algún documento digital ya emitido."+"\r\r"+"Ya existe al menos un documento emitido con fecha superior a la seleccionada."))
						$t_retorno:="0"
					End if 
				End if 
			Else 
				CD_Dlog (0;__ ("La fecha ingresada no es válida."))
				$t_retorno:="0"
			End if 
			
		: ($vt_accion="ObtieneRutaScriptPHP")
			  // Modificado por: Saúl Ponce (07-03-2017) Ticket Nº 176499, añadí el caso para obtener la nueva ruta del archivo PHP
			$t_retorno:=Get 4D folder:C485(Current resources folder:K5:16)+"ResourcesACT"+Folder separator:K24:12+"FEAR"+Folder separator:K24:12+"SCRIPT_FE_AR.php"
			
	End case 
Else 
	$t_retorno:="1"
End if 

$0:=$t_retorno