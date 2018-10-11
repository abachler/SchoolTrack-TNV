//%attributes = {}
  //EXE_LoadCommandLibrary


vb_Modificado_4Dv11:=True:C214
  //método modificado para v11
  //puede necesitar ajustes si se copia  a STX




  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_TEXT:C284($filePath)
C_LONGINT:C283($vl_TableNumber;$vl_Records)
  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$filePath:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Commands.txt"

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
If (Application type:C494=4D Remote mode:K5:5)
	$pId:=Execute on server:C373("EXE_LoadCommandLibrary";Pila_256K;"Actualización de comandos ejecutables.")
Else 
	SET CHANNEL:C77(10;$filePath)
	If (ok=1)
		
		$pId:=IT_UThermometer (1;0;__ ("Actualizando lista de comandos ejecutables…"))
		READ WRITE:C146([xShell_ExecutableCommands:19])
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		
		KRL_ClearTable (->[xShell_ExecCommands_Localized:232])
		KRL_ClearTable (->[xShell_ExecutableCommands:19])
		SQ_EstableceSecuencia (->[xShell_ExecutableCommands:19]ID:10;0)
		
		If (Application version:C493>="11@")
			
			
			EM_ErrorManager ("Install")
			EM_ErrorManager ("SetMode";"")
			
			RECEIVE VARIABLE:C81($vl_TableNumber)
			RECEIVE VARIABLE:C81($vl_Records)
			If ($vl_Records#0)
				For ($k;1;$vl_Records)
					RECEIVE RECORD:C79([xShell_ExecutableCommands:19])
					SAVE RECORD:C53([xShell_ExecutableCommands:19])
				End for 
			End if 
			
			RECEIVE VARIABLE:C81($vl_TableNumber)
			RECEIVE VARIABLE:C81($vl_Records)
			If ($vl_Records#0)
				For ($k;1;$vl_Records)
					RECEIVE RECORD:C79([xShell_ExecCommands_Localized:232])
					SAVE RECORD:C53([xShell_ExecCommands_Localized:232])
				End for 
			End if 
			
		Else 
			
			
			RECEIVE VARIABLE:C81($vl_Records)
			EM_ErrorManager ("Install")
			EM_ErrorManager ("SetMode";"")
			For ($i;1;$nbRecords)
				RECEIVE RECORD:C79([xShell_ExecutableCommands:19])
				[xShell_ExecutableCommands:19]ID:10:=0
				If ($vl_Records=0)
					SAVE RECORD:C53([xShell_ExecutableCommands:19])
				End if 
			End for 
			KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
			
			
		End if 
		
		
		SET CHANNEL:C77(11)
		EM_ErrorManager ("Clear")
		IT_UThermometer (-2;$pId)
		USR_BuildAccesTables 
		
		
	Else 
		$r:=CD_Dlog (0;__ ("El archivo que contiene los comandos ejecutables no pudo ser cargado."))
	End if 
	
End if 

KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
KRL_UnloadReadOnly (->[xShell_ExecCommands_Localized:232])