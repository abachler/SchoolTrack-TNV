If (USR_checkRights ("A";->[Alumnos_EventosEnfermeria:14]))
	AL_UpdateArrays (xALP_ConsultasEnfermeria;0)
	vProfAutoriza:=""
	WDW_OpenFormWindow (->[Alumnos_EventosEnfermeria:14];"Input";-1;4;__ ("Ingreso de: ")+[Alumnos:2]Nombre_Común:30)
	FORM SET INPUT:C55([Alumnos_EventosEnfermeria:14];"Input")
	ADD RECORD:C56([Alumnos_EventosEnfermeria:14];*)
	CLOSE WINDOW:C154
	QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Alumno_Numero:1=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Fecha:2;aDateCE;[Alumnos_EventosEnfermeria:14]Afeccion:6;aMotCons;[Alumnos_EventosEnfermeria:14];aCENo;[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;aCEHora)
	AL_UpdateArrays (xALP_ConsultasEnfermeria;-2)
	AL_SetLine (xALP_ConsultasEnfermeria;0)
Else 
	USR_ALERT_UserHasNoRights (2)
End if 
