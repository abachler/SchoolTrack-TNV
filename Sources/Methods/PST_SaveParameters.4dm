//%attributes = {}
  //PST_SaveParameters

C_LONGINT:C283(iPst_groups;ipst_Sections;iPst_maxCandidates;iPST_DistributeBySex;viPST_DaysBeforeExam;iPst_maxPerSection;iPST_GrupsbyAge;viPST_IviewDuration;viPST_AutoAsigInterview;viPST_AsigExamLibres)
C_LONGINT:C283(viPST_NbPresentations;viPST_MaxPerPresentation;viPST_AutoAsigPresent;viPST_FixedEXSesions;viPST_VariableEXSesions;viPST_NbSesions;viPST_DontAsigExamJF)
C_BOOLEAN:C305(iPST_ExamsModified)
C_TIME:C306(vhPST_FirstInterview;vhPST_LastInterview)
READ WRITE:C146([XShell_FatObjects:86])
QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="Postulaciones_Examenes")
While (Locked:C147([XShell_FatObjects:86]))
	LOAD RECORD:C52([XShell_FatObjects:86])
End while 
If (Records in selection:C76([XShell_FatObjects:86])=0)
	CREATE RECORD:C68([XShell_FatObjects:86])
	[XShell_FatObjects:86]FatObjectName:1:="Postulaciones_Examenes"
End if 
  //C_longint(viPst_DaysBeforeExam)
  //viPst_DaysBeforeExam:=3

AT_DimArrays (0;-><>asPST_IViewIndicators)
  //vtPST_EvalEntrevistas:=ST_ClearExtraCR (Replace string(vtPST_EvalEntrevistas;";";"\r"))

For ($i;1;Size of array:C274(atPST_Indicadores))
	APPEND TO ARRAY:C911(<>asPST_IViewIndicators;atPST_Indicadores{$i}+": "+atPST_NombreIndicador{$i})
End for 
  //
  //AT_Text2Array (-><>asPST_IViewIndicators;vtPST_EvalEntrevistas;"\r")
  //For ($i;1;Size of array(<>asPST_IViewIndicators))
  //<>asPST_IViewIndicators{$i}:=ST_ClearSpaces (<>asPST_IViewIndicators{$i})
  //End for 

$size:=BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->iPst_groups;->ipst_Sections;->iPst_maxCandidates;->iPST_DistributeBySex;->atPST_GroupName;->adPST_FromDate;->adPST_ToDate;->aiPST_GroupID;->aiPST_Candidates;->aiPST_ExamTime;->aiPST_maxpostulantes;->aiPST_Cupos;->cb_noActualizarGrupos)
$size:=BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;$size;->vhPST_FirstInterview;->vhPST_LastInterview;->viPST_IviewDuration;->vdPST_StartInterviews;->vdPST_EndInterviews;->iPST_GrupsbyAge;->iPST_MaxPerSection;->viPST_AutoAsigInterview;->viPST_AsigExamLibres)
$size:=BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_NbPresentations;->viPST_MaxPerPresentation;->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
$size:=BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_NumJornadasVisita;->viPST_MaxPerJornadaVisita;->viPST_AutoAsigJornadas)
$size:=BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_FixedEXSesions;->viPST_VariableEXSesions;->viPST_NbSesions;->adPst_ExamSesionsDate;->aLPST_ExamAttendance)
$size:=BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_AutoAsigPresent;->viPST_AutoAsigExam;->viPst_DaysBeforeExam)
$size:=BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;$size;-><>vrPST_minPoints;-><>vrPST_maxPoints;-><>vrPST_step;-><>vrPST_precision;-><>asPST_IViewIndicators)
$size:=BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;$size;-><>vrPST_minEvConductual;-><>vrPST_maxEvConductual;-><>vrPST_stepEvConductual;-><>vrPST_precisionEvConductual)
$size:=BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;$size;->viPST_DontAsigExamJF;->vtPST_CantidadIndicadores;->atPST_Indicadores;->atPST_NombreIndicador)

READ WRITE:C146([ADT_SesionesDeExamenes:123])
For ($i;1;Size of array:C274(adPst_ExamSesionsDate))
	QUERY:C277([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]ID:1=aLPST_SesionID{$i})
	[ADT_SesionesDeExamenes:123]Place:3:=atADT_Place{$i}
	[ADT_SesionesDeExamenes:123]Date_Session:2:=adPst_ExamSesionsDate{$i}
	[ADT_SesionesDeExamenes:123]Responsable:6:=asADT_Responsable{$i}
	[ADT_SesionesDeExamenes:123]ID_Responsable:7:=alADT_Responsable_ID{$i}
	SAVE RECORD:C53([ADT_SesionesDeExamenes:123])
	READ WRITE:C146([ADT_Examenes:122])
	QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID_Sesion:12=[ADT_SesionesDeExamenes:123]ID:1)
	FIRST RECORD:C50([ADT_Examenes:122])
	While (Not:C34(End selection:C36([ADT_Examenes:122])))
		[ADT_Examenes:122]Date_Exam:2:=[ADT_SesionesDeExamenes:123]Date_Session:2
		[ADT_Examenes:122]Secs:8:=SYS_DateTime2Secs ([ADT_Examenes:122]Date_Exam:2;[ADT_Examenes:122]Time_Exam:3)
		[ADT_Examenes:122]Responsable:5:=[ADT_SesionesDeExamenes:123]Responsable:6
		SAVE RECORD:C53([ADT_Examenes:122])
		NEXT RECORD:C51([ADT_Examenes:122])
	End while 
End for 
KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])

SAVE RECORD:C53([XShell_FatObjects:86])
KRL_UnloadReadOnly (->[XShell_FatObjects:86])