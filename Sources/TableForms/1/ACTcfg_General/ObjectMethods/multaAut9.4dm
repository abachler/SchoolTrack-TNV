If (Self:C308->=1)
	cs_GenerarMultaEnMismoAviso:=0
End if 
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)