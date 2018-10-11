Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		C_POINTER:C301($y_punteroVarColumna)
		C_LONGINT:C283($l_fila;$l_columna)
		LISTBOX GET CELL POSITION:C971(lb_enfermedades;$l_columna;$l_fila;$y_punteroVarColumna)
		If ($l_fila#0)
			$l_posSeleccionado:=IT_DynamicPopupMenu_Array (-><>aEnfermedades)
			aEnfermedad{$l_fila}:=<>aEnfermedades{$l_posSeleccionado}
			al_idEnfermedad{$l_fila}:=-1
			vl_ModSalud:=vl_ModSalud ?+ 0
		End if 
End case 