//%attributes = {}
C_TEXT:C284($modulo;$1)
C_POINTER:C301($tabla;$2)
C_LONGINT:C283($profID;$3)
C_BOOLEAN:C305($altKey;$4)
ARRAY LONGINT:C221($al_RecNumAsignaturasNiveles;0)

$modulo:=$1
$tabla:=$2
$profID:=$3
If (Count parameters:C259=4)
	$altKey:=$4
End if 
$bEsProfJefe:=False:C215
$tCurso:=""
$lTutorID:=0
$tCursoProfesor:=""

$recNum:=Find in field:C653([Cursos:3]Numero_del_profesor_jefe:2;$profID)
If ($recNum>=0)
	READ ONLY:C145([Cursos:3])
	GOTO RECORD:C242([Cursos:3];$recNUm)
	If ([Cursos:3]Numero_del_curso:6>0)
		$bEsProfJefe:=True:C214
		$tCurso:=[Cursos:3]Curso:1
		$tCursoProfesor:=$tCurso
	End if 
End if 

$recNum:=Find in field:C653([Profesores:4]Numero:1;$profID)
If ($recNUm>=0)
	READ ONLY:C145([Profesores:4])
	GOTO RECORD:C242([Profesores:4];$recNum)
	$lTutorID:=[Profesores:4]Numero:1
End if 

Case of 
	: ($modulo="SchoolTrack")
		Case of 
			: ((Table:C252($tabla)=Table:C252(->[Alumnos:2])) & ($profID>0))
				If ($bEsProfJefe)
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$tCurso)
					KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
					CREATE SET:C116([Alumnos:2];"A")
				Else 
					CREATE EMPTY SET:C140([Alumnos:2];"A")
				End if 
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=$profID;*)
				QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=$profID)
				CREATE SET:C116([Asignaturas:18];"asignaturasProf")
				
				  //cargo las asignaturas según la configuración de director y autorizados del nivel
				STR_ResponsableNiveles ("cargaAsignaturas";$profID;->$al_RecNumAsignaturasNiveles)
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
				
			: ((Table:C252($tabla)=Table:C252(->[Cursos:3])) & ($profID>0))
				  //20130520 ASM Para cargar los cursos en donde es profesor Jefe, imparte clases o es profesor firmante
				QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=$profID)
				CREATE SET:C116([Cursos:3];"CursosJefe")
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=$profID;*)
				QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=$profID)
				KRL_RelateSelection (->[Cursos:3]Curso:1;->[Asignaturas:18]Curso:5;"")
				CREATE SET:C116([Cursos:3];"CursosAsig")
				
				UNION:C120("CursosJefe";"CursosAsig";"Cursos")
				
				  //cargo las asignaturas según la configuración de director y autorizados del nivel
				STR_ResponsableNiveles ("cargaAsignaturas";$profID;->$al_RecNumAsignaturasNiveles)
				CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturasNiveles)
				CREATE SET:C116([Asignaturas:18];"asignaturaConfNivel")
				UNION:C120("Cursos";"asignaturaConfNivel";"Cursos")
				
				USE SET:C118("Cursos")
				SET_ClearSets ("CursosJefe";"CursosAsig";"Cursos";asignaturaConfNivel)
				REDUCE SELECTION:C351([Asignaturas:18];0)
				
			: ((Table:C252($tabla)=Table:C252(->[Profesores:4])) & ($profID>0))
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=$profID)
				
			: ((Table:C252($tabla)=Table:C252(->[Profesores:4])))
				If (Not:C34($altKey))
					QUERY SELECTION:C341([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
				End if 
				
				
			: ((Table:C252($tabla)=Table:C252(->[Asignaturas:18])) & ($profID>0))
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=$profID;*)
				QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=$profID)
				CREATE SET:C116([Asignaturas:18];"asignaturasProf")
				
				  //cargo las asignaturas según la configuración de director y autorizados del nivel
				STR_ResponsableNiveles ("cargaAsignaturas";$profID;->$al_RecNumAsignaturasNiveles)
				CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturasNiveles)
				CREATE SET:C116([Asignaturas:18];"asignaturaConfNivel")
				UNION:C120("asignaturasProf";"asignaturaConfNivel";"A")
				SET_ClearSets ("asignaturasProf";"asignaturaConfNivel")
				
				If ($bEsProfJefe)
					QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=$profID)
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
				
				  // MOD Ticket N° 209394 PA 20180621
				QUERY SELECTION BY ATTRIBUTE:C1424([Asignaturas:18];[Asignaturas:18]Opciones:57;"NoMostrarEnSTWA";=;False:C215)
				  //AS_ConfAsignaturaNoVisibleSTWA ("filtrarAsignaturas")
				
			: ((Table:C252($tabla)=Table:C252(->[Actividades:29])) & ($profID>0))
				QUERY:C277([Actividades:29];[Actividades:29]No_Profesor:3=$profID)
				
			: ((Table:C252($tabla)=Table:C252(->[Familia:78])) & ($profID>0))
				Case of 
					: ($tCurso#"")
						QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$tCurso)
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24)
					Else 
						QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=$profID;*)
						QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=$profID)
						CREATE SET:C116([Asignaturas:18];"asignaturasProf")
						
						  //cargo las asignaturas según la configuración de director y autorizados del nivel
						STR_ResponsableNiveles ("cargaAsignaturas";$profID;->$al_RecNumAsignaturasNiveles)
						CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_RecNumAsignaturasNiveles)
						CREATE SET:C116([Asignaturas:18];"asignaturaConfNivel")
						UNION:C120("asignaturasProf";"asignaturaConfNivel";"asignaturaProfConfNivel")
						USE SET:C118("asignaturaProfConfNivel")
						SET_ClearSets ("asignaturasProf";"asignaturaConfNivel";"asignaturaProfConfNivel")
						
						KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1)
						QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
						KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24)
						REDUCE SELECTION:C351([Alumnos:2];0)
						REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
						
				End case 
				
			: (Table:C252($tabla)=Table:C252(->[Cursos:3]))
				If (Not:C34($altKey))  //para no mostrar los de ADT
					If (Records in selection:C76([Cursos:3])>0)
						QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
					End if 
				End if 
		End case 
		
		
	: ($modulo="AccountTrack")
		Case of 
			: (Table:C252($tabla)=Table:C252(->[ACT_CuentasCorrientes:175]))
				If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
					If (Not:C34($altKey))
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					End if 
				End if 
			: (Table:C252($tabla)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				If (Records in selection:C76([ACT_Documentos_de_Pago:176])>0)
					QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
				End if 
			: (Table:C252($tabla)=Table:C252(->[Personas:7]))
				If (Records in selection:C76([Personas:7])>0)
					QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
				End if 
		End case 
		
		
	: ($modulo="AdmissionTrack")
		Case of 
			: (Table:C252($tabla)=Table:C252(->[Profesores:4]))
				If (Records in selection:C76([Profesores:4])>0)
					QUERY SELECTION:C341([Profesores:4];[Profesores:4]Es_Entrevistador_Admisiones:35=True:C214)
				End if 
		End case 
End case 

