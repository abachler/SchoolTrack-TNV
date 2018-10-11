//%attributes = {}
  //PST_ReadParameters

$admissionTrackIsInitialized:=Num:C11(PREF_fGet (0;"ADT_Inicializado";"0"))
If ($admissionTrackIsInitialized=1)
	PST_InitVariables 
	C_LONGINT:C283(iPst_groups;ipst_Sections;iPst_maxCandidates;iPST_DistributeBySex;viPST_DaysBeforeExam;iPst_maxPerSection;iPST_GrupsbyAge;viPST_IviewDuration;viPST_AutoAsigInterview;viPST_AsigExamLibres)
	C_LONGINT:C283(viPST_NbPresentations;viPST_MaxPerPresentation;viPST_AutoAsigPresent;viPST_FixedEXSesions;viPST_VariableEXSesions;viPST_NbSesions;viPST_DontAsigExamJF)
	C_REAL:C285(<>vrPST_minPoints;<>vrPST_maxPoints;<>vrPST_step)
	C_REAL:C285(<>vrPST_minEvConductual;<>vrPST_maxEvConductual;<>vrPST_stepEvConductual)
	C_LONGINT:C283($result;<>vrPST_precision;<>vrPST_precisionEvConductual)
	_O_ARRAY STRING:C218(35;aD1;0)
	_O_ARRAY STRING:C218(35;aD2;0)
	_O_ARRAY STRING:C218(35;aD3;0)
	_O_ARRAY STRING:C218(35;aD4;0)
	_O_ARRAY STRING:C218(35;aD5;0)
	
	ARRAY INTEGER:C220(aColor1;0)
	ARRAY INTEGER:C220(aColor2;0)
	ARRAY INTEGER:C220(aColor3;0)
	ARRAY INTEGER:C220(aColor4;0)
	ARRAY INTEGER:C220(aColor5;0)
	
	ARRAY POINTER:C280(aiPST_ColorArrPtr;5)
	aiPST_ColorArrPtr{1}:=->aColor1
	aiPST_ColorArrPtr{2}:=->aColor2
	aiPST_ColorArrPtr{3}:=->aColor3
	aiPST_ColorArrPtr{4}:=->aColor4
	aiPST_ColorArrPtr{5}:=->aColor5
	
	ARRAY POINTER:C280(ayPST_ScheduleColPointers;5)
	ayPST_ScheduleColPointers{1}:=->aD1
	ayPST_ScheduleColPointers{2}:=->aD2
	ayPST_ScheduleColPointers{3}:=->aD3
	ayPST_ScheduleColPointers{4}:=->aD4
	ayPST_ScheduleColPointers{5}:=->aD5
	
	_O_ARRAY STRING:C218(80;<>asPST_IViewIndicators;0)
	
	READ ONLY:C145([XShell_FatObjects:86])
	QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="Postulaciones_Examenes")
	If ((Records in selection:C76([XShell_FatObjects:86])=1) & (Not:C34(Macintosh option down:C545 | Windows Alt down:C563)))
		$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->iPst_groups;->ipst_Sections;->iPst_maxCandidates;->iPST_DistributeBySex;->atPST_GroupName;->adPST_FromDate;->adPST_ToDate;->aiPST_GroupID;->aiPST_Candidates;->aiPST_ExamTime;->aiPST_maxpostulantes;->aiPST_Cupos;->cb_noActualizarGrupos)
		$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;$size;->vhPST_FirstInterview;->vhPST_LastInterview;->viPST_IviewDuration;->vdPST_StartInterviews;->vdPST_EndInterviews;->iPST_GrupsbyAge;->iPST_MaxPerSection;->viPST_AutoAsigInterview;->viPST_AsigExamLibres)
		$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_NbPresentations;->viPST_MaxPerPresentation;->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
		$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_NumJornadasVisita;->viPST_MaxPerJornadaVisita;->viPST_AutoAsigJornadas)
		$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_FixedEXSesions;->viPST_VariableEXSesions;->viPST_NbSesions;->adPst_ExamSesionsDate;->aLPST_ExamAttendance)
		$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_AutoAsigPresent;->viPST_AutoAsigExam;->viPst_DaysBeforeExam)
		$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;$size;-><>vrPST_minPoints;-><>vrPST_maxPoints;-><>vrPST_step;-><>vrPST_precision;-><>asPST_IViewIndicators)
		$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;$size;-><>vrPST_minEvConductual;-><>vrPST_maxEvConductual;-><>vrPST_stepEvConductual;-><>vrPST_precisionEvConductual)
		$size:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_DontAsigExamJF;->vtPST_CantidadIndicadores;->atPST_Indicadores;->atPST_NombreIndicador)
		
		  //vtPST_EvalEntrevistas:=AT_array2text (-><>asPST_IViewIndicators;"\r")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$result)
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_numero:1#0)
		vsPST_ActualCandidates:="(actualmente, "+String:C10($result)+" registrados)"
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		
		C_TIME:C306($nextHour)
		ARRAY LONGINT:C221(aTimeIView;0)
		_O_ARRAY STRING:C218(35;aD1;0)
		_O_ARRAY STRING:C218(35;aD2;0)
		_O_ARRAY STRING:C218(35;aD3;0)
		_O_ARRAY STRING:C218(35;aD4;0)
		_O_ARRAY STRING:C218(35;aD5;0)
		
		ARRAY INTEGER:C220(aColor1;0)
		ARRAY INTEGER:C220(aColor2;0)
		ARRAY INTEGER:C220(aColor3;0)
		ARRAY INTEGER:C220(aColor4;0)
		ARRAY INTEGER:C220(aColor5;0)
		
		ARRAY POINTER:C280(aiPST_ColorArrPtr;5)
		aiPST_ColorArrPtr{1}:=->aColor1
		aiPST_ColorArrPtr{2}:=->aColor2
		aiPST_ColorArrPtr{3}:=->aColor3
		aiPST_ColorArrPtr{4}:=->aColor4
		aiPST_ColorArrPtr{5}:=->aColor5
		
		If (viPST_IviewDuration>0)
			$periodos:=Int:C8(((vhPST_LastInterview-vhPST_FirstInterview)/60)/viPST_IviewDuration)
			$periodos:=$periodos+1
			If ($periodos>=1)
				ARRAY LONGINT:C221(aTimeIView;$periodos)
				AT_DimArrays ($periodos;->aD1;->aD2;->aD3;->aD4;->aD5)
				AT_DimArrays ($periodos;->aColor1;->aColor2;->aColor3;->aColor4;->aColor5)
				aTimeIView{1}:=vhPST_FirstInterview*1
				$NextHour:=aTimeIView{1}
				For ($i;2;$periodos)
					aTimeIView{$i}:=$NextHour+(viPST_IviewDuration*60)
					$nextHour:=$nextHour+(viPST_IviewDuration*60)
				End for 
			End if 
		Else 
			viPST_IviewDuration:=20
		End if 
	Else 
		PST_SaveParameters 
	End if 
	
	ADTcfg_LoadSesionesEX 
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;<>lPST_CurrentPostulations)
	QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Terminado:44=False:C215)
	SET QUERY DESTINATION:C396(0)
	
	ADTcdd_LoadEstados2Arrays 
End if 