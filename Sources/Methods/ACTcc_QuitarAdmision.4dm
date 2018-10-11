//%attributes = {}
  //ACTcc_QuitarAdmision

If (viACT_AsignarMatAdmision=0)
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
	CREATE SET:C116([Alumnos:2];"todos")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29;<=;Nivel_AdmisionDirecta*1)
	CREATE SET:C116([Alumnos:2];"admision")
	DIFFERENCE:C122("todos";"admision";"todos")
	USE SET:C118("todos")
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
	SET_ClearSets ("todos";"admision")
End if 