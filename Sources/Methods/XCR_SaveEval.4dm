//%attributes = {}
  //XCR_SaveEval

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_POINTER:C301($fieldPtr)

READ WRITE:C146([Alumnos_Actividades:28])
CREATE SELECTION FROM ARRAY:C640([Alumnos_Actividades:28];aAERNs)
Case of 
	: (vl_PeriodoSeleccionadoActividad=1)
		$fieldPtr:=->[Alumnos_Actividades:28]Comentarios_P1:6
	: (vl_PeriodoSeleccionadoActividad=2)
		$fieldPtr:=->[Alumnos_Actividades:28]Comentarios_P2:13
	: (vl_PeriodoSeleccionadoActividad=3)
		$fieldPtr:=->[Alumnos_Actividades:28]Comentarios_P3:14
	: (vl_PeriodoSeleccionadoActividad=4)
		$fieldPtr:=->[Alumnos_Actividades:28]Comentarios_P4:41
	: (vl_PeriodoSeleccionadoActividad=5)
		$fieldPtr:=->[Alumnos_Actividades:28]Comentarios_P5:53
End case 
ARRAY TEXT:C222($tempComments;0)
ARRAY LONGINT:C221($ids;0)
SELECTION TO ARRAY:C260($fieldPtr->;$tempComments;[Alumnos_Actividades:28]ID:63;$ids)
For ($i;1;Size of array:C274($tempComments))
	If ($tempComments{$i}#aAEXObs{$i})
		SN3_MarcarRegistros (SN3_DTi_CalificacionesExtraCurr;0;aAEXIDs{$i})
	End if 
End for 
Case of 
	: (vl_PeriodoSeleccionadoActividad=1)
		ARRAY TO SELECTION:C261(aExEvF;[Alumnos_Actividades:28]Evaluación_Final_P1:7;aAEXEv1;[Alumnos_Actividades:28]Periodo1_Evaluación1:15;aAEXEv2;[Alumnos_Actividades:28]Periodo1_Evaluación2:16;aAEXEv3;[Alumnos_Actividades:28]Periodo1_Evaluación3:17;aAEXEv4;[Alumnos_Actividades:28]Periodo1_Evaluación4:18;aAEXEv5;[Alumnos_Actividades:28]Periodo1_Evaluación5:19;aAEXEv6;[Alumnos_Actividades:28]Periodo1_Evaluación6:20;aAEXIn;[Alumnos_Actividades:28]Inasistencia_P1:10;aAEXObs;[Alumnos_Actividades:28]Comentarios_P1:6)
	: (vl_PeriodoSeleccionadoActividad=2)
		ARRAY TO SELECTION:C261(aExEvF;[Alumnos_Actividades:28]Evaluación_Final_P2:8;aAEXEv1;[Alumnos_Actividades:28]Periodo2_Evaluación1:21;aAEXEv2;[Alumnos_Actividades:28]Periodo2_Evaluación2:22;aAEXEv3;[Alumnos_Actividades:28]Periodo2_Evaluación3:23;aAEXEv4;[Alumnos_Actividades:28]Periodo2_Evaluación4:24;aAEXEv5;[Alumnos_Actividades:28]Periodo2_Evaluación5:25;aAEXEv6;[Alumnos_Actividades:28]Periodo2_Evaluación6:26;aAEXIn;[Alumnos_Actividades:28]Inasistencia_P2:11;aAEXObs;[Alumnos_Actividades:28]Comentarios_P2:13)
	: (vl_PeriodoSeleccionadoActividad=3)
		ARRAY TO SELECTION:C261(aExEvF;[Alumnos_Actividades:28]Evaluación_Final_P3:9;aAEXEv1;[Alumnos_Actividades:28]Periodo3_Evaluación1:27;aAEXEv2;[Alumnos_Actividades:28]Periodo3_Evaluación2:28;aAEXEv3;[Alumnos_Actividades:28]Periodo3_Evaluación3:29;aAEXEv4;[Alumnos_Actividades:28]Periodo3_Evaluación4:30;aAEXEv5;[Alumnos_Actividades:28]Periodo3_Evaluación5:31;aAEXEv6;[Alumnos_Actividades:28]Periodo3_Evaluación6:32;aAEXIn;[Alumnos_Actividades:28]Inasistencia_P3:12;aAEXObs;[Alumnos_Actividades:28]Comentarios_P3:14)
	: (vl_PeriodoSeleccionadoActividad=4)
		ARRAY TO SELECTION:C261(aExEvF;[Alumnos_Actividades:28]Evaluación_Final_P4:39;aAEXEv1;[Alumnos_Actividades:28]Periodo4_Evaluación1:33;aAEXEv2;[Alumnos_Actividades:28]Periodo4_Evaluación2:34;aAEXEv3;[Alumnos_Actividades:28]Periodo4_Evaluación3:35;aAEXEv4;[Alumnos_Actividades:28]Periodo4_Evaluación4:36;aAEXEv5;[Alumnos_Actividades:28]Periodo4_Evaluación5:37;aAEXEv6;[Alumnos_Actividades:28]Periodo4_Evaluación6:38;aAEXIn;[Alumnos_Actividades:28]Inasistencia_P4:42;aAEXObs;[Alumnos_Actividades:28]Comentarios_P4:41)
	: (vl_PeriodoSeleccionadoActividad=5)
		ARRAY TO SELECTION:C261(aExEvF;[Alumnos_Actividades:28]Evaluacion_Final_P5:51;aAEXEv1;[Alumnos_Actividades:28]Periodo5_Evaluacion1:45;aAEXEv2;[Alumnos_Actividades:28]Periodo5_Evaluacion2:46;aAEXEv3;[Alumnos_Actividades:28]Periodo5_Evaluacion3:47;aAEXEv4;[Alumnos_Actividades:28]Periodo5_Evaluacion4:48;aAEXEv5;[Alumnos_Actividades:28]Periodo5_Evaluacion5:49;aAEXEv6;[Alumnos_Actividades:28]Periodo5_Evaluacion6:50;aAEXIn;[Alumnos_Actividades:28]Inasistencia_P5:52;aAEXObs;[Alumnos_Actividades:28]Comentarios_P5:53)
End case 
KRL_UnloadReadOnly (->[Alumnos_Actividades:28])
modXCR:=False:C215