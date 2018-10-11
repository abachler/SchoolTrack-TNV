Self:C308->:=ST_Format (Self:C308;->[Alumnos:2]Apellido_materno:4)
If (Form event:C388=On Data Change:K2:15)
	vbSpell_StopChecking:=True:C214
End if 