If ([Alumnos:2]numero_de_matricula:51#"")
	If (KRL_RecordExists (->[Alumnos:2]numero_de_matricula:51))
		$ignore:=CD_Dlog (0;__ ("Ya existe un alumno con este número de matrícula."))
		[Alumnos:2]numero_de_matricula:51:=""
		GOTO OBJECT:C206([Alumnos:2]numero_de_matricula:51)
	End if 
End if 