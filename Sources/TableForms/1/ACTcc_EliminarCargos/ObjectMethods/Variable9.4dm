IT_Clairvoyance (Self:C308;-><>atACT_CargosExtraordinarios;"";False:C215)
If (Self:C308->#"")
	$choice:=Find in array:C230(<>atACT_CargosExtraordinarios;Self:C308->)
	If ($choice#-1)
		cbTodosb3:=0
		b3:=1
		vsGlosab3:=<>atACT_CargosExtraordinarios{$choice}
	Else 
		Self:C308->:=""
	End if 
End if 
If ((b1=1) | ((b2=1) & (vsGlosab2#"")) | ((b3=1) & (vsGlosab3#"")) | ((b2=1) & (cbTodosb2=1)) | ((b3=1) & (cbTodosb3=1)))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 

