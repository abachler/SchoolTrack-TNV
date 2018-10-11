If (Self:C308->=1)
	viPST_FatherAC:=0
	[Alumnos:2]Apoderado_Cuentas_Número:28:=vlPST_IDMOTHER
	SAVE RECORD:C53([Alumnos:2])
End if 
PST_UpdateParents ("Mother")
PST_UpdateParents ("Father")