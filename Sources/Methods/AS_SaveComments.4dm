//%attributes = {}
  //AS_SaveComments

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_POINTER:C301($obsPointer)
If (modobservaciones)
	SORT ARRAY:C229(aNtaIDAlumno;aNtaObs;>)
	Case of 
		: (vlSTR_PeriodoObservaciones>Size of array:C274(atSTR_Periodos_nombre))
			$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
		: (vlSTR_PeriodoObservaciones=1)
			$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
		: (vlSTR_PeriodoObservaciones=2)
			$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
		: (vlSTR_PeriodoObservaciones=3)
			$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
		: (vlSTR_PeriodoObservaciones=4)
			$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
		: (vlSTR_PeriodoObservaciones=5)
			$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
	End case 
	  //EV2_RegistrosDeLaAsignatura ([Asignaturas]Numero)
	  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos_ComplementoEvaluacion]ID_Alumno;>)
	SORT ARRAY:C229(aNtaIDAlumno;aNtaObs;>)
	
	READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
	FIRST RECORD:C50([Alumnos_ComplementoEvaluacion:209])
	
	For ($i;1;Size of array:C274(aNtaObs))
		$id:=aNtaIDAlumno{$i}
		$key:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Asignaturas:18]Numero_del_Nivel:6;->[Asignaturas:18]Numero:1;->$id)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->$key;True:C214)
		If (ST_ExactlyEqual (aNtaObs{$i};$obsPointer->)=0)
			$obsPointer->:=aNtaObs{$i}
			SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
			SN3_MarcarRegistros (SN3_DTi_Observaciones;SN3_SDTx_Asignatura)
		End if 
	End for 
	UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
	READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
	modobservaciones:=False:C215
	LOG_RegisterEvt ("Asignaturas - Modificación en observaciones: "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
End if 
