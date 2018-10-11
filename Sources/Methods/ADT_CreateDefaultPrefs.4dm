//%attributes = {}
  //ADT_CreateDefaultPrefs

PST_InitVariables 
$currentYear:=Year of:C25(Current date:C33(*))
iPst_groups:=4
ipst_Sections:=4
iPst_maxCandidates:=120
iPST_DistributeBySex:=1
AT_RedimArrays (4;->atPST_GroupName;->adPST_FromDate;->adPST_ToDate;->aiPST_GroupID;->aiPST_Candidates;->aiPST_ExamTime;->aiPST_maxpostulantes;->aiPST_Cupos)
atPST_GroupName{1}:=__ ("Grupo 1")
atPST_GroupName{2}:=__ ("Grupo 2")
atPST_GroupName{3}:=__ ("Grupo 3")
atPST_GroupName{4}:=__ ("Grupo 4")
adPST_FromDate{1}:=DT_GetDateFromDayMonthYear (1;12;$currentYear-5)
adPST_FromDate{2}:=DT_GetDateFromDayMonthYear (1;4;$currentYear-4)
adPST_FromDate{3}:=DT_GetDateFromDayMonthYear (1;7;$currentYear-4)
adPST_FromDate{4}:=DT_GetDateFromDayMonthYear (1;10;$currentYear-4)
adPST_ToDate{1}:=DT_GetDateFromDayMonthYear (31;3;$currentYear-4)
adPST_ToDate{2}:=DT_GetDateFromDayMonthYear (30;6;$currentYear-4)
adPST_ToDate{3}:=DT_GetDateFromDayMonthYear (30;9;$currentYear-4)
adPST_ToDate{4}:=DT_GetDateFromDayMonthYear (30;11;$currentYear-4)
aiPST_GroupID{1}:=1
aiPST_GroupID{2}:=2
aiPST_GroupID{3}:=3
aiPST_GroupID{4}:=4
aiPST_Candidates{1}:=10
aiPST_Candidates{2}:=10
aiPST_Candidates{3}:=10
aiPST_Candidates{4}:=10
aiPST_ExamTime{1}:=0
aiPST_ExamTime{2}:=0
aiPST_ExamTime{3}:=0
aiPST_ExamTime{4}:=0
aiPST_maxpostulantes{1}:=0
aiPST_maxpostulantes{2}:=0
aiPST_maxpostulantes{3}:=0
aiPST_maxpostulantes{4}:=0
aiPST_Cupos{1}:=0
aiPST_Cupos{2}:=0
aiPST_Cupos{3}:=0
aiPST_Cupos{4}:=0


vhPST_FirstInterview:=Time:C179("8:00:00")
vhPST_LastInterview:=Time:C179("17:40:00")
viPST_IviewDuration:=20
vdPST_StartInterviews:=DT_GetDateFromDayMonthYear (3;5;$currentYear)
vdPST_EndInterviews:=DT_GetDateFromDayMonthYear (20;5;$currentYear)
iPST_GrupsbyAge:=1
iPST_MaxPerSection:=8
viPST_AutoAsigInterview:=1
viPST_AsigExamLibres:=0
cb_noActualizarGrupos:=0
viPST_NbPresentations:=0
viPST_MaxPerPresentation:=80

viPST_FixedEXSesions:=1
viPST_VariableEXSesions:=0
viPST_NbSesions:=0
ARRAY LONGINT:C221(aLPST_SesionID;0)
ARRAY DATE:C224(adPst_ExamSesionsDate;0)
ARRAY INTEGER:C220(alADT_ExamAttendance;0)
ARRAY BOOLEAN:C223(abADT_ReservedPG;0)
ARRAY TEXT:C222(atADT_Place;0)

viPST_AutoAsigPresent:=1
viPST_AutoAsigExam:=1
viPst_DaysBeforeExam:=15

<>vrPST_minPoints:=1
<>vrPST_maxPoints:=10
<>vrPST_step:=0.1
<>vrPST_precision:=1
  //<>asPST_IViewIndicators:=

<>vrPST_minEvConductual:=1
<>vrPST_maxEvConductual:=5
<>vrPST_stepEvConductual:=1
<>vrPST_precisionEvConductual:=0

vtPST_EvalEntrevistas:=""

viPST_DontAsigExamJF:=0

PST_SaveParameters 



  //EstadosADTMX
C_BLOB:C604($blob)
PREF_Set (0;"LastEstadoID";"0")

$hl_Estados:=New list:C375

APPEND TO LIST:C376($hl_Estados;__ ("Inscrito");-1)
APPEND TO LIST:C376($hl_Estados;__ ("Informes");-2)
APPEND TO LIST:C376($hl_Estados;__ ("Aspirante");-3)
APPEND TO LIST:C376($hl_Estados;"Lista de Espera";-4)
APPEND TO LIST:C376($hl_Estados;__ ("Admitido");-5)
APPEND TO LIST:C376($hl_Estados;__ ("Desiste");-6)
APPEND TO LIST:C376($hl_Estados;__ ("Rechazado");-7)


SET BLOB SIZE:C606($blob;0)
LIST TO BLOB:C556($hl_Estados;$blob)

PREF_SetBlob (0;"estadosADT";$blob)

HL_ClearList ($hl_Estados)