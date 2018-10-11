//%attributes = {}
  // MÉTODO: MPA_Aprendizajes_a_Notas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/10/11, 10:48:10
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_Apendizajes_a_Notas()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_Convertir_a_Notas;$b_finalesModificados;$b_promediosPeriodosModificados)
C_LONGINT:C283($l_IdMatriz;$l_recNumCalificaciones;$vl_PeriodoSeleccionado)
C_TEXT:C284($t_llaveCalificaciones)

If (False:C215)
	C_BOOLEAN:C305(MPA_Aprendizajes_a_Notas ;$0)
	C_LONGINT:C283(MPA_Aprendizajes_a_Notas ;$1)
	C_TEXT:C284(MPA_Aprendizajes_a_Notas ;$2)
	C_LONGINT:C283(MPA_Aprendizajes_a_Notas ;$3)
End if 
C_BOOLEAN:C305(vb_RecalcularTodo)

$l_IdMatriz:=$1
$t_llaveCalificaciones:=$2

  // CODIGO PRINCIPAL
$b_Convertir_a_Notas:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IDMatriz;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)

If ($b_Convertir_a_Notas)
	$l_recNumCalificaciones:=KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveCalificaciones;True:C214)
	KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->$t_llaveCalificaciones;False:C215)
	
	[Alumnos_Calificaciones:208]P01_Final_Real:112:=[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Real:57
	[Alumnos_Calificaciones:208]P01_Final_RealNoAproximado:496:=[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Real:57
	[Alumnos_Calificaciones:208]P01_Final_Literal:116:=[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Literal:62
	[Alumnos_Calificaciones:208]P01_Final_Nota:113:=[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Nota:67
	[Alumnos_Calificaciones:208]P01_Final_Puntos:114:=[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Puntos:72
	[Alumnos_Calificaciones:208]P01_Final_Simbolo:115:=[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Simbolo:77
	$b_promediosPeriodosModificados:=$b_promediosPeriodosModificados | (EV2_PromediosModificados (1))
	
	[Alumnos_Calificaciones:208]P02_Final_Real:187:=[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Real:58
	[Alumnos_Calificaciones:208]P02_Final_RealNoAproximado:497:=[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Real:58
	[Alumnos_Calificaciones:208]P02_Final_Literal:191:=[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Literal:63
	[Alumnos_Calificaciones:208]P02_Final_Nota:188:=[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Nota:68
	[Alumnos_Calificaciones:208]P02_Final_Puntos:189:=[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Puntos:73
	[Alumnos_Calificaciones:208]P02_Final_Simbolo:190:=[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Simbolo:78
	$b_promediosPeriodosModificados:=$b_promediosPeriodosModificados | (EV2_PromediosModificados (2))
	
	[Alumnos_Calificaciones:208]P03_Final_Real:262:=[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Real:59
	[Alumnos_Calificaciones:208]P03_Final_RealNoAproximado:498:=[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Real:59
	[Alumnos_Calificaciones:208]P03_Final_Literal:266:=[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Literal:64
	[Alumnos_Calificaciones:208]P03_Final_Nota:263:=[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Nota:69
	[Alumnos_Calificaciones:208]P03_Final_Puntos:264:=[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Puntos:74
	[Alumnos_Calificaciones:208]P03_Final_Simbolo:265:=[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Simbolo:79
	$b_promediosPeriodosModificados:=$b_promediosPeriodosModificados | (EV2_PromediosModificados (3))
	
	[Alumnos_Calificaciones:208]P04_Final_Real:337:=[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Real:60
	[Alumnos_Calificaciones:208]P04_Final_RealNoAproximado:499:=[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Real:60
	[Alumnos_Calificaciones:208]P04_Final_Literal:341:=[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Literal:65
	[Alumnos_Calificaciones:208]P04_Final_Nota:338:=[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Nota:70
	[Alumnos_Calificaciones:208]P04_Final_Puntos:339:=[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Puntos:75
	[Alumnos_Calificaciones:208]P04_Final_Simbolo:340:=[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Simbolo:80
	$b_promediosPeriodosModificados:=$b_promediosPeriodosModificados | (EV2_PromediosModificados (4))
	
	[Alumnos_Calificaciones:208]P05_Final_Real:412:=[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Real:61
	[Alumnos_Calificaciones:208]P05_Final_RealNoAproximado:500:=[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Real:61
	[Alumnos_Calificaciones:208]P05_Final_Literal:416:=[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Literal:66
	[Alumnos_Calificaciones:208]P05_Final_Nota:413:=[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Nota:71
	[Alumnos_Calificaciones:208]P05_Final_Puntos:414:=[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Puntos:76
	[Alumnos_Calificaciones:208]P05_Final_Simbolo:415:=[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Simbolo:81
	$b_promediosPeriodosModificados:=$b_promediosPeriodosModificados | (EV2_PromediosModificados (5))
	
	$b_promediosPeriodosModificados:=$b_promediosPeriodosModificados | vb_RecalcularTodo
	If ($b_promediosPeriodosModificados)
		$b_finalesModificados:=EV2_Calculos_PromediosFinales (Record number:C243([Alumnos_Calificaciones:208]))
	End if 
	
	If (([Asignaturas:18]nivel_jerarquico:107>0) & ($b_promediosPeriodosModificados | $b_finalesModificados))
		EV2_LanzaProcesoConsolidacion ([Alumnos_Calificaciones:208]ID_Asignatura:5;[Alumnos_Calificaciones:208]ID_Alumno:6;0)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveCalificaciones;False:C215)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->$t_llaveCalificaciones;False:C215)
	End if 
	
	$0:=($b_promediosPeriodosModificados | $b_finalesModificados)
	
End if 
