If (Self:C308->=1)
	vsGlosab2:=""
	viACT_IDItem:=0
	b2:=1
End if 
IT_SetButtonState (((b2=1) & ((cbTodosb2=1) | (viACT_IDItem#0)));->bNext)