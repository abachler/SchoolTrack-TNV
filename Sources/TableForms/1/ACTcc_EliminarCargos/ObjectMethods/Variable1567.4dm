  //IT_Clairvoyance (Self;->atACT_ItemNames2Charge;"";False)
If (atACT_ItemNames2Charge{atACT_ItemNames2Charge}#"")
	$choice:=Find in array:C230(atACT_ItemNames2Charge;atACT_ItemNames2Charge{atACT_ItemNames2Charge})
	If ($choice#-1)
		cbTodosb2:=0
		b2:=1
		vsGlosab2:=atACT_ItemNames2Charge{$choice}
		viACT_IDItem:=alACT_ItemIds2Charge{$choice}
	Else 
		Self:C308->:=""
	End if 
End if 
If ((b1=1) | ((b2=1) & (vsGlosab2#"")) | ((b3=1) & (vsGlosab3#"")) | ((b2=1) & (cbTodosb2=1)) | ((b3=1) & (cbTodosb3=1)))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 