C_LONGINT:C283($l_col;$l_linea)
C_POINTER:C301($vy_pointer)
C_TEXT:C284($t_var)
C_LONGINT:C283($l_campo;$l_tabla)

LISTBOX GET CELL POSITION:C971(lb_multasAut;$l_col;$l_linea;$vy_pointer)

If ($l_linea>0)
	
	ACTcfg_OpcionesRecAutTabla ("EliminaElementoEnArreglos";->$l_linea)
	
End if 