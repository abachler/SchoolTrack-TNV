//%attributes = {}
  //SN3_OpenConfig_ConsultaUsuarios

  //20152010 JVP agrego validacion de modulo y proceso
If (LICENCIA_esModuloAutorizado (1;SchoolNet))
	
	If (USR_GetMethodAcces (Current method name:C684))
		WDW_OpenFormWindow (->[SN3_PublicationPrefs:161];"ConsultaUsuarios";0;4;__ ("Configuración SchoolNet"))
		DIALOG:C40([SN3_PublicationPrefs:161];"ConsultaUsuarios")
		CLOSE WINDOW:C154
		
	End if 
	
	
Else 
	CD_Dlog (0;__ ("Lo siento, Ud. no está autorizado para utilizar esta función."))
	ok:=0
End if 