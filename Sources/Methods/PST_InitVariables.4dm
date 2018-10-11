//%attributes = {}
  //PST_InitVariables

C_LONGINT:C283(cb_noActualizarGrupos)
C_LONGINT:C283(hl_gestion)
C_LONGINT:C283(iPst_groups;iPST_tSections;iPst_maxCandidates;iPST_DistributeBySex;viPST_DaysBeforeExam;iPst_maxPerSection;iPST_GrupsbyAge;viPST_IviewDuration;viPST_AutoAsigInterview;viPST_AsigExamLibres)
C_LONGINT:C283(viPST_NbPresentations;viPST_MaxPerPresentation;viPST_AutoAsigPresent;viPST_FixedEXSesions;viPST_VariableEXSesions;viPST_NbSesions)
C_BOOLEAN:C305(iPST_ExamsModified)
C_TIME:C306(vhPST_FirstInterview;vhPST_LastInterview)
C_TEXT:C284(sSearch)
C_TEXT:C284(horaListadoDiario)
C_TEXT:C284(diaListadoSemanal)
C_TEXT:C284(horaListadoSemanal)

C_PICTURE:C286(previewPlantillaADN)
  //campos del formulario
ARRAY TEXT:C222(atnombreCampo;0)
ARRAY TEXT:C222(atEtiquetaCampo;0)
ARRAY LONGINT:C221(aiIDCampo;0)
ARRAY BOOLEAN:C223(abCampoObligatorio;0)


ARRAY TEXT:C222(atPST_GroupName;0)

ARRAY DATE:C224(adPST_FromDate;0)
ARRAY DATE:C224(adPST_ToDate;0)
ARRAY INTEGER:C220(aiPST_GroupID;0)
ARRAY INTEGER:C220(aiPST_Candidates;0)
ARRAY LONGINT:C221(aiPST_ExamTime;0)
ARRAY LONGINT:C221(aiPST_maxpostulantes;0)
ARRAY INTEGER:C220(aiPST_Cupos;0)

ARRAY LONGINT:C221(aiCML_IDAlerta;0)
ARRAY TEXT:C222(atCML_NombreAlerta;0)
ARRAY TEXT:C222(atCML_ModuloAlerta;0)

ARRAY PICTURE:C279(<>apCML_SiVariable;0)
ARRAY BOOLEAN:C223(<>abCML_SiVariable;0)
ARRAY TEXT:C222(<>atCML_CodigoVariable;0)
ARRAY TEXT:C222(<>atCML_DescripcionVariable;0)


ARRAY DATE:C224(adFechaActividad;0)
ARRAY LONGINT:C221(atHoraActividad;0)
ARRAY TEXT:C222(atLogActividades;0)

  //`àrreglos para area list de Observaciones en Candidatos
ARRAY DATE:C224(adFechaObservacion;0)
ARRAY TEXT:C222(atTextoObservacion;0)
ARRAY TEXT:C222(atUsuarioObservacion;0)
ARRAY LONGINT:C221(aiIDObservacion;0)

C_LONGINT:C283(viPST_NumJornadasVisita)
C_LONGINT:C283(viPST_MaxPerJornadaVisita)
C_LONGINT:C283(viPST_AutoAsigJornadas)

ARRAY TEXT:C222(atTipoInstitucion;0)
ARRAY TEXT:C222(atInstitucion;0)
ARRAY TEXT:C222(atPaisEducacion;0)
ARRAY TEXT:C222(atGradoONivel;0)
ARRAY LONGINT:C221(aiAno;0)
ARRAY LONGINT:C221(IDEducacionAnterior;0)
C_LONGINT:C283(v_idAlerta)

ARRAY TEXT:C222(atNombresDocumentos;0)
ARRAY TEXT:C222(atTagDocumentos;0)
ARRAY LONGINT:C221(aiIDDocumentos;0)
ARRAY PICTURE:C279(apIncluirEnFormulario;0)
ARRAY BOOLEAN:C223(abIncluirEnFormulario;0)
ARRAY LONGINT:C221(aiCrearDocumento;0)

cb_noActualizarGrupos:=0
iPST_ExamsModified:=False:C215
iPst_groups:=0
ipst_Sections:=0
iPst_maxCandidates:=0
iPst_maxPerSection:=0
iPST_DistributeBySex:=1
iPST_GrupsbyAge:=1
viPst_DaysBeforeExam:=1
viPST_AutoAsigExam:=1
viPST_AsigExamLibres:=0
vhPST_FirstInterview:=?00:00:00?
vhPST_LastInterview:=?00:00:00?
viPST_IviewDuration:=0
vdPST_StartInterviews:=!00-00-00!
vdPST_EndInterviews:=!00-00-00!
viPST_AutoAsigInterview:=0
viPST_NbPresentations:=0
viPST_MaxPerPresentation:=0
viPST_AutoAsigPresent:=0
viPST_DontAsigExamJF:=0
ARRAY DATE:C224(adPST_PresentDate;0)
ARRAY LONGINT:C221(aLPST_PresentTime;0)
ARRAY INTEGER:C220(aiPST_Asistentes;0)
ARRAY TEXT:C222(atPST_Place;0)
ARRAY TEXT:C222(atPST_Encargado;0)
ARRAY LONGINT:C221(aiADT_IDEntrevistador;0)

viPST_FixedEXSesions:=0
viPST_VariableEXSesions:=0
viPST_NbSesions:=0
ARRAY DATE:C224(adPst_ExamSesionsDate;0)
ARRAY INTEGER:C220(aLPST_ExamAttendance;0)
ARRAY TEXT:C222(atPST_SelEXmTeacher;0)
ARRAY TEXT:C222(atPST_SelEXmGroupNames;0)
ARRAY DATE:C224(adPST_SelEXmDate;0)
ARRAY REAL:C219(aLPST_SelEXmSecs;0)
ARRAY LONGINT:C221(aLPST_SelEXmID;0)
ARRAY LONGINT:C221(aLPST_SelEXmTime;0)


ARRAY TEXT:C222(aAsignaciones;0)
ARRAY TEXT:C222(aSearchPost;0)
sSearch:=""


ARRAY INTEGER:C220(aiPST_EXmGroupID;0)
ARRAY TEXT:C222(atPST_EXmGroupName;0)
ARRAY DATE:C224(adPST_EXmDate;0)
ARRAY LONGINT:C221(aLPST_EXmTime;0)
ARRAY REAL:C219(aLPST_EXmSecs;0)
ARRAY TEXT:C222(asPST_EXmSections;0)
ARRAY INTEGER:C220(aiPST_EXmAttendance;0)
ARRAY INTEGER:C220(aiPST_EXmGirls;0)
ARRAY INTEGER:C220(aiPST_EXmBoys;0)
ARRAY INTEGER:C220(aiPST_EXmID;0)


ARRAY TEXT:C222(atPST_Indicadores;0)
ARRAY TEXT:C222(atPST_NombreIndicador;0)
C_LONGINT:C283(vtPST_CantidadIndicadores)

ARRAY TEXT:C222(at_Connexions;0)
_O_ARRAY STRING:C218(80;<>asPST_IViewIndicators;0)

<>vrPST_minPoints:=0
<>vrPST_maxPoints:=0
<>vrPST_step:=0
<>vrPST_precision:=0
<>vrPST_minEvConductual:=0
<>vrPST_maxEvConductual:=0
<>vrPST_stepEvConductual:=0
<>vrPST_precisionEvConductual:=0