Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		C_POINTER:C301($y_punteroVarColumna)
		C_LONGINT:C283($l_fila;$l_columna)
		LISTBOX GET CELL POSITION:C971(lb_enfermedades;$l_columna;$l_fila;$y_punteroVarColumna)
		ad_fechaEnfermedad{$l_fila}:=DT_PopCalendar 
		vl_ModSalud:=vl_ModSalud ?+ 0
End case 