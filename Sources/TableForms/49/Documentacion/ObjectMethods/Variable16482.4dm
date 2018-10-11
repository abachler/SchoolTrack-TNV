$r:=CD_Dlog (0;__ ("¿Está seguro de querer elimnar este documento?");__ ("");__ ("Si");__ ("No"))
If ($r=1)
	ARRAY TEXT:C222($atNombres;0)
	
	$id:=atADT_DID{abADT_DRevisado}
	_O_QUERY SUBRECORDS:C108([ADT_Candidatos:49]Documentos:50;[ADT_Candidatos]Documentos'ID=$id)
	$folder:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
	$fileName:=[ADT_Candidatos]Documentos'path
	
	DOCUMENT LIST:C474($folder;$atNombres)
	$el:=Find in array:C230($atNombres;$fileName)
	If ($el>0)
		$folderDelete:=$folder+Folder separator:K24:12+$fileName
		DELETE DOCUMENT:C159($folderDelete)
	End if 
	
	_O_DELETE SUBRECORD:C96([ADT_Candidatos:49]Documentos:50)
	SAVE RECORD:C53([ADT_Candidatos:49])
	v_certificado:=""
	v_idCertificado:=""
	
	If ($filename#"")
		If (Application type:C494=4D Remote mode:K5:5)
			$p:=Execute on server:C373("SYS_DeleteFile";Pila_256K;"DeletingFile";$folder;$fileName)
		Else 
			$p:=New process:C317("SYS_DeleteFile";Pila_256K;"DeletingFile";$folder;$fileName)
		End if 
	End if 
	AT_Delete (abADT_DRevisado;1;->adADT_DFecha;->atADT_DNombre;->abADT_DRevisado;->atADT_DObs;->apADT_DVer;->atADT_DID;->abADT_DElectronico;->atADT_DPath;->apADT_DAbrir;->apADT_DEliminar)
	_O_DISABLE BUTTON:C193(bDelDoc)
	LISTBOX SELECT ROW:C912(*;"documentos";0;lk remove from selection:K53:3)
	
	REDRAW WINDOW:C456
	ARRAY PICTURE:C279(apADT_DTempIcono;0)
	COPY ARRAY:C226(apADT_DAbrir;apADT_DTempIcono)
End if 