//%attributes = {}
  //EV2_EximeAlumno

C_LONGINT:C283($idAlumno;$1;$idAsignatura;$2;$0)
$idAlumno:=$1
$idAsignatura:=$2



$recNumAlumno:=Find in field:C653([Alumnos:2]numero:1;$idAlumno)
KRL_GotoRecord (->[Alumnos:2];$recNumAlumno;False:C215)

If (OK=1)
	EV2_CargaRegistro ($idAsignatura;$idAlumno;True:C214)
	$l_recNumCalificaciones:=Record number:C243([Alumnos_Calificaciones:208])
	If (ok=1)
		$title:=__ ("Eximición para ")+[Alumnos:2]apellidos_y_nombres:40
		WDW_OpenFormWindow (->[Asignaturas:18];"Eximición";-1;Movable form dialog box:K39:8;$title)
		DIALOG:C40([Asignaturas:18];"Eximición")
		CLOSE WINDOW:C154
		If (ok=1)
			Case of 
				: (bok=1)
					[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8:=vi_g1
					[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7:=vd_g1
					[Alumnos_ComplementoEvaluacion:209]Eximicion_Obs:9:=vt_g1
					SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
					EV2_EsAlumnoEximido 
					SAVE RECORD:C53([Alumnos_Calificaciones:208])
					UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
					
				: (bReincorporar=1)
					[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8:=0
					[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7:=!00-00-00!
					[Alumnos_ComplementoEvaluacion:209]Eximicion_Obs:9:=""
					SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
					[Alumnos_Calificaciones:208]Anual_Real:11:=-10
					[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-10
					[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=-10
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=-10
					[Alumnos_Calificaciones:208]P01_Presentacion_Real:102:=-10
					[Alumnos_Calificaciones:208]P01_Final_RealNoAproximado:496:=-10
					[Alumnos_Calificaciones:208]P01_Final_Real:112:=-10
					[Alumnos_Calificaciones:208]P02_Presentacion_Real:177:=-10
					[Alumnos_Calificaciones:208]P02_Final_Real:187:=-10
					[Alumnos_Calificaciones:208]P02_Final_RealNoAproximado:497:=-10
					[Alumnos_Calificaciones:208]P03_Presentacion_Real:252:=-10
					[Alumnos_Calificaciones:208]P03_Final_Real:262:=-10
					[Alumnos_Calificaciones:208]P03_Final_RealNoAproximado:498:=-10
					[Alumnos_Calificaciones:208]P04_Presentacion_Real:327:=-10
					[Alumnos_Calificaciones:208]P04_Final_Real:337:=-10
					[Alumnos_Calificaciones:208]P04_Final_RealNoAproximado:499:=-10
					[Alumnos_Calificaciones:208]P05_Presentacion_Real:402:=-10
					[Alumnos_Calificaciones:208]P05_Final_Real:412:=-10
					[Alumnos_Calificaciones:208]P05_Final_RealNoAproximado:500:=-10
					SAVE RECORD:C53([Alumnos_Calificaciones:208])
					UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
			End case 
			
			
			READ ONLY:C145([Alumnos_Calificaciones:208])
			  //AL_SetSelect (xALP_StdList;alLines)
			_O_DISABLE BUTTON:C193(b_eximir)
			
			$b_promediosModificados:=False:C215
			For ($i_periodos;1;viSTR_Periodos_NumeroPeriodos)
				$b_promediosModificados:=$b_promediosModificados | (EV2_Calculos ($l_recNumCalificaciones;$i_periodos))
			End for 
			If ($b_promediosModificados)
				AL_CalculaPromediosGenerales ($idAlumno)
				EV2_ResultadosAsignatura 
			End if 
		End if 
		  //AL_CalculaSituacionFinal ($studentID)
	End if 
End if 