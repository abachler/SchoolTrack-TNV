If (USR_checkRights ("A";->[Alumnos_EventosOrientacion:21]))
	WDW_OpenFormWindow (->[Alumnos_EventosOrientacion:21];"Input";-1;5)
	FORM SET INPUT:C55([Alumnos_EventosOrientacion:21];"Input")
	ADD RECORD:C56([Alumnos_EventosOrientacion:21];*)
	CLOSE WINDOW:C154
	QUERY:C277([Alumnos_EventosOrientacion:21];[Alumnos_EventosOrientacion:21]Alumno_Numero:1=[Alumnos:2]numero:1)
	AL_UpdateFields (xALP_PsyEvents;2)
Else 
	USR_ALERT_UserHasNoRights (2)
End if 
