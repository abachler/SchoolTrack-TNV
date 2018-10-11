If (Self:C308->=1)
	IT_SetButtonState (True:C214;->cbDatosCta;->cbDatosApdo)
Else 
	cbDatosApdo:=1
	cbDatosCta:=0
	IT_SetButtonState (False:C215;->cbDatosCta;->cbDatosApdo)
End if 
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)