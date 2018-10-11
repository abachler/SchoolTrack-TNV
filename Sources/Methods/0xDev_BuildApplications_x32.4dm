//%attributes = {}
  // 0xDev_BuildApplications_v14()
  // Por: Alberto Bachler K.: 14-01-14, 07:16:19
  //  ---------------------------------------------
  //   // 0xDev_BuildApplications_v14()
  // Por: Alberto Bachler K.: 10-01-14, 19:15:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_licencias;$i_tags;$l_idProceso;$l_nuevoBuildNumber)
C_TIME:C306($h_referencia)
C_TEXT:C284($t_bloqueLicencias;$t_carpetaLicenciasActiva;$t_carpetaLicenciasOEM;$t_etiqueta;$t_rutaDestino;$t_rutaDocumento;$t_rutaEstructura;$t_rutaOrigen;$t_rutaScriptGeneracion;$t_ScriptGeneracion)
C_TEXT:C284($t_valorEtiqueta;$t_version;$t_versionLarga)

ARRAY TEXT:C222($at_BloqueLicencias;0)
ARRAY TEXT:C222($at_nombresDocumentos;0)
ARRAY TEXT:C222($at_rutaDocumentos;0)
ARRAY TEXT:C222($at_valoresEtiquetas;0)

If (SYS_IsMacintosh )
	$t_rutaScriptGeneracion:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppMac_v15.xml"
Else 
	$t_rutaScriptGeneracion:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppWin_v15.xml"
End if 

  //Creo el bloque xml de licencias
  // si las licencias no están instaladas en la carpeta de licencias activas las copio (deben estar imperativamente ahí)
$t_carpetaLicenciasOEM:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"Licenses"
DOCUMENT LIST:C474($t_carpetaLicenciasOEM;$at_nombresDocumentos;Ignore invisible:K24:16)
DOCUMENT LIST:C474($t_carpetaLicenciasOEM;$at_rutaDocumentos;Absolute path:K24:14+Ignore invisible:K24:16)
APPEND TO ARRAY:C911($at_BloqueLicencias;"<ItemsCount>"+String:C10(Size of array:C274($at_nombresDocumentos))+"</ItemsCount>")
$t_carpetaLicenciasActiva:=Get 4D folder:C485(Licenses folder:K5:11)
For ($i_licencias;1;Size of array:C274($at_nombresDocumentos))
	$t_rutaDocumento:=$t_carpetaLicenciasActiva+$at_nombresDocumentos{$i_licencias}
	If (Test path name:C476($t_rutaDocumento)#Is a document:K24:1)
		COPY DOCUMENT:C541($at_rutaDocumentos{$i_licencias};$t_rutaDocumento)
	End if 
	APPEND TO ARRAY:C911($at_BloqueLicencias;"<Item"+String:C10($i_licencias)+">"+$t_rutaDocumento+"</Item"+String:C10($i_licencias)+">")
End for 
$t_bloqueLicencias:=AT_array2text (->$at_BloqueLicencias;"\r")


  //defino los pares tags/valores
$t_version:=SYS_LeeVersionEstructura 
$t_version:=SYS_LeeVersionEstructura ("build";->$l_nuevoBuildNumber)
$t_versionLarga:=$t_version+", ©Colegium 2000-2010"
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%version%;"+$t_version)
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%VersionLongString%;"+$t_versionLarga)
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%PrivateBuild%;"+String:C10($l_nuevoBuildNumber))
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%SpecialBuild%;"+String:C10($l_nuevoBuildNumber))
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%licencias%;"+$t_bloqueLicencias)


  //abro el archivo BuildApp.xml para procesar los tags
$h_referencia:=Open document:C264($t_rutaScriptGeneracion)
RECEIVE PACKET:C104($h_referencia;$t_ScriptGeneracion;32000)
CLOSE DOCUMENT:C267($h_referencia)

  //reemplazo los tags por valores y guardo el archivo
For ($i_tags;1;Size of array:C274($at_valoresEtiquetas))
	$t_etiqueta:=ST_GetWord ($at_valoresEtiquetas{$i_tags};1;";")
	$t_valorEtiqueta:=ST_GetWord ($at_valoresEtiquetas{$i_tags};2;";")
	$t_ScriptGeneracion:=Replace string:C233($t_ScriptGeneracion;$t_etiqueta;$t_valorEtiqueta)
End for 

  //Creo una copia del archivo XML con los tags reemplazados por valores
Case of 
	: (SYS_IsMacintosh )
		$t_rutaScriptGeneracion:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppMac.xml"
	: (SYS_IsWindows )
		$t_rutaScriptGeneracion:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppWin.xml"
End case 
$h_referencia:=Create document:C266($t_rutaScriptGeneracion)
SEND PACKET:C103($h_referencia;$t_ScriptGeneracion)
CLOSE DOCUMENT:C267($h_referencia)





  // servidor y clientes 32 bits
MESSAGES ON:C181
$l_idProceso:=IT_UThermometer (1;0;__ ("Generando aplicaciones..."))
BUILD APPLICATION:C871($t_rutaScriptGeneracion)
IT_UThermometer (-2;$l_idProceso)
MESSAGES OFF:C175

If (OK=1)
	$l_idProceso:=IT_UThermometer (1;0;__ ("Copiando archivos de la aplicación..."))
	$t_rutaEstructura:=Get 4D folder:C485(Database folder:K5:14)
	
	Case of 
		: (SYS_IsMacintosh )
			
			  //20160422 ASM Ticket 159316 
			  //copio cert.pem y key.pem
			  //$t_rutaOrigen:=$t_rutaEstructura+"cert.pem"
			  //$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator+"Aplicaciones"+Folder separator+"Client Server executable"+Folder separator+"SchoolTrack 11 Server.app"+Folder separator+"Contents"+Folder separator+"cert.pem"
			  //COPY DOCUMENT($t_rutaOrigen;$t_rutaDestino;*)
			
			  //$t_rutaOrigen:=$t_rutaEstructura+"key.pem"
			  //$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator+"Aplicaciones"+Folder separator+"Client Server executable"+Folder separator+"SchoolTrack 11 Server.app"+Folder separator+"Contents"+Folder separator+"key.pem"
			  //COPY DOCUMENT($t_rutaOrigen;$t_rutaDestino;*)
			
			  //copio la carpeta "Config" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Config"
			$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+"SchoolTrack 12 Server.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Config"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
			
			  //copio la carpeta "Carpeta Web" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
			$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+"SchoolTrack 12 Server.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Carpeta Web"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
			
			  //copio la carpeta "Config" a la aplicación Runtime generada
			$t_rutaOrigen:=$t_rutaEstructura+"Config"
			$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final Application"+Folder separator:K24:12+"SchoolTrack 12.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Config"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
			
			  //copio la carpeta "Carpeta Web" a la aplicación Runtime generada
			$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
			$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final Application"+Folder separator:K24:12+"SchoolTrack 12.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Carpeta Web"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
			
			
		: (SYS_IsWindows )
			
			  //20160422 ASM Ticket 159316 
			  //copio cert.pem y key.pem
			  //$t_rutaOrigen:=$t_rutaEstructura+"cert.pem"
			  //$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator+"Aplicaciones"+Folder separator+"Client Server executable"+Folder separator+"SchoolTrack 11 Server"+Folder separator+"cert.pem"
			  //COPY DOCUMENT($t_rutaOrigen;$t_rutaDestino;*)
			  //
			  //$t_rutaOrigen:=$t_rutaEstructura+"key.pem"
			  //$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator+"Aplicaciones"+Folder separator+"Client Server executable"+Folder separator+"SchoolTrack 11 Server"+Folder separator+"key.pem"
			  //COPY DOCUMENT($t_rutaOrigen;$t_rutaDestino;*)
			
			  //copio la carpeta "Config" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Config"
			$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+"SchoolTrack 12 Server"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Config"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
			
			  //copio la carpeta "Carpeta Web" a la aplicación Cliente Servidor generada
			$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
			$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+"SchoolTrack 12 Server"+Folder separator:K24:12+"Server Database"+Folder separator:K24:12+"Carpeta Web"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
			
			  //copio la carpeta "Config" a la aplicación Runtime generada
			$t_rutaOrigen:=$t_rutaEstructura+"Config"
			$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final Application"+Folder separator:K24:12+"SchoolTrack 12"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Config"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
			
			  //copio la carpeta "Carpeta Web" a la aplicación Runtime generada
			$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
			$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final Application"+Folder separator:K24:12+"SchoolTrack 12"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Carpeta Web"
			SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
			
	End case 
	$l_idProceso:=IT_UThermometer (-2;$l_idProceso;__ ("Copiando archivos de la aplicación..."))
End if 

$0:=OK





