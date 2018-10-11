C_LONGINT:C283($l_campo;$l_columna;$l_fila;$l_Tabla;$l_transaccionOK)
C_POINTER:C301($y_areaEnFoco;$y_variableColumna)
C_TEXT:C284($t_variableColumna)



$y_areaEnFoco:=Focus object:C278
RESOLVE POINTER:C394($y_areaEnFoco;$t_variableColumna;$l_Tabla;$l_campo)
Case of 
	: ($t_variableColumna="lb_Etapas")
		If ((atMPA_EtapasArea>0) & (Size of array:C274(atMPA_EtapasArea)>1))
			LISTBOX GET CELL POSITION:C971(*;"lb_etapas";$l_columna;$l_fila;$y_variableColumna)
			OK:=MPAcfg_Area_EliminaEtapa ([MPA_DefinicionAreas:186]ID:1;alMPA_NivelDesde{$l_fila};alMPA_NivelHasta{$l_fila})
		Else 
			BEEP:C151
		End if 
	: ($t_variableColumna="lb_asignaturasArea")
		If (atMPA_AsignaturasArea>0)
			LISTBOX GET CELL POSITION:C971(*;$t_variableColumna;$l_columna;$l_fila;$y_variableColumna)
			READ WRITE:C146([xxSTR_Materias:20])
			$l_transaccionOK:=MPAcfg_Area_AsignaAsignatura (atMPA_AsignaturasArea{$l_fila};"")
			If ($l_transaccionOK=1)
				AT_Delete ($l_fila;1;->atMPA_AsignaturasArea)
				MPAcfg_Area_AlGuardar 
				SAVE RECORD:C53([MPA_DefinicionAreas:186])
			End if 
		Else 
			BEEP:C151
		End if 
	Else 
		BEEP:C151
End case 