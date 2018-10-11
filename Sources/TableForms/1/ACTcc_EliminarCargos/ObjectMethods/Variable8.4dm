IT_Clairvoyance (Self:C308;->atACT_ItemNames2Charge;"";False:C215)
If (Self:C308->#"")
	$choice:=Find in array:C230(atACT_ItemNames2Charge;Self:C308->)
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