//%attributes = {}
  //SN3_OpenConfig_ActuaDatos


  //20152010 JVP agrego validacion de modulo y proceso
If (LICENCIA_esModuloAutorizado (1;SchoolNet))
	
	If (USR_GetMethodAcces (Current method name:C684))
		
		WDW_OpenFormWindow (->[SN3_PublicationPrefs:161];"ActuaDatos_ConfigPanel";0;4;__ ("Actualización de Datos"))
		DIALOG:C40([SN3_PublicationPrefs:161];"ActuaDatos_ConfigPanel")
		CLOSE WINDOW:C154
		
	End if 
	
	
Else 
	CD_Dlog (0;__ ("Lo siento, Ud. no está autorizado para utilizar esta función."))
	ok:=0
End if 