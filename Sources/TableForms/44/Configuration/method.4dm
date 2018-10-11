Case of 
	: (Form event:C388=On Load:K2:1)
		CFG_STR_LoadConfiguration ("Evaluacion")
		ENABLE MENU ITEM:C149(1;4)
		
		XS_SetConfigInterface 
		EVS_SeleccionPagina (1)
		LISTBOX SELECT ROW:C912(*;"lbEstilos";1)
		vl_LastEvStyleRecNum:=aEvStyleRecNo{1}
		vlEVS_CurrentEvStyleID:=0
		$l_IdEstilo:=aEvStyleId{1}
		EVS_CargaEstiloEvaluacion ($l_IdEstilo)
		OBJECT SET ENABLED:C1123(*;"botonEliminar";False:C215)
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		EVS_FijaEstadoObjetosInterfaz 
		
	: (Form event:C388=On Unload:K2:2)
		vlEVS_CurrentEvStyleID:=0
		
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 

