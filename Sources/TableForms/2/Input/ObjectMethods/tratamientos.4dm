Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_LONGINT:C283($l_columna;$l_fila)
		C_POINTER:C301($y_punteroVarColumna)
		$l_fila:=0
		$l_columna:=0
		LISTBOX GET CELL POSITION:C971(lb_tratamientos;$l_columna;$l_fila;$y_punteroVarColumna)
		If ((Size of array:C274($y_punteroVarColumna->)>0) & ($l_fila<=Size of array:C274($y_punteroVarColumna->)))
			OBJECT SET ENABLED:C1123(*;"buttonsTratamientodelete";True:C214)
		End if 
End case 