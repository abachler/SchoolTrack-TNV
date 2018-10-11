//%attributes = {}
  // SN3_SendAttachments()
  //
  //
  // modificado por: Alberto Bachler Klein: 09/02/17, 16:42:46
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_ModuloDidactivo)
C_LONGINT:C283($i;$l_error;$l_idConexion;$l_puerto;$l_timeout;$l_timeoutActual;$x)
C_TEXT:C284($t_directorioFTP;$t_nombreCarpeta;$t_rutaCarpeta;$t_rutaFTP;$t_rutaLocal;$t_rutaServidor;$t_errorFTP)

ARRAY DATE:C224($ad_FTP_fechaObjetos;0)
ARRAY INTEGER:C220($ai_FTP_tipoObjetos;0)
ARRAY LONGINT:C221($al_FTP_bytesObjetos;0)
ARRAY TEXT:C222($at_FTP_nombreObjetos;0)
ARRAY TEXT:C222($at_nombreArchivos;0)
ARRAY TEXT:C222($at_nombreArchivos2;0)
ARRAY TEXT:C222($at_nombreArchivos3;0)
ARRAY TEXT:C222($at_rutasFTP;0)
ARRAY TEXT:C222($at_rutasLocales;0)



  //ASM agregué el parametro solo para enviar los datos de guias
$b_ModuloDidactivo:=False:C215

If (Count parameters:C259=1)
	$t_nombreCarpeta:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsGuias"
	$t_rutaCarpeta:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsGuias"+Folder separator:K24:12
	$b_ModuloDidactivo:=True:C214
Else 
	$t_nombreCarpeta:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
	$t_rutaCarpeta:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"+Folder separator:K24:12
End if 

