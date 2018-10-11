Case of 
	: (Form event:C388=On Data Change:K2:15)
		C_LONGINT:C283($l_columna;$l_fila;$l_pos)
		C_POINTER:C301($y_pointerArray;$y_pointerCHK)
		LISTBOX GET CELL POSITION:C971(*;"Lb_NoVisbleSTWA";$l_columna;$l_fila;$y_pointerArray)
		$y_pointerCHK:=OBJECT Get pointer:C1124(Object named:K67:5;"MarcarTodos")
		If (Not:C34($y_pointerArray->{$l_fila}))
			$y_pointerCHK->:=0
		Else 
			$l_pos:=Find in array:C230(ab_noVisible;False:C215)
			If ($l_pos=-1)
				$y_pointerCHK->:=1
			End if 
		End if 
		
End case 