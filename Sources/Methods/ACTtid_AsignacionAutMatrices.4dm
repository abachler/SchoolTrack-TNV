//%attributes = {}
  //ACTtid_AsignacionAutMatrices
  //esta variable se usa adentro
C_POINTER:C301($vyQRY_TablePointer;vyQRY_TablePointer)
C_POINTER:C301(yBWR_currentTable;$yBWR_currentTable)
C_TEXT:C284(vsBWR_CurrentModule;$vsBWR_CurrentModule)

ACTcfg_OpcionesListaMatrices ("LeeDia")

If (lACT_ReglasMatricesDia>0)
	If (Day of:C23(Current date:C33(*))=lACT_ReglasMatricesDia)
		
		  //Guarda y escribe variables de ambiente para que se pueda leer la conf.
		$vyQRY_TablePointer:=vyQRY_TablePointer
		vyQRY_TablePointer:=->[ACT_CuentasCorrientes:175]
		$vsBWR_CurrentModule:=vsBWR_CurrentModule
		vsBWR_CurrentModule:="AccountTrack"
		$yBWR_currentTable:=yBWR_currentTable
		yBWR_currentTable:=->[ACT_CuentasCorrientes:175]
		
		ACTinit_LoadPrefs 
		
		ACTcfg_OpcionesListaMatrices ("onLoadConf")
		ACTcfg_OpcionesListaMatrices ("AplicaMatrices")
		
		  //Se restauran valores de conf.
		vyQRY_TablePointer:=$vyQRY_TablePointer
		vsBWR_CurrentModule:=$vsBWR_CurrentModule
		yBWR_currentTable:=$yBWR_currentTable
		
		LOG_RegisterEvt ("Aplicación automática de asignación de matrices de cargo a cuentas corrientes ejecutada para el día "+String:C10(lACT_ReglasMatricesDia)+".")
		
	End if 
End if 