AL_SetIdentificadorPrincipal 
If ([Alumnos:2]Fecha_de_nacimiento:7#Old:C35([Alumnos:2]Fecha_de_nacimiento:7))
	READ WRITE:C146([Alumnos_ControlesMedicos:99])
	QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Numero_Alumno:1=[Alumnos:2]numero:1)
	While (Not:C34(End selection:C36([Alumnos_ControlesMedicos:99])))
		[Alumnos_ControlesMedicos:99]Edad:4:=DT_ReturnAgeLongString ([Alumnos:2]Fecha_de_nacimiento:7;[Alumnos_ControlesMedicos:99]Fecha:2)
		SAVE RECORD:C53([Alumnos_ControlesMedicos:99])
		NEXT RECORD:C51([Alumnos_ControlesMedicos:99])
	End while 
	UNLOAD RECORD:C212([Alumnos_ControlesMedicos:99])
	READ ONLY:C145([Alumnos_ControlesMedicos:99])
End if 