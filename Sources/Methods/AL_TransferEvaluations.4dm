//%attributes = {}
  // AL_TransferEvaluations()
  //
  //
  // creado por: Alberto Bachler Klein: 30-11-16, 10:18:36
  // -----------------------------------------------------------
C_LONGINT:C283($fia;$i;$idDestino;$l_elemento;$l_ignorado;$l_opcionSexo;$l_recumAsignaturas;$l_recumCalificaciones;$ok)

ARRAY LONGINT:C221($al_elementosEncontrados;0)
ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_IdAsignaturasDestino;0)
ARRAY LONGINT:C221($al_IdAsignaturasOrigen;0)
ARRAY LONGINT:C221($al_recNumAsignaturasDestino;0)
ARRAY LONGINT:C221($id_destino_ordenado;0)
ARRAY TEXT:C222($at_llaveCalificacion;0)
ARRAY TEXT:C222($at_nombreInternoDestino;0)
ARRAY TEXT:C222($at_nombreInternoOrigen;0)
ARRAY TEXT:C222($at_nombreOficialDestino;0)
ARRAY TEXT:C222($at_nombreOficialOrigen;0)

Case of 
	: ([Alumnos:2]Sexo:49="F")
		$l_opcionSexo:=2
	: ([Alumnos:2]Sexo:49="M")
		$l_opcionSexo:=3
	Else 
		$l_opcionSexo:=1
End case 

READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
READ ONLY:C145([Asignaturas:18])


USE SET:C118("AsignaturasDestino")

QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Seleccion_por_sexo:24=1;*)
QUERY SELECTION:C341([Asignaturas:18]; | [Asignaturas:18]Seleccion_por_sexo:24=$l_opcionSexo)
CREATE SET:C116([Asignaturas:18];"Asignaturas de destino")
SELECTION TO ARRAY:C260([Asignaturas:18];$al_recNumAsignaturasDestino;[Asignaturas:18]Numero:1;$al_IdAsignaturasDestino;[Asignaturas:18]Asignatura:3;$at_nombreOficialDestino;[Asignaturas:18]denominacion_interna:16;$at_nombreInternoDestino)


  //búsqueda de las notas existentes del alumno
  //en asignaturas obligatorias (sin selección)
EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Consolidacion_Madre_Id:7=0;*)
QUERY SELECTION:C341([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17=False:C215)

QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Seleccion_por_sexo:24=1;*)
QUERY SELECTION:C341([Asignaturas:18]; | [Asignaturas:18]Seleccion_por_sexo:24=$l_opcionSexo)
KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Llave_principal:1;$at_llaveCalificacion;[Asignaturas:18]Asignatura:3;$at_nombreOficialOrigen;[Asignaturas:18]denominacion_interna:16;$at_nombreInternoOrigen;[Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IdAsignaturasOrigen)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)



$ok:=1
  //TRANSFERENCIA DE LAS EVALUACIONES A LAS ASIGNATURAS DE DESTINO
If (Size of array:C274($at_llaveCalificacion)>0)
	For ($i;1;Size of array:C274($at_llaveCalificacion))
		$l_recumCalificaciones:=Find in field:C653([Alumnos_Calificaciones:208]Llave_principal:1;$at_llaveCalificacion{$i})
		If ($l_recumCalificaciones>=0)
			$l_recumAsignaturas:=Find in field:C653([Asignaturas:18]Numero:1;$al_IdAsignaturasOrigen{$i})
			If ($l_recumAsignaturas>=0)
				AT_Initialize (->$al_IdAlumnos)
				APPEND TO ARRAY:C911($al_IdAlumnos;[Alumnos:2]numero:1)
				GOTO RECORD:C242([Alumnos_Calificaciones:208];$l_recumCalificaciones)
				$at_nombreOficialDestino{0}:=$at_nombreOficialOrigen{$i}
				$at_nombreInternoDestino{0}:=$at_nombreInternoOrigen{$i}
				AT_Initialize (->$al_elementosEncontrados)
				$l_ignorado:=AT_MultiArraySearch (False:C215;->$al_elementosEncontrados;->$at_nombreOficialDestino;->$at_nombreInternoDestino)
				If (Size of array:C274($al_elementosEncontrados)=1)
					$l_elemento:=$al_elementosEncontrados{1}
					$idDestino:=$al_IdAsignaturasDestino{$l_elemento}
					$OK:=EV2_TransfiereEvaluaciones ($al_IdAsignaturasOrigen{$i};$al_IdAsignaturasDestino{$l_elemento};->$al_IdAlumnos)
				Else 
					$OK:=KRL_DeleteRecord (->[Alumnos_Calificaciones:208];$l_recumCalificaciones)
				End if 
				If ($OK=0)
					$i:=Size of array:C274($l_recumCalificaciones)+1
				End if 
			End if 
		End if 
	End for 
End if 



If ($ok=1)
	USE SET:C118("Asignaturas de destino")
	CLEAR SET:C117("Asignaturas de destino")
	For ($i;1;Size of array:C274($al_recNumAsignaturasDestino))
		READ WRITE:C146([Asignaturas:18])
		GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturasDestino{$i})
		If (Locked:C147([Asignaturas:18]))
			$ok:=0
			$i:=Size of array:C274($al_recNumAsignaturasDestino)+1
		Else 
			AS_CreaRegistrosEvaluacion ([Alumnos:2]numero:1;[Asignaturas:18]Numero:1)
		End if 
		ASsev_Parcial_a_Subasignatura   // si en la asignatura de destino hay subasignaturas inscribimos el parcial de la madre en las subasignaturas
		UNLOAD RECORD:C212([Asignaturas:18])
		READ ONLY:C145([Asignaturas:18])
	End for 
End if 

$0:=$OK

KRL_UnloadReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])

$0:=$OK

