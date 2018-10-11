//%attributes = {}
  //XDOC_AttachDocument

C_LONGINT:C283($table;$recordID)
$table:=$1
$recordID:=$2
If (Count parameters:C259=3)
	$refType:=$3
Else 
	$refType:="DOC"
End if 

If ($refType="DOC")
	$filename:=xfGetFileName ("Seleccione el documento que desea adjuntar")
	If ($fileName#"")
		GET DOCUMENT PROPERTIES:C477($fileName;$locked;$invisible;$createdOn;$createdAt;$modifiedOn;$modifiedAt)
		$size:=Get document size:C479($fileName)
		If (SYS_IsMacintosh )
			$creator:=_o_Document creator:C529($fileName)
		Else 
			$creator:=""
		End if 
		CREATE RECORD:C68([xShell_Documents:91])
		[xShell_Documents:91]RelatedTable:1:=$table
		[xShell_Documents:91]RelatedID:2:=$recordID
		[xShell_Documents:91]DocumentCreator:8:=$creator
		[xShell_Documents:91]RefType:10:="DOC"
		[xShell_Documents:91]DocumentName:3:=SYS_Path2FileName ($fileName)
		[xShell_Documents:91]OriginalPath:12:="DocsPlan"
		[xShell_Documents:91]Created_On:14:=$createdOn
		[xShell_Documents:91]CreatedAt:15:=$createdAt
		[xShell_Documents:91]ModifiedOn:16:=$modifiedOn
		[xShell_Documents:91]ModifiedAt:17:=$modifiedAt
		[xShell_Documents:91]DocSize:13:=$size
		[xShell_Documents:91]DocumentDescription:4:=""
		[xShell_Documents:91]ApplicationName:6:=""
		SAVE RECORD:C53([xShell_Documents:91])
		$extensions:=ST_CountWords ([xShell_Documents:91]DocumentName:3;0;".")
		$extension:=ST_GetWord ([xShell_Documents:91]DocumentName:3;$extensions;".")
		If ($extension#"")
			$externalFileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
			[xShell_Documents:91]DocumentType:5:=$extension
		Else 
			[xShell_Documents:91]DocumentType:5:=""
			$externalFileName:=String:C10([xShell_Documents:91]DocID:9)
		End if 
		$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
		SAVE RECORD:C53([xShell_Documents:91])
		$dataFilePath:=sys_getRutaBaseDatos 
		$filePath:=$dataFilePath+"Archivos"+Folder separator:K24:12+$serverFolder+Folder separator:K24:12+$externalFileName
		SYS_StoreFile (document;$filePath)
		  //MONO 193174
		$l_idAsignatura:=KRL_GetNumericFieldData (->[Asignaturas_PlanesDeClases:169]ID_Plan:1;->[xShell_Documents:91]RelatedID:2;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2)
		$t_logmsj:="Planes de Clases: Nuevo archivo "+[xShell_Documents:91]DocumentName:3
		$t_logmsj:=$t_logmsj+" del plan id :"+String:C10([xShell_Documents:91]RelatedID:2)
		$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10($l_idAsignatura)+") - "
		$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]Curso:5)
		LOG_RegisterEvt ($t_logmsj)
		UNLOAD RECORD:C212([xShell_Documents:91])
		READ ONLY:C145([xShell_Documents:91])
	End if 
Else 
	CREATE RECORD:C68([xShell_Documents:91])
	[xShell_Documents:91]RelatedTable:1:=$table
	[xShell_Documents:91]RelatedID:2:=$recordID
	[xShell_Documents:91]RefType:10:="URL"
	[xShell_Documents:91]DocumentType:5:="URL"
	[xShell_Documents:91]URL:11:="http://"
	[xShell_Documents:91]DocumentName:3:=""
	[xShell_Documents:91]OriginalPath:12:=""
	[xShell_Documents:91]DocSize:13:=0
	[xShell_Documents:91]DocumentDescription:4:=""
	[xShell_Documents:91]ApplicationName:6:=""
	SAVE RECORD:C53([xShell_Documents:91])
	vtXDOC_DocType:=$refType
	WDW_OpenFormWindow (->[xShell_Documents:91];"Input";7;4;__ ("Nueva Referencia"))
	KRL_ModifyRecord (->[xShell_Documents:91];"Input")
	CLOSE WINDOW:C154
	If (ok=0)
		DELETE RECORD:C58([xShell_Documents:91])
	End if 
End if 
