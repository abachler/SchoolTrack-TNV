$closeSesion:=True:C214
For ($i;1;Size of array:C274(<>alXS_ModuleProcessID))
	If ((<>alXS_ModuleProcessID{$i}>0) & (<>alXS_ModuleProcessID{$i}#Current process:C322))
		$closeSesion:=False:C215
		$processNumber:=<>alXS_ModuleProcessID{$i}
	End if 
End for 
If ($closeSesion)
	XS_CloseSesion 
Else 
	BRING TO FRONT:C326($processNumber)
	PCS_UnRegisterProcess (Current process:C322)
	$position:=Find in array:C230(<>alXS_ModuleRef;vlBWR_currentModuleRef)
	<>alXS_ModuleProcessID{$Position}:=0
	
	  //20120827 RCH Se registra cierre de sesion de modulo
	LOG_RegisterEvt ("Cierre de sesión de módulo.")
	
	CANCEL:C270
End if 