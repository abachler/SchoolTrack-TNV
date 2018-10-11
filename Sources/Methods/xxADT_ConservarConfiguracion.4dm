//%attributes = {}
  //xxADT_ConservarConfiguracion

  //`Creado Por: Julia Belmar
  //`Fecha: 25/11/2009, 17:17
  //`para no perder la configuración de AdmissionTrack al cierre del año escolar


PST_ReadParameters 
ARRAY TEXT:C222(atPST_GroupNameTemp;0)
ARRAY DATE:C224(adPST_FromDateTemp;0)
ARRAY DATE:C224(adPST_ToDateTemp;0)
ARRAY INTEGER:C220(aiPST_GroupIDTemp;0)
ARRAY INTEGER:C220(aiPST_CandidatesTemp;0)
ARRAY LONGINT:C221(aiPST_ExamTimeTemp;0)
ARRAY LONGINT:C221(aiPST_maxpostulantesTemp;0)
ARRAY INTEGER:C220(aiPST_CuposTemp;0)



COPY ARRAY:C226(atPST_GroupName;atPST_GroupNameTemp)
COPY ARRAY:C226(adPST_FromDate;adPST_FromDateTemp)
COPY ARRAY:C226(adPST_ToDate;adPST_ToDateTemp)
COPY ARRAY:C226(aiPST_GroupID;aiPST_GroupIDTemp)
COPY ARRAY:C226(aiPST_Candidates;aiPST_CandidatesTemp)
COPY ARRAY:C226(aiPST_ExamTime;aiPST_ExamTimeTemp)
COPY ARRAY:C226(aiPST_maxpostulantes;aiPST_maxpostulantesTemp)
COPY ARRAY:C226(aiPST_Cupos;aiPST_CuposTemp)

  //iPst_groups  `conservar número de grupos
  //ipst_Sections  `conservar el número de secciones
  //iPst_maxCandidates  `conservar el m+aximo de candidatos
  //iPST_DistributeBySex  `conservar la distribuccion por sexo

  //AT_RedimArrays (4;->atPST_GroupName;->adPST_FromDate;->adPST_ToDate;->aiPST_GroupID;->aiPST_Candidates;->aiPST_ExamTime;->aiPST_maxpostulantes;->aiPST_Cupos)
  //atPST_GroupName  `conservar el arreglo con el nombre de los grupos


  //actualizo las fechas desde
For ($i;1;Size of array:C274(adPST_FromDateTemp))
	$dia:=Day of:C23(adPST_FromDateTemp{$i})
	$mes:=Month of:C24(adPST_FromDateTemp{$i})
	$ano:=Year of:C25(adPST_FromDateTemp{$i})+1
	adPST_FromDateTemp{$i}:=DT_GetDateFromDayMonthYear ($dia;$mes;$ano)
End for 

  //actualizo las fechas hasta
For ($i;1;Size of array:C274(adPST_ToDateTemp))
	$dia:=Day of:C23(adPST_ToDateTemp{$i})
	$mes:=Month of:C24(adPST_ToDateTemp{$i})
	$ano:=Year of:C25(adPST_ToDateTemp{$i})+1
	adPST_ToDateTemp{$i}:=DT_GetDateFromDayMonthYear ($dia;$mes;$ano)
End for 


COPY ARRAY:C226(adPST_FromDateTemp;adPST_FromDate)
COPY ARRAY:C226(adPST_ToDateTemp;adPST_ToDate)
COPY ARRAY:C226(aiPST_ExamTimeTemp;aiPST_ExamTime)
COPY ARRAY:C226(aiPST_GroupIDTemp;aiPST_GroupID)
COPY ARRAY:C226(aiPST_CandidatesTemp;aiPST_Candidates)
COPY ARRAY:C226(aiPST_maxpostulantesTemp;aiPST_maxpostulantes)
COPY ARRAY:C226(aiPST_CuposTemp;aiPST_Cupos)
COPY ARRAY:C226(atPST_GroupNameTemp;atPST_GroupName)

  //ADT_InicializaAdmissionTrack

  //crea el intervalo de fechas por defecto, para los valores del formulario
  //READ WRITE([xxADT_Fechas])
  //ALL RECORDS([xxADT_Fechas])
  //DELETE SELECTION([xxADT_Fechas])
  //SAVE RECORD([xxADT_Fechas])
  //
  //For ($i;1;Size of array(adPST_FromDate))
  //CREATE RECORD([xxADT_Fechas])
  //[xxADT_Fechas]ID:=aiPST_GroupID{$i}
  //[xxADT_Fechas]Fecha Inicio:=adPST_FromDate{$i}
  //[xxADT_Fechas]Fecha Término:=adPST_ToDate{$i}
  //[xxADT_Fechas]Postula:=True
  //SAVE RECORD([xxADT_Fechas])
  //End for 
  //READ ONLY([xxADT_Fechas])



  //aiPST_GroupID  `guardar los id's de grupo
  //aiPST_maxpostulantes  `guardar el máximo de postulantes
  //aiPST_ExamTime  `guardar las horas de exámen

For ($i;1;Size of array:C274(aiPST_Candidates))
	aiPST_Candidates{$i}:=0
End for 

For ($i;1;Size of array:C274(aiPST_Cupos))
	aiPST_Cupos{$i}:=aiPST_maxpostulantes{$i}-aiPST_Candidates{$i}
End for 

  //guardar el intervalo de fechas para las entrevistas
  //vhPST_FirstInterview 
  //vhPST_LastInterview 

  //guardar la duracion de la entrevista
  //viPST_IviewDuration

  //guardar el intervalo de horas para las entrevistas
  //vdPST_StartInterviews
  //vdPST_EndInterviews

  //iPST_GrupsbyAge:=1
  //iPST_MaxPerSection:=8
  //viPST_AutoAsigInterview:=1


  //viPST_NbPresentations:=0
  //viPST_MaxPerPresentation:=80

  //viPST_FixedEXSesions:=1
  //viPST_VariableEXSesions:=0
  //viPST_NbSesions:=0


  //ARRAY LONGINT(aLPST_SesionID;0)
  //ARRAY DATE(adPst_ExamSesionsDate;0)
  //ARRAY INTEGER(alADT_ExamAttendance;0)
  //ARRAY BOOLEAN(abADT_ReservedPG;0)
  //ARRAY TEXT(atADT_Place;0)

  //viPST_AutoAsigPresent:=1
  //viPST_AutoAsigExam:=1
  //viPST_MasExaminadores:=0
  //viPst_DaysBeforeExam:=15

  //
  //<>vrPST_minPoints:=1
  //<>vrPST_maxPoints:=10
  //<>vrPST_step:=0.1
  //<>vrPST_precision:=1
  //  `<>asPST_IViewIndicators:=
  //
  //<>vrPST_minEvConductual:=1
  //<>vrPST_maxEvConductual:=5
  //<>vrPST_stepEvConductual:=0
  //<>vrPST_precisionEvConductual:=1
  //
  //vtPST_EvalEntrevistas:=""
  //
  //viPST_DontAsigExamJF:=0
PST_SaveParameters 