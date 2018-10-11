//%attributes = {}
  //AL_LeeObservacionesHistoricas

$recNum:=$1
vtSTR_AL_Observaciones:=""

  //If (aNtaAsignatura>0)
If ($recNum>=0)
	READ ONLY:C145([Alumnos_Calificaciones:208])
	  //KRL_GotoRecord (->[Alumnos_Calificaciones];aNtaRecNum{aNtaAsignatura};False) //ASM 20140602 Ticket  133506
	KRL_GotoRecord (->[Alumnos_Calificaciones:208];$recNum;False:C215)
	
	  //20140619 ASM Para cargar el complemento de evaluacion de asignaturas historicas creadas manualmente.
	If ([Asignaturas_Historico:84]ID_AsignaturaOriginal:30#0)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;False:C215)
	Else 
		KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_RegistroHistorico:87;->[Alumnos_Calificaciones:208]Llave_RegistroHistorico:504;False:C215)
	End if 
	
	PERIODOS_LeeDatosHistoricos (vl_NivelSeleccionado_Historico;vl_Year_Historico)
	
	For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
		$observaciones:=""
		KRL_GetFieldValueByFieldName ("[Alumnos_ComplementoEvaluacion]P0"+String:C10($i)+"_Obs_Academicas";->$observaciones)
		vtSTR_AL_Observaciones:=vtSTR_AL_Observaciones+Uppercase:C13(atSTR_Periodos_Nombre{$i})+":"+Char:C90(Carriage return:K15:38)+$observaciones+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	End for 
	vtSTR_AL_Observaciones:=vtSTR_AL_Observaciones+"FINAL:"+Char:C90(Carriage return:K15:38)+[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
	vtSTR_AL_LabelObservaciones:="Observaciones en "+[Alumnos_Calificaciones:208]NombreInternoAsignatura:8
	
	  //PERIODOS_LeeDatosHistoricos (vl_NivelSeleccionado_Historico;vl_Year_Historico)
	
	ALP_RemoveAllArrays (xALP_HNotasECursos)
	ARRAY TEXT:C222(aObsPJTerm;0)
	ARRAY TEXT:C222(aPJobs;0)
	For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
		APPEND TO ARRAY:C911(aObsPJTerm;atSTR_Periodos_Nombre{$i})
	End for 
	APPEND TO ARRAY:C911(aObsPJTerm;"Finales")
	ARRAY TEXT:C222(aPJobs;Size of array:C274(aObsPJTerm))
	
	
	Case of 
		: (Size of array:C274(aPJObs)=3)
			aPJObs{1}:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
			aPJObs{2}:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
			aPJObs{3}:=[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
			$rows:=4
			$rowPad:=9
		: (Size of array:C274(aPJObs)=4)
			aPJObs{1}:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
			aPJObs{2}:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
			aPJObs{3}:=[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
			aPJObs{4}:=[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
			$rows:=4
			$rowPad:=8
		: (Size of array:C274(aPJObs)=5)
			aPJObs{1}:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
			aPJObs{2}:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
			aPJObs{3}:=[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
			aPJObs{4}:=[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
			aPJObs{5}:=[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
			$rows:=4
			$rowPad:=8
		: (Size of array:C274(aPJObs)=6)
			aPJObs{1}:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
			aPJObs{2}:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
			aPJObs{3}:=[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
			aPJObs{4}:=[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
			aPJObs{5}:=[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
			aPJObs{6}:=[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
			$rows:=4
			$rowPad:=8
	End case 
	
	ALP_RemoveAllArrays (xALP_HNotasECursos)
	C_LONGINT:C283($Error)
	
	  //specify arrays to display
	$Error:=AL_SetArraysNam (xALP_HNotasECursos;1;1;"aObsPJTerm")
	$Error:=AL_SetArraysNam (xALP_HNotasECursos;2;1;"aPJObs")
	
	  //column 1 settings
	AL_SetHeaders (xALP_HNotasECursos;1;1;__ ("Período"))
	AL_SetWidths (xALP_HNotasECursos;1;1;100)
	AL_SetFormat (xALP_HNotasECursos;1;"";0;0;0;0)
	AL_SetHdrStyle (xALP_HNotasECursos;1;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_HNotasECursos;1;"Tahoma";9;0)
	AL_SetStyle (xALP_HNotasECursos;1;"Tahoma";9;0)
	AL_SetForeColor (xALP_HNotasECursos;1;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_HNotasECursos;1;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_HNotasECursos;1;0)
	AL_SetEntryCtls (xALP_HNotasECursos;1;0)
	
	  //column 2 settings
	AL_SetHeaders (xALP_HNotasECursos;2;1;__ ("Observaciones"))
	AL_SetWidths (xALP_HNotasECursos;2;1;476)
	AL_SetFormat (xALP_HNotasECursos;2;"";0;0;0;0)
	AL_SetHdrStyle (xALP_HNotasECursos;2;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_HNotasECursos;2;"Tahoma";9;0)
	AL_SetStyle (xALP_HNotasECursos;2;"Tahoma";9;0)
	AL_SetForeColor (xALP_HNotasECursos;2;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_HNotasECursos;2;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_HNotasECursos;2;Num:C11(vb_HistoricoEditable))
	AL_SetEntryCtls (xALP_HNotasECursos;2;0)
	
	  //general options
	
	AL_SetColOpts (xALP_HNotasECursos;1;1;1;0;0)
	AL_SetRowOpts (xALP_HNotasECursos;0;1;0;0;1;0)
	AL_SetCellOpts (xALP_HNotasECursos;0;1;1)
	AL_SetMiscOpts (xALP_HNotasECursos;0;0;"\\";0;1)
	AL_SetCallbacks (xALP_HNotasECursos;"";"XALCB_EX_HObs_Asignaturas")
	AL_SetMiscColor (xALP_HNotasECursos;0;"White";0)
	AL_SetMiscColor (xALP_HNotasECursos;1;"White";0)
	AL_SetMiscColor (xALP_HNotasECursos;2;"White";0)
	AL_SetMiscColor (xALP_HNotasECursos;3;"White";0)
	AL_SetMainCalls (xALP_HNotasECursos;"";"")
	AL_SetScroll (xALP_HNotasECursos;0;-3)
	AL_SetCopyOpts (xALP_HNotasECursos;0;"\t";"\r";Char:C90(0))
	AL_SetSortOpts (xALP_HNotasECursos;0;1;0;"Select the columns to sort:";0)
	AL_SetEntryOpts (xALP_HNotasECursos;3;1;0;0;0;<>tXS_RS_DecimalSeparator)
	AL_SetHeight (xALP_HNotasECursos;1;2;4;3;2)
	AL_SetDividers (xALP_HNotasECursos;"Black";"Light Gray";0;"Black";"Light Gray";0)
	AL_SetDrgOpts (xALP_HNotasECursos;0;30;0)
	AL_SetColLock (xALP_HNotasECursos;1)
	
	  //dragging options
	
	AL_SetDrgSrc (xALP_HNotasECursos;1;"";"";"")
	AL_SetDrgSrc (xALP_HNotasECursos;2;"";"";"")
	AL_SetDrgSrc (xALP_HNotasECursos;3;"";"";"")
	AL_SetDrgDst (xALP_HNotasECursos;1;"";"";"")
	AL_SetDrgDst (xALP_HNotasECursos;1;"";"";"")
	AL_SetDrgDst (xALP_HNotasECursos;1;"";"";"")
	
	  //ALP_SetDefaultAppareance (xALP_HNotasECursos;9;4)//MONO Ticket 186325 
	AL_UpdateArrays (xALP_HNotasECursos;-2)
	AL_SetLine (xALP_HNotasECursos;0)
	
	
End if 
