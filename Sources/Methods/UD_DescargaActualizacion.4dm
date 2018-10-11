//%attributes = {}
  // KRL_ActualizaAplicacion()
  // Por: Alberto Bachler: 11/07/13, 12:14:47
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_LONGINT:C283($0)
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_actualizarAgente;$b_actualizarAplicacion;$b_exito)
C_DATE:C307($d_FechaModificacionFTP)
C_LONGINT:C283($l_error;$l_IdConexion;$l_tamañoDescargado;$l_tamañoEnFTP)
C_TIME:C306($h_HoraModificacionFTP;$h_ref)
C_TEXT:C284($t_comando;$t_destinoAchivoAgente;$t_destinoArchivoActualizacion;$t_directorioDescargas;$t_DirectorioSchoolTrack;$t_error;$t_error7z;$t_errorEjecucion;$t_rutaActualizacion;$t_RutaAgente)
C_TEXT:C284($t_rutaAplicacion;$t_rutaAplicacionActual;$t_rutaArchivoActualizacion;$t_rutaBaseDatos;$t_rutaDestino;$t_rutaDocumentoActualización;$t_rutaEnFTP;$t_rutaOrigen;$t_rutaVersionAnterior;$t_textoRespuesta)
C_TEXT:C284($t_URL_AgenteInstalacion;$t_URL_archivoActualizacion)

ARRAY TEXT:C222($at_Ruta;0)

  // determino si hay actualizaciones de SchoolTrack
$b_actualizarAplicacion:=True:C214  // para pruebas - Reemplazar por llamado a Web Service
If ($b_actualizarAplicacion=False:C215)
	$l_error:=1
	$t_error:=__ ("La versión actual de SchoolTrack corresponde a la última actualización disponible.")
End if 


