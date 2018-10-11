//%attributes = {}
  //XCR_ObtieneDatosPeriodoActual

C_LONGINT:C283($periodo;$1)

If (Count parameters:C259=1)
	$periodo:=$1
Else 
	$periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
End if 

Case of 
	: ($periodo=1)
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion1:54:=[Alumnos_Actividades:28]Periodo1_Evaluación1:15
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion2:55:=[Alumnos_Actividades:28]Periodo1_Evaluación2:16
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion3:56:=[Alumnos_Actividades:28]Periodo1_Evaluación3:17
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion4:57:=[Alumnos_Actividades:28]Periodo1_Evaluación4:18
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion5:58:=[Alumnos_Actividades:28]Periodo1_Evaluación5:19
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion6:59:=[Alumnos_Actividades:28]Periodo1_Evaluación6:20
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion_Final:60:=[Alumnos_Actividades:28]Evaluación_Final_P1:7
		[Alumnos_Actividades:28]Periodo_Actual_Inasistencia:61:=[Alumnos_Actividades:28]Inasistencia_P1:10
		[Alumnos_Actividades:28]Periodo_Actual_Comentarios:62:=[Alumnos_Actividades:28]Comentarios_P1:6
	: ($periodo=2)
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion1:54:=[Alumnos_Actividades:28]Periodo2_Evaluación1:21
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion2:55:=[Alumnos_Actividades:28]Periodo2_Evaluación2:22
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion3:56:=[Alumnos_Actividades:28]Periodo2_Evaluación3:23
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion4:57:=[Alumnos_Actividades:28]Periodo2_Evaluación4:24
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion5:58:=[Alumnos_Actividades:28]Periodo2_Evaluación5:25
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion6:59:=[Alumnos_Actividades:28]Periodo2_Evaluación6:26
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion_Final:60:=[Alumnos_Actividades:28]Evaluación_Final_P2:8
		[Alumnos_Actividades:28]Periodo_Actual_Inasistencia:61:=[Alumnos_Actividades:28]Inasistencia_P2:11
		[Alumnos_Actividades:28]Periodo_Actual_Comentarios:62:=[Alumnos_Actividades:28]Comentarios_P2:13
	: ($periodo=3)
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion1:54:=[Alumnos_Actividades:28]Periodo3_Evaluación1:27
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion2:55:=[Alumnos_Actividades:28]Periodo3_Evaluación2:28
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion3:56:=[Alumnos_Actividades:28]Periodo3_Evaluación3:29
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion4:57:=[Alumnos_Actividades:28]Periodo3_Evaluación4:30
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion5:58:=[Alumnos_Actividades:28]Periodo3_Evaluación5:31
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion6:59:=[Alumnos_Actividades:28]Periodo3_Evaluación6:32
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion_Final:60:=[Alumnos_Actividades:28]Evaluación_Final_P3:9
		[Alumnos_Actividades:28]Periodo_Actual_Inasistencia:61:=[Alumnos_Actividades:28]Inasistencia_P3:12
		[Alumnos_Actividades:28]Periodo_Actual_Comentarios:62:=[Alumnos_Actividades:28]Comentarios_P3:14
	: ($periodo=4)
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion1:54:=[Alumnos_Actividades:28]Periodo4_Evaluación1:33
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion2:55:=[Alumnos_Actividades:28]Periodo4_Evaluación2:34
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion3:56:=[Alumnos_Actividades:28]Periodo4_Evaluación3:35
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion4:57:=[Alumnos_Actividades:28]Periodo4_Evaluación4:36
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion5:58:=[Alumnos_Actividades:28]Periodo4_Evaluación5:37
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion6:59:=[Alumnos_Actividades:28]Periodo4_Evaluación6:38
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion_Final:60:=[Alumnos_Actividades:28]Evaluación_Final_P4:39
		[Alumnos_Actividades:28]Periodo_Actual_Inasistencia:61:=[Alumnos_Actividades:28]Inasistencia_P4:42
		[Alumnos_Actividades:28]Periodo_Actual_Comentarios:62:=[Alumnos_Actividades:28]Comentarios_P4:41
	: ($periodo=5)
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion1:54:=[Alumnos_Actividades:28]Periodo5_Evaluacion1:45
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion2:55:=[Alumnos_Actividades:28]Periodo5_Evaluacion2:46
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion3:56:=[Alumnos_Actividades:28]Periodo5_Evaluacion3:47
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion4:57:=[Alumnos_Actividades:28]Periodo5_Evaluacion4:48
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion5:58:=[Alumnos_Actividades:28]Periodo5_Evaluacion5:49
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion6:59:=[Alumnos_Actividades:28]Periodo5_Evaluacion6:50
		[Alumnos_Actividades:28]Periodo_Actual_Evaluacion_Final:60:=[Alumnos_Actividades:28]Evaluacion_Final_P5:51
		[Alumnos_Actividades:28]Periodo_Actual_Inasistencia:61:=[Alumnos_Actividades:28]Inasistencia_P5:52
		[Alumnos_Actividades:28]Periodo_Actual_Comentarios:62:=[Alumnos_Actividades:28]Comentarios_P5:53
End case 