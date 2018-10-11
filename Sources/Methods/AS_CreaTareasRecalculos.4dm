//%attributes = {}
  // MƒTODO: AS_CreaTareasRecalculos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creaci—n: 12/04/12, 17:38:50
  // ----------------------------------------------------
  // DESCRIPCIîN
  //
  //
  // PARçMETROS
  // AS_CreaTareasRecalculos()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)

C_BOOLEAN:C305($b_readWriteState)
C_LONGINT:C283($i;$l_IdAsignatura;$l_RecNumAsignaturaActual;$l_recNumMadre)
C_POINTER:C301($y_arregloIDAlumnos)

ARRAY LONGINT:C221($al_IDsAsignaturasMadres;0)
ARRAY TEXT:C222($at_Cursos;0)
If (False:C215)
	C_LONGINT:C283(AS_CreaTareasRecalculos ;$1)
	C_POINTER:C301(AS_CreaTareasRecalculos ;$2)
End if 

  // CODIGO PRINCIPAL
$l_IdAsignatura:=$1
$y_arregloIDAlumnos:=$2

  // conservo el recNum de esta asignatura y el estado de carga
  // para volver a ella si cambia la selecci—n
KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura)
$l_RecNumAsignaturaActual:=Record number:C243([Asignaturas:18])
$b_readWriteState:=Not:C34(Read only state:C362([Asignaturas:18]))
EV2_ResultadosAsignatura   //calculo los resultados de esta asignatura

  // creamos tareas batch para el recalculo de promedios de alumnos y cursos
For ($i;1;Size of array:C274($y_arregloIDAlumnos->))
	BM_CreateRequest ("CalculaPromediosGenerales";String:C10($y_arregloIDAlumnos->{$i});String:C10($y_arregloIDAlumnos->{$i}))
End for 

  // creamos tareas batch para el recalculo de promedios de los cursos
QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$y_arregloIDAlumnos->)
DISTINCT VALUES:C339([Alumnos:2]curso:20;$at_Cursos)
For ($i;1;Size of array:C274($at_Cursos))
	BM_CreateRequest ("Recalcular Promedios Curso";$at_Cursos{$i};$at_Cursos{$i})
End for 

KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura)
If ([Asignaturas:18]nivel_jerarquico:107>0)
	  //si esta asignatura consolida en otras asignaturas se deben recalcular los promedios generales de las asignaturas madres
	AScsd_LeeReferencias ([Asignaturas:18]Numero:1;-1)
	If (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
		SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;$al_IDsAsignaturasMadres)
		KRL_UnloadReadOnly (->[Asignaturas_Consolidantes:231])
		For ($i;1;Size of array:C274($al_IDsAsignaturasMadres))
			$l_recNumMadre:=Find in field:C653([Asignaturas:18]Numero:1;$al_IDsAsignaturasMadres{$i})
			EV2_ResultadosAsignatura ($l_recNumMadre)
		End for 
	End if 
	
	KRL_GotoRecord (->[Asignaturas:18];$l_RecNumAsignaturaActual;$b_readWriteState)  // vuelvo a la asignatura de origen
End if 