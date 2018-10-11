//%attributes = {}

  //
  //If (USR_GetMethodAcces (Current method name))
  //WDW_OpenFormWindow (->[SN3_PublicationPrefs];"GAFE";0;4;"GAFE")
  //DIALOG([SN3_PublicationPrefs];"GAFE")
  //CLOSE WINDOW
  //End if x

  //20151125 JVP agrego validacion de modulo y proceso
If (LICENCIA_esModuloAutorizado (1;SchoolNet))
	If (USR_GetMethodAcces (Current method name:C684))
		WDW_OpenFormWindow (->[SN3_PublicationPrefs:161];"GAFE";0;4;"GAFE")
		DIALOG:C40([SN3_PublicationPrefs:161];"GAFE")
		CLOSE WINDOW:C154
	End if 
	
Else 
	CD_Dlog (0;__ ("Lo siento, Ud. no está autorizado para utilizar esta función."))
	ok:=0
End if 

