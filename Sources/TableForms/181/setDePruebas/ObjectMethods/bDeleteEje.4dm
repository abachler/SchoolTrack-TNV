C_LONGINT:C283($vl_col;$vl_line)
C_POINTER:C301($vy_var)

LISTBOX GET CELL POSITION:C971(lb_setPruebas;$vl_col;$vl_line;$vy_var)
If ($vl_line>0)
	ACTdte_setPruebasOpcionesGen ("EliminaElementoDetalle";->$vl_line)
End if 
