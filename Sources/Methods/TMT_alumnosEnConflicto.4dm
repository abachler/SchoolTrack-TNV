//%attributes = {}
  // TMT_alumnosEnConflicto()
  // Por: Alberto Bachler: 15/06/13, 08:17:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_POINTER:C301($6)
C_POINTER:C301($7)

C_BOOLEAN:C305($b_ConflictoAlumnos;$b_ConflictoBloqueHorario)
C_DATE:C307($d_inicioSesiones;$d_terminoSesiones)
_O_C_INTEGER:C282($i_alumnosAsignados)
C_LONGINT:C283($l_elemento;$l_elementoEnAsignaciones;$l_enConflictos;$l_IdAsignatura;$l_IdProfesor;$l_NumeroDeCiclo;$l_numeroDia_ISO;$l_numeroHora;$l_numeroNivel;$l_recNumAsignacion)
C_LONGINT:C283($l_recNumAsignatura;$l_tipoValidacion)
C_POINTER:C301($y_IdAlumnosEnConflicto_al;$y_recNumConflictosHorario_al)

ARRAY LONGINT:C221($al_Calificaciones_IdAlumno;0)
ARRAY LONGINT:C221($al_Calificaciones_IdAsignatura;0)
ARRAY LONGINT:C221($al_IdAlumnosEnAsignatura;0)
ARRAY LONGINT:C221($al_IdAlumnosEnConflicto;0)
ARRAY LONGINT:C221($al_IdAsignaturasAsignadas;0)
ARRAY LONGINT:C221($al_IdAsignaturasEnConflicto;0)
ARRAY LONGINT:C221($al_recNumAsignacionesHorario;0)
ARRAY LONGINT:C221($al_RecNumConflictosHorario;0)
ARRAY TEXT:C222($at_AlumnosEnConflicto;0)
ARRAY TEXT:C222($at_asignaturasEnConflicto;0)
ARRAY TEXT:C222($at_Calificaciones_Alumno;0)
ARRAY TEXT:C222($at_Calificaciones_Asignatura;0)


If (False:C215)
	C_LONGINT:C283(TMT_alumnosEnConflicto ;$0)
	C_LONGINT:C283(TMT_alumnosEnConflicto ;$1)
	C_LONGINT:C283(TMT_alumnosEnConflicto ;$2)
	C_LONGINT:C283(TMT_alumnosEnConflicto ;$3)
	C_LONGINT:C283(TMT_alumnosEnConflicto ;$4)
	C_LONGINT:C283(TMT_alumnosEnConflicto ;$5)
	C_POINTER:C301(TMT_alumnosEnConflicto ;$6)
	C_POINTER:C301(TMT_alumnosEnConflicto ;$7)
End if 


$l_tipoValidacion:=$1
Case of 
	: ($l_tipoValidacion=0)  // asignación de una asignatura
		$l_recNumAsignatura:=$2
		$l_numeroDia_ISO:=$3
		$l_numeroHora:=$4
		$l_NumeroDeCiclo:=$5
		KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;False:C215)
		$l_IdAsignatura:=[Asignaturas:18]Numero:1
		$l_IdProfesor:=[Asignaturas:18]profesor_numero:4
		$l_numeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
		PERIODOS_LoadData ($l_numeroNivel)
		$d_inicioSesiones:=vdSTR_Periodos_InicioEjercicio
		$d_terminoSesiones:=vdSTR_Periodos_FinEjercicio
		
	: ($l_tipoValidacion=1)  // modificación de fechas de una asignación a un bloque horario
		$l_recNumAsignacion:=$2
		KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacion;False:C215)
		$l_IdAsignatura:=[TMT_Horario:166]ID_Asignatura:5
		$l_IdProfesor:=[TMT_Horario:166]ID_Teacher:9
		$l_numeroDia_ISO:=[TMT_Horario:166]NumeroDia:1
		$l_numeroHora:=[TMT_Horario:166]NumeroHora:2
		$l_numeroDeCiclo:=[TMT_Horario:166]No_Ciclo:14
		$l_numeroNivel:=[TMT_Horario:166]Nivel:10
		$d_inicioSesiones:=[TMT_Horario:166]SesionesDesde:12
		$d_terminoSesiones:=[TMT_Horario:166]SesionesHasta:13
		
	: ($l_tipoValidacion=2)  // desplazamiento de una asignación existente a otro bloque horario
		$l_recNumAsignacion:=$2
		KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacion;False:C215)
		$l_IdAsignatura:=[TMT_Horario:166]ID_Asignatura:5
		$l_IdProfesor:=[TMT_Horario:166]ID_Teacher:9
		$d_inicioSesiones:=[TMT_Horario:166]SesionesDesde:12
		$d_terminoSesiones:=[TMT_Horario:166]SesionesHasta:13
		$l_numeroNivel:=[TMT_Horario:166]Nivel:10
		$l_numeroDia_ISO:=$3
		$l_numeroHora:=$4
		$l_NumeroDeCiclo:=$5
