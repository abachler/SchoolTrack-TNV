  // [Familia_RelacionesFamiliares].Formulario1()
  // Por: Alberto Bachler: 13/05/13, 17:20:49
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



If (Form event:C388=On Display Detail:K2:22)
	READ ONLY:C145([Personas:7])
	RELATE ONE:C42([Familia_RelacionesFamiliares:77]ID_Persona:3)
	
	vt_Familia:=KRL_GetTextFieldData (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Nombre_de_la_familia:3)
	vt_Alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Familia_RelacionesFamiliares:77]ID_Alumno:1;->[Alumnos:2]apellidos_y_nombres:40)
	
End if 