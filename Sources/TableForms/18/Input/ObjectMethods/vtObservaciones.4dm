  //Método de Objeto: [asignaturas]Input.vtObservaciones


  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======

  //20121113 RCH Spell_CheckSpelling se ejecutaba despues de guardar el registro
Spell_CheckSpelling 

EV2_CargaRegistro ([Asignaturas:18]Numero:1;[Alumnos:2]numero:1;True:C214)
Case of 
	: (vl_PeriodoSeleccionado=1)
		$fieldPtr:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
	: (vl_PeriodoSeleccionado=2)
		$fieldPtr:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
	: (vl_PeriodoSeleccionado=3)
		$fieldPtr:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
	: (vl_PeriodoSeleccionado=4)
		$fieldPtr:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
	: (vl_PeriodoSeleccionado=5)
		$fieldPtr:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
	: (vl_PeriodoSeleccionado=-1)
		$fieldPtr:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
End case 
If ($fieldPtr->#vtObservaciones)
	$fieldPtr->:=vtObservaciones
	SN3_MarcarRegistros (SN3_DTi_Observaciones;-1)  //Debiera ser la constante Asignatura en vez de -1, pero el editor lo tokeniza mal...
	SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
End if 
KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
EV2_ObtieneDatosPeriodoActual (vl_periodoSeleccionado)  //20130626 ASM para cargar los promedios actuales.
vbSpell_StopChecking:=True:C214