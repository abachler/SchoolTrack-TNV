//%attributes = {}
  //XS_CloseSesion

If (Process number:C372("Cierre de sesión")=0)
	  //20120827 RCH Se registra cierre de sesion aca porque no se guardaba el modulo
	LOG_RegisterEvt ("Fin de sesión")
	$pid:=New process:C317("XS_CloseSesion";Pila_256K;"Cierre de sesión")
Else 
	<>vt_CloseSesion:=True:C214
	$b_clearCompleted:=SYS_ClearFolderContent (Temporary folder:C486+"4D"+Folder separator:K24:12+"PrintPreview")
	
	
	dhXS_StopApplicationProcess 
	For ($i;1;Size of array:C274(<>alXS_ModuleProcessID))
		If (<>alXS_ModuleProcessID{$i}#0)
			POST OUTSIDE CALL:C329(<>alXS_ModuleProcessID{$i})
			PROCESS PROPERTIES:C336(<>alXS_ModuleProcessID{$i};$processName;$state;$time)
			If ($processName#"Cierre de sesión")
				While ($state>=0)
					DELAY PROCESS:C323(Current process:C322;10)
					PROCESS PROPERTIES:C336(<>alXS_ModuleProcessID{$i};$processName;$state;$time)
				End while 
				<>alXS_ModuleProcessID{$i}:=0
			End if 
		End if 
	End for 
	For ($i;Size of array:C274(<>alXS_RegisteredProcessIDs);1;-1)
		POST OUTSIDE CALL:C329(<>alXS_RegisteredProcessIDs{$i})
		PROCESS PROPERTIES:C336(<>alXS_RegisteredProcessIDs{$i};$processName;$state;$time)
		If ($processName#"Cierre de sesión")
			While ($state>=0)
				DELAY PROCESS:C323(Current process:C322;10)
				PROCESS PROPERTIES:C336(<>alXS_RegisteredProcessIDs{$i};$processName;$state;$time)
			End while 
			PCS_UnRegisterProcess (<>alXS_RegisteredProcessIDs{$i})
		End if 
	End for 
	
	<>vt_CloseSesion:=False:C215
	  //LOG_RegisterEvt ("Fin de sesión") // se guarda arriba
	UNREGISTER CLIENT:C649
	SYS_ClearResourceFile 
	
	USR_login 
	LOC_ChangeLanguage 
	SYS_OpenLangageResource 
	dhXS_Startup 
	
	pCALL_BWR_StartBrowser (vlBWR_CurrentModuleRef)
	dhXS_StartApplicationProcesses 
End if 