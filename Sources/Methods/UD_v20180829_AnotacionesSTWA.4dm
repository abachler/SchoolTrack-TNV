//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 29-08-18, 10:41:43
  // ----------------------------------------------------
  // Método: UD_v20180829_AnotacionesSTWA
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

READ ONLY:C145([Asignaturas:18])
READ WRITE:C146([Alumnos_Anotaciones:11])

C_LONGINT:C283($l_indice;$l_therm;$l_indice2)
C_TEXT:C284($t_asignatura;$t_asignatura2)


ALL RECORDS:C47([Asignaturas:18])
SELECTION TO ARRAY:C260([Asignaturas:18];$al_RecNumAsignaturas)
$l_therm:=IT_Progress (1;0;0;"Verificando anotaciones")
For ($l_indice;1;Size of array:C274($al_RecNumAsignaturas))
	$l_therm:=IT_Progress (0;$l_therm;$l_indice/Size of array:C274($al_RecNumAsignaturas);"Verificando anotaciones")
	GOTO RECORD:C242([Asignaturas:18];$al_RecNumAsignaturas{$l_indice})
	$t_asignatura:=[Asignaturas:18]Asignatura:3+" - ("+[Asignaturas:18]Curso:5+")"
	QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Asignatura:10=$t_asignatura)
	If (Records in selection:C76([Alumnos_Anotaciones:11])>0)
		SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11];$al_recNumAnotaciones)
		If ([Asignaturas:18]Asignatura:3#[Asignaturas:18]denominacion_interna:16)
			For ($l_indice2;1;Size of array:C274($al_recNumAnotaciones))
				GOTO RECORD:C242([Alumnos_Anotaciones:11];$al_recNumAnotaciones{$l_indice2})
				[Alumnos_Anotaciones:11]Asignatura:10:=Replace string:C233([Alumnos_Anotaciones:11]Asignatura:10;$t_asignatura;$t_asignatura2)
				[Alumnos_Anotaciones:11]Observaciones:4:=Replace string:C233([Alumnos_Anotaciones:11]Observaciones:4;$t_asignatura;$t_asignatura2)
				SAVE RECORD:C53([Alumnos_Anotaciones:11])
			End for 
		End if 
	End if 
End for 
$l_therm:=IT_Progress (-1;$l_therm)
KRL_UnloadReadOnly (->[Alumnos_Anotaciones:11])
