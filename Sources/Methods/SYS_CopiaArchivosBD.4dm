//%attributes = {}
  // SYS_CopiaArchivosBD()
  // Por: Alberto Bachler K.: 04-10-14, 17:49:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($0)

C_LONGINT:C283($l_idProceso;$l_idProcesoAvance)
C_REAL:C285($r_libreVolumen;$r_tamañoBD;$r_tamañoVolumen;$r_usadoEnVolumen)
C_TEXT:C284($t_carpetaDestino;$t_nombreArchivoCopia;$t_nombreArchivoDatos;$t_RutaArchivoCopia;$t_rutaArchivoDatos;$t_rutaCarpetaDatos)


If (False:C215)
	C_TEXT:C284(SYS_CopiaArchivosBD ;$1)
End if 

$t_carpetaDestino:=$1
$t_nombreArchivoDatos:=SYS_Path2FileName (Data file:C490)
$t_nombreArchivoDatos:=Substring:C12($t_nombreArchivoDatos;1;Length:C16($t_nombreArchivoDatos)-4)


If (Application type:C494=4D Remote mode:K5:5)
	SYS_TamañoBD_y_Disco (->$r_tamañoBD;->$r_tamañoVolumen;->$r_usadoEnVolumen;->$r_libreVolumen)
	If ($r_libreVolumen>($r_tamañoBD*4))
		$l_idProceso:=Execute on server:C373("SYS_CopyDataFile";Pila_256K;"Respaldo de la base de datos";$t_carpetaDestino;$t_nombreArchivoCopia)
		$l_idProcesoAvance:=IT_UThermometer (1;0;__ ("Respaldando la base de datos..."))
		DELAY PROCESS:C323(Current process:C322;60)
		While (Semaphore:C143("Copiando base de datos"))
			DELAY PROCESS:C323(Current process:C322;15)
		End while 
		CLEAR SEMAPHORE:C144("Copiando base de datos")
		$l_idProcesoAvance:=IT_UThermometer (-2;$l_idProcesoAvance)
	Else 
		CD_Dlog (0;__ ("No hay espacio disponible para copiar la base de datos"))
	End if 
	
Else 
	If (Not:C34(Semaphore:C143("Copiando base de datos")))
		SYS_TamañoBD_y_Disco (->$r_tamañoBD;->$r_tamañoVolumen;->$r_usadoEnVolumen;->$r_libreVolumen)
		SYS_CreatePath ($t_carpetaDestino)
		
		If ($r_libreVolumen>($r_tamañoBD*4))  //verificacion de disponibilidad de espacio en disco
			$l_idProcesoAvance:=IT_UThermometer (1;0;__ ("Copiando la base de datos..."))
			$t_rutaArchivoDatos:=Data file:C490
			$t_rutaCarpetaDatos:=SYS_GetServerProperty (XS_DataFileFolder)
			$t_rutaArchivoDatos:=$t_rutaCarpetaDatos+$t_nombreArchivoDatos+".4DD"
			$t_RutaArchivoCopia:=$t_carpetaDestino+Folder separator:K24:12+$t_nombreArchivoDatos+".4DD"
			COPY DOCUMENT:C541($t_rutaArchivoDatos;$t_RutaArchivoCopia;*)
			$t_rutaArchivoDatos:=$t_rutaCarpetaDatos+$t_nombreArchivoDatos+".4Dindx"
			$t_RutaArchivoCopia:=$t_carpetaDestino+Folder separator:K24:12+$t_nombreArchivoDatos+".4Dindx"
			COPY DOCUMENT:C541($t_rutaArchivoDatos;$t_RutaArchivoCopia;*)
			$t_rutaArchivoDatos:=$t_rutaCarpetaDatos+$t_nombreArchivoDatos+".Match"
			$t_RutaArchivoCopia:=$t_carpetaDestino+Folder separator:K24:12+$t_nombreArchivoDatos+".Match"
			COPY DOCUMENT:C541($t_rutaArchivoDatos;$t_RutaArchivoCopia;*)
			$t_rutaArchivoDatos:=$t_rutaCarpetaDatos+$t_nombreArchivoDatos+".count"
			$t_RutaArchivoCopia:=$t_carpetaDestino+Folder separator:K24:12+$t_nombreArchivoDatos+".count"
			COPY DOCUMENT:C541($t_rutaArchivoDatos;$t_RutaArchivoCopia;*)
			DELAY PROCESS:C323(Current process:C322;60)
			$l_idProcesoAvance:=IT_UThermometer (-2;$l_idProcesoAvance)
		Else 
			<>vtBKP_ErrorString:="Espacio en disco insuficiente: "+String:C10($r_tamañoBD*4)+"Mb requeridos, "+String:C10($r_libreVolumen)+"Mb disponibles."
			LOG_RegisterEvt ("ERROR. No fue posible respaldar la base de datos: "+<>vtBKP_ErrorString)
		End if 
	End if 
	
End if 

