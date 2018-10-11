Case of 
	: (Form event:C388=On Data Change:K2:15)
		
		C_LONGINT:C283($vl_line;$vl_col)
		C_POINTER:C301($vy_pointer)
		LISTBOX GET CELL POSITION:C971(lb_setPruebas;$vl_col;$vl_line;$vy_pointer)
		
		Case of 
			: ($vl_col=1)
				If (Length:C16($vy_pointer->{$vl_line})>80)
					$vy_pointer->{$vl_line}:=Substring:C12($vy_pointer->{$vl_line};1;80)
					CD_Dlog (0;__ ("El número máximo de caracteres es 80."))
				End if 
		End case 
End case 