//%attributes = {}
  // BUILD_GenerateApps_64Bit()
  // 
  //
  // creado por: Alberto Bachler Klein: 21-08-16, 10:36:11
  // -----------------------------------------------------------
C_LONGINT:C283($i_licencias;$i_tags;$l_idProceso;$l_nuevoBuildNumber;$l_version_BuildNumber;$l_version_Mayor;$l_version_Revision)
C_TIME:C306($h_referencia)
C_TEXT:C284($t_bloqueLicencias;$t_carpetaLicenciasActiva;$t_carpetaLicenciasOEM;$t_etiqueta;$t_rutaDestino;$t_rutaDocumento;$t_rutaEstructura;$t_rutaOrigen;$t_rutaScriptGeneracion;$t_ScriptGeneracion)
C_TEXT:C284($t_valorEtiqueta;$t_version;$t_version_Anterior;$t_version_DTSanterior;$t_version_SinBuild;$t_versionLarga)

ARRAY TEXT:C222($at_BloqueLicencias;0)
ARRAY TEXT:C222($at_nombresDocumentos;0)
ARRAY TEXT:C222($at_rutaDocumentos;0)
ARRAY TEXT:C222($at_valoresEtiquetas;0)



vsBWR_CurrentModule:="Colegium Systems"
GET PICTURE FROM LIBRARY:C565("Module SchoolTrack";vpXS_IconModule)
If (Application type:C494#4D Local mode:K5:1)
	CD_Dlog (0;__ ("La generación de aplicaciones sólo puede ser realizada en 4th Dimension."))
Else 
	$t_version_Anterior:=SYS_LeeVersionEstructura ("principal";->$l_version_Mayor)
	$t_version_Anterior:=SYS_LeeVersionEstructura ("revision";->$l_version_Revision)
	$t_version_Anterior:=SYS_LeeVersionEstructura ("build";->$l_version_BuildNumber)
	$t_version_Anterior:=SYS_LeeVersionEstructura ("dts";->$t_version_DTSanterior)
	$t_version_SinBuild:=String:C10($l_version_Mayor)+"."+String:C10($l_version_Revision)
	
	
	$t_rutaScriptGeneracion:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppWinServer64_Client32Win.xml"
	
	  //defino los pares tags/valores
	$t_version:=SYS_LeeVersionEstructura 
	$t_version:=SYS_LeeVersionEstructura ("build";->$l_nuevoBuildNumber)+" 64-bit"
	$t_versionLarga:=$t_version+", ©Colegium 2000-2017"
	APPEND TO ARRAY:C911($at_valoresEtiquetas;"%version%;"+$t_version)
	APPEND TO ARRAY:C911($at_valoresEtiquetas;"%VersionLongString%;"+$t_versionLarga)
	APPEND TO ARRAY:C911($at_valoresEtiquetas;"%PrivateBuild%;"+String:C10($l_nuevoBuildNumber))
	APPEND TO ARRAY:C911($at_valoresEtiquetas;"%SpecialBuild%;"+String:C10($l_nuevoBuildNumber))
	
	
	  //abro el archivo BuildApp.xml para procesar los tags
	$t_ScriptGeneracion:=Document to text:C1236($t_rutaScriptGeneracion)
	
	
	  //reemplazo los tags por valores y guardo el archivo
	For ($i_tags;1;Size of array:C274($at_valoresEtiquetas))
		$t_etiqueta:=ST_GetWord ($at_valoresEtiquetas{$i_tags};1;";")
		$t_valorEtiqueta:=ST_GetWord ($at_valoresEtiquetas{$i_tags};2;";")
		$t_ScriptGeneracion:=Replace string:C233($t_ScriptGeneracion;$t_etiqueta;$t_valorEtiqueta)
	End for 
	
	  //Creo una copia del archivo XML con los tags reemplazados por valores
	$t_rutaScriptGeneracion:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppWinServer64_Client32Win.xml"
	TEXT TO DOCUMENT:C1237($t_rutaScriptGeneracion;$t_ScriptGeneracion)
	
	
	
	  // Copio las carpetas Config y Carpeta Web a la carpeta de Server Database antes de generar la aplicación servidor y poder así firmarla para macOS
	$t_rutaEstructura:=Get 4D folder:C485(Database folder:K5:14)
	$l_idProceso:=IT_UThermometer (1;0;__ ("Preparando aplicaciones cliente servidor 64-bit ...");-5)
	Case of 
		: (SYS_IsMacintosh )
			If (False:C215)
				  //copio la carpeta "Config" a la aplicación Cliente Servidor generada
				$t_rutaOrigen:=$t_rutaEstructura+"Config"
				$t_rutaDestinoConfig:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Server 64-bit.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Config"
				SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoConfig)
				$b_valido:=Test path name:C476($t_rutaDestinoConfig)
				
				  //copio la carpeta "Carpeta Web" a la aplicación Cliente Servidor generada
				$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
				$t_rutaDestinoWeb:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Server 64-bit.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Carpeta Web"
				SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoWeb)
				$b_valido:=Test path name:C476($t_rutaDestinoWeb)
			End if 
			
		: (SYS_IsWindows )
			  //copio la carpeta "Config" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Config"
			$t_rutaDestinoConfig:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Server 64-bit"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Config"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoConfig)
			$b_valido:=Test path name:C476($t_rutaDestinoConfig)
			
			  //copio la carpeta "Carpeta Web" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
			$t_rutaDestinoWeb:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Server 64-bit"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Carpeta Web"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoWeb)
			$b_valido:=Test path name:C476($t_rutaDestinoWeb)
	End case 
	$l_idProceso:=IT_UThermometer (-2;$l_idProceso)
	
	  //genero la aplicaciones
	MESSAGES ON:C181
	$l_idProceso:=IT_UThermometer (1;0;__ ("Generando aplicaciones 64-bits...");-5)
	BUILD APPLICATION:C871($t_rutaScriptGeneracion)
	$b_GeneracionOK:=(OK=1)  //201707005 RCH
	IT_UThermometer (-2;$l_idProceso)
	DELETE FOLDER:C693($t_rutaDestinoWeb;Delete with contents:K24:24)  // elimino la carpeta Carpeta Web de la aplicacion "fuente" 4D Server
	DELETE FOLDER:C693($t_rutaDestinoConfig;Delete with contents:K24:24)  // elimino la carpeta Config de la aplicacion "fuente" 4D Server
	MESSAGES OFF:C175
	
	$t_rutaFalsoCliente64:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+"SchoolTrack 12 64-bit Client"
	DELETE FOLDER:C693($t_rutaFalsoCliente64;Delete with contents:K24:24)
	
	If (Not:C34($b_GeneracionOK))
		OK:=0
	End if 
End if 


$0:=OK


