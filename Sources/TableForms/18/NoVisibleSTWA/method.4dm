Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($l_pos)
		$l_pos:=Find in array:C230(ab_noVisible;False:C215)
		If ($l_pos=-1)
			$y_pointerCHK:=OBJECT Get pointer:C1124(Object named:K67:5;"MarcarTodos")
			$y_pointerCHK->:=1
		End if 
End case 