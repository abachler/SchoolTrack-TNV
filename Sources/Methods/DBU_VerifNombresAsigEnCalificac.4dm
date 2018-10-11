//%attributes = {}
  //DBU_VerifNombresAsigEnCalificac


ARRAY LONGINT:C221($aRecNums;0)
QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNums;"")
$m:=Milliseconds:C459
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando nombres de asignaturas en registros de calificaciones..."))
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Alumnos_Calificaciones:208];$aRecNums{$i})
	RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
	If (([Alumnos_Calificaciones:208]NombreOficialAsignatura:7#[Asignaturas:18]Asignatura:3) | ([Alumnos_Calificaciones:208]NombreInternoAsignatura:8#[Asignaturas:18]denominacion_interna:16))
		KRL_ReloadInReadWriteMode (->[Alumnos_Calificaciones:208])
		[Alumnos_Calificaciones:208]NombreOficialAsignatura:7:=[Asignaturas:18]Asignatura:3
		[Alumnos_Calificaciones:208]NombreInternoAsignatura:8:=[Asignaturas:18]denominacion_interna:16
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
$m:=Milliseconds:C459-$m
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
