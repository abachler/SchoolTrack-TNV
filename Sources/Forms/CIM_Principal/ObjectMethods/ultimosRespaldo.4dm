
If (Contextual click:C713)
	$y_nombreArchivo:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreArchivoRespaldo")
	$y_rutaArchivo:=OBJECT Get pointer:C1124(Object named:K67:5;"rutaArchivoRespaldo")
	If ($y_rutaArchivo->>0)
		$b_archivoExiste:=(SYS_TestPathName ($y_rutaArchivo->{$y_rutaArchivo->};Server)=Is a document:K24:1)
	End if 
	Case of 
		: ($y_nombreArchivo->=0)
			$l_Choice:=Pop up menu:C542("(Ver el archivo;(Copiar el archivo a un directorio local;(Enviar al FTP desde este computador;(Enviar al FTP desde el servidor")
		: ($b_archivoExiste)
			If (Application type:C494=4D Remote mode:K5:5)
				$l_Choice:=Pop up menu:C542("Ver el archivo;Copiar el archivo a un directorio local;Enviar al FTP desde este computador;Enviar al FTP desde el servidor")
			Else 
				$l_Choice:=Pop up menu:C542("Ver el archivo;Copiar el archivo a un directorio local;Enviar al FTP desde este computador;(Enviar al FTP desde el servidor")
			End if 
		Else 
			$l_Choice:=Pop up menu:C542("(Ver el archivo;(Copiar el archivo a un directorio local;(Enviar al FTP desde este computador;(Enviar al FTP desde el servidor")
	End case 
	
	Case of 
		: ($l_Choice=1)
			SHOW ON DISK:C922($y_rutaArchivo->{$y_nombreArchivo->})
			
			
		: ($l_Choice=2)
			$t_folder:=Select folder:C670("Seleccione la carpeta en la que desea copiar...")
			$t_fileName:=$y_nombreArchivo->{$y_nombreArchivo->}
			
			If ($t_folder#"")
				If (Application type:C494=4D Remote mode:K5:5)
					SYS_CopyFileFromServer ($y_rutaArchivo->{$y_rutaArchivo->};$t_folder+$t_fileName)
				Else 
					
					$t_fileName:=$y_nombreArchivo->{$y_nombreArchivo->}
					$b_Copy:=True:C214
					If (Test path name:C476($t_folder+$t_fileName)=Is a document:K24:1)
						$l_UserChoice:=CD_Dlog (0;"Ya existe un documento con el mismo nombre.\r\r¿Desea usted reemplazarlo?";"";"No";"Reemplazar")
						If ($l_UserChoice=2)
							DELETE DOCUMENT:C159($t_folder+$t_fileName)
						Else 
							$b_Copy:=False:C215
						End if 
					End if 
					
					If ($b_copy)
						$l_ProcessID:=IT_UThermometer (1;0;__ ("Copiando el archivo ")+$t_fileName+__ ("a la carpeta ")+$t_folder)
						COPY DOCUMENT:C541($y_rutaArchivo->{$y_rutaArchivo->};$t_folder+$t_fileName)
						$l_ProcessID:=IT_UThermometer (-2;$l_ProcessID;__ ("Copiando el archivo ")+$t_fileName+__ ("a la carpeta ")+$t_folder)
						SHOW ON DISK:C922($t_folder+$t_fileName)
					End if 
				End if 
			End if 
			
		: ($l_choice=3)
			$t_rutaDocumento:=$y_rutaArchivo->{$y_nombreArchivo->}
			$t_nombreArchivo:=SYS_Path2FileName ($t_rutaDocumento)
			If (Application type:C494=4D Remote mode:K5:5)
				$t_rutaLocal:=Temporary folder:C486+$t_nombreArchivo
				SYS_CopyFileFromServer ($t_rutaDocumento;$t_rutaLocal)
			Else 
				$t_rutaLocal:=$t_rutaDocumento
			End if 
			If (Test path name:C476($t_rutaLocal)=Is a document:K24:1)
				$l_process:=New process:C317("BKP_SubeRespaldo";0;__ ("Transferencia de archivos");$t_rutaLocal)
			End if 
			
		: ($l_choice=4)
			$t_rutaDocumento:=$y_rutaArchivo->{$y_nombreArchivo->}
			  // MOD Ticket N° 210367 Patricio Aliaga 20180904
			  //$l_proceso:=Execute on server("BKP_SubeRespaldo";0;"Envio de respaldo al FTP";$t_rutaDocumento;<>REGISTEREDNAME)
			$l_proceso:=Execute on server:C373("BKP_SubeRespaldo";0;"Envio de respaldo al FTP";$t_rutaDocumento)
			
	End case 
End if 
