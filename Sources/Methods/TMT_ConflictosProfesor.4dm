//%attributes = {}
  // TMT_ConflictosProfesor()
  // Por: Alberto Bachler: 15/06/13, 10:36:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_POINTER:C301($6)
C_POINTER:C301($7)

C_DATE:C307($d_inicioSesiones;$d_terminoSesiones)
_O_C_INTEGER:C282($i_alumnos)
C_LONGINT:C283($l_alumnosDistintos;$l_alumnosEnComun;$l_IdAsignatura;$l_IdProfesor;$l_Indice;$l_NumeroDeCiclo;$l_numeroDia_ISO;$l_numeroHora;$l_numeroNivel;$l_recNumAsignacion)
C_LONGINT:C283($l_recNumAsignatura;$l_tipoValidacion)
C_POINTER:C301($y_alumnosEnComun_al;$y_RecNumAsignaciones_al)

ARRAY LONGINT:C221($al_IdAlumnosEnAsignatura;0)
ARRAY LONGINT:C221($al_IdAlumnosEnComun;0)
ARRAY LONGINT:C221($al_IdAlumnosYaAsignados;0)
ARRAY LONGINT:C221($al_IdAsignaturasEnHorario;0)
ARRAY LONGINT:C221($al_RecNumConflictosHorario;0)
If (False:C215)
	C_BOOLEAN:C305(TMT_ConflictosProfesor ;$0)
	C_LONGINT:C283(TMT_ConflictosProfesor ;$1)
	C_LONGINT:C283(TMT_ConflictosProfesor ;$2)
	C_LONGINT:C283(TMT_ConflictosProfesor ;$3)
	C_LONGINT:C283(TMT_ConflictosProfesor ;$4)
	C_LONGINT:C283(TMT_ConflictosProfesor ;$5)
	C_POINTER:C301(TMT_ConflictosProfesor ;$6)
	C_POINTER:C301(TMT_ConflictosProfesor ;$7)
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
$y_RecNumAsignaciones_al:=$6
$y_alumnosEnComun_al:=$7

If ($l_IdProfesor>0)  //MONO TICKET 197671
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$l_numeroDia_ISO;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]NumeroHora:2=$l_numeroHora;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Asignatura:5#$l_idAsignatura;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Teacher:9=$l_IdProfesor;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]No_Ciclo:14=$l_numeroDeCiclo;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]Nivel:10=$l_numeroNivel)
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12>=$d_inicioSesiones;*)
	QUERY SELECTION:C341([TMT_Horario:166]; | ;[TMT_Horario:166]SesionesHasta:13<=$d_terminoSesiones)
	If (Records in selection:C76([TMT_Horario:166])>0)
		  // obtengo la lista de alumnos de las asignaturas previamente asignadas en el mismo horario
		SELECTION TO ARRAY:C260([TMT_Horario:166];$al_RecNumConflictosHorario;[TMT_Horario:166]ID_Asignatura:5;$al_IdAsignaturasEnHorario)
		QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$al_IdAsignaturasEnHorario)
		AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$al_IdAlumnosYaAsignados)
		  // obtengo la lista de los alumnos de la asignatura que se desea asignar
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_idAsignatura)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_IdAlumnosEnAsignatura)
		  // determino si se repiten alumnos de las asignaturas actualmente asignadas y de la que se desea asignar
		
		$l_alumnosEnComun:=0
		$l_alumnosDistintos:=0
		For ($i_alumnos;1;Size of array:C274($al_IdAlumnosEnAsignatura))
			$l_Indice:=Find in array:C230($al_IdAlumnosYaAsignados;$al_IdAlumnosEnAsignatura{$i_alumnos})
			If ($l_indice>0)
				APPEND TO ARRAY:C911($al_IdAlumnosEnComun;$al_IdAlumnosEnAsignatura{$i_alumnos})
			End if 
		End for 
	End if 
End if 

COPY ARRAY:C226($al_RecNumConflictosHorario;$y_RecNumAsignaciones_al->)
COPY ARRAY:C226($al_IdAlumnosEnComun;$y_alumnosEnComun_al->)

If (Size of array:C274($al_RecNumConflictosHorario)>0)
	$0:=True:C214
End if 

