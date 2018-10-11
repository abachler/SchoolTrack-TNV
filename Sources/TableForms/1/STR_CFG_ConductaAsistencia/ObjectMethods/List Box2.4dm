Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_LONGINT:C283($columna;$fila)
		C_POINTER:C301($y_puntero)
		LISTBOX GET CELL POSITION:C971(lb_justificacion;$columna;$fila;$y_puntero)
		GOTO SELECTED RECORD:C245([xxSTR_JustificacionAtrasos:227];$fila)
		KRL_ReloadInReadWriteMode (->[xxSTR_JustificacionAtrasos:227])
End case 