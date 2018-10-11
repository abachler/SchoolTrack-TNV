Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		C_LONGINT:C283($l_columna;$l_fila)
		C_POINTER:C301($y_punteroVarColumna)
		LISTBOX GET CELL POSITION:C971(lb_tratamientos;$l_columna;$l_fila;$y_punteroVarColumna)
		$y_punteroVarColumna->{$l_fila}:=DT_PopCalendar 
		vl_ModSalud:=vl_ModSalud ?+ 6
End case 
