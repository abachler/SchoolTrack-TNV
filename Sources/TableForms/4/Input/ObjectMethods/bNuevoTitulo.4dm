If (USR_checkRights ("M";->[Profesores:4]))
	WDW_Open (354;107;1;Movable form dialog box:K39:8;"Títulos";"WDW_Close")
	FORM SET INPUT:C55([Profesores_Titulos:216];"Input")
	ADD RECORD:C56([Profesores_Titulos:216];*)
	CLOSE WINDOW:C154
	ARRAY TEXT:C222(at_TitulosProfesores;0)
	QUERY:C277([Profesores_Titulos:216];[Profesores_Titulos:216]ID_Profesor:5=[Profesores:4]Numero:1)
	SELECTION TO ARRAY:C260([Profesores_Titulos:216]Titulo:1;at_TitulosProfesores)
Else 
	USR_ALERT_UserHasNoRights (0)
End if 