//%attributes = {}
  //Compiler_STW

  //Propiedades Evaluacion
ARRAY TEXT:C222(atAS_EvalPropSourceName;0)  //destination name
ARRAY TEXT:C222(atAS_EvalPropClassName;0)  //destination class
ARRAY LONGINT:C221(alAS_EvalPropSourceID;0)  //id destination
ARRAY LONGINT:C221(aiAS_EvalPropEnterable;0)  //method
ARRAY REAL:C219(arAS_EvalPropPercent;0)  //grade weight
ARRAY REAL:C219(arAS_EvalPropCoefficient;0)  //coefficient
ARRAY BOOLEAN:C223(abAS_EvalPropPrintDetail;0)  //print on reports
ARRAY TEXT:C222(atAS_EvalPropPrintName;0)  //print as
ARRAY TEXT:C222(atAS_EvalPropDescription;0)  //description
ARRAY DATE:C224(adAS_EvalPropDueDate;0)  //due date  
ARRAY REAL:C219(arAS_EvalPropPonderacion;0)
ARRAY INTEGER:C220(ALSTR_INASISTENCIASPERIODO;0)

  //WSstw_GetAsignatura
ARRAY TEXT:C222(aIndEsfuerzo;0)
C_REAL:C285(rGradesFrom)
C_REAL:C285(rGradesTo)
C_LONGINT:C283(iGradesDec)
C_REAL:C285(rGradesInterval)
C_REAL:C285(rPointsFrom)
C_REAL:C285(rPointsTo)
C_LONGINT:C283(iPointsDec)
C_REAL:C285(rPointsInterval)
ARRAY TEXT:C222(aSymbol;0)
C_LONGINT:C283(iEvaluationMode)
  //C_REAL(iEvaluationMode)
C_TEXT:C284(rMinSimbolo)
  //C_TEXT(vs_GradesFormat)
_O_C_STRING:C293(255;vs_GradesFormat)
C_LONGINT:C283(viSTR_NoModificarNotas)
C_REAL:C285(rMinimo)


  //Aprendizajes
C_TEXT:C284(obs)
C_LONGINT:C283(recnumasig)
C_LONGINT:C283(recnum)
C_LONGINT:C283(tipoeval)
C_TEXT:C284(valor)
C_LONGINT:C283(estilo)
C_LONGINT:C283(vl_calculosSobreCompetencias)
ARRAY TEXT:C222(atEVLG_LLavesEjes;0)
ARRAY TEXT:C222(atEVLG_Alumnos;0)
ARRAY TEXT:C222(atEVLG_Indicadores;0)
ARRAY TEXT:C222(atEVLG_Observaciones_Final;0)
_O_ARRAY STRING:C218(5;asEVLG_EvaluacionSimbolos;0)
_O_ARRAY STRING:C218(5;asEVLG_EvaluacionSimbolos_Final;0)
ARRAY REAL:C219(arEVLG_EvaluacionReal;0)
ARRAY REAL:C219(arEVLG_EvaluacionReal_Final;0)
ARRAY LONGINT:C221(alEVLG_IdsAlumnosEValuaciones;0)
ARRAY LONGINT:C221(alEVLG_RecNumAlumnos;0)

ARRAY TEXT:C222(atEVLG_EjesLogros;0)
ARRAY LONGINT:C221(alEVLG_Ids;0)
ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
ARRAY TEXT:C222(atEVLG_Icons;0)

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

  //WSstw_RecibirAsistencia
C_LONGINT:C283(vAsistencia)

  //WSstw_GetExplorerAsigData
C_LONGINT:C283(vl_RecNum)
C_TEXT:C284(vt_PromInterno)
C_TEXT:C284(vt_PromOficial)
C_REAL:C285(vr_Aprobacion)

  //WSstw_GetAsignaturaParameters
C_BOOLEAN:C305(vbBloqueo)
C_TEXT:C284(vtFechaBloqueo)
C_LONGINT:C283(viSTR_NoModificarNotas)
C_TEXT:C284(tXS_RS_DecimalSeparator)
C_LONGINT:C283(vlHorasClase)
C_LONGINT:C283(vl_MatrizAprendizajes)
C_LONGINT:C283(vl_IDUsuario)

  //WSstw_GetAlumnoConducta
