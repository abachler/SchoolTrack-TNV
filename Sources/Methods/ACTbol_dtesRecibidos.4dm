//%attributes = {}
  //ACTbol_dtesRecibidos

TRACE:C157
  //en produccion crear el proceso autorizado
If (LICENCIA_esModuloAutorizado (1;12))
	If (USR_GetMethodAcces (Current method name:C684))
		ACTcfg_DeclaraArreglos ("ACTdteRecibidos_Listado")
		
		WDW_OpenFormWindow (->[ACT_DTEs_Recibidos:238];"dtes_recibidos";-1;4;__ ("Documentos recibidos"))
		DIALOG:C40([ACT_DTEs_Recibidos:238];"dtes_recibidos")
		CLOSE WINDOW:C154
		
		ACTcfg_DeclaraArreglos ("ACTdteRecibidos_Listado")
	End if 
Else 
	CD_Dlog (0;__ ("Su licencia no permite ejecutar esta opción."))
End if 