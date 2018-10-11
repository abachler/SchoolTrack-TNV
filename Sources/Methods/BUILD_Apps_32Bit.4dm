//%attributes = {}
  // BUILD_GenerateApps_32Bit()
  // 
  //
  // creado por: Alberto Bachler Klein: 21-08-16, 10:35:31
  // -----------------------------------------------------------
C_LONGINT:C283($i_licencias;$i_tags;$l_idProceso;$l_nuevoBuildNumber)
C_TIME:C306($h_referencia)
C_TEXT:C284($t_bloqueLicencias;$t_carpetaLicenciasActiva;$t_carpetaLicenciasOEM;$t_etiqueta;$t_rutaDestino;$t_rutaDocumento;$t_rutaEstructura;$t_rutaOrigen;$t_rutaGeneracionCS;$t_ScriptGeneracion)
C_TEXT:C284($t_valorEtiqueta;$t_version;$t_versionLarga)

ARRAY TEXT:C222($at_BloqueLicencias;0)
ARRAY TEXT:C222($at_nombresDocumentos;0)
ARRAY TEXT:C222($at_rutaDocumentos;0)
ARRAY TEXT:C222($at_valoresEtiquetas;0)

If (SYS_IsMacintosh )
	$t_rutaGeneracionCS:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppCSMac32.xml"
	$t_rutaGeneracionMono:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppMonoMac32.xml"
Else 
	$t_rutaGeneracionCS:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppCSWin32.xml"
	$t_rutaGeneracionMono:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppMonoWin32.xml"
End if 

$t_rutaEstructura:=Get 4D folder:C485(Database folder:K5:14)

  //defino los pares tags/valores
$t_version:=(OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Completa"))->
$l_nuevoBuildNumber:=(OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Build"))->
  //$t_version:=SYS_LeeVersionEstructura 
  //$t_version:=SYS_LeeVersionEstructura ("build";->$l_nuevoBuildNumber)
$t_versionLarga:=$t_version+", ©Colegium 2000-2017"
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%version%;"+$t_version)
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%VersionLongString%;"+$t_versionLarga)
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%PrivateBuild%;"+String:C10($l_nuevoBuildNumber))
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%SpecialBuild%;"+String:C10($l_nuevoBuildNumber))


  //abro el archivo BuildApp.xml para procesar los tags
$t_ScriptGeneracionCS:=Document to text:C1236($t_rutaGeneracionCS)
$t_ScriptGeneracionMono:=Document to text:C1236($t_rutaGeneracionMono)

  //reemplazo los tags por valores y guardo el archivo
For ($i_tags;1;Size of array:C274($at_valoresEtiquetas))
	$t_etiqueta:=ST_GetWord ($at_valoresEtiquetas{$i_tags};1;";")
	$t_valorEtiqueta:=ST_GetWord ($at_valoresEtiquetas{$i_tags};2;";")
	$t_ScriptGeneracionCS:=Replace string:C233($t_ScriptGeneracionCS;$t_etiqueta;$t_valorEtiqueta)
	$t_ScriptGeneracionMono:=Replace string:C233($t_ScriptGeneracionMono;$t_etiqueta;$t_valorEtiqueta)
End for 

  //Creo una copia del archivo XML con los tags reemplazados por valores
Case of 
	: (SYS_IsMacintosh )
		$t_rutaGeneracionCS:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppCSMac32.xml"
		$t_rutaGeneracionMono:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppMonoMac32.xml"
	: (SYS_IsWindows )
		$t_rutaGeneracionCS:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppCSWin32.xml"
		$t_rutaGeneracionMono:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppCSMono32.xml"
End case 
CREATE FOLDER:C475($t_rutaGeneracionCS;*)
TEXT TO DOCUMENT:C1237($t_rutaGeneracionCS;$t_ScriptGeneracionCS)
TEXT TO DOCUMENT:C1237($t_rutaGeneracionMono;$t_ScriptGeneracionMono)



  // ********* GENERACION DE LA APLICACION MONOUSUARIO ********* 
$l_idProceso:=IT_UThermometer (1;0;__ ("Preparando aplicación monousuario 32-bit ...");-5)
  // Copio las carpetas Config y Carpeta Web a la carpeta de Database antes de generar la aplicación monousuario y poder así firmarla para macOS
Case of 
	: (SYS_IsMacintosh )
		  //copio la carpeta "Config" a la aplicación Cliente Servidor generada
		$t_rutaOrigen:=$t_rutaEstructura+"Config"
		$t_rutaDestinoConfig:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Volume Desktop 32-bit.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Config"
		SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoConfig)
		$b_valido:=Test path name:C476($t_rutaDestinoConfig)
		
		  //copio la carpeta "Carpeta Web" a la aplicación Cliente Servidor generada
		$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
		$t_rutaDestinoWeb:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Volume Desktop 32-bit.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Carpeta Web"
		SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoWeb)
		$b_valido:=Test path name:C476($t_rutaDestinoWeb)
		
		$t_rutaOrigenPropiedadesXML:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"settings.4DSettings"
		$t_rutaDestinoPropiedadesXML:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Volume Desktop 32-bit.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Preferences"+Folder separator:K24:12+"settings.4DSettings"
		CREATE FOLDER:C475($t_rutaDestinoPropiedadesXML;*)
		If (Test path name:C476($t_rutaDestinoPropiedadesXML)=Is a document:K24:1)
			DELETE DOCUMENT:C159($t_rutaDestinoPropiedadesXML)
		End if 
		COPY DOCUMENT:C541($t_rutaOrigenPropiedadesXML;$t_rutaDestinoPropiedadesXML)
		
	: (SYS_IsWindows )
		  //copio la carpeta "Config" a la aplicación Cliente Servidor generada
		$t_rutaOrigen:=$t_rutaEstructura+"Config"
		$t_rutaDestinoConfig:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Volume Desktop 32-bit"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Config"
		SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoConfig)
		$b_valido:=Test path name:C476($t_rutaDestinoConfig)
		
		  //copio la carpeta "Carpeta Web" a la aplicación Cliente Servidor generada
		$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
		$t_rutaDestinoWeb:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Volume Desktop 32-bit"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Carpeta Web"
		SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoWeb)
		$b_valido:=Test path name:C476($t_rutaDestinoWeb)
		
		$t_rutaOrigenPropiedadesXML:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"settings.4DSettings"
		$t_rutaDestinoPropiedadesXML:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Volume Desktop 32-bit"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Preferences"+Folder separator:K24:12+"settings.4DSettings"
		CREATE FOLDER:C475($t_rutaDestinoPropiedadesXML;*)
		If (Test path name:C476($t_rutaDestinoPropiedadesXML)=Is a document:K24:1)
			DELETE DOCUMENT:C159($t_rutaDestinoPropiedadesXML)
		End if 
		COPY DOCUMENT:C541($t_rutaOrigenPropiedadesXML;$t_rutaDestinoPropiedadesXML)
		
