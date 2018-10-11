//%attributes = {}
TRACE:C157
  //en produccion crear el proceso autorizado

If (USR_GetMethodAcces (Current method name:C684))
	ACTcfg_DeclaraArreglos ("ACTdteEmitidos_Listado")
	
	C_BOOLEAN:C305(vbACT_sobreSeleccion)
	vbACT_sobreSeleccion:=False:C215
	If (Count parameters:C259>=1)
		vbACT_sobreSeleccion:=$1
	End if 
	
	WDW_OpenFormWindow (->[ACT_Boletas:181];"DTEsEmitidos";-1;4;__ ("Obtener PDFs"))
	DIALOG:C40([ACT_Boletas:181];"DTEsEmitidos")
	CLOSE WINDOW:C154
	
	ACTcfg_DeclaraArreglos ("ACTdteEmitidos_Listado")
	vbACT_sobreSeleccion:=False:C215
End if 