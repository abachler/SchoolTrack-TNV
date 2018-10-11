If (ADTcdd_esRegistroValido )
	
	Case of 
		: (Form event:C388=On Clicked:K2:4)
			
			ARRAY TEXT:C222($atADT_ID;0)
			ARRAY TEXT:C222($atADT_Nombre;0)
			C_TEXT:C284($idCertificado)
			C_BOOLEAN:C305($SiCertificado)
			$SiCertificado:=False:C215
			  //primero ver si ya el alumno tiene el certificado de nacimiento ingresado
			_O_ALL SUBRECORDS:C109([ADT_Candidatos:49]Documentos:50)
			SF_Subtable2Array (->[ADT_Candidatos:49]Documentos:50;->[ADT_Candidatos]Documentos'ID;->$atADT_ID)  //;->[ADT_Candidatos]Documentos'Nombre;->$atADT_Nombre)
			
			For ($i;1;Size of array:C274($atADT_ID))
				If (Num:C11($atADT_ID{$i})<0)
					$SiCertificado:=True:C214
					$idCertificado:=$atADT_ID{$i}
				End if 
			End for 
			
			$path:=xfGetFileName 
			If ($path#"")
				
				If ($SiCertificado=True:C214)
					  //hay certificado, entonces primero borro el registro
					
					READ WRITE:C146([ADT_Candidatos:49])
					_O_QUERY SUBRECORDS:C108([ADT_Candidatos:49]Documentos:50;[ADT_Candidatos]Documentos'ID=$idCertificado)
					$folder:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
					$fileName:=[ADT_Candidatos]Documentos'path
					If (Application type:C494=4D Remote mode:K5:5)
						$p:=Execute on server:C373("SYS_DeleteFile";Pila_256K;"DeletingFile";$folder;$fileName)
					Else 
						$p:=New process:C317("SYS_DeleteFile";Pila_256K;"DeletingFile";$folder;$fileName)
					End if 
					_O_DELETE SUBRECORD:C96([ADT_Candidatos:49]Documentos:50)
					SAVE RECORD:C53([ADT_Candidatos:49])
				End if 
				
				
				$name:=SYS_Path2FileName ($path)
				
				If ($name#"")
					$vb_continuar:=ADTcdd_ValidateDocumentSize (document;50;20)
					If ($vb_continuar)
						AT_Insert (0;1;->adADT_DFecha;->atADT_DNombre;->abADT_DRevisado;->atADT_DObs;->apADT_DVer;->atADT_DID;->abADT_DElectronico;->atADT_DPath;->apADT_DAbrir;->apADT_DEliminar)
						atADT_DNombre{Size of array:C274(atADT_DNombre)}:=$name
						adADT_DFecha{Size of array:C274(adADT_DFecha)}:=Current date:C33(*)
						atADT_DObs{Size of array:C274(atADT_DObs)}:=""
						atADT_DID{Size of array:C274(atADT_DID)}:="-"+DTS_MakeFromDateTime +"_"+String:C10([Alumnos:2]numero:1)
						_O_CREATE SUBRECORD:C72([ADT_Candidatos:49]Documentos:50)
						[ADT_Candidatos]Documentos'Revisado:=False:C215
						[ADT_Candidatos]Documentos'Nombre:=$name
						[ADT_Candidatos]Documentos'Fecha:=adADT_DFecha{Size of array:C274(adADT_DFecha)}
						[ADT_Candidatos]Documentos'Observaciones:="Certifiado de Nacimiento"
						[ADT_Candidatos]Documentos'ID:=atADT_DID{Size of array:C274(atADT_DID)}
						v_certificado:=$name
						v_idCertificado:=atADT_DID{Size of array:C274(atADT_DID)}
						If ($path#"")
							[ADT_Candidatos]Documentos'path:=$name
							[ADT_Candidatos]Documentos'Electronico:=True:C214
							abADT_DElectronico{Size of array:C274(abADT_DElectronico)}:=True:C214
							atADT_DPath{Size of array:C274(atADT_DPath)}:=$name
							GET DOCUMENT ICON:C700($path;apADT_DAbrir{Size of array:C274(apADT_DAbrir)};16)
							GET PICTURE FROM LIBRARY:C565(2633;apADT_DVer{Size of array:C274(apADT_DVer)})
							GET PICTURE FROM LIBRARY:C565(19879;apADT_DEliminar{Size of array:C274(apADT_DEliminar)})
							[ADT_Candidatos]Documentos'icono:=apADT_DAbrir{Size of array:C274(apADT_DAbrir)}
							  //guardamos el documento
							
							$folder:="Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
							$serverPath:=SYS_GetServer_4DFolder (Database folder:K5:14)+$folder+Folder separator:K24:12+[ADT_Candidatos]Documentos'path
							$p:=IT_UThermometer (1;0;__ ("Cargando archivo..."))
							$t_error:=KRL_CopyFileToServer ($path;$serverPath;True:C214)
							If ($t_error#"")
								CD_Dlog (0;"Error al almacenar el archivo.")
							End if 
							IT_UThermometer (-2;$p)
						Else 
							GET PICTURE FROM LIBRARY:C565(27511;apADT_DAbrir{Size of array:C274(apADT_DAbrir)})
						End if 
						
						SAVE RECORD:C53([ADT_Candidatos:49])
						LISTBOX SELECT ROW:C912(*;"documentos";Size of array:C274(adADT_DFecha);Listbox replace selection)
						_O_ENABLE BUTTON:C192(bDelDoc)
						REDRAW WINDOW:C456
						ARRAY PICTURE:C279(apADT_DTempIcono;0)
						COPY ARRAY:C226(apADT_DAbrir;apADT_DTempIcono)
						
						_O_ALL SUBRECORDS:C109([ADT_Candidatos:49]Documentos:50)
						SF_Subtable2Array (->[ADT_Candidatos:49]Documentos:50;->[ADT_Candidatos]Documentos'Revisado;->abADT_DRevisado;->[ADT_Candidatos]Documentos'Nombre;->atADT_DNombre;->[ADT_Candidatos]Documentos'Fecha;->adADT_DFecha;->[ADT_Candidatos]Documentos'Observaciones;->atADT_DObs;->[ADT_Candidatos]Documentos'ID;->atADT_DID;->[ADT_Candidatos]Documentos'Electronico;->abADT_DElectronico;->[ADT_Candidatos]Documentos'path;->atADT_DPath;->[ADT_Candidatos]Documentos'icono;->apADT_DAbrir)
					End if 
				End if 
			End if 
			
	End case 
End if 