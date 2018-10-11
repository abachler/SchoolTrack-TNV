

If (Self:C308->=1)
	C_BOOLEAN:C305($vb_value)
	$vb_value:=(Self:C308->=1)
	ACTbol_OpcionesDuplicacionNC ("SetArrayDuplica";->$vb_value)
	If (Self:C308->=1)
		vbACT_calculaMontoDup:=True:C214
	End if 
Else 
	vr_montoDuplicacion:=0
End if 