End case 
$y_recNumConflictosHorario_al:=$6
$y_IdAlumnosEnConflicto_al:=$7

QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$l_numeroDia_ISO;*)
QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]NumeroHora:2=$l_numeroHora;*)
QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Asignatura:5#$l_idAsignatura;*)
QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Teacher:9#$l_IdProfesor;*)
QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]No_Ciclo:14=$l_numeroDeCiclo;*)
QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]Nivel:10=$l_numeroNivel)
CREATE SET:C116([TMT_Horario:166];"$todos")
QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=$d_inicioSesiones;*)
QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$d_terminoSesiones)
CREATE SET:C116([TMT_Horario:166];"$asignacionesConRangoSuperior")
USE SET:C118("$todos")
QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12>=$d_inicioSesiones;*)
QUERY SELECTION:C341([TMT_Horario:166]; | ;[TMT_Horario:166]SesionesHasta:13<=$d_terminoSesiones)
CREATE SET:C116([TMT_Horario:166];"$asignacionesConRangoInferior")
UNION:C120("$asignacionesConRangoSuperior";"$asignacionesConRangoInferior";"$asignacionesSobrepuestas")
USE SET:C118("$asignacionesSobrepuestas")
SET_ClearSets ("$todos";"$asignacionesConRangoSuperior";"$asignacionesConRangoInferior";"$asignacionesSobrepuestas")

  //QUERY SELECTION([TMT_Horario];[TMT_Horario]SesionesHasta>=Current date(*))  //MONO (ticket 146331) los bloques encontrados para la validación deben estar vigentes. MONO (ticket 188222) no necesariament porque puede haber tope con las sesiones. 
QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12>=$d_inicioSesiones;*)
QUERY SELECTION:C341([TMT_Horario:166]; | ;[TMT_Horario:166]SesionesHasta:13<=$d_terminoSesiones)

