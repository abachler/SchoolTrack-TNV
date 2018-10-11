Case of 
	: (Form event:C388=On Printing Detail:K2:18)
		RELATE ONE:C42([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
		vHeader:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
		vSesion:="Sesión del "+DT_Date2SpanishString ([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
		  //vTeacher:=[Profesores]Nombre_común
		
		  //20120704 RCH
		If ([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10#0)
			vTeacher:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10;->[Profesores:4]Nombre_comun:21)
			If ((vTeacher="") & ([Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11#""))
				vTeacher:=[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11
			End if 
		Else 
			vTeacher:=[Profesores:4]Nombre_comun:21
		End if 
		
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$stdID;[Alumnos:2]apellidos_y_nombres:40;aText1)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		SORT ARRAY:C229(aText1;>)
		vt_Absents:=AT_array2text (->aText1;", ")
End case 
