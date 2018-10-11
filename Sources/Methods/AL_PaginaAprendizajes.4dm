//%attributes = {}
  // MÉTODO: AL_PaginaAprendizajes
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 09:05:25
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Activa la página Evaluación de aprendizajes del formulario [Alumnos].Input
  //
  // PARÁMETROS
  // AL_PaginaAprendizajes()
  // ----------------------------------------------------
C_LONGINT:C283($0)
If (False:C215)
	C_LONGINT:C283(AL_PaginaAprendizajes ;$0)
End if 
C_LONGINT:C283(vlEVLG_AsignaturaSeleccionada)
C_LONGINT:C283(vlSTR_PeriodoSeleccionado)

ARRAY LONGINT:C221(aIdAlumnos_a_Recalcular;0)

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
  //MONO TICKET 211799
ARRAY TEXT:C222(atMPA_uuidRegistro;0)
ARRAY DATE:C224(adEVLG_FechaLogro;0)


modNotas:=False:C215
vlEVLG_mostrarObservacion:=Num:C11(PREF_fGet (0;"Indicador/Observación";"0"))
vtObservaciones:=""

AL_CiclosEscolares (vl_NivelSeleccionado)

If ((vl_Year=<>gYear) & (vl_NivelSeleccionado=[Alumnos:2]nivel_numero:29))  //MONO 184433
	MPA_LeeEvaluacionesActuales 
Else 
	MPA_LeeHistoricosAlumno ([Alumnos:2]numero:1;0;vl_year;vl_NivelSeleccionado)
End if 
$0:=1

If ((vl_Year=<>gYear) & (vl_NivelSeleccionado=[Alumnos:2]nivel_numero:29) & (vl_PeriodoSeleccionado=PERIODOS_PeriodosActuales (Current date:C33(*);False:C215)))
	OBJECT SET VISIBLE:C603(*;"back2Now@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"back2Now@";True:C214)
End if 
vlEVLG_currentTerm:=vl_PeriodoSeleccionado
