If ([Alumnos:2]IDNacional_2:71#"")
	If (KRL_RecordExists (->[Alumnos:2]IDNacional_2:71))
		CD_Dlog (0;__ ("Ya existe un alumno con este identificador."))
		[Alumnos:2]IDNacional_2:71:=""
		GOTO OBJECT:C206([Alumnos:2]IDNacional_2:71)
	End if 
End if 