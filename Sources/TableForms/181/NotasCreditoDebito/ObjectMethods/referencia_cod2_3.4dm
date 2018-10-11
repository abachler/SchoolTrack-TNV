If ([ACT_Boletas:181]DTE_estado_id:24 ?? 2)
	C_LONGINT:C283($l_columna;$l_linea)
	C_POINTER:C301($vy_arrayPointer)
	LISTBOX GET CELL POSITION:C971(lb_detalleNC;$l_columna;$l_linea;$vy_arrayPointer)
	If ($l_linea>0)
		AT_Delete ($l_linea;1;$vy_arrayPointer)
	End if 
Else 
	CD_Dlog (0;"El documento ya fue enviado a dte. No es posible modificar este detalle.")
End if 