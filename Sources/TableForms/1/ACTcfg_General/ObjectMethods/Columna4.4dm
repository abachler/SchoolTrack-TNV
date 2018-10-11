C_LONGINT:C283($l_col;$l_linea)
C_POINTER:C301($vy_pointer)
C_TEXT:C284($t_var)
C_LONGINT:C283($l_campo;$l_tabla)

LISTBOX GET CELL POSITION:C971(lb_multasAut;$l_col;$l_linea;$vy_pointer)

If ($l_linea>0)
	C_TEXT:C284($t_nomVar)
	C_LONGINT:C283($l_numTabla;$l_numCampo)
	
	RESOLVE POINTER:C394($vy_pointer;$t_nomVar;$l_numTabla;$l_numCampo)
	
	ACTcfg_OpcionesRecAutTabla ("ClickEnColumnaListBox";->$t_nomVar;->$l_linea)
	
End if 