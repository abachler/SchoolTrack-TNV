If (Self:C308->=1)
	viPST_MotherAA:=0
	[Alumnos:2]Apoderado_académico_Número:27:=vlPST_IDFATHER
	SAVE RECORD:C53([Alumnos:2])
End if 
PST_UpdateParents ("Mother")
PST_UpdateParents ("Father")