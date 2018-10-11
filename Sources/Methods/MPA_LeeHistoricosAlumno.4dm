//%attributes = {}
  //MPA_LeeHistoricosAlumno


C_LONGINT:C283($1;$2;$3;$idAlumno;$idAsignatura;$year;vl_PeriodoSeleccionado)
$idAlumno:=$1
$idAsignatura:=$2
$year:=$3

If (vl_PeriodoSeleccionado=0)
	vl_PeriodoSeleccionado:=-1
End if 

GOTO OBJECT:C206(lb_Asignaturas)
ALP_RemoveAllArrays (xALP_Aprendizajes)
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
ARRAY TEXT:C222(atMPA_FechaLogro;0)
ARRAY TEXT:C222(atMPA_FechaEstimada;0)


If ($idAsignatura=0)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;-$idAlumno;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77;=;vl_year;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91;=;vl_NivelSeleccionado)
	AT_DistinctsFieldValues (->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;->aNtaIdAsignatura)
	ARRAY TEXT:C222(aNtaAsignatura;Size of array:C274(aNtaIdAsignatura))
	For ($i;Size of array:C274(aNtaIdAsignatura);1;-1)
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_AsignaturaOriginal:30;=;Abs:C99(aNtaIdAsignatura{$i});*)
		QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Año:5=vl_year)
		If (Records in selection:C76([Asignaturas_Historico:84])>0)
			aNtaAsignatura{$i}:=[Asignaturas_Historico:84]Nombre_interno:3
		End if 
	End for 
	
	If (Size of array:C274(aNtaIdAsignatura)>0)
		$el:=Find in array:C230(aNtaIdAsignatura;vlEVLG_AsignaturaSeleccionada)
		If ($el>0)
			aNtaIdAsignatura:=$el
		End if 
		If (aNtaIdAsignatura=0)
			aNtaIdAsignatura:=1
			vlEVLG_AsignaturaSeleccionada:=aNtaIdAsignatura{1}
		End if 
		LISTBOX DELETE COLUMN:C830(*;"lb_Asignaturas";1)
		LISTBOX INSERT COLUMN:C829(*;"lb_Asignaturas";1;"Asignaturas";aNtaAsignatura;"HeaderAsignaturas";vlb_Header)
		OBJECT SET ENTERABLE:C238(*;"lb_Asignaturas";False:C215)
		OBJECT SET FONT SIZE:C165(*;"lb_Asignaturas";9)
		OBJECT SET RGB COLORS:C628(*;"lb_Asignaturas";0x0000;0x00FFFFFF;(<>vl_AltBackground_Red << 16)+(<>vl_AltBackground_Green << 8)+<>vl_AltBackground_Blue)
		LISTBOX SELECT ROW:C912(*;"lb_Asignaturas";aNtaIdAsignatura)
		OBJECT SET SCROLL POSITION:C906(*;"lb_Asignaturas";aNtaIdAsignatura)
		aNtaAsignatura:=aNtaIdAsignatura
	End if 
End if 