If (Records in selection:C76([TMT_Horario:166])>0)
	  // obtengo la lista de otras asignaturas con distinto profesor asignadas en el mismo nivel
	SELECTION TO ARRAY:C260([TMT_Horario:166];$al_recNumAsignacionesHorario;[TMT_Horario:166]ID_Asignatura:5;$al_IdAsignaturasAsignadas)
	
	  // busco los registros de Alumnos_Calificaciones de esas asignaturas para obtener la lista de alumnos de todas esas asignaturas, excluyendo rtetirados y promovidos
	QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$al_IdAsignaturasAsignadas)
	SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
	SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Asignatura:5;Automatic:K51:4;Structure configuration:K51:2)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]Status:50#"Retirado@";*)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Alumnos:2]Status:50#"Promovido@")
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_Calificaciones_IdAlumno;[Alumnos_Calificaciones:208]ID_Asignatura:5;$al_Calificaciones_IdAsignatura;[Asignaturas:18]denominacion_interna:16;$at_Calificaciones_Asignatura;[Alumnos:2]apellidos_y_nombres:40;$at_Calificaciones_Alumno)
	
	  // obtengo la lista de los alumnos de la asignatura que se desea asignar, excluyendo rtetirados y promovidos
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_idAsignatura)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]Status:50#"Retirado@";*)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Alumnos:2]Status:50#"Promovido@")
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnosEnAsignatura)
	
	  // restablezco las relaciones como están definidas en la estructura
	SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)
	SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Asignatura:5;Structure configuration:K51:2;Structure configuration:K51:2)
	
	  // determino si se repiten alumnos de las asignaturas actualmente asignadas y de la que se desea asignar
	For ($i_alumnosAsignados;1;Size of array:C274($al_IdAlumnosEnAsignatura))
		  // para cada Id de alumno que se desea asignar busco en la lista de alumnos de asignaciones previas
		$l_elemento:=Find in array:C230($al_Calificaciones_IdAlumno;$al_IdAlumnosEnAsignatura{$i_alumnosAsignados})
		If ($l_elemento>0)
			  // el alumno de la asignatura que se quiere asignar ya está en alguna de las asignaturas asignadas en el mismo bloque horario
			  // en las mismas fechas. Lo agrego a la lista de alumnos en conflicto (ID y Apellidos_y_Nombres
			APPEND TO ARRAY:C911($al_IdAlumnosEnConflicto;$al_Calificaciones_IdAlumno{$l_elemento})
			APPEND TO ARRAY:C911($at_AlumnosEnConflicto;$at_Calificaciones_Alumno{$l_elemento})
			
			  // determino si el ID de la asignatura está en la lista de asignaturas en conflicto
			$l_enConflictos:=Find in array:C230($al_IdAsignaturasEnConflicto;$al_Calificaciones_IdAsignatura{$l_elemento})
			If ($l_enConflictos<0)
				  // agrego la asignatura a la lista de conflictos si no está
				APPEND TO ARRAY:C911($al_IdAsignaturasEnConflicto;$al_Calificaciones_IdAsignatura{$l_elemento})
				APPEND TO ARRAY:C911($at_asignaturasEnConflicto;$at_Calificaciones_Asignatura{$l_elemento})
				  // determino cual es la lista de asignaciones de horario para las que, dependiendo de la respuesta del usuario,
				  // debería eliminar sesiones o restringir las fechas de aplicación
				$l_elementoEnAsignaciones:=Find in array:C230($al_IdAsignaturasAsignadas;$al_Calificaciones_IdAsignatura{$l_elemento})
				If ($l_elementoEnAsignaciones>0)
					If (Find in array:C230($al_RecNumConflictosHorario;$al_recNumAsignacionesHorario{$l_elementoEnAsignaciones})<0)
						APPEND TO ARRAY:C911($al_RecNumConflictosHorario;$al_recNumAsignacionesHorario{$l_elementoEnAsignaciones})
					End if 
				End if 
			End if 
		End if 
	End for 
	  // si hay al menos un alumno cursando alguna de la(s) asignaturas ya asignadas
	  // y la asignatura que se desea asignar el usuario deberá optar por algunas de las opciones de asignación
	$b_ConflictoAlumnos:=Choose:C955(Size of array:C274($al_IdAlumnosEnConflicto)>0;True:C214;False:C215)
	  // si no hay alumnos en conflicto y el profesor es distinto el usuario deberá confirmar la asignación
	  // de más de una asignatura en el mismo bloque horario
	$b_ConflictoBloqueHorario:=Choose:C955(Size of array:C274($al_IdAlumnosEnConflicto)=0;True:C214;False:C215)
End if 

COPY ARRAY:C226($al_IdAlumnosEnConflicto;$y_IdAlumnosEnConflicto_al->)
COPY ARRAY:C226($al_RecNumConflictosHorario;$y_recNumConflictosHorario_al->)

Case of 
	: (Size of array:C274($al_IdAlumnosEnConflicto)>0)  // hay asignaturas asignadas y alumnos de la asignatura que se desea asignar ya asignados a este bloque horario
		$0:=Size of array:C274($al_IdAlumnosEnConflicto)
	: (Size of array:C274($al_recNumAsignacionesHorario)>0)  // hay asignaturas asignadas pero sin conflictos entre los alumnos ya asignados y los alumnos de la asignatura
		$0:=-Size of array:C274($al_recNumAsignacionesHorario)  // devuelvo en negativo el numero de asignaturas ya asignadas
	Else 
		$0:=0
End case 

