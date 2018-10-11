Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
				READ ONLY:C145([Cursos:3])
				READ ONLY:C145([Personas:7])
				OBJECT SET ENTERABLE:C238(*;"IECursoC@";True:C214)
				OBJECT SET ENTERABLE:C238(*;"IECursoA@";True:C214)
				_O_ENABLE BUTTON:C192(*;"BIECursoC@")
				If ([Cursos_Eventos:128]Fecha_Observación:2=!00-00-00!)
					[Cursos_Eventos:128]id_Curso:1:=[Cursos:3]Numero_del_curso:6
					[Cursos_Eventos:128]Fecha_Observación:2:=Current date:C33(*)
					[Cursos_Eventos:128]Categoría:3:="Situación Actual"
					[Cursos_Eventos:128]RegistradoPor_Nombre:7:=<>tUSR_CurrentUser
					[Cursos_Eventos:128]RegistradoPor_Número:6:=<>lUSR_CurrentUserID
					QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
					[Cursos_Eventos:128]ProfesorJefe_Nombre:8:=[Profesores:4]Apellidos_y_nombres:28
					_O_DISABLE BUTTON:C193(b_EliminarEvcCurso)
					SET WINDOW TITLE:C213(__ ("Nuevo Evento para ")+[Cursos:3]Curso:1)
				End if 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
				READ ONLY:C145([Cursos:3])
				READ ONLY:C145([Personas:7])
				OBJECT SET ENTERABLE:C238(*;"IECursoC@";False:C215)
				OBJECT SET ENTERABLE:C238(*;"IECursoA@";False:C215)
				_O_DISABLE BUTTON:C193(*;"BIECursoC@")
		End case 
End case 
