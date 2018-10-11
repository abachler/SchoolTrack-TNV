If (USR_checkRights ("A";->[Alumnos_ObsOrientacion:127]))
	WDW_OpenFormWindow (->[Alumnos_ObsOrientacion:127];"Input";-1;5)
	FORM SET INPUT:C55([Alumnos_ObsOrientacion:127];"Input")
	ADD RECORD:C56([Alumnos_ObsOrientacion:127];*)
	CLOSE WINDOW:C154
	QUERY:C277([Alumnos_ObsOrientacion:127];[Alumnos_ObsOrientacion:127]Alumno_Numero:1=[Alumnos:2]numero:1)
	AL_UpdateFields (xALP_PsyObs;2)
Else 
	USR_ALERT_UserHasNoRights (2)
End if 
