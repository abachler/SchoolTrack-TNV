//%attributes = {}
  // UD_v20130408_PctAprobacion()
  // Por: Alberto Bachler: 08/04/13, 11:54:38
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

ALL RECORDS:C47([Asignaturas:18])

ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNums;"")
$l_IdProceso:=IT_Progress (1;0;0;"Determinando % de alumnos aprobados en asignaturas...")
For ($i;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$al_RecNums{$i})
	EV2_ResultadosAsignatura ($al_RecNums{$i})
	SAVE RECORD:C53([Asignaturas:18])
	$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/Size of array:C274($al_RecNums);"Determinando % de alumnos aprobados en asignaturas...\r"+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5)
End for 
KRL_UnloadReadOnly (->[Asignaturas:18])
$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
