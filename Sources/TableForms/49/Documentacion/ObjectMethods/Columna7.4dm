IT_SetButtonState ((Self:C308->>0);->bDelDoc)
If (Self:C308->>0)
	If (abADT_DElectronico{Self:C308->})
		$r:=CD_Dlog (0;__ ("Se dispone a eliminar el documento electrónico asociado. ¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			_O_QUERY SUBRECORDS:C108([ADT_Candidatos:49]Documentos:50;[ADT_Candidatos]Documentos'ID=atADT_DID{Self:C308->})
			If ([ADT_Candidatos]Documentos'path#"")
				$folder:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
				$fileName:=[ADT_Candidatos]Documentos'path
				If (Application type:C494=4D Remote mode:K5:5)
					$p:=Execute on server:C373("SYS_DeleteFile";Pila_256K;"DeletingFile";$folder;$fileName)
				Else 
					$p:=New process:C317("SYS_DeleteFile";Pila_256K;"DeletingFile";$folder;$fileName)
				End if 
				[ADT_Candidatos]Documentos'icono:=[ADT_Candidatos]Documentos'icono*0
				[ADT_Candidatos]Documentos'path:=""
				[ADT_Candidatos]Documentos'Electronico:=False:C215
				[ADT_Candidatos]Documentos'Nombre:=""
				[ADT_Candidatos]Documentos'Fecha:=!00-00-00!
				[ADT_Candidatos]Documentos'Observaciones:=""
				SAVE RECORD:C53([ADT_Candidatos:49])
				$el:=Find in array:C230(atADT_DNombre;$fileName)
				If ($el>0)
					atADT_DNombre{$el}:=""
					adADT_DFecha{$el}:=!00-00-00!
					atADT_DObs{$el}:=""
					apADT_DAbrir{$el}:=apADT_DAbrir{$el}*0
					apADT_DVer{$el}:=apADT_DVer{$el}*0
					apADT_DEliminar{$el}:=apADT_DEliminar{$el}*0
				End if 
				abADT_DElectronico{Self:C308->}:=False:C215
				GET PICTURE FROM LIBRARY:C565(27511;apADT_DAbrir{Self:C308->})
				apADT_DVer{Self:C308->}:=apADT_DVer{Self:C308->}*0
				apADT_DEliminar{Self:C308->}:=apADT_DEliminar{Self:C308->}*0
				REDRAW WINDOW:C456
				ARRAY PICTURE:C279(apADT_DTempIcono;0)
				COPY ARRAY:C226(apADT_DAbrir;apADT_DTempIcono)
			End if 
		End if 
	End if 
End if 
REDRAW WINDOW:C456