C_LONGINT:C283(vIDAlumno)
C_LONGINT:C283(vl_AnotacionesNegativas)
C_LONGINT:C283(vl_AnotacionesPositivas)
C_LONGINT:C283(vl_PuntosNegativos)
C_LONGINT:C283(vl_PuntosPositivos)
C_LONGINT:C283(vl_Castigos)
C_LONGINT:C283(vl_suspensiones)
C_LONGINT:C283(vl_AnotacionesNeutras)
C_LONGINT:C283(vl_TotalRetardoAcumulado)
C_LONGINT:C283(vl_inasistencias)
C_LONGINT:C283(vl_InasistenciasJustificadas)
C_LONGINT:C283(vl_HorasInasistencia)
C_LONGINT:C283(vl_AtrasosJornada)
C_LONGINT:C283(vl_AtrasosSesion)
C_LONGINT:C283(vl_TotalAtrasos)
C_REAL:C285(vr_PorcentajeAsistenciaAnual)
C_TEXT:C284(vs_FaltasPorAtrasos)
C_REAL:C285(vr_FaltasPorAtrasosJornada)
C_REAL:C285(vr_FaltasPorAtrasosSesion)
C_REAL:C285(vr_PorcentajeAsistencia)
C_TEXT:C284(vt_fechaCondicionalidad)
C_TEXT:C284(vt_motivoCondicionalidad)
C_TEXT:C284(vNameAlumno)
C_LONGINT:C283(bCondicional)
C_LONGINT:C283(vl_indicadorMinutos)
C_LONGINT:C283(vl_indicadorInasistencia)

  //WSstw_ProcessLogin
C_TEXT:C284(vt_Login)
C_TEXT:C284(vt_Password)
C_LONGINT:C283(vl_Conectados)
C_LONGINT:C283(vl_IDProfesor)
C_TEXT:C284(vt_NameProfesor)
C_LONGINT:C283(vl_version)

  //Sstw_TestLoginSemaphore
C_BOOLEAN:C305(vb_SemaphoreState)

  //WSstw_GetAsignaturas
C_LONGINT:C283(vCantidad)
C_LONGINT:C283(vIDProfesor)
C_LONGINT:C283(vIDUsuario)
C_TEXT:C284(vColSTW)
C_TEXT:C284(vDirSTW)
C_TEXT:C284(vt_nombreColegio)
C_TEXT:C284(vt_AgnoEscolar)
C_LONGINT:C283(vPrimeraColumnaOrden)
C_BOOLEAN:C305(vbMostrarProfe)
C_LONGINT:C283(vInicial)
C_LONGINT:C283(vTotalAsignaturas)

