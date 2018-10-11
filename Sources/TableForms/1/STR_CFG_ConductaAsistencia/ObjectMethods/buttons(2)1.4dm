C_LONGINT:C283($columna;$fila)
C_POINTER:C301($y_puntero)
LISTBOX GET CELL POSITION:C971(lb_justificacion;$columna;$fila;$y_puntero)
If ($fila>0)
	GOTO SELECTED RECORD:C245([xxSTR_JustificacionAtrasos:227];$fila)
	ST_JustificacionAtrasos ("eliminaMotivo";[xxSTR_JustificacionAtrasos:227]ID:1)
End if 