If ($b_actualizarAplicacion)
	  // determino si es necesario actualizar el agente
	$b_actualizarAgente:=True:C214  // para pruebas - Reemplazar por llamado a Web Service
	
	
	
	  //Preparación de directorios de descarga e instalacion
	Case of 
		: (SYS_IsWindows )
			$t_rutaAplicacion:=Application file:C491
			$t_rutaAplicacion:=SYS_GetParentNme ($t_rutaAplicacion)
			$t_DirectorioSchoolTrack:=SYS_GetParentNme ($t_rutaAplicacion)
			$t_RutaAgente:=$t_DirectorioSchoolTrack+"AgenteSchoolTrack"
			
		: (SYS_IsMacintosh )
			$t_rutaAplicacion:=Application file:C491
			$t_DirectorioSchoolTrack:=SYS_GetParentNme ($t_rutaAplicacion)
			$t_RutaAgente:=$t_DirectorioSchoolTrack+"AgenteSchoolTrack.app"
	End case 
	$t_directorioDescargas:=$t_DirectorioSchoolTrack+"Descargas"+Folder separator:K24:12
	$t_rutaVersionAnterior:=$t_DirectorioSchoolTrack+"VersionAnterior"+Folder separator:K24:12
	
	
	
	  // ****** PARA TEST FIJO EL DIRECTORIO DONDE SON  INSTALADAS LAS APLICACIONES POR DEFECTO ******
	$t_DirectorioSchoolTrack:=System folder:C487(Applications or program files:K41:17)+"SchoolTrack v11"+Folder separator:K24:12
	$t_rutaVersionAnterior:=System folder:C487(Applications or program files:K41:17)+"SchoolTrack v11"+Folder separator:K24:12+"VersionAnterior"+Folder separator:K24:12
	$t_directorioDescargas:=$t_DirectorioSchoolTrack+"Descargas"+Folder separator:K24:12
	Case of 
		: (SYS_IsMacintosh )
			$t_rutaAplicacion:=System folder:C487(Applications or program files:K41:17)+"SchoolTrack v11"+Folder separator:K24:12+"SchoolTrack 11 Server.app"
			$t_RutaAgente:=$t_DirectorioSchoolTrack+"AgenteSchoolTrack.app"
		: (SYS_IsWindows )
			$t_rutaAplicacion:=System folder:C487(Applications or program files:K41:17)+"SchoolTrack v11"+Folder separator:K24:12+"SchoolTrack 11 Server"
			$t_RutaAgente:=$t_DirectorioSchoolTrack+"AgenteSchoolTrack"
	End case 
	  // ******  FIN TESTS ******//
	
	
	
	  // establezco la URL del archivo que contiene el Agente y la ruta de destino de la descarga
	$t_URL_AgenteInstalacion:="/interno/desarrollo/abk/AgenteSchoolTrack.zip"
	$t_destinoAchivoAgente:=$t_directorioDescargas+"AgenteSchoolTrack.zip"
	
	
	
	  // establezco la URL del archivo que contiene la aplicación actualizada y la ruta de destino de la descarga
	$t_URL_archivoActualizacion:="/pub/SchoolTrack_v11/MacOS/SchoolTrack 11 Server_13226.zip"
	$t_destinoArchivoActualizacion:=$t_directorioDescargas+"SchoolTrackInstall.zip"
	
	
	
	  // creo los directorios para la descarga y para respaldar la versión actual
	SYS_CreateFolder ($t_rutaVersionAnterior)
	SYS_CreateFolder ($t_directorioDescargas)
	
	$b_exito:=True:C214
	If ($b_actualizarAgente)
		If (Test path name:C476($t_rutaAgente)=Is a folder:K24:2)
			  // Muevo la versión actual del Agente al directorio de respaldo VersionAnterior
			$t_rutaOrigen:=LEP_Escape_path ($t_RutaAgente)
			$t_rutaDestino:=LEP_Escape_path ($t_rutaVersionAnterior)
			$t_comando:="mv "+$t_rutaOrigen+" "+$t_rutaDestino
			$b_Exito:=LEP_EjecutaComando ($t_comando;->$t_errorEjecucion)
		End if 
		
		If ($b_exito)
			  //Descargo y descomprimo el agente en la carpeta Descargas
			$l_error:=FTP_Login ("ftp.colegium.com";"abachler";"gamine";$l_IdConexion;$t_textoRespuesta)
			$l_error:=FTP_GetFileInfo ($l_IdConexion;$t_URL_AgenteInstalacion;$l_tamañoEnFTP;$d_FechaModificacionFTP;$h_HoraModificacionFTP)
			$l_error:=FTP_Receive ($l_IdConexion;$t_URL_AgenteInstalacion;$t_destinoAchivoAgente;1)
			$l_error:=FTP_Logout ($l_IdConexion)
			$l_tamañoDescargado:=Get document size:C479($t_destinoAchivoAgente)
			$l_error:=(-3)*Num:C11($l_tamañoEnFTP#$l_tamañoDescargado)
			If ($l_error=0)
				  //$b_exito:=z7_Extract ($t_destinoAchivoAgente;$t_DirectorioSchoolTrack;"";->$t_error7z)
				If ($b_exito=False:C215)
					$t_error:=__ ("El archivo con el AgenteSchoolTrack no puedo se descomprimido.\r")
				End if 
			Else 
				$t_error:=__ ("El AgenteSchoolTrack no pudo ser descargado.\r ^0;";$t_error7z)
			End if 
		Else 
			$t_error:=__ ("La versión actual del AgenteSchoolTrack no pudo ser respaldada.\r ^0";$t_error7z)
		End if 
	End if 
	
	  // Descargo y descomprimo el archivo Aplicacion en la Carpeta Descargas
	If ($b_exito)
		If ($l_IdConexion=0)
			$l_error:=FTP_Login ("ftp.colegium.com";"abachler";"gamine";$l_IdConexion;$t_textoRespuesta)
		End if 
		$l_error:=FTP_GetFileInfo ($l_IdConexion;$t_URL_archivoActualizacion;$l_tamañoEnFTP;$d_FechaModificacionFTP;$h_HoraModificacionFTP)
		$l_error:=FTP_Receive ($l_IdConexion;$t_URL_archivoActualizacion;$t_destinoArchivoActualizacion;1)
		$l_error:=FTP_Logout ($l_IdConexion)
		$l_tamañoDescargado:=Get document size:C479($t_destinoArchivoActualizacion)
		$l_error:=(-4)*Num:C11($l_tamañoEnFTP#$l_tamañoDescargado)
		If ($l_error#0)
			$b_exito:=False:C215
			$t_error:=__ ("La actualización de SchoolTrack no pudo ser descargada correctamente.\r")
		End if 
	End if 
	
	
	
	If ($b_exito)
		<>b_AppUD_actualizarAplicacion:=True:C214
		QUIT 4D:C291
	End if 
End if 
$0:=$l_error