End case 
IT_UThermometer (-2;$l_idProceso)

  // genero la aplicación monousuario
MESSAGES ON:C181
$l_idProceso:=IT_UThermometer (1;0;__ ("Generando aplicaciones monousuario 32 bit...");-5)
BUILD APPLICATION:C871($t_rutaGeneracionMono)
$b_GeneracionOK:=(OK=1)
IT_UThermometer (-2;$l_idProceso)
MESSAGES OFF:C175

If ($b_GeneracionOK)
	DELETE FOLDER:C693($t_rutaDestinoWeb;Delete with contents:K24:24)  // elimino la carpeta Carpeta Web de la aplicacion "fuente" 4D Volume Desktop
	DELETE FOLDER:C693($t_rutaDestinoConfig;Delete with contents:K24:24)  // elimino la carpeta Config de la aplicacion "fuente" 4D Volume Desktop
	
	
	
	
	  // ********* GENERACION DE LAS APLICACIONES CLIENTE SERVIDOR ********* 
	$l_idProceso:=IT_UThermometer (1;0;__ ("Preparando aplicaciones cliente servidor 32-bit ...");-5)
	
	  // Copio las carpetas Config y Carpeta Web a la carpeta de Server Database antes de generar la aplicación servidor y poder así firmarla para macOS
	Case of 
		: (SYS_IsMacintosh )
			  //copio la carpeta "Config" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Config"
			$t_rutaDestinoConfig:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Server 32-bit.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Config"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoConfig)
			$b_valido:=Test path name:C476($t_rutaDestinoConfig)
			
			  //copio la carpeta "Carpeta Web" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
			$t_rutaDestinoWeb:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Server 32-bit.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Carpeta Web"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoWeb)
			$b_valido:=Test path name:C476($t_rutaDestinoWeb)
			
			
		: (SYS_IsWindows )
			  //copio la carpeta "Config" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Config"
			$t_rutaDestinoConfig:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Server 32-bit"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Config"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoConfig)
			$b_valido:=Test path name:C476($t_rutaDestinoConfig)
			
			  //copio la carpeta "Carpeta Web" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
			$t_rutaDestinoWeb:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"4D"+Folder separator:K24:12+"4D Server 32-bit"+Folder separator:K24:12+"Server database"+Folder separator:K24:12+"Carpeta Web"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestinoWeb)
			$b_valido:=Test path name:C476($t_rutaDestinoWeb)
	End case 
	$l_idProceso:=IT_UThermometer (-2;$l_idProceso)
	
	
	  // Genero las aplicaciones servidor y clientes 32 bits
	MESSAGES ON:C181
	$l_idProceso:=IT_UThermometer (1;0;__ ("Generando aplicaciones cliente servidor 32 bit...");-5)
	BUILD APPLICATION:C871($t_rutaGeneracionCS)
	$b_GeneracionOK:=(OK=1)  //20170705 RCH
	IT_UThermometer (-2;$l_idProceso)
	DELETE FOLDER:C693($t_rutaDestinoWeb;Delete with contents:K24:24)  // elimino la carpeta Carpeta Web de la aplicacion "fuente" 4D Server
	DELETE FOLDER:C693($t_rutaDestinoConfig;Delete with contents:K24:24)  // elimino la carpeta Config de la aplicacion "fuente" 4D Server
	MESSAGES OFF:C175
	If (Not:C34($b_GeneracionOK))
		OK:=0
	End if 
	  // generacion server 32 terminada,
End if 



$0:=OK





