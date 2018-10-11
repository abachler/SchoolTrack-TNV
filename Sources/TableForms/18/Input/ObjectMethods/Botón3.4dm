AL_ExitCell (xALP_Aprendizajes)

$text:=Replace string:C233(vtSTR_PeriodosPopupMenu;"; ";";( ")+"(-;Evaluación Final"
$result:=Pop up menu:C542($text;0)

If ($result>0)
	If ($result<=Size of array:C274(atSTR_Periodos_Nombre))
		vt_periodo:=atSTR_Periodos_Nombre{$result}
		vl_PeriodoSeleccionado:=aiSTR_Periodos_Numero{$result}
		atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vl_PeriodoSeleccionado)
		vlSTR_PeriodoSeleccionado:=aiSTR_Periodos_Numero{$result}
		AS_PageEVLG 
		  //EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;aNtaIDAlumno{aNtaStdNme};[Asignaturas]EVAPR_IdMatriz)
		  //If (vl_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
		  //vb_AvisaSiCambioPeriodo:=True
		  //SET COLOR(sPeriodo;-3)
		  //Else 
		  //SET COLOR(sPeriodo;-5)
		  //End if 
	Else 
		atSTR_Periodos_Nombre:=0
		vlSTR_PeriodoSeleccionado:=0
		vl_PeriodoSeleccionado:=-1
		vt_periodo:="Evaluación final"
		AS_PageEVLG 
		  //EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;aNtaIDAlumno{aNtaStdNme};[Asignaturas]EVAPR_IdMatriz)
		  //SET COLOR(sPeriodo;-5)
	End if 
	
End if 

If (vl_PeriodoSeleccionado>0)
	vlSTR_PeriodoSeleccionado:=vl_PeriodoSeleccionado
End if 