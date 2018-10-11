LOAD RECORD:C52([Asignaturas_PlanesDeClases:169])
If ([Asignaturas_PlanesDeClases:169]Nombre:14#vtSTK_NombrePlan)
	[Asignaturas_PlanesDeClases:169]Nombre:14:=vtSTK_NombrePlan
	SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
	  //MONO 193174
	$t_logmsj:="Planes de Clases: Modificación del plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
	$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
	$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
	LOG_RegisterEvt ($t_logmsj)
End if 