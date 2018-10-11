//%attributes = {}
  //EXE_SaveCommandLibrary


vb_Modificado_4Dv11:=True:C214
  //método modificado para v11
  //puede necesitar ajustes si se copia  a STX

C_TEXT:C284($filePath)
C_LONGINT:C283($vl_Records)
C_LONGINT:C283($vl_TableNumber)


If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("EXE_SaveCommandLibrary";Pila_256K;"Guardando archivo de comandos")
Else 
	$filePath:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Commands.txt"
	If (SYS_TestPathName ($filePath)=Is a document:K24:1)
		DELETE DOCUMENT:C159($filePath)
	End if 
	SET CHANNEL:C77(10;$filePath)
	If (ok=1)
		
		
		If (Application version:C493>="11@")
			READ ONLY:C145([xShell_ExecutableCommands:19])
			ALL RECORDS:C47([xShell_ExecutableCommands:19])
			$vl_TableNumber:=Table:C252(->[xShell_ExecutableCommands:19])
			$vl_Records:=Records in selection:C76([xShell_ExecutableCommands:19])
			SEND VARIABLE:C80($vl_TableNumber)
			SEND VARIABLE:C80($vl_Records)
			FIRST RECORD:C50([xShell_ExecutableCommands:19])
			While (Not:C34(End selection:C36([xShell_ExecutableCommands:19])))
				SEND RECORD:C78([xShell_ExecutableCommands:19])
				NEXT RECORD:C51([xShell_ExecutableCommands:19])
			End while 
			
			
			ALL RECORDS:C47([xShell_ExecCommands_Localized:232])
			$vl_TableNumber:=Table:C252(->[xShell_ExecCommands_Localized:232])
			$vl_Records:=Records in selection:C76([xShell_ExecCommands_Localized:232])
			SEND VARIABLE:C80($vl_TableNumber)
			SEND VARIABLE:C80($vl_Records)
			FIRST RECORD:C50([xShell_ExecCommands_Localized:232])
			While (Not:C34(End selection:C36([xShell_ExecCommands_Localized:232])))
				SEND RECORD:C78([xShell_ExecCommands_Localized:232])
				NEXT RECORD:C51([xShell_ExecCommands_Localized:232])
			End while 
		End if 
		SET CHANNEL:C77(11)
		
		
	Else 
		
		READ ONLY:C145([xShell_ExecutableCommands:19])
		ALL RECORDS:C47([xShell_ExecutableCommands:19])
		$vl_Records:=Records in selection:C76([xShell_ExecutableCommands:19])
		SEND VARIABLE:C80($vl_Records)
		FIRST RECORD:C50([xShell_ExecutableCommands:19])
		While (Not:C34(End selection:C36([xShell_ExecutableCommands:19])))
			SEND RECORD:C78([xShell_ExecutableCommands:19])
			NEXT RECORD:C51([xShell_ExecutableCommands:19])
		End while 
		SET CHANNEL:C77(11)
		
		
		
	End if 
	
End if 