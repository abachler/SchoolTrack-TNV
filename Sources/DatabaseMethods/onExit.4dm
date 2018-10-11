  // Método: On Exit
  // código original de: 
  // modificado por Alberto Bachler Klein, 07/03/18, 12:11:42
  // 
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305(<>b_NoEjecutarOnExit)

If ((Not:C34(Test semaphore:C652("ReconstruyendoBD"))) & (Not:C34(Test semaphore:C652("CompactandoBD"))))
	If (Not:C34(<>b_NoEjecutarOnExit))
		<>quit:=True:C214
		<>stopDaemons:=True:C214
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"Log")
		Bash_Quit 
		SQ_EscribeDatos 
		EM_ErrorManager ("Clear")
		SYS_ClearResourceFile 
		OT ClearAll 
	End if 
	CIM_CuentaRegistros ("GuardaArchivo")
End if 

  // en caso de que alguna BD externa haya quedado abierta
SQL_CloseExternalDatabase 


$b_clearCompleted:=SYS_ClearFolderContent (Temporary folder:C486+"4D"+Folder separator:K24:12+"PrintPreview")