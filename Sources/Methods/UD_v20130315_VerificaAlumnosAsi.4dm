//%attributes = {}
  //UD_v20130315_VerificaAlumnosAsi

C_BOOLEAN:C305($continuar)
C_LONGINT:C283($ok;$i)
ARRAY LONGINT:C221($al_Cursos;0)
ARRAY LONGINT:C221($al_IdAsignatura;0)
ARRAY TEXT:C222($at_NombreCursos;0)
ARRAY LONGINT:C221($al_niveles;0)
$ok:=1
$continuar:=True:C214
START TRANSACTION:C239
ALL RECORDS:C47([Cursos:3])
SELECTION TO ARRAY:C260([Cursos:3];$al_Cursos;[Cursos:3]Curso:1;$at_NombreCursos)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando inscripción de alumnos en asignaturas...")
For ($i;1;Size of array:C274($al_Cursos))
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_Cursos))
	GOTO RECORD:C242([Cursos:3];$al_Cursos{$i})
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
	CREATE SET:C116([Alumnos:2];"Alumnos")
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Curso:5#[Alumnos:2]curso:20)
	QRY_QueryWithArray (->[Asignaturas:18]Curso:5;->$at_NombreCursos;True:C214)
	SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IdAsignatura)
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
	CREATE SET:C116([Alumnos:2];"Alumnos2")
	INTERSECTION:C121("Alumnos";"Alumnos2";"Alumnos2")
	USE SET:C118("Alumnos2")
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
	QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$al_IdAsignatura;True:C214)
	If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
		If (<>vtXS_CountryCode="mx")
			AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]NIvel_Numero:4;->$al_niveles)
			If (Size of array:C274($al_niveles)>0)
				If (Not:C34($al_niveles{Size of array:C274($al_niveles)}#[Alumnos:2]nivel_numero:29))
					$ok:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208])
				End if 
			Else 
				$ok:=1
			End if 
		Else 
			$ok:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208])
		End if 
	End if 
	If ($ok=0)
		$continuar:=False:C215
		$i:=Size of array:C274($al_Cursos)+1
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
If ($continuar)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 
SET_ClearSets ("Alumnos";"Alumnos2")