If (Size of array:C274(SN3_Docs2Send)>0)
	SN3_LoadGeneralSettings 
	  //para los nombres del log JVP 20160616
	
	$l_error:=IT_GetTimeOut ($l_timeoutActual)
	$l_timeout:=127
	$l_error:=IT_SetTimeOut ($l_timeout)
	$l_error:=IT_GetPort (1;$l_puerto)
	$l_error:=IT_SetPort (1;SN3_FTP_Port)
	
	
	
	$l_error:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$l_idConexion)
	If ($l_error=0)
		  //$l_error:=FTP_SetPassive ($l_idConexion;<>ftp_UsePassive)
		$l_error:=FTP_SetPassive ($l_idConexion;1)  //20170520 RCH. Se cambia a pedido de JHB
		$t_directorioFTP:="/interno/desarrollo/abk/tests/"+<>vtXS_CountryCode+"."+<>gRolBD
		  //$t_directorioFTP:="/documentos3/"+<>vtXS_CountryCode+"."+<>gRolBD
		$l_error:=FTP_CreatePath ($l_idConexion;$t_directorioFTP)
		If ($l_error=0)
			$l_error:=FTP_ChangeDir ($l_idConexion;$t_directorioFTP)
			$l_error:=FTP_GetDirList ($l_idConexion;$t_directorioFTP;$at_FTP_nombreObjetos;$al_FTP_bytesObjetos;$ai_FTP_tipoObjetos;$ad_FTP_fechaObjetos)
		End if 
		$l_error:=FTP_Logout ($l_idConexion)
		$l_error:=IT_SetPort (1;$l_puerto)
		
		For ($i;Size of array:C274(SN3_Docs2Send);1;-1)
			If (SN3_extensions{$i}#"")
				$t_archivoExtension:=String:C10(SN3_Docs2Send{$i})+"."+SN3_extensions{$i}
				$t_archivo:=String:C10(SN3_Docs2Send{$i})
			Else 
				$t_archivoExtension:=String:C10(SN3_Docs2Send{$i})
				$t_archivo:=String:C10(SN3_Docs2Send{$i})
			End if 
			
			If ($b_ModuloDidactivo)
				$t_rutaFTP:=$t_directorioFTP+"/"+"md_"+String:C10(SN3_Docs2Send{$i})
			Else 
				$t_rutaFTP:=$t_directorioFTP+"/"+String:C10(SN3_Docs2Send{$i})
			End if 
			
			
			If (Find in array:C230($at_FTP_nombreObjetos;$t_rutaFTP)=-1)
				If (Application type:C494=4D Remote mode:K5:5)
					$t_rutaLocal:=Temporary folder:C486+$t_archivoExtension
					$t_rutaServidor:=$t_rutaCarpeta+$t_archivoExtension
					KRL_CopyFileFromServer ($t_rutaServidor;$t_rutaLocal)
				Else 
					$t_rutaLocal:=$t_rutaCarpeta+$t_archivoExtension
				End if 
				
				
				
				APPEND TO ARRAY:C911($at_rutasLocales;$t_rutaLocal)
				APPEND TO ARRAY:C911($at_rutasFTP;$t_rutaFTP)
				APPEND TO ARRAY:C911($at_NombreArchivos;SN3_DocsNames{$i})
				
				  //If ($b_ModuloDidactivo)
				  //If (SN3_AdjuntoMD{$i})
				
				
				  //  //INSERT IN ARRAY($at_nombreArchivos;1;1)
				  //  //INSERT IN ARRAY($at_nombreArchivos2;1;1)
				  //  //INSERT IN ARRAY($at_nombreArchivos3;1;1)
				  //  //$at_nombreArchivos{1}:=$t_archivoExtension
				  //  //$at_nombreArchivos2{1}:=$t_archivo
				  //  //$at_nombreArchivos3{1}:=SN3_DocsNames{$i}
				  //End if
				  //Else
				  //If (Not(SN3_AdjuntoMD{$i}))
				  //INSERT IN ARRAY($at_nombreArchivos;1;1)
				  //INSERT IN ARRAY($at_nombreArchivos2;1;1)
				  //INSERT IN ARRAY($at_nombreArchivos3;1;1)
				  //$at_nombreArchivos{1}:=$t_archivoExtension
				  //$at_nombreArchivos2{1}:=$t_archivo
				  //$at_nombreArchivos3{1}:=SN3_DocsNames{$i}
				  //End if
				  //End if
			Else 
				DELETE FROM ARRAY:C228(SN3_Docs2Send;$i;1)
				DELETE FROM ARRAY:C228(SN3_DocsNames;$i;1)
				DELETE FROM ARRAY:C228(SN3_extensions;$i;1)
				DELETE FROM ARRAY:C228(SN3_AdjuntoMD;$i;1)
			End if 
		End for 
		
		
		
		If (Size of array:C274($at_rutasLocales)>0)
			SN3_LoadGeneralSettings 
			
			$l_error:=IT_GetPort (1;$l_puerto)
			$l_error:=IT_SetPort (1;SN3_FTP_Port)
			
			$t_ftp:="ftp.colegium.com"
			$t_user:="abachler"
			$t_password:="gamine"
			SN3_FTP_Server:=$t_ftp
			SN3_FTP_User:=$t_user
			SN3_FTP_Password:=$t_password
			
			$l_error:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$l_idConexion)
			If ($l_error=0)
				  //$l_error:=FTP_SetPassive ($l_idConexion;<>ftp_UsePassive)
				$l_error:=FTP_SetPassive ($l_idConexion;1)  //20170520 RCH. Se cambia a pedido de JHB
				If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
					SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP "+("pasiva "*SN3_FTP_Passive)+"iniciada en "+("el servidor"*SN3_SendFrom_Server)+(SN3_SendFrom_SelectedWS*SN3_SendFrom_Workstation)+".")
				Else 
					SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP "+("pasiva "*SN3_FTP_Passive)+"iniciada en esta máquina.")
				End if 
				SN3_RegisterLogEntry (SN3_Log_Info;"Conexión establecida, identificación aceptada.")
				  //$t_directorioFTP:="/documentos3/"+<>vtXS_CountryCode+"."+<>gRolBD
				
				$l_error:=FTP_CreatePath ($l_idConexion;$t_directorioFTP)
				If ($l_error=0)
					$l_error:=FTP_ChangeDir ($l_idConexion;$t_directorioFTP)
					If ($l_error=0)
						  //If (Application type=4D Remote mode)
						  //$t_rutaCarpeta:=Temporary folder
						  //Else
						  //  //$t_rutaCarpeta:=<>syT_ArchivosFolder+<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"+Folder separator
						  //End if
						CD_THERMOMETREXSEC (1;0;__ ("Enviando archivos adjuntos a planes de clase..."))
						For ($x;1;Size of array:C274($at_nombreArchivos))
							  //$newPath:=$t_rutaCarpeta+$at_nombreArchivos{$x}
							  //If ($b_ModuloDidactivo)
							  //$hostPath:=$t_directorioFTP+"/"+"md_"+String($at_nombreArchivos2{$x})
							  //Else
							  //$hostPath:=$t_directorioFTP+"/"+String($at_nombreArchivos2{$x})
							  //End if
							  //$t_errorFTP:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$t_directorioFTP;$newPath;$hostPath;(Application type=4D Remote mode);->$l_idConexion;False)
							$t_errorFTP:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$t_directorioFTP;$at_rutasLocales{$x};$at_rutasFTP{$x}+".txt";(Application type:C494=4D Remote mode:K5:5);->$l_idConexion;False:C215)
							If ($t_errorFTP="")
								SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+$at_nombreArchivos{$x}+" ha sido transferido exitósamente.")
							Else 
								SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+$at_nombreArchivos{$x}+" no pudo ser transferido a causa de un error FTP: "+$t_errorFTP)
								  //SN3_ManejaReferencias ("actualizar";SN3_Documentos;SN3_Docs2Send{$x};SNT_Accion_Actualizar)
							End if 
							CD_THERMOMETREXSEC (0;$x/Size of array:C274($at_nombreArchivos)*100)
						End for 
						CD_THERMOMETREXSEC (-1)
					End if 
				End if 
				
				$l_error:=FTP_Logout ($l_idConexion)
				SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP terminada.")
				$l_error:=IT_SetPort (1;$l_puerto)
				
				
			Else 
				If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
					SN3_RegisterLogEntry (SN3_Log_Error;"Conexión FTP imposible desde "+("el servidor"*SN3_SendFrom_Server)+(SN3_SendFrom_SelectedWS*SN3_SendFrom_Workstation)+" (identificación incorrecta).")
				Else 
					SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP imposible desde esta máquina (identificación incorrecta).")
				End if 
			End if 
		End if 
	Else 
		If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
			SN3_RegisterLogEntry (SN3_Log_Error;"Conexión FTP imposible desde "+("el servidor"*SN3_SendFrom_Server)+(SN3_SendFrom_SelectedWS*SN3_SendFrom_Workstation)+" (identificación incorrecta).")
		Else 
			SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP imposible desde esta máquina (identificación incorrecta).")
		End if 
	End if 
	$l_error:=IT_SetTimeOut ($l_timeoutActual)
End if 