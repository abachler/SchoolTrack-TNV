  //$choice:=Pop up menu(vtACT_Items)
$choice:=ACTKRL_PopUp (->atACT_ItemNames2Charge)

If ($choice>0)
	cbTodosb2:=0
	b2:=1
	vsGlosab2:=atACT_ItemNames2Charge{$choice}
	viACT_IDItem:=alACT_ItemIds2Charge{$choice}
End if 
IT_SetButtonState (((b2=1) & ((cbTodosb2=1) | (viACT_IDItem#0)));->bNext)