If (Size of array:C274(aNtaIdAsignatura)>0)
	If ($idAsignatura=0)
		$idAsignatura:=aNtaIdAsignatura{aNtaIdAsignatura}
	End if 
	
	Case of 
		: (vl_PeriodoSeleccionado=1)
			$punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
			$punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
			$punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
			$punteroIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
			$punteroObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
			$punteroObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
			$punteroPeriodo:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
			
		: (vl_PeriodoSeleccionado=2)
			$punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
			$punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
			$punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
			$punteroIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
			$punteroObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
			$punteroObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
			$punteroPeriodo:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
			
		: (vl_PeriodoSeleccionado=3)
			$punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
			$punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
			$punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
			$punteroIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
			$punteroObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
			$punteroObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
			$punteroPeriodo:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
			
			
		: (vl_PeriodoSeleccionado=4)
			$punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
			$punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
			$punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
			$punteroIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
			$punteroObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
			$punteroObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
			$punteroPeriodo:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
			
			
		: (vl_PeriodoSeleccionado=5)
			$punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
			$punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
			$punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
			$punteroIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
			$punteroObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
			$punteroObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
			$punteroPeriodo:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
			
			
		: (vl_PeriodoSeleccionado=-1)
			$punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
			$punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
			$punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
			$punteroIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
			$punteroObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84
			
	End case 
	
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
	
	
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;-$idAlumno;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$idAsignatura;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=vl_year;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91;=;vl_NivelSeleccionado)
	  //cargo obs año sel ticket 158450  JVP
	QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6=-$idAlumno)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=vl_year)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5=$idAsignatura)
	vtObservaciones:=$punteroObsAsignatura->
	  //
	QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? vl_PeriodoSeleccionado) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	If (vlEVLG_mostrarObservacion=0)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;alEVLG_IdEje;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;alEVLG_IdDimension;*)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;alEVLG_IdCompetencia;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;alEVLG_TipoObjeto;$punteroLiteral->;atEVLG_Indicador;*)
		SELECTION TO ARRAY:C260($punteroReal->;arEVLG_Indicador;$punteroIndicador->;atEVLG_Observacion;[Alumnos_EvaluacionAprendizajes:203]Enunciado:9;atEVLG_Competencia;*)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88;atEVLG_Muestra;[Alumnos_EvaluacionAprendizajes:203]OrdenEje:85;$aOrdenEje;[Alumnos_EvaluacionAprendizajes:203]OrdenDimension:86;$aOrdenDimension;*)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]OrdenCompetencia:87;$aOrdenCompetencia;[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;adEVLG_FechaLogro;[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;atMPA_uuidRegistro;*)
		SELECTION TO ARRAY:C260
	Else 
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;alEVLG_IdEje;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;alEVLG_IdDimension;*)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;alEVLG_IdCompetencia;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;alEVLG_TipoObjeto;$punteroLiteral->;atEVLG_Indicador;*)
		SELECTION TO ARRAY:C260($punteroReal->;arEVLG_Indicador;$punteroObsCompetencia->;atEVLG_Observacion;[Alumnos_EvaluacionAprendizajes:203]Enunciado:9;atEVLG_Competencia;*)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88;atEVLG_Muestra;[Alumnos_EvaluacionAprendizajes:203]OrdenEje:85;$aOrdenEje;[Alumnos_EvaluacionAprendizajes:203]OrdenDimension:86;$aOrdenDimension;*)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]OrdenCompetencia:87;$aOrdenCompetencia;[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;adEVLG_FechaLogro;[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;atMPA_uuidRegistro;*)
		SELECTION TO ARRAY:C260
	End if 
	ARRAY LONGINT:C221(alEVLG_TipoEvaluación;Size of array:C274(atEVLG_Competencia))
	ARRAY LONGINT:C221(alEVLG_RefEstiloEvaluacion;Size of array:C274(atEVLG_Competencia))
	ARRAY TEXT:C222(atEVLG_Muestra;Size of array:C274(atEVLG_Competencia))
	ARRAY TEXT:C222(atMPA_FechaLogro;Size of array:C274(adEVLG_FechaLogro))
	
	For ($l_indice;1;Size of array:C274(adEVLG_FechaLogro))
		atEVLG_Muestra{$l_indice}:=""  //20180609 ASM Ticket 208971
		If (adEVLG_FechaLogro{$l_indice}#!00-00-00!)
			atMPA_FechaLogro{$l_indice}:=String:C10(adEVLG_FechaLogro{$l_indice};7)
		Else 
			atMPA_FechaLogro{$l_indice}:=""
		End if 
	End for 
	
	AT_MultiLevelSort (">>>";->$aOrdenEje;->$aOrdenDimension;->$aOrdenCompetencia;->atEVLG_Competencia;->atEVLG_Muestra;->alEVLG_RecNum;->alEVLG_TipoObjeto;->atEVLG_Indicador;->arEVLG_Indicador;->atEVLG_Observacion;->alEVLG_IdCompetencia;->alEVLG_IdDimension;->alEVLG_IdEje;->atMPA_uuidRegistro;->adEVLG_FechaLogro)
	xALP_Set_Aprendizajes_AS 
	  //20171205 ASM 
	  //AL_SetColOpts (xALP_Aprendizajes;1;1;1;9;0)
	  //AL_SetWidths (xALP_Aprendizajes;3;1;270)
	
	ARRAY LONGINT:C221($aEnterableCells;2;0)
	For ($i;1;Size of array:C274(alEVLG_RecNum))
		Case of 
			: (alEVLG_TipoObjeto{$i}=Eje_Aprendizaje)
				$cellEnterable:=0
				AL_SetRowStyle (xALP_Aprendizajes;$i;5)
				AL_SetRowRGBColor (xALP_Aprendizajes;$i;0;0;0;220;220;220)
				AL_SetCellEnter (xALP_Aprendizajes;2;$i;2;$i;$aEnterableCells;0)
				AL_SetCellEnter (xALP_Aprendizajes;3;$i;3;$i;$aEnterableCells;0)
				
				
			: (alEVLG_TipoObjeto{$i}=Dimension_Aprendizaje)
				AL_SetRowStyle (xALP_Aprendizajes;$i;3)
				AL_SetRowRGBColor (xALP_Aprendizajes;$i;0;0;0;255;255;215)
				AL_SetCellEnter (xALP_Aprendizajes;2;$i;2;$i;$aEnterableCells;0)
				AL_SetCellEnter (xALP_Aprendizajes;3;$i;3;$i;$aEnterableCells;0)
				
			: (alEVLG_TipoObjeto{$i}=Logro_Aprendizaje)
				AL_SetRowStyle (xALP_Aprendizajes;$i;0)
				AL_SetRowRGBColor (xALP_Aprendizajes;$i;0;0;0;255;255;255)
				
				AL_SetCellEnter (xALP_Aprendizajes;2;$i;2;$i;$aEnterableCells;0)
				AL_SetCellEnter (xALP_Aprendizajes;3;$i;3;$i;$aEnterableCells;0)
		End case 
	End for 
	AL_UpdateArrays (xALP_Aprendizajes;-2)
	OBJECT SET VISIBLE:C603(xALP_Aprendizajes;True:C214)
	OBJECT SET VISIBLE:C603(*;"lb_Asignaturas";True:C214)
	
Else 
	ARRAY TEXT:C222(aNtaAsignatura;0)
	LISTBOX DELETE COLUMN:C830(*;"lb_Asignaturas";1)
	LISTBOX INSERT COLUMN:C829(*;"lb_Asignaturas";1;"Asignaturas";aNtaAsignatura;"HeaderAsignaturas";vlb_Header)
	ALP_RemoveAllArrays (xALP_Aprendizajes)
	xALP_Set_Aprendizajes_AS 
	vtEVLG_AsignaturaSeleccionada:=""
	OBJECT SET VISIBLE:C603(xALP_Aprendizajes;True:C214)
	OBJECT SET VISIBLE:C603(*;"lb_Asignaturas";True:C214)
	
	
End if 
GOTO OBJECT:C206(lb_Asignaturas)
OBJECT SET ENTERABLE:C238(vtObservaciones;False:C215)
OBJECT SET VISIBLE:C603(*;"EvaluacionAprendizajes1";False:C215)
