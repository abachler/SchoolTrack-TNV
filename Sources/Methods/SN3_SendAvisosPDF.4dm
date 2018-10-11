//%attributes = {}
  // SN3_SendAvisosPDF()
  // Por: Alberto Bachler K.: 21-10-14, 19:13:36
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_archivoComprimido)
C_LONGINT:C283($i_archivos;$l_errorFTP;$l_idConexionFTP;$l_puertoActual;$l_timeoutActual)
C_TEXT:C284($t_directorioFTP;$t_nombreArchivo;$t_resultadoCompresion;$t_rutaArchivo;$t_rutaArchivoFTP;$t_rutaCarpeta;$t_rutaLocal;$t_textoErrorFTP)
ARRAY TEXT:C222($at_archivos;0)

  // PREPARACION: COMPRESION DE LOS AVISOS EN UN SOLO ARCHIVO
$t_rutaCarpeta:=SYS_CarpetaAplicacion (CLG_Intercambios_SNT)+"AvisosPDF4SN"+Folder separator:K24:12
SYS_CreaCarpetaServidor ($t_rutaCarpeta)



  // si hay archivos en la carpeta /AvisosPDF4SN (en servidor o monousuario) los comprimo todos en un archivo en la carpeta /Archivos/
SYS_ServerDocumentList ($t_rutaCarpeta;->$at_archivos;Absolute path:K24:14)
If (Size of array:C274($at_archivos)>0)
	$t_rutaArchivo:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"avisos_"+DTS_MakeFromDateTime +".zip"
	  // comprimimos todos los archivos contenidos en la carpeta en un solo archivo (no la carpeta, así lo espera SN3)
	$b_archivoComprimido:=SYS_CompresionEnServidor ($t_rutaCarpeta;$t_rutaArchivo;"";->$t_resultadoCompresion;False:C215)
	If ($b_archivoComprimido)
		For ($i_archivos;1;Size of array:C274($at_archivos))
			DELETE DOCUMENT:C159($at_archivos{$i_archivos})
		End for 
	End if 
End if 

  // OBTENCION DE LAS RUTAS DE LOS ARCHIVOS COMPRIMIDOS A ENVIAR AL FTP
  // obtengo las rutas de todos los documentos que que se encuentran en la carpeta Archivos 
  // elimino de la lista de archivos a enviar que no corresponden a avisos de cobranza comprimidos ("avisos_...")
