If (Form event:C388=On Data Change:K2:15)
	C_POINTER:C301($y_codigo)
	C_LONGINT:C283($l_col;$l_line;$l_cuantos)
	
	$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"atACT_CatCodigo")
	LISTBOX GET CELL POSITION:C971(*;"lb_categoriasItems";$l_col;$l_line)
	If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))
		If ($y_codigo->{$l_line}#"")
			$l_cuantos:=Count in array:C907($y_codigo->;$y_codigo->{$l_line})
			If ($l_cuantos>1)
				CD_Dlog (0;"Aviso: Este valor ya fue asignado a otra categoría")
			End if 
		End if 
	Else 
		BEEP:C151
	End if 
End if 