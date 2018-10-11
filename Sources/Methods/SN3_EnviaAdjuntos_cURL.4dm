//%attributes = {}
  // SN3_EnviaAdjuntos_Curl()
  //
  //
  // creado por: Alberto Bachler Klein: 09/02/17, 18:44:08
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_ModuloDidactivo)
C_LONGINT:C283($i_documentos;$l_error;$l_idConexion;$l_puerto)
C_TEXT:C284($t_archivo;$t_archivoExtension;$t_directorioFTP;$t_errorCURL;$t_nombreCarpeta;$t_rutaCarpeta;$t_rutaFTP;$t_rutaLocal;$t_rutaServidor)

ARRAY TEXT:C222($at_NombreArchivos;0)
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

  //If (Size of array(SN3_Docs2Send)>0)
SN3_LoadGeneralSettings 
SN3_FTP_User:="abachler"
SN3_FTP_Password:="gamine"
$t_directorioFTP:="ftp://"+SN3_FTP_Server+":"+String:C10(SN3_FTP_Port)+"/documentos3/"+<>vtXS_CountryCode+"."+<>gRolBD
$t_directorioFTP:="ftp://ftp.colegium.com:"+String:C10(SN3_FTP_Port)+"/interno/desarrollo/abk/tests/"+<>vtXS_CountryCode+"."+<>gRolBD


$l_error:=CURL_TestConnection 
If ($l_error=0)
	
	For ($i_documentos;1;Size of array:C274(SN3_Docs2Send))
		If (SN3_extensions{$i_documentos}#"")
			$t_archivoExtension:=String:C10(SN3_Docs2Send{$i_documentos})+"."+SN3_extensions{$i_documentos}
			$t_archivo:=String:C10(SN3_Docs2Send{$i_documentos})
		Else 
			$t_archivoExtension:=String:C10(SN3_Docs2Send{$i_documentos})
			$t_archivo:=String:C10(SN3_Docs2Send{$i_documentos})
		End if 
		
		If ($b_ModuloDidactivo)
			$t_rutaFTP:=$t_directorioFTP+"/"+"md_"+String:C10(SN3_Docs2Send{$i_documentos})
		Else 
			$t_rutaFTP:=$t_directorioFTP+"/"+String:C10(SN3_Docs2Send{$i_documentos})
			  //$t_rutaFTP:=$t_directorioFTP+"/"+$t_archivoExtension
		End if 
		
		If (Application type:C494=4D Remote mode:K5:5)
			$t_rutaLocal:=Temporary folder:C486+$t_archivoExtension
			$t_rutaServidor:=$t_rutaCarpeta+$t_archivoExtension
			KRL_CopyFileFromServer ($t_rutaServidor;$t_rutaLocal)
		Else 
			$t_rutaLocal:=$t_rutaCarpeta+$t_archivoExtension
		End if 
		
		APPEND TO ARRAY:C911($at_rutasLocales;$t_rutaLocal)
		APPEND TO ARRAY:C911($at_rutasFTP;$t_rutaFTP)
		APPEND TO ARRAY:C911($at_NombreArchivos;SN3_DocsNames{$i_documentos})
	End for 
	
	
	
	If (Size of array:C274($at_rutasLocales)>0)
		If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
			SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP "+("pasiva "*SN3_FTP_Passive)+"iniciada en "+("el servidor"*SN3_SendFrom_Server)+(SN3_SendFrom_SelectedWS*SN3_SendFrom_Workstation)+".")
		Else 
			SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP "+("pasiva "*SN3_FTP_Passive)+"iniciada en esta máquina.")
		End if 
		SN3_RegisterLogEntry (SN3_Log_Info;"Conexión establecida, identificación aceptada.")
		
		
		
		CD_THERMOMETREXSEC (1;0;__ ("Enviando archivos adjuntos a planes de clase..."))
		For ($i_documentos;1;Size of array:C274($at_nombreArchivos))
			$t_errorCURL:=CURL_SendToFTP ($at_rutasLocales{$i_documentos};$at_rutasFTP{$i_documentos};SN3_FTP_User;SN3_FTP_Password)
			If ($t_errorCURL="")
				SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+$at_nombreArchivos{$i_documentos}+" ha sido transferido exitósamente.")
			Else 
				SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+$at_nombreArchivos{$i_documentos}+" no pudo ser transferido a causa de un error FTP: "+$t_errorFTP)
				SN3_ManejaReferencias ("actualizar";SN3_Documentos;SN3_Docs2Send{$i_documentos};SNT_Accion_Actualizar)
			End if 
			CD_THERMOMETREXSEC (0;$i_documentos/Size of array:C274($at_nombreArchivos)*100)
		End for 
		CD_THERMOMETREXSEC (-1)
		
		
		$l_error:=FTP_Logout ($l_idConexion)
		SN3_RegisterLogEntry (SN3_Log_Info;"Envío de archivos adjuntos a planes de clases finalizados.")
		$l_error:=IT_SetPort (1;$l_puerto)
	End if 
	
	
Else 
	If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
		SN3_RegisterLogEntry (SN3_Log_Error;"Conexión FTP imposible desde "+("el servidor"*SN3_SendFrom_Server)+(SN3_SendFrom_SelectedWS*SN3_SendFrom_Workstation)+" (identificación incorrecta).")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP imposible desde esta máquina (identificación incorrecta).")
	End if 
End if 