ARRAY TEXT:C222(aOrdenAS;0)
ARRAY TEXT:C222(aAbrev;0)
ARRAY TEXT:C222(aNivelNombre;0)
ARRAY TEXT:C222(aCurso;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY INTEGER:C220(aNumDeAlumnos;0)
ARRAY TEXT:C222(aPromedio;0)
ARRAY TEXT:C222(aPromOficial;0)
ARRAY REAL:C219(aAprobacion;0)
ARRAY LONGINT:C221(aRecNums;0)
ARRAY TEXT:C222(aNombreProfesor;0)
ARRAY TEXT:C222(aAprobacion2;0)

  //WSstw_GetFotoAlumno
C_LONGINT:C283(vl_IDAlumno)
C_BLOB:C604(vxFoto)
C_LONGINT:C283(vl_Resultado)

  //WSstw_GetNotasSubAsignatura
ASsev_InitArrays 

C_LONGINT:C283(vl_IDMadre)
C_LONGINT:C283(vl_Periodo)
C_LONGINT:C283(vlColumna)
C_LONGINT:C283(vl_OrdenSubNotas)

  //WSstw_RecibirObs_NEW
C_TEXT:C284(vt_Obs)

  //WSstw_RecibirObsCats
C_LONGINT:C283(vl_RecNum)
C_LONGINT:C283(vl_Periodo)
C_LONGINT:C283(vIDUsuario)
C_LONGINT:C283(vIDProfesor)
C_LONGINT:C283(vlIDAlumno)
C_TEXT:C284(vt_STW_ResultadoDatos)
ARRAY TEXT:C222(atSTR_ObsEval_CategoriaWS;0)
ARRAY TEXT:C222(atSTR_ObsEval_ObservacionWS;0)
ARRAY LONGINT:C221(alSTR_ObsEval_RefObsWS;0)

  //WSstw_GetStudentAverage_NEW
C_LONGINT:C283(vPeriodo)
C_LONGINT:C283(vRecNumAS)
C_LONGINT:C283(vOrden)
C_LONGINT:C283(vFila)
C_TEXT:C284(vNota)
C_LONGINT:C283(vColumna)
C_TEXT:C284(vReturn)

  //WSstw_GetSubAsignaturaAverage
C_TEXT:C284(vNotaControl)
C_TEXT:C284(vNota1)
C_TEXT:C284(vNota2)
C_TEXT:C284(vNota3)
C_TEXT:C284(vNota4)
C_TEXT:C284(vNota5)
C_TEXT:C284(vNota6)
C_TEXT:C284(vNota7)
C_TEXT:C284(vNota8)
C_TEXT:C284(vNota9)
C_TEXT:C284(vNota10)
C_TEXT:C284(vNota11)
C_TEXT:C284(vNota12)
C_LONGINT:C283(vColumna)
C_TEXT:C284(vReturnSub)
C_TEXT:C284(vReturnAS)

  //WSstw_GetObsAsignatura
C_LONGINT:C283(vl_RecNum)
C_LONGINT:C283(vl_Periodo)
ARRAY TEXT:C222(aArreglos;0)
ARRAY TEXT:C222(aHeaders;0)
ARRAY LONGINT:C221(aEnterable;0)
ARRAY TEXT:C222(aNtaStdNme;0)
ARRAY TEXT:C222(aNtaObs;0)
ARRAY LONGINT:C221(aNtaIDAlumno;0)
ARRAY TEXT:C222(aNtaStatus;0)
C_LONGINT:C283(vl_Orden)
C_LONGINT:C283(viSTR_UtilizarObservaciones)
ARRAY TEXT:C222(atSTR_Observacion;0)
ARRAY LONGINT:C221(alSTR_RefObservacion;0)
ARRAY TEXT:C222(atSTR_PeriodosObservaciones;0)
C_LONGINT:C283(vlSTR_PeriodoSeleccionado)
C_LONGINT:C283(hl_observaciones)

  //WSstw_GetNotasAsignatura
EV2_InitArrays 
C_REAL:C285(vr_MinEscalaNota)
C_TEXT:C284(vt_MinEscalaNotaSim)
C_LONGINT:C283(vl_OrdenNotas)
ARRAY LONGINT:C221(aIcono;0)
C_LONGINT:C283(vl_OrdenNotas)
ARRAY TEXT:C222(atSTR_Periodos_Nombre;0)
C_LONGINT:C283(vl_NotaOficialVisible)

  //WSstw_GetObsCategoriaAlumno
C_LONGINT:C283(vl_IDAlumno)
C_LONGINT:C283(vl_Periodo)
C_LONGINT:C283(vl_RecNumAsig)

ARRAY TEXT:C222(atSTR_ObsEval_Categoria;0)
ARRAY TEXT:C222(atSTR_ObsEval_Observacion;0)
ARRAY LONGINT:C221(alSTR_ObsEval_RefObs;0)



  //WSstw_RecibeOBSCompetencia
C_LONGINT:C283(recnumcomp)
C_TEXT:C284(obs)


  //WSstw_GetAprendizajesAlumno
C_LONGINT:C283(vlEVLG_currentTerm)
C_LONGINT:C283(vl_PeriodoSeleccionado)
C_LONGINT:C283(vlEVLG_mostrarObservacion)
ARRAY TEXT:C222(aEnterable2;0)
ARRAY TEXT:C222(aEnterable3;0)
ARRAY TEXT:C222(aStyles4;0)
ARRAY TEXT:C222(aNotas;0)
ARRAY TEXT:C222(aNotasColores;0)

ARRAY LONGINT:C221(aVisiblidadNotas;0)

ARRAY TEXT:C222(aEstilosEV;0)
ARRAY TEXT:C222(aSimbBinarios;0)
ARRAY TEXT:C222(aIndTipo1;0)
ARRAY TEXT:C222(aEscalasInd;0)
C_TEXT:C284(vtObservaciones)
C_TEXT:C284(vsName)
ARRAY TEXT:C222(atSTR_PeriodosAprendizajes;0)


  //WSstw_RecibeIndAprendizaje
C_REAL:C285(id_usuario)
C_TEXT:C284(name_usuario)
