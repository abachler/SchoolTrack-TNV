IT_clairvoyanceOnFields2 (Self:C308;->[Profesores:4]Apellidos_y_nombres:28;True:C214)

If (vProfAutoriza="")
	KRL_UnloadReadOnly (->[Profesores:4])
	UNLOAD RECORD:C212([Profesores:4])
	[Alumnos_EventosEnfermeria:14]ID_Profesor_Autoriza:13:=0
End if 

If (Record number:C243([Profesores:4])#-1)
	[Alumnos_EventosEnfermeria:14]ID_Profesor_Autoriza:13:=[Profesores:4]Numero:1
End if 
vbSpell_StopChecking:=True:C214