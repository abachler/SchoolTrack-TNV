Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		
		C_LONGINT:C283($vl_col;$vl_line)
		C_POINTER:C301($vy_var)
		C_REAL:C285($vr_decuento)
		
		LISTBOX GET CELL POSITION:C971(lb_listadoSet;$vl_col;$vl_line;$vy_var)
		If ($vl_line>0)
			ACTdte_setPruebasOpcionesGen ("EditaCaso";->$vl_line)
		End if 
		
End case 