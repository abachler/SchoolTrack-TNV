//%attributes = {}
  // MNU_Execute()
  // Por: Alberto Bachler Klein: 10-11-15, 19:23:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
vt_text1:=""


For ($i;1;Get last table number:C254)
	If (Is table number valid:C999($i))
		UNLOAD RECORD:C212(Table:C252($i)->)
	End if 
End for 
READ ONLY:C145(*)

vtEXC_Commands:=""
READ ONLY:C145([xShell_ExecutableCommands:19])
WDW_OpenFormWindow (->[xShell_ExecutableCommands:19];"Manager";0;4;__ ("Ejecutar una acción"))
DIALOG:C40([xShell_ExecutableCommands:19];"Manager")

IT_MODIFIERS 
CLOSE WINDOW:C154

If (ok=1)
	
	Case of 
		: (vtEXC_Commands#"")
			USR_RegisterUserEvent (UE_Execute;vlBWR_SelectedTableRef;vtEXC_Commands)
			If ((Application type:C494=4D Remote mode:K5:5) & (bExecuteOnServer=1))
				$l_idProceso:=Execute on server:C373("EXE_Execute";128000;"Ejecucion de comandos";vtEXC_Commands;False:C215;<>registeredName)
			Else 
				If (<>option)
					$l_idProceso:=New process:C317("EXE_Execute";128000;"Ejecucion de comandos";vtEXC_Commands)
				Else 
					EXE_Execute (vtEXC_Commands)
				End if 
			End if 
			
		: ([xShell_ExecutableCommands:19]MethodName:2#"")
			USR_RegisterUserEvent (UE_Execute;vlBWR_SelectedTableRef;[xShell_ExecutableCommands:19]MethodName:2)
			If ((<>option) | ([xShell_ExecutableCommands:19]ExecutableOnClient:5))
				LOG_RegisterEvt ("Ejecución de comando: "+[xShell_ExecutableCommands:19]MethodName:2;0;0)
				EXECUTE METHOD:C1007([xShell_ExecutableCommands:19]MethodName:2)
			Else 
				If (Application type:C494=4D Remote mode:K5:5)
					$err:=CD_Dlog (0;__ ("Esta tarea será ejecutada en el servidor para optimizar el rendimiento."))
					LOG_RegisterEvt ("Ejecución de comando: "+[xShell_ExecutableCommands:19]MethodName:2;0;0)
					$l_idProceso:=PCS_RunProcess ([xShell_ExecutableCommands:19]MethodName:2;128000;ST_GetWord (XS_GetCommandAliasDescription (Record number:C243([xShell_ExecutableCommands:19]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");True:C214;False:C215;True:C214;True:C214)
				Else 
					LOG_RegisterEvt ("Ejecución de comando: "+[xShell_ExecutableCommands:19]MethodName:2;0;0)
					$l_idProceso:=PCS_RunProcess ([xShell_ExecutableCommands:19]MethodName:2;128000;ST_GetWord (XS_GetCommandAliasDescription (Record number:C243([xShell_ExecutableCommands:19]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");True:C214;False:C215;True:C214;False:C215)
				End if 
				If ($l_idProceso=0)
					CD_Dlog (0;__ ("No había suficiente memoria para ejecutar en un proceso independiente.\rLa ejecución se realizará en el proceso principal."))
					LOAD RECORD:C52([xShell_ExecutableCommands:19])
					EXECUTE METHOD:C1007([xShell_ExecutableCommands:19]MethodName:2)
				Else 
				End if 
			End if 
	End case 
	
	
	  //Case of 
	  //: (bExecuteScript=1)
	  //VARIABLE TO BLOB(vt_text1;$x_blob)
	  //$l_idProceso:=New process("EXE_ExecuteFootRunnerTextBlob";128000;"Ejecución de script";$x_blob;vs_ScriptName;bc_executeOnServer)
	  //LOG_RegisterEvt ("Ejecución de Script "+vs_ScriptName;0;0)
	
	  //: (bExecuteDocument=1)
	  //LOG_RegisterEvt ("Ejecución de Script "+[xShell_ExecutableCommands]MethodName;0;0)
	  //$l_idProceso:=New process("EXE_ExecuteFootRunnerDocument";32000;"Ejecución de código")
	
	  //: (bExecute=1)
	  //If ([xShell_ExecutableCommands]MethodName#"")
	  //USR_RegisterUserEvent (UE_Execute;vlBWR_SelectedTableRef;[xShell_ExecutableCommands]MethodName)
	  //If ((<>option) | ([xShell_ExecutableCommands]ExecutableOnClient))
	  //LOG_RegisterEvt ("Ejecución de comando: "+[xShell_ExecutableCommands]MethodName;0;0)
	  //EXECUTE METHOD([xShell_ExecutableCommands]MethodName)
	  //Else 
	  //If (Application type=4D Remote mode)
	  //$err:=CD_Dlog (0;__ ("Esta tarea será ejecutada en el servidor para optimizar el rendimiento."))
	  //LOG_RegisterEvt ("Ejecución de comando: "+[xShell_ExecutableCommands]MethodName;0;0)
	  //$l_idProceso:=PCS_RunProcess ([xShell_ExecutableCommands]MethodName;128000;ST_GetWord (XS_GetCommandAliasDescription (Record number([xShell_ExecutableCommands]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");True;False;True;True)
	  //Else 
	  //LOG_RegisterEvt ("Ejecución de comando: "+[xShell_ExecutableCommands]MethodName;0;0)
	  //$l_idProceso:=PCS_RunProcess ([xShell_ExecutableCommands]MethodName;128000;ST_GetWord (XS_GetCommandAliasDescription (Record number([xShell_ExecutableCommands]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");True;False;True;False)
	  //End if 
	  //If ($l_idProceso=0)
	  //CD_Dlog (0;__ ("No había suficiente memoria para ejecutar en un proceso independiente.\rLa ejecución se realizará en el proceso principal."))
	  //EXECUTE METHOD([xShell_ExecutableCommands]MethodName)
	  //Else 
	  //End if 
	  //End if 
	  //End if 
	
	  //: ((bExecuteString=1) & (vtEXC_Commands#""))
	  //USR_RegisterUserEvent (UE_Execute;vlBWR_SelectedTableRef;vtEXC_Commands)
	  //If ((Application type=4D Remote mode) & (bExecuteOnServer=1))
	  //$l_idProceso:=Execute on server("EXE_Execute";128000;"Ejecucion de comandos";vtEXC_Commands)
	  //Else 
	  //If (<>option)
	  //$l_idProceso:=New process("EXE_Execute";128000;"Ejecucion de comandos";vtEXC_Commands)
	  //Else 
	  //EXE_Execute (vtEXC_Commands)
	  //End if 
	  //End if 
	  //End case 
End if 

