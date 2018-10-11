IT_SetButtonState ((Self:C308->>0);->bDelDoc)
If (Self:C308->>0)
	If ((IT_AltKeyIsDown ) | (Not:C34(abADT_DElectronico{Self:C308->})))
		$path:=xfGetFileName 
		If ($path#"")
			$name:=SYS_Path2FileName ($path)
			_O_QUERY SUBRECORDS:C108([ADT_Candidatos:49]Documentos:50;[ADT_Candidatos]Documentos'ID=atADT_DID{Self:C308->})
			If ([ADT_Candidatos]Documentos'path#"")
				$folder:="DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
				$fileName:=[ADT_Candidatos]Documentos'path
				If (Application type:C494=4D Remote mode:K5:5)
					$p:=Execute on server:C373("SYS_DeleteFile";Pila_256K;"DeletingFile";$folder;$fileName)
				Else 
					$p:=New process:C317("SYS_DeleteFile";Pila_256K;"DeletingFile";$folder;$fileName)
				End if 
			End if 
			atADT_DPath{Self:C308->}:=$name
			atADT_DNombre{Self:C308->}:=$name
			abADT_DElectronico{Self:C308->}:=True:C214
			  //guardamos el documento
			$folder:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
			$p:=IT_UThermometer (1;0;__ ("Cargando archivo..."))
			DOCUMENT TO BLOB:C525($path;$blob)
			$err:=xDOC_StoreDocument ($folder+Folder separator:K24:12+$name;->$blob;False:C215;"";"")
			IT_UThermometer (-2;$p)
			GET DOCUMENT ICON:C700($path;apADT_DAbrir{Self:C308->};16)
			apADT_DTempIcono{Self:C308->}:=apADT_DAbrir{Self:C308->}
			GET PICTURE FROM LIBRARY:C565(2633;apADT_DVer{Self:C308->})
			GET PICTURE FROM LIBRARY:C565(19879;apADT_DEliminar{Self:C308->})
			[ADT_Candidatos]Documentos'Nombre:=$name
			[ADT_Candidatos]Documentos'path:=$name
			[ADT_Candidatos]Documentos'Electronico:=True:C214
			[ADT_Candidatos]Documentos'icono:=apADT_DAbrir{Self:C308->}
			SAVE RECORD:C53([ADT_Candidatos:49])
		End if 
	Else 
		If (abADT_DElectronico{Self:C308->})
			If (Application type:C494=4D Remote mode:K5:5)
				_O_QUERY SUBRECORDS:C108([ADT_Candidatos:49]Documentos:50;[ADT_Candidatos]Documentos'ID=atADT_DID{Self:C308->})
				If ([ADT_Candidatos]Documentos'path#"")
					$localPath:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)+Folder separator:K24:12
					$serverPath:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
					  //$localPath:=SYS_RetreiveFile ($serverPath;[ADT_Candidatos]Documentos'path;$localPath)
					SYS_RetrieveFile_v11 ($serverPath;[ADT_Candidatos]Documentos'path;$localPath)
					If (SYS_IsMacintosh )
						_O_SET DOCUMENT CREATOR:C531($localPath;"")
						_O_SET DOCUMENT TYPE:C530($localPath;"")
					End if 
				End if 
				$folder:=$localPath
			Else 
				$folder:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
			End if 
			$fileName:=atADT_DPath{Self:C308->}
			OPEN URL:C673($vt_localPath)
		End if 
	End if 
End if 