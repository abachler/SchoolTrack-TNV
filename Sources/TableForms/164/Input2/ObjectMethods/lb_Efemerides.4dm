If (Form event:C388=On Double Clicked:K2:5)
	C_LONGINT:C283($col;$row)
	LISTBOX GET CELL POSITION:C971(lb_Efemerides;$col;$row)
	LBX_EditItem_byObjectPointer ("lb_Efemerides";Self:C308;$row)
End if 