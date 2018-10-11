//%attributes = {}
  // Método: ACTpgr_ManejoPagares
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 16:52:31
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal


If (USR_GetMethodAcces (Current method name:C684))
	  //solo se entra a la pag 2
	WDW_OpenFormWindow (->[ACT_Pagares:184];"Configuracion";-1;4;"Pagarés")
	DIALOG:C40([ACT_Pagares:184];"Configuracion")
	CLOSE WINDOW:C154
End if 