//%attributes = {}
  // BUILD_GenerateApps_32Bit()
  // 
  //
  // creado por: Alberto Bachler Klein: 21-08-16, 10:35:31
  // -----------------------------------------------------------
C_LONGINT:C283($i_licencias;$i_tags;$l_idProceso;$l_nuevoBuildNumber)
C_TIME:C306($h_referencia)
C_TEXT:C284($t_bloqueLicencias;$t_carpetaLicenciasActiva;$t_carpetaLicenciasOEM;$t_etiqueta;$t_rutaDestino;$t_rutaDocumento;$t_rutaEstructura;$t_rutaOrigen;$t_rutaScriptGeneracion;$t_ScriptGeneracion)
C_TEXT:C284($t_valorEtiqueta;$t_version;$t_versionLarga)

ARRAY TEXT:C222($at_BloqueLicencias;0)
ARRAY TEXT:C222($at_nombresDocumentos;0)
ARRAY TEXT:C222($at_rutaDocumentos;0)
ARRAY TEXT:C222($at_valoresEtiquetas;0)


$t_rutaScriptGeneracion:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppWinMono64.xml"


  //defino los pares tags/valores
$t_version:=SYS_LeeVersionEstructura 
$t_version:=SYS_LeeVersionEstructura ("build";->$l_nuevoBuildNumber)
$t_versionLarga:=$t_version+", ©Colegium 2000-2017"
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%version%;"+$t_version)
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%VersionLongString%;"+$t_versionLarga)
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%PrivateBuild%;"+String:C10($l_nuevoBuildNumber))
APPEND TO ARRAY:C911($at_valoresEtiquetas;"%SpecialBuild%;"+String:C10($l_nuevoBuildNumber))
  //APPEND TO ARRAY($at_valoresEtiquetas;"%licencias%;"+$t_bloqueLicencias)


  //abro el archivo BuildApp.xml para procesar los tags
$t_ScriptGeneracion:=Document to text:C1236($t_rutaScriptGeneracion)


  //reemplazo los tags por valores y guardo el archivo
For ($i_tags;1;Size of array:C274($at_valoresEtiquetas))
	$t_etiqueta:=ST_GetWord ($at_valoresEtiquetas{$i_tags};1;";")
	$t_valorEtiqueta:=ST_GetWord ($at_valoresEtiquetas{$i_tags};2;";")
	$t_ScriptGeneracion:=Replace string:C233($t_ScriptGeneracion;$t_etiqueta;$t_valorEtiqueta)
End for 

  //Creo una copia del archivo XML con los tags reemplazados por valores
$t_rutaScriptGeneracion:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"BuildApp"+Folder separator:K24:12+"BuildAppWinMono64.xml"
TEXT TO DOCUMENT:C1237($t_rutaScriptGeneracion;$t_ScriptGeneracion)





  // servidor y clientes 32 bits
MESSAGES ON:C181
$l_idProceso:=IT_UThermometer (1;0;__ ("Generando aplicaciones...");-5)
BUILD APPLICATION:C871($t_rutaScriptGeneracion)
IT_UThermometer (-2;$l_idProceso)
MESSAGES OFF:C175

If (OK=1)
	$l_idProceso:=IT_UThermometer (1;0;__ ("Copiando archivos de la aplicación...");-5)
	$t_rutaEstructura:=Get 4D folder:C485(Database folder:K5:14)
	
	  //copio la carpeta "Config" a la aplicación Runtime generada
	$t_rutaOrigen:=$t_rutaEstructura+"Config"
	$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final Application"+Folder separator:K24:12+"SchoolTrack 12 64-bit"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Config"
	SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
	
	  //copio la carpeta "Carpeta Web" a la aplicación Runtime generada
	$t_rutaOrigen:=$t_rutaEstructura+"Carpeta Web"
	$t_rutaDestino:=$t_rutaEstructura+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final Application"+Folder separator:K24:12+"SchoolTrack 12 64-bit"+Folder separator:K24:12+"Database"+Folder separator:K24:12+"Carpeta Web"
	SYS_CopyFolder ($t_rutaOrigen;$t_rutaDestino)
	
	$l_idProceso:=IT_UThermometer (-2;$l_idProceso;__ ("Copiando archivos de la aplicación..."))
End if 

$0:=OK