$t_rutaCarpeta:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12
SYS_ServerDocumentList ($t_rutaCarpeta;->$at_archivos;Absolute path:K24:14)
For ($i_archivos;Size of array:C274($at_archivos);1;-1)
	$t_nombreArchivo:=SYS_Path2FileName ($at_archivos{$i_archivos})
	If (($t_nombreArchivo#"avisos_@") | (SYS_TestPathName ($at_archivos{$i_archivos};Server)#Is a document:K24:1))
		DELETE FROM ARRAY:C228($at_archivos;$i_archivos)
	End if 
End for 

  // ENVIO DE LOS ARCHIVOS AL FTP
SN3_LoadGeneralSettings 
$l_errorFTP:=IT_GetTimeOut ($l_timeoutActual)
$l_errorFTP:=IT_SetTimeOut (127)
$l_errorFTP:=IT_GetPort (1;$l_puertoActual)
$l_errorFTP:=IT_SetPort (1;SN3_FTP_Port)
$l_errorFTP:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$l_idConexionFTP)
If ($l_errorFTP=0)
	  //$l_errorFTP:=FTP_SetPassive ($l_idConexionFTP;<>ftp_UsePassive)
	$l_errorFTP:=FTP_SetPassive ($l_idConexionFTP;1)  //20170520 RCH. Se cambia a pedido de JHB
	$t_directorioFTP:="/documentos3/"+<>vtXS_CountryCode+"."+<>gRolBD
	$l_errorFTP:=FTP_CreatePath ($l_idConexionFTP;$t_directorioFTP)
	
	
	If ($l_errorFTP=0)
		SN3_RegisterLogEntry (SN3_Log_Info;__ ("Conexión FTP establecida desde ")+Current machine:C483+"/"+Current system user:C484)
		
		If (Application type:C494=4D Remote mode:K5:5)
			  // si se está ejecutando en un cliente obtengo los archivo desde el servidor lo almaceno en una carpeta temporal en el cliente y lo envío al FTP
			SYS_CreaCarpeta (Temporary folder:C486+"AvisosPDF4SN"+Folder separator:K24:12)
			For ($i_archivos;1;Size of array:C274($at_archivos))
				$x_blob:=KRL_GetFileFromServer ($at_archivos{$i_archivos};True:C214)
				$t_rutaLocal:=Temporary folder:C486+"AvisosPDF4SN"+Folder separator:K24:12+SYS_Path2FileName ($at_archivos{$i_archivos})
				BLOB TO DOCUMENT:C526($t_rutaLocal;$x_blob)
				$t_nombreArchivo:=SYS_Path2FileName ($at_archivos{$i_archivos})
				$t_rutaArchivoFTP:=$t_directorioFTP+"/"+$t_nombreArchivo
				
				  // verificamos si la conexión sigue disponible
				$l_errorFTP:=FTP_VerifyID ($l_idConexionFTP)
				If ($l_errorFTP#0)
					  // si no está disponible abrimos una nueva conexión y nos aseguramos que el directorio de destino exista
					$l_errorFTP:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$l_idConexionFTP)
					  //$l_errorFTP:=FTP_SetPassive ($l_idConexionFTP;<>ftp_UsePassive)
					$l_errorFTP:=FTP_SetPassive ($l_idConexionFTP;1)  //20170520 RCH. Se cambia a pedido de JHBud
					$l_errorFTP:=FTP_CreatePath ($l_idConexionFTP;$t_directorioFTP)
				End if 
				
				  // enviamos el archivo comprimido al FTP
				$t_textoErrorFTP:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$t_directorioFTP;$t_rutaLocal;$t_rutaArchivoFTP;True:C214;->$l_idConexionFTP;False:C215)
				
				If ($t_textoErrorFTP="")
					  // si el archivo es transferido correctamente es eliminado en el servidor
					SYS_DeleteFileOnServer ($at_archivos{$i_archivos})
					SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+$t_nombreArchivo+" ha sido transferido exitósamente.")
				Else 
					  // si no fue posible transferir el archivo obtenido desde el servidor se elimina en la máquina local pero permanece en el servidor
					  // para ser enviado en una próxima pasada
					DELETE DOCUMENT:C159($t_rutaLocal)
					SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+$t_nombreArchivo+" no pudo ser transferido a causa de un error FTP: "+$t_textoErrorFTP)
				End if 
			End for 
			
		Else 
			  // si se ejecuta en el servidor o en una aplicación mono usuario lo envío directamente
			For ($i_archivos;1;Size of array:C274($at_archivos))
				$t_nombreArchivo:=SYS_Path2FileName ($at_archivos{$i_archivos})
				$t_rutaArchivoFTP:=$t_directorioFTP+"/"+$t_nombreArchivo
				$t_textoErrorFTP:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$t_directorioFTP;$at_archivos{$i_archivos};$t_rutaArchivoFTP;True:C214;->$l_idConexionFTP;False:C215)
				If ($t_textoErrorFTP="")
					SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+$t_nombreArchivo+" ha sido transferido exitosamente.")
				Else 
					SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+$t_nombreArchivo+" no pudo ser transferido a causa de un error FTP: "+$t_textoErrorFTP)
				End if 
			End for 
		End if 
		
	Else 
		SN3_RegisterLogEntry (SN3_Log_Info;__ ("No fue posible establecer la conexión FTP desde ")+Current machine:C483+"/"+Current system user:C484)
	End if 
End if 
$l_errorFTP:=FTP_Logout ($l_idConexionFTP)
$l_errorFTP:=IT_SetTimeOut ($l_timeoutActual)
$l_errorFTP:=IT_SetPort (1;$l_puertoActual)

