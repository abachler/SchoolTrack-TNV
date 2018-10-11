//%attributes = {}
  //XDOC_LoadHelperDocumentsLibrary

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 18/07/03, 16:49:52
  // -------------------------------------------------------------------------------
  // Metodo: EXE_LoadCommandFile
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_TEXT:C284($file)
C_LONGINT:C283($nbRecords)

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"HelperDocuments.txt"

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
If (Application type:C494=4D Remote mode:K5:5)
	$pId:=Execute on server:C373(Current method name:C684;Pila_256K;"Cargando documentos externos.")
Else 
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		READ WRITE:C146([xShell_Documents:91])
		QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RefType:10;=;"HLPR";*)
		QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedTable:1=-1;*)
		QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedID:2=-1)
		DELETE SELECTION:C66([xShell_Documents:91])
		
		$pId:=IT_UThermometer (1;0;__ ("Actualizando documentos externos…"))
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		Repeat 
			CREATE RECORD:C68([xShell_Documents:91])
			RECEIVE RECORD:C79([xShell_Documents:91])
			If (OK=1)
				SAVE RECORD:C53([xShell_Documents:91])
			End if 
		Until ((error#0) | (OK=0))
		EM_ErrorManager ("Clear")
		SET CHANNEL:C77(11)
		UNLOAD RECORD:C212([xShell_Documents:91])
		READ ONLY:C145([xShell_Documents:91])
		IT_UThermometer (-2;$pId)
	Else 
		$r:=CD_Dlog (1;__ ("El archivo que contiene los documentos externos no pudo ser cargado."))
	End if 
End if 


  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------