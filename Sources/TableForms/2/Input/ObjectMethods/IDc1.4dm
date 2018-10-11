If ([Alumnos:2]IDNacional_3:70#"")
	If (KRL_RecordExists (->[Alumnos:2]IDNacional_3:70))
		CD_Dlog (0;__ ("Ya existe un alumno con este identificador."))
		[Alumnos:2]IDNacional_3:70:=""
		GOTO OBJECT:C206([Alumnos:2]IDNacional_3:70)
	End if 
End if 