//%attributes = {}
  //dhBWR_SpecialSearch
  //20111122 AS. agregue una validación para que no se muestren los alumnos retirados, a menos que se mantenga presionada la tecla Alt.
If ("Instrucciones"="")
	  // utilizar para realizar busquedas especiales antes de cargar la seleccion en el explorador
End if 

ARRAY LONGINT:C221($al_RecNumAsignaturasNiveles;0)

Case of 
	: (<>vsXS_CurrentModule="SchoolTrack")
		Case of 
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (<>lUSR_RelatedTableUserID>0))
				If (<>bUSR_EsProfesorJefe)
					QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=<>lUSR_RelatedTableUserID)
					KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
					CREATE SET:C116([Alumnos:2];"A")
				Else 
					CREATE EMPTY SET:C140([Alumnos:2];"A")
				End if 
				
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=<>lUSR_RelatedTableUserID;*)
				QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=<>lUSR_RelatedTableUserID)
				CREATE SET:C116([Asignaturas:18];"asignaturasProf")
				
				  //20180630 ticket 210832 cargo las asignaturas según la configuración de director y autorizados del nivel
				STR_ResponsableNiveles ("cargaAsignaturas";<>lUSR_RelatedTableUserID;->$al_RecNumAsignaturasNiveles)
				CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturasNiveles)
				CREATE SET:C116([Asignaturas:18];"asignaturaConfNivel")
				UNION:C120("asignaturasProf";"asignaturaConfNivel";"asignaturaProfConfNivel")
				USE SET:C118("asignaturaProfConfNivel")
				SET_ClearSets ("asignaturasProf";"asignaturaConfNivel";"asignaturaProfConfNivel")
				
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				CREATE SET:C116([Alumnos:2];"B")
				UNION:C120("A";"B";"C")
				USE SET:C118("C")
				SET_ClearSets ("A";"B";"C")
				
				REDUCE SELECTION:C351([Asignaturas:18];0)
				REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT";*)
				QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]curso:20#"POST")
				
				If (Not:C34(IT_AltKeyIsDown ))
					  //QUERY SELECTION([Alumnos]; & ;[Alumnos]Status#"Ret@";*)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29#Nivel_Retirados;*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]ocultoEnNominas:89=False:C215)
				End if 
				
				
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3])) & (<>lUSR_RelatedTableUserID>0))
				
				  //20130520 ASM Para cargar los cursos en donde es profesor Jefe, imparte clases o es profesor firmante
				QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=<>lUSR_RelatedTableUserID)
				CREATE SET:C116([Cursos:3];"CursosJefe")
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=<>lUSR_RelatedTableUserID;*)
				QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=<>lUSR_RelatedTableUserID)
				KRL_RelateSelection (->[Cursos:3]Curso:1;->[Asignaturas:18]Curso:5;"")
				CREATE SET:C116([Cursos:3];"CursosAsig")
				
				UNION:C120("CursosJefe";"CursosAsig";"Cursos")
				
				  //ASM 20180630 Ticket 210832 cargo las asignaturas según la configuración de director y autorizados del nivel 
				STR_ResponsableNiveles ("cargaAsignaturas";<>lUSR_RelatedTableUserID;->$al_RecNumAsignaturasNiveles)
				CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturasNiveles)
				KRL_RelateSelection (->[Cursos:3]Curso:1;->[Asignaturas:18]Curso:5;"")
				CREATE SET:C116([Cursos:3];"asignaturaConfNivel")
				UNION:C120("Cursos";"asignaturaConfNivel";"Cursos")
				
				USE SET:C118("Cursos")
				SET_ClearSets ("CursosJefe";"CursosAsig";"Cursos";"asignaturaConfNivel")
				REDUCE SELECTION:C351([Asignaturas:18];0)
				
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4])) & (<>lUSR_RelatedTableUserID>0))
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=<>lUSR_RelatedTableUserID)
				
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4])))
				If (Not:C34(IT_AltKeyIsDown ))
					QUERY SELECTION:C341([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
				End if 
				
				
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18])) & (<>lUSR_RelatedTableUserID>0))
				ARRAY LONGINT:C221($al_RecNumAsignaturasNiveles;0)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=<>lUSR_RelatedTableUserID;*)
				QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=<>lUSR_RelatedTableUserID)
				
				CREATE SET:C116([Asignaturas:18];"asignaturasProf")
				
				  //cargo las asignaturas según la configuración de director y autorizados del nivel
				STR_ResponsableNiveles ("cargaAsignaturas";<>lUSR_RelatedTableUserID;->$al_RecNumAsignaturasNiveles)
				CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturasNiveles)
				CREATE SET:C116([Asignaturas:18];"asignaturaConfNivel")
				UNION:C120("asignaturasProf";"asignaturaConfNivel";"A")
				USE SET:C118("A")
				SET_ClearSets ("asignaturasProf";"asignaturaConfNivel")
				
				If (<>bUSR_EsProfesorJefe)
					  //QUERY([Cursos];[Cursos]Curso=<>tUSR_Curso)
					  //20130523 ASM para cargar los cursos en donde es profesor jefe.
					QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=<>lUSR_RelatedTableUserID)
					KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
					KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
					CREATE SET:C116([Asignaturas:18];"B")
				Else 
					CREATE EMPTY SET:C140([Asignaturas:18];"B")
				End if 
				
				UNION:C120("A";"B";"C")
				USE SET:C118("C")
				SET_ClearSets ("A";"B";"C")
				
				
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Actividades:29])) & (<>lUSR_RelatedTableUserID>0))
				QUERY:C277([Actividades:29];[Actividades:29]No_Profesor:3=<>lUSR_RelatedTableUserID)
				
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78])) & (<>lUSR_RelatedTableUserID>0))
				Case of 
					: (<>tUSR_Curso#"")
						QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=<>tUSR_Curso)
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24)
					Else 
						QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=<>lUSR_RelatedTableUserID;*)
						QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=<>lUSR_RelatedTableUserID)
						KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1)
						QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
						KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						
						If (Not:C34(IT_AltKeyIsDown ))
							QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Status:50#"Ret@";*)
							QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29#Nivel_Retirados)
						End if 
						
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24)
						REDUCE SELECTION:C351([Alumnos:2];0)
						REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
						
				End case 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
				If (Not:C34(IT_AltKeyIsDown ))  //para no mostrar los de ADT
					If (Records in selection:C76([Cursos:3])>0)
						QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
					End if 
				End if 
		End case 
		
		
	: (<>vsXS_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
					If (Not:C34(IT_AltKeyIsDown ))
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					End if 
				End if 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				If (Records in selection:C76([ACT_Documentos_de_Pago:176])>0)
					QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
				End if 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				If (Records in selection:C76([Personas:7])>0)
					QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
				End if 
		End case 
		
		
	: (<>vsXS_CurrentModule="AdmissionTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				If (Records in selection:C76([Profesores:4])>0)
					QUERY SELECTION:C341([Profesores:4];[Profesores:4]Es_Entrevistador_Admisiones:35=True:C214)
				End if 
		End case 
End case 
