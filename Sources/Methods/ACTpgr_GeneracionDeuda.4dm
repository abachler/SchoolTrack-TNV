//%attributes = {}
  // Método: ACTpgr_GeneracionDeuda
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 16:50:33
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

If (USR_GetMethodAcces (Current method name:C684))
	If (Not:C34(Test semaphore:C652("ACT_ConfiguracionPagare")))
		WDW_OpenFormWindow (->[ACT_Pagares:184];"GeneracionPagares";-1;4;"Generación de deuda")
		DIALOG:C40([ACT_Pagares:184];"GeneracionPagares")
		CLOSE WINDOW:C154
	Else 
		CD_Dlog (0;"En este momento hay algún usuario en la configuración. Intente generar deudas en "+"otro momento.")
	End if 
End if 