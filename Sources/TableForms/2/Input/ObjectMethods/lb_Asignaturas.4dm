  //[Alumnos].Input.lb_Asignaturas



Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		
		
	: (Form event:C388=On Clicked:K2:4)
		AL_ExitCell (xALP_Aprendizajes)
		
		  //MONO TICKET 211799
		AL_UpdateArrays (xALP_Aprendizajes;0)
		ARRAY TEXT:C222(atEVLG_Competencia;0)
		ARRAY TEXT:C222(atEVLG_Indicador;0)
		ARRAY TEXT:C222(atEVLG_Observacion;0)
		ARRAY TEXT:C222(atEVLG_Muestra;0)
		ARRAY REAL:C219(arEVLG_Indicador;0)
		ARRAY LONGINT:C221(alEVLG_TipoEvaluación;0)
		ARRAY LONGINT:C221(alEVLG_RefEstiloEvaluacion;0)
		ARRAY LONGINT:C221(alEVLG_RecNum;0)
		ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
		ARRAY LONGINT:C221(alEVLG_IdCompetencia;0)
		ARRAY LONGINT:C221(alEVLG_IdDimension;0)
		ARRAY LONGINT:C221(alEVLG_IdEje;0)
		  //MONO TICKET 211799
		ARRAY TEXT:C222(atMPA_uuidRegistro;0)
		ARRAY DATE:C224(adEVLG_FechaLogro;0)
		
		AL_PostEdicionCompetencias 
		
		If ((vl_Year=<>gYear) & (vl_NivelSeleccionado=[Alumnos:2]nivel_numero:29))  //MONO 184433
			$recNum:=Find in field:C653([Asignaturas:18]Numero:1;aNtaIdAsignatura{aNtaAsignatura})
			KRL_GotoRecord (->[Asignaturas:18];$recNum)
			If ([Asignaturas:18]EVAPR_IdMatriz:91#0)
				EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;[Alumnos:2]numero:1;[Asignaturas:18]EVAPR_IdMatriz:91)
				vlEVLG_AsignaturaSeleccionada:=aNtaIdAsignatura{aNtaAsignatura}
				vtEVLG_AsignaturaSeleccionada:="Aprendizajes esperados en "+[Asignaturas:18]denominacion_interna:16
			Else 
				vlEVLG_AsignaturaSeleccionada:=aNtaIdAsignatura{aNtaAsignatura}
				vtEVLG_AsignaturaSeleccionada:="Aprendizajes esperados en "+[Asignaturas:18]denominacion_interna:16
			End if 
			
			
		Else 
			MPA_LeeHistoricosAlumno ([Alumnos:2]numero:1;aNtaIdAsignatura{aNtaAsignatura};vl_year;vl_NivelSeleccionado)
		End if 
		
		AL_UpdateArrays (xALP_Aprendizajes;-1)  //MONO TICKET 211799
End case 