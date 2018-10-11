//%attributes = {}
  // USR_UserQuit()
  // Por: Alberto Bachler K.: 17-04-15, 16:03:56
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_TEXT:C284(<>vsXS_CurrentModule;<>tUSR_CurrentUser)


If (Application type:C494=4D Remote mode:K5:5)
	If (Process number:C372("Cierre de Aplicacion")=0)
		  //20120831 RCH Se registra cierre de sesion aca porque no se guardaba el modulo
		LOG_RegisterEvt ("Fin de sesión")
		$pid:=New process:C317("USR_UserQuit";Pila_256K;"Cierre de Aplicacion")
	Else 
		$Process:=IT_UThermometer (1;0;__ ("Cerrando ")+<>vsXS_CurrentModule+__ ("…\rUn momento por favor"))
		<>vt_CloseSesion:=True:C214
		<>stopDaemons:=True:C214
		For ($i;1;Size of array:C274(<>alXS_ModuleProcessID))
			If (<>alXS_ModuleProcessID{<>alXS_ModuleProcessID}#0)
				POST OUTSIDE CALL:C329(<>alXS_ModuleProcessID{$i})
				PROCESS PROPERTIES:C336(<>alXS_ModuleProcessID{$i};$processName;$state;$time)
				If ($processName#"Cierre de Aplicacion")
					While ($state>=0)
						DELAY PROCESS:C323(Current process:C322;10)
						PROCESS PROPERTIES:C336(<>alXS_ModuleProcessID{$i};$processName;$state;$time)
					End while 
				End if 
			End if 
		End for 
		IT_UThermometer (-2;$Process)
		
		<>vt_CloseSesion:=False:C215
		USR_UnregisterConnection (<>lUSR_CurrentUserID;<>tUSR_CurrentUser)
		UNREGISTER CLIENT:C649
		
		
		$b_clearCompleted:=SYS_ClearFolderContent (Temporary folder:C486+"4D"+Folder separator:K24:12+"PrintPreview")
		
		QUIT 4D:C291
	End if 
	
	
Else 
	$Process:=IT_UThermometer (1;0;__ ("Cerrando ")+<>vsXS_CurrentModule+__ ("…\rUn momento por favor"))
	<>vt_CloseSesion:=True:C214
	<>quit:=True:C214
	dhXS_StopApplicationProcess 
	
	<>vt_CloseSesion:=True:C214
	If (Type:C295(<>alXS_ModuleProcessID)=LongInt array:K8:19)
		For ($i;1;Size of array:C274(<>alXS_ModuleProcessID))
			If (<>alXS_ModuleProcessID{<>alXS_ModuleProcessID}#0)
				POST OUTSIDE CALL:C329(<>alXS_ModuleProcessID{$i})
				PROCESS PROPERTIES:C336(<>alXS_ModuleProcessID{$i};$processName;$state;$time)
				If ($processName#"Cierre de Aplicacion")
					While ($state>=0)
						DELAY PROCESS:C323(Current process:C322;10)
						PROCESS PROPERTIES:C336(<>alXS_ModuleProcessID{$i};$processName;$state;$time)
					End while 
				End if 
			End if 
		End for 
	End if 
	IT_UThermometer (-2;$Process)
	
	<>vt_CloseSesion:=False:C215
	LOG_RegisterEvt ("Fin de sesión")
	USR_UnregisterConnection (<>lUSR_CurrentUserID;<>tUSR_CurrentUser)
	<>quit:=True:C214
	
	
	$b_clearCompleted:=SYS_ClearFolderContent (Temporary folder:C486+"4D"+Folder separator:K24:12+"PrintPreview")
	
	QUIT 4D:C291
End if 