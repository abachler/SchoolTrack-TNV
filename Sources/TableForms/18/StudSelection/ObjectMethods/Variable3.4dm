If ((ALProEvt=1) | (ALProEvt=2) | (ALProEvt=-2))
	ARRAY INTEGER:C220(aSelect;0)
	$rslt:=AL_GetSelect (xALP_List;aSelect)
End if 
If (Size of array:C274(aSelect)>0)
	_O_ENABLE BUTTON:C192(bInscribe)
Else 
	_O_DISABLE BUTTON:C193(bInscribe)
End if 