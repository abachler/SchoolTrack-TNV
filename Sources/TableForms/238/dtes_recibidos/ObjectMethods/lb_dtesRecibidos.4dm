C_LONGINT:C283($l_col;$l_linea)
C_POINTER:C301($vy_pointer)
C_TEXT:C284($t_var)
C_LONGINT:C283($l_campo;$l_tabla)

LISTBOX GET CELL POSITION:C971(lb_dtesRecibidos;$l_col;$l_linea;$vy_pointer)

If ($l_col>0)
	RESOLVE POINTER:C394($vy_pointer;$t_var;$l_tabla;$l_campo)
	
	Case of 
		: ($t_var="atACT_PDF")
			If (atACT_PDF{$l_linea}=__ ("Ver"))
				SHOW ON DISK:C922(atACT_PDF_ruta{$l_linea})
			End if 
	End case 
	
End if 
