//%attributes = {}
  //AL_PaginaExtracurriculares

AL_RemoveArrays (xALP_ActividadesAlumno;1;11)
ARRAY LONGINT:C221(alSTR_ExtraC_IDActividad;0)
ARRAY TEXT:C222(atSTR_ExtraC_Actividad;0)
ARRAY TEXT:C222(atSTR_ExtraC_Evaluacion1;0)
ARRAY TEXT:C222(atSTR_ExtraC_Evaluacion2;0)
ARRAY TEXT:C222(atSTR_ExtraC_Evaluacion3;0)
ARRAY TEXT:C222(atSTR_ExtraC_Evaluacion4;0)
ARRAY TEXT:C222(atSTR_ExtraC_Evaluacion5;0)
ARRAY TEXT:C222(atSTR_ExtraC_Evaluacion6;0)
ARRAY TEXT:C222(atSTR_ExtraC_EvaluacionPeriodo;0)
ARRAY INTEGER:C220(aiSTR_ExtraC_Inasistencias;0)
ARRAY TEXT:C222(atSTR_ExtraC_Comentarios;0)

If (vl_periodoSeleccionado=0)
	PERIODOS_LoadData ([Alumnos:2]numero:1)
	For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
		If ((adSTR_Periodos_Desde{$i}<=Current date:C33(*)) & (adSTR_Periodos_Hasta{$i}>=Current date:C33(*)))
			vl_periodoSeleccionado:=$i
		End if 
	End for 
End if 

QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Alumno_Numero:1=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Año:3=vl_Year)
QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];(([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? vl_periodoSeleccionado)))

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
Case of 
	: (vl_periodoSeleccionado=1)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;alSTR_ExtraC_IDActividad;[Actividades:29]Nombre:2;atSTR_ExtraC_Actividad;[Alumnos_Actividades:28]Periodo1_Evaluación1:15;atSTR_ExtraC_Evaluacion1;[Alumnos_Actividades:28]Periodo1_Evaluación2:16;atSTR_ExtraC_Evaluacion2;[Alumnos_Actividades:28]Periodo1_Evaluación3:17;atSTR_ExtraC_Evaluacion3;[Alumnos_Actividades:28]Periodo1_Evaluación4:18;atSTR_ExtraC_Evaluacion4;[Alumnos_Actividades:28]Periodo1_Evaluación5:19;atSTR_ExtraC_Evaluacion5;[Alumnos_Actividades:28]Periodo1_Evaluación6:20;atSTR_ExtraC_Evaluacion6;[Alumnos_Actividades:28]Evaluación_Final_P1:7;atSTR_ExtraC_EvaluacionPeriodo;[Alumnos_Actividades:28]Inasistencia_P1:10;aiSTR_ExtraC_Inasistencias;[Alumnos_Actividades:28]Comentarios_P1:6;atSTR_ExtraC_Comentarios)
	: (vl_periodoSeleccionado=2)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;alSTR_ExtraC_IDActividad;[Actividades:29]Nombre:2;atSTR_ExtraC_Actividad;[Alumnos_Actividades:28]Periodo2_Evaluación1:21;atSTR_ExtraC_Evaluacion1;[Alumnos_Actividades:28]Periodo2_Evaluación2:22;atSTR_ExtraC_Evaluacion2;[Alumnos_Actividades:28]Periodo2_Evaluación3:23;atSTR_ExtraC_Evaluacion3;[Alumnos_Actividades:28]Periodo2_Evaluación4:24;atSTR_ExtraC_Evaluacion4;[Alumnos_Actividades:28]Periodo2_Evaluación5:25;atSTR_ExtraC_Evaluacion5;[Alumnos_Actividades:28]Periodo2_Evaluación6:26;atSTR_ExtraC_Evaluacion6;[Alumnos_Actividades:28]Evaluación_Final_P2:8;atSTR_ExtraC_EvaluacionPeriodo;[Alumnos_Actividades:28]Inasistencia_P2:11;aiSTR_ExtraC_Inasistencias;[Alumnos_Actividades:28]Comentarios_P2:13;atSTR_ExtraC_Comentarios)
	: (vl_periodoSeleccionado=3)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;alSTR_ExtraC_IDActividad;[Actividades:29]Nombre:2;atSTR_ExtraC_Actividad;[Alumnos_Actividades:28]Periodo3_Evaluación1:27;atSTR_ExtraC_Evaluacion1;[Alumnos_Actividades:28]Periodo3_Evaluación3:29;atSTR_ExtraC_Evaluacion2;[Alumnos_Actividades:28]Periodo3_Evaluación2:28;atSTR_ExtraC_Evaluacion3;[Alumnos_Actividades:28]Periodo3_Evaluación4:30;atSTR_ExtraC_Evaluacion4;[Alumnos_Actividades:28]Periodo3_Evaluación5:31;atSTR_ExtraC_Evaluacion5;[Alumnos_Actividades:28]Periodo3_Evaluación6:32;atSTR_ExtraC_Evaluacion6;[Alumnos_Actividades:28]Evaluación_Final_P3:9;atSTR_ExtraC_EvaluacionPeriodo;[Alumnos_Actividades:28]Inasistencia_P3:12;aiSTR_ExtraC_Inasistencias;[Alumnos_Actividades:28]Comentarios_P3:14;atSTR_ExtraC_Comentarios)
	: (vl_periodoSeleccionado=4)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;alSTR_ExtraC_IDActividad;[Actividades:29]Nombre:2;atSTR_ExtraC_Actividad;[Alumnos_Actividades:28]Periodo4_Evaluación1:33;atSTR_ExtraC_Evaluacion1;[Alumnos_Actividades:28]Periodo4_Evaluación2:34;atSTR_ExtraC_Evaluacion2;[Alumnos_Actividades:28]Periodo4_Evaluación3:35;atSTR_ExtraC_Evaluacion3;[Alumnos_Actividades:28]Periodo4_Evaluación4:36;atSTR_ExtraC_Evaluacion4;[Alumnos_Actividades:28]Periodo4_Evaluación5:37;atSTR_ExtraC_Evaluacion5;[Alumnos_Actividades:28]Periodo4_Evaluación6:38;atSTR_ExtraC_Evaluacion6;[Alumnos_Actividades:28]Evaluación_Final_P4:39;atSTR_ExtraC_EvaluacionPeriodo;[Alumnos_Actividades:28]Inasistencia_P4:42;aiSTR_ExtraC_Inasistencias;[Alumnos_Actividades:28]Comentarios_P4:41;atSTR_ExtraC_Comentarios)
	: (vl_periodoSeleccionado=5)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;alSTR_ExtraC_IDActividad;[Actividades:29]Nombre:2;atSTR_ExtraC_Actividad;[Alumnos_Actividades:28]Periodo5_Evaluacion1:45;atSTR_ExtraC_Evaluacion1;[Alumnos_Actividades:28]Periodo5_Evaluacion2:46;atSTR_ExtraC_Evaluacion2;[Alumnos_Actividades:28]Periodo5_Evaluacion3:47;atSTR_ExtraC_Evaluacion3;[Alumnos_Actividades:28]Periodo5_Evaluacion4:48;atSTR_ExtraC_Evaluacion4;[Alumnos_Actividades:28]Periodo5_Evaluacion5:49;atSTR_ExtraC_Evaluacion5;[Alumnos_Actividades:28]Periodo5_Evaluacion6:50;atSTR_ExtraC_Evaluacion6;[Alumnos_Actividades:28]Evaluacion_Final_P5:51;atSTR_ExtraC_EvaluacionPeriodo;[Alumnos_Actividades:28]Inasistencia_P5:52;aiSTR_ExtraC_Inasistencias;[Alumnos_Actividades:28]Comentarios_P5:53;atSTR_ExtraC_Comentarios)
End case 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

xALSet_AL_ActividadesExtra 
  //ARC_LeeAgnosDetalleHistórico 

$result:=1
$0:=$result