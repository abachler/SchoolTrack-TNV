//%attributes = {}
  //SN3_SendAttachments

  //ASM agregué el parametro solo para enviar los datos de guias 
C_BOOLEAN:C305($b_ModuloDidactivo)
$b_ModuloDidactivo:=False:C215

If (Count parameters:C259=1)
	$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsGuias"
	$folder:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsGuias"+Folder separator:K24:12
	$b_ModuloDidactivo:=True:C214
Else 
	$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
	$folder:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"+Folder separator:K24:12
End if 

If (Size of array:C274(SN3_Docs2Send)>0)
	SN3_LoadGeneralSettings 
	  //20110930 RCH Se mueve declaracion de arreglo $fileNames y se deja todo el codigo del metodo dentro del primer login. Si hay un error de conexion al comienzo no se continua con la seguna parte...
	ARRAY TEXT:C222($fileNames;0)
	  //para los nombres del log JVP 20160616
	ARRAY TEXT:C222($fileNames2;0)
	ARRAY TEXT:C222($fileNames3;0)
	  //MONO
	ARRAY TEXT:C222($at_fileReferenceKey;0)
	
	$err:=IT_GetTimeOut ($timeout)
	$tiempo:=127
	$err:=IT_SetTimeOut ($tiempo)
	$err:=IT_GetPort (1;$port)
	$err:=IT_SetPort (1;SN3_FTP_Port)
	$err:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpConnectionID)
	
	If ($err=0)
		
		$err:=FTP_SetPassive ($ftpConnectionID;1)  //20170520 RCH. Se cambia a pedido de JHB
		$t_directorioFTP:="/documentos3/"+<>vtXS_CountryCode+"."+<>gRolBD
		$err:=FTP_CreatePath ($ftpConnectionID;$t_directorioFTP)
		If ($err=0)
			$err:=FTP_ChangeDir ($ftpConnectionID;$t_directorioFTP)
			ARRAY TEXT:C222($at_FTP_nombreObjetos;0)
			ARRAY LONGINT:C221($al_FTP_bytesObjetos;0)
			ARRAY DATE:C224($adFTP_ObjectDate;0)
			ARRAY INTEGER:C220($aiFTP_ObjectKInd;0)
			$err:=FTP_GetDirList ($ftpConnectionID;$t_directorioFTP;$at_FTP_nombreObjetos;$al_FTP_bytesObjetos;$aiFTP_ObjectKInd;$adFTP_ObjectDate)
		End if 
		$err:=FTP_Logout ($ftpConnectionID)
		$err:=IT_SetPort (1;$port)
		
		For ($i;Size of array:C274(SN3_Docs2Send);1;-1)
			If (SN3_extensions{$i}#"")
				$fileName:=String:C10(SN3_Docs2Send{$i})+"."+SN3_extensions{$i}
				$fileName2:=String:C10(SN3_Docs2Send{$i})
			Else 
				$fileName:=String:C10(SN3_Docs2Send{$i})
				$fileName2:=String:C10(SN3_Docs2Send{$i})
			End if 
			  //JVP 20160603 busco con el nombre que corresponda
			If ($b_ModuloDidactivo)
				$ftpFileName:="md_"+String:C10(SN3_Docs2Send{$i})
			Else 
				$ftpFileName:=String:C10(SN3_Docs2Send{$i})
			End if 
			If (Find in array:C230($at_FTP_nombreObjetos;$ftpFileName)=-1)
				If (Application type:C494=4D Remote mode:K5:5)
					$folder:=Temporary folder:C486
					$newPath:=$folder+$fileName
					If (SYS_TestPathName ($newPath)=Is a document:K24:1)
						DELETE DOCUMENT:C159($newPath)
					End if 
					SYS_RetrieveFile_v11 ($serverFolder;$fileName;$folder)
				End if 
				
				If ($b_ModuloDidactivo)
					If (SN3_AdjuntoMD{$i})
						INSERT IN ARRAY:C227($fileNames;1;1)
						INSERT IN ARRAY:C227($fileNames2;1;1)
						INSERT IN ARRAY:C227($fileNames3;1;1)
						INSERT IN ARRAY:C227($at_fileReferenceKey;1;1)  //MONO
						$fileNames{1}:=$fileName
						$fileNames2{1}:=$fileName2
						$fileNames3{1}:=SN3_DocsNames{$i}
						$at_fileReferenceKey{1}:=SN3_FileReferenceKey{$i}  //MONO
					End if 
				Else 
					If (Not:C34(SN3_AdjuntoMD{$i}))
						INSERT IN ARRAY:C227($fileNames;1;1)
						INSERT IN ARRAY:C227($fileNames2;1;1)
						INSERT IN ARRAY:C227($fileNames3;1;1)
						INSERT IN ARRAY:C227($at_fileReferenceKey;1;1)  //MONO
						$fileNames{1}:=$fileName
						$fileNames2{1}:=$fileName2
						$fileNames3{1}:=SN3_DocsNames{$i}
						$at_fileReferenceKey{1}:=SN3_FileReferenceKey{$i}  //MONO
					End if 
				End if 
				
			Else 
				DELETE FROM ARRAY:C228(SN3_Docs2Send;$i;1)
				DELETE FROM ARRAY:C228(SN3_DocsNames;$i;1)
				DELETE FROM ARRAY:C228(SN3_extensions;$i;1)
				DELETE FROM ARRAY:C228(SN3_AdjuntoMD;$i;1)
				DELETE FROM ARRAY:C228(SN3_FileReferenceKey;$i;1)  //MONO
			End if 
		End for 
		
		If (Size of array:C274($fileNames)>0)
			SN3_LoadGeneralSettings 
			
			$err:=IT_GetPort (1;$port)
			$err:=IT_SetPort (1;SN3_FTP_Port)
			$err:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpConnectionID)
			
			If ($err=0)
				
				$err:=FTP_SetPassive ($ftpConnectionID;1)  //20170520 RCH. Se cambia a pedido de JHB
				If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
					SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP "+("pasiva "*SN3_FTP_Passive)+"iniciada en "+("el servidor"*SN3_SendFrom_Server)+(SN3_SendFrom_SelectedWS*SN3_SendFrom_Workstation)+".")
				Else 
					SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP "+("pasiva "*SN3_FTP_Passive)+"iniciada en esta máquina.")
				End if 
				SN3_RegisterLogEntry (SN3_Log_Info;"Conexión establecida, identificación aceptada.")
				$t_directorioFTP:="/documentos3/"+<>vtXS_CountryCode+"."+<>gRolBD
				$err:=FTP_CreatePath ($ftpConnectionID;$t_directorioFTP)
				If ($err=0)
					$err:=FTP_ChangeDir ($ftpConnectionID;$t_directorioFTP)
					If ($err=0)
						If (Application type:C494=4D Remote mode:K5:5)
							$folder:=Temporary folder:C486
						End if 
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Enviando archivos adjuntos a planes de clase..."))
						For ($x;1;Size of array:C274($fileNames))
							$newPath:=$folder+$fileNames{$x}
							If ($b_ModuloDidactivo)
								$hostPath:=$t_directorioFTP+"/"+"md_"+String:C10($fileNames2{$x})
							Else 
								$hostPath:=$t_directorioFTP+"/"+String:C10($fileNames2{$x})
							End if 
							$errorString:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$t_directorioFTP;$newPath;$hostPath;(Application type:C494=4D Remote mode:K5:5);->$ftpConnectionID;False:C215)
							If ($errorString="")
								SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+$fileNames3{$x}+" ha sido transferido exitósamente.")
							Else 
								SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+$fileNames3{$x}+" no pudo ser transferido a causa de un error FTP: "+$errorString)
								  //MONO
								$l_idRef:=Num:C11(Substring:C12(SN3_FileReferenceKey{$x};Position:C15(".";SN3_FileReferenceKey{$x})+1))
								Case of 
									: (SN3_FileReferenceKey{$x}="PLANES@")
										SN3_ManejaReferencias ("actualizar";SN3_Documentos;$l_idRef;SNT_Accion_Actualizar)
									: (SN3_FileReferenceKey{$x}="GUIAS@")
										SN3_ManejaReferencias ("actualizar";10013;$l_idRef;SNT_Accion_Actualizar)
								End case 
								
							End if 
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$x/Size of array:C274($fileNames))
						End for 
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					End if 
				End if 
				$err:=FTP_Logout ($ftpConnectionID)
				SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP terminada.")
				$err:=IT_SetPort (1;$port)
				
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
	$err:=IT_SetTimeOut ($timeout)
End if 