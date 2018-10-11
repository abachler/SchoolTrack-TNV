//%attributes = {}
  // MÉTODO: EVLG_LeeAprendizajesAlumno
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 01/03/12, 18:11:41
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EVLG_LeeAprendizajesAlumno()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_calculosSobreCompetencias;$b_DimensionesIngresables;$b_EjesIngresables;$b_periodoAbierto;$b_usuarioAutorizado)
C_LONGINT:C283($l_referenciaArea;$l_celdaEditable;$l_IdAlumno;$l_IdEstiloOficial;$l_IdMatriz;$l_periodo;$l_recNum;$l_recNumEval)
C_POINTER:C301($y_campoIndicador;$y_campoLiteral;$y_campoNumerico;$y_campoObsAsignatura;$y_campoObsCompetencia;$y_campoPeriodo;$y_campoReal)
C_TEXT:C284($t_nombreCampoLiteral;$t_nombreCampoReal;$t_sexoAlumno)

ARRAY DATE:C224($ad_MPA_FechaLogro;0)
ARRAY INTEGER:C220($ai_OrdenCompetencia;0)
ARRAY INTEGER:C220($ai_OrdenDimension;0)
ARRAY INTEGER:C220($ai_OrdenEje;0)
ARRAY INTEGER:C220($ai_TipoEvalCompetencia;0)
ARRAY INTEGER:C220($ai_TipoEvalDimension;0)
ARRAY INTEGER:C220($ai_TipoEvalEje;0)
ARRAY LONGINT:C221($aEnterableCells;0)
ARRAY LONGINT:C221($al_IdCompetencia;0)
ARRAY LONGINT:C221($al_IdDimension;0)
ARRAY LONGINT:C221($al_IdEje;0)
ARRAY LONGINT:C221($al_IdEstiloCompetencia;0)
ARRAY LONGINT:C221($al_IdEstiloDimension;0)
ARRAY LONGINT:C221($al_IdEstiloEje;0)
ARRAY LONGINT:C221($al_RecNumObjetosMatriz;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($al_TipoObjeto;0)
ARRAY REAL:C219($ar_maximoEscalaEjes;0)
ARRAY REAL:C219($ar_maximoEscalaDimension;0)
ARRAY REAL:C219($ar_minimoEscalaDimension;0)
ARRAY REAL:C219($ar_minimoEscalaEjes;0)
ARRAY TEXT:C222($at_llaveRegistros;0)
ARRAY TEXT:C222($at_NombreCompetencia;0)
ARRAY TEXT:C222($at_NombreDimension;0)
ARRAY TEXT:C222($at_nombreEje;0)

ARRAY INTEGER:C220($al_arregloD2Celdas;2;0)

If (False:C215)
	C_LONGINT:C283(EVLG_LeeAprendizajesAlumno ;$1)
	C_LONGINT:C283(EVLG_LeeAprendizajesAlumno ;$2)
	C_LONGINT:C283(EVLG_LeeAprendizajesAlumno ;$3)
End if 





  // CODIGO PRINCIPAL
$l_referenciaArea:=$1
$l_IdAlumno:=$2
$l_IdMatriz:=$3
ALP_RemoveAllArrays ($l_referenciaArea)


$l_recNum:=Find in field:C653([MPA_AsignaturasMatrices:189]ID_Matriz:1;$l_IdMatriz)
KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNum)
$b_EjesIngresables:=([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Eje_Aprendizaje)
$b_DimensionesIngresables:=([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Dimension_Aprendizaje)

$l_recNum:=Find in field:C653([Alumnos:2]numero:1;$l_IdAlumno)
KRL_GotoRecord (->[Alumnos:2];$l_recNum)
$t_sexoAlumno:=[Alumnos:2]Sexo:49
vsName:=[Alumnos:2]apellidos_y_nombres:40

QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_IdMatriz)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Automatic:K51:4;Manual:K51:3)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Automatic:K51:4;Manual:K51:3)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Automatic:K51:4;Manual:K51:3)

  //elimino registros existentes en matrices sin relaciones con los objetos definidos  ` en el mapa
SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_RecNums;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;$al_TipoObjeto;[MPA_ObjetosMatriz:204]ID_Eje:3;$al_IdEje;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEje;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$ai_OrdenEje;[MPA_ObjetosMatriz:204]ID_Dimension:4;$al_IdDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_NombreDimension;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$ai_OrdenDimension;[MPA_ObjetosMatriz:204]ID_Competencia:5;$al_IdCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_NombreCompetencia;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;$ai_OrdenCompetencia)
For ($i;Size of array:C274($al_RecNums);1;-1)
	Case of 
		: (($al_TipoObjeto{$i}=Eje_Aprendizaje) & ($at_nombreEje{$i}=""))
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNums{$i})
			DELETE RECORD:C58([MPA_ObjetosMatriz:204])
			
		: (($al_TipoObjeto{$i}=Dimension_Aprendizaje) & ($at_NombreDimension{$i}=""))
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNums{$i})
			DELETE RECORD:C58([MPA_ObjetosMatriz:204])
			
		: (($al_TipoObjeto{$i}=Logro_Aprendizaje) & ($at_NombreCompetencia{$i}=""))
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNums{$i})
			DELETE RECORD:C58([MPA_ObjetosMatriz:204])
			
	End case 
End for 
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Structure configuration:K51:2;Structure configuration:K51:2)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Structure configuration:K51:2;Structure configuration:K51:2)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Structure configuration:K51:2;Structure configuration:K51:2)
  // ---


  // creo las llaves de acceso a los registros de evaluación de acuerdo a la configuración de la matriz
  // estas llaves (arreglo $at_llaveRegistros) son utilizadas más abajo para leer los registros de evaluación de aprendizaje del alumno
QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_IdMatriz)
LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_RecNumObjetosMatriz;"")
For ($i;1;Size of array:C274($al_RecNumObjetosMatriz))
	READ WRITE:C146([MPA_ObjetosMatriz:204])
	GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_RecNumObjetosMatriz{$i})
	
	Case of 
		: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
			$b_enunciadoDefinido:=(Find in field:C653([MPA_DefinicionEjes:185]ID:1;[MPA_ObjetosMatriz:204]ID_Eje:3)>=0)
		: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
			$b_enunciadoDefinido:=(Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;[MPA_ObjetosMatriz:204]ID_Dimension:4)>=0)
		: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
			$b_enunciadoDefinido:=(Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[MPA_ObjetosMatriz:204]ID_Competencia:5)>=0)
	End case 
	
	If ($b_enunciadoDefinido)  // si existe la definición en mapas para el objeto asignado a la matriz 
		Case of 
			: (([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje))
				$key:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
				APPEND TO ARRAY:C911($at_llaveRegistros;$key)
				$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$key)
				$createRecord:=($l_recNumEval<0)
			: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
				RELATE ONE:C42([MPA_ObjetosMatriz:204]ID_Competencia:5)
				Case of 
					: ([MPA_DefinicionCompetencias:187]RestriccionSexo:27=0)
						$key:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
						APPEND TO ARRAY:C911($at_llaveRegistros;$key)
						$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$key)
						$createRecord:=($l_recNumEval<0)
						
					: ((([MPA_DefinicionCompetencias:187]RestriccionSexo:27=1) & ($t_sexoAlumno="F")) | (([MPA_DefinicionCompetencias:187]RestriccionSexo:27=2) & ($t_sexoAlumno="M")))
						$key:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
						APPEND TO ARRAY:C911($at_llaveRegistros;$key)
						$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$key)
						$createRecord:=($l_recNumEval<0)
				End case 
		End case 
		
		If ($createRecord)
			  // si el registro de evaluación no existe pero existe en la matriz y está definido en las tablas de definición ([MPA_DefinicionEjes], [MPA_DefinicionDimensiones], [MPA_DefinicionCompetencias])...
			  // creo el registro de evaluación 
			
			CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
			[Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78:=<>gInstitucion
			[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
			[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=$l_IdAlumno
			[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=[Asignaturas:18]Numero:1
			[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=[MPA_ObjetosMatriz:204]ID_Competencia:5
			[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
			[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=[MPA_ObjetosMatriz:204]ID_Dimension:4
			[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=[MPA_ObjetosMatriz:204]Tipo_Objeto:2
			[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=[MPA_ObjetosMatriz:204]ID_Matriz:1
			[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
			SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
			MPA_RecuperaEvalCicloAnterior 
		Else 
			KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNumEval)
			If ([MPA_ObjetosMatriz:204]Periodos:7#[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10)
				KRL_LoadRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNumEval)
				[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
				SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
				UNLOAD RECORD:C212([Alumnos_EvaluacionAprendizajes:203])
			End if 
		End if 
	End if 
End for 
READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
  // ---

ARRAY TEXT:C222(atEVLG_Competencia;0)
ARRAY TEXT:C222(atEVLG_Indicador;0)
ARRAY TEXT:C222(atEVLG_Observacion;0)
ARRAY REAL:C219(arEVLG_Indicador;0)
ARRAY LONGINT:C221(alEVLG_TipoEvaluación;0)
ARRAY LONGINT:C221(alEVLG_RefEstiloEvaluacion;0)
ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
ARRAY LONGINT:C221(alEVLG_RecNum;0)
ARRAY TEXT:C222(atEVLG_Muestra;0)
ARRAY TEXT:C222(atMPA_FechaEstimada;0)
ARRAY TEXT:C222(atMPA_FechaLogro;0)
ARRAY DATE:C224(adEVLG_FechaLogro;0)
Case of 
	: (vl_periodoSeleccionado=1)
		$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
		$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
		$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
		$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
		$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
		$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
		
	: (vl_periodoSeleccionado=2)
		$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
		$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
		$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
		$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
		$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
		$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
		
	: (vl_periodoSeleccionado=3)
		$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
		$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
		$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
		$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
		$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
		$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
		
	: (vl_periodoSeleccionado=4)
		$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
		$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
		$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
		$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
		$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
		$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
		
	: (vl_periodoSeleccionado=5)
		$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
		$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
		$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
		$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
		$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
		$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
		
	: (vl_periodoSeleccionado=-1)
		$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
		$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
		$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
		$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
		$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84
		
End case 

QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_IdAlumno;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;[Asignaturas:18]Numero:1)
QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? vl_periodoSeleccionado) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)

  // retenemos solos registros de evaluación que están efectivamente definidos en la matriz y en las tablas de definición ([MPA_DefinicionEjes], [MPA_DefinicionDimensiones], [MPA_DefinicionCompetencias])
  // (las llaves de acceso a esos registros fueron construidas más arriba en el código)
QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]Key:8;->$at_llaveRegistros;True:C214)
ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
If (vlEVLG_mostrarObservacion=0)
	SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum;[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;atMPA_uuidRegistro;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;alEVLG_IdEje;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;alEVLG_IdDimension;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;alEVLG_IdCompetencia;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;alEVLG_TipoObjeto;$y_campoLiteral->;atEVLG_Indicador;$y_campoReal->;arEVLG_Indicador;$y_campoIndicador->;atEVLG_Observacion;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEje;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_NombreDimension;[MPA_DefinicionCompetencias:187]Competencia:6;$at_NombreCompetencia;[MPA_DefinicionEjes:185]TipoEvaluación:12;$ai_TipoEvalEje;[MPA_DefinicionEjes:185]EstiloEvaluación:13;$al_IdEstiloEje;[MPA_DefinicionDimensiones:188]TipoEvaluacion:15;$ai_TipoEvalDimension;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;$al_IdEstiloDimension;[MPA_DefinicionCompetencias:187]TipoEvaluacion:12;$ai_TipoEvalCompetencia;[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;$al_IdEstiloCompetencia;[MPA_DefinicionEjes:185]Escala_Minimo:17;$ar_minimoEscalaEjes;[MPA_DefinicionEjes:185]Escala_Maximo:18;$ar_maximoEscalaEjes;[MPA_DefinicionDimensiones:188]Escala_Minimo:12;$ar_minimoEscalaDimension;[MPA_DefinicionDimensiones:188]Escala_Maximo:13;$ar_maximoEscalaDimension;[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;adEVLG_FechaLogro)
Else 
	SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum;[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;atMPA_uuidRegistro;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;alEVLG_IdEje;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;alEVLG_IdDimension;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;alEVLG_IdCompetencia;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;alEVLG_TipoObjeto;$y_campoLiteral->;atEVLG_Indicador;$y_campoReal->;arEVLG_Indicador;$y_campoObsCompetencia->;atEVLG_Observacion;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEje;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_NombreDimension;[MPA_DefinicionCompetencias:187]Competencia:6;$at_NombreCompetencia;[MPA_DefinicionEjes:185]TipoEvaluación:12;$ai_TipoEvalEje;[MPA_DefinicionEjes:185]EstiloEvaluación:13;$al_IdEstiloEje;[MPA_DefinicionDimensiones:188]TipoEvaluacion:15;$ai_TipoEvalDimension;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;$al_IdEstiloDimension;[MPA_DefinicionCompetencias:187]TipoEvaluacion:12;$ai_TipoEvalCompetencia;[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;$al_IdEstiloCompetencia;[MPA_DefinicionEjes:185]Escala_Minimo:17;$ar_minimoEscalaEjes;[MPA_DefinicionEjes:185]Escala_Maximo:18;$ar_maximoEscalaEjes;[MPA_DefinicionDimensiones:188]Escala_Minimo:12;$ar_minimoEscalaDimension;[MPA_DefinicionDimensiones:188]Escala_Maximo:13;$ar_maximoEscalaDimension;[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;adEVLG_FechaLogro)
End if 

SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AT_RedimArrays (Size of array:C274(alEVLG_RecNum);->atEVLG_Competencia;->alEVLG_TipoEvaluación;->alEVLG_RefEstiloEvaluacion;->atEVLG_Muestra;->atMPA_FechaEstimada;->atMPA_FechaLogro)

ALP_RemoveAllArrays (xALP_Aprendizajes)
xALP_Set_Aprendizajes_AS 
If (Application version:C493>="14@")
	GET PICTURE FROM LIBRARY:C565(12047;$p_imagen)
	AL_SetIcon ($l_referenciaArea;12047;$p_imagen)
End if 
For ($i;1;Size of array:C274(alEVLG_RecNum))
	Case of 
		: (alEVLG_TipoObjeto{$i}=Eje_Aprendizaje)
			atEVLG_Competencia{$i}:=$at_nombreEje{$i}
			alEVLG_TipoEvaluación{$i}:=$ai_TipoEvalEje{$i}
			alEVLG_RefEstiloEvaluacion{$i}:=$al_IdEstiloEje{$i}
			$b_periodoAbierto:=(((adSTR_Periodos_Cierre{vlSTR_PeriodoSeleccionado}>Current date:C33(*)) | (adSTR_Periodos_Cierre{vlSTR_PeriodoSeleccionado}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0)) & ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado"))
			$b_usuarioAutorizado:=(((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])))
			$l_celdaEditable:=Num:C11($b_usuarioAutorizado & $b_periodoAbierto & $b_EjesIngresables)
			If (<>vb_BloquearModifSituacionFinal)
				$l_celdaEditable:=0
			End if 
			  //AL_SetRowStyle ($l_referenciaArea;$i;5)
			AL_SetRowRGBColor ($l_referenciaArea;$i;0;0;0;220;220;220)
			
			
			Case of 
				: ($b_EjesIngresables=False:C215)
					AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
					AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;0)
					AL_SetCellStyle ($l_referenciaArea;1;$i;1;$i;$aEnterableCells;1)
					AL_SetCellStyle ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;1)
					
					Case of 
						: (alEVLG_TipoEvaluación{$i}=1)
							$estilo:=alEVLG_RefEstiloEvaluacion{$i}
							EVS_ReadStyleData ($estilo)
							Case of 
								: (iEvaluationMode=Notas)
									atEVLG_Muestra{$i}:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
									atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Notas;iGradesDec)
								: (iEvaluationMode=Puntos)
									atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
									atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Puntos;iPointsDec)
								: (iEvaluationMode=Porcentaje)
									atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
									atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Porcentaje;1)
								: (iEvaluationMode=Simbolos)
									atEVLG_Muestra{$i}:=""
									atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Simbolos)
							End case 
						: (alEVLG_TipoEvaluación{$i}=2)
							atEVLG_Muestra{$i}:=""
						: (alEVLG_TipoEvaluación{$i}=3)
							atEVLG_Muestra{$i}:=String:C10($ar_minimoEscalaEjes{$i})+" - "+String:C10($ar_maximoEscalaEjes{$i})
					End case 
					
				: (alEVLG_TipoEvaluación{$i}=1)  //estilo de evaluación en el caso de ejes y dimensiones
					$estilo:=alEVLG_RefEstiloEvaluacion{$i}
					EVS_ReadStyleData ($estilo)
					Case of 
						: (iEvaluationMode=Notas)
							atEVLG_Muestra{$i}:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
						: (iEvaluationMode=Puntos)
							atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
						: (iEvaluationMode=Porcentaje)
							atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
						: (iEvaluationMode=Simbolos)
							If (Application version:C493>="14@")
								atEVLG_Muestra{$i}:=""
								AL_SetCellLongProperty ($l_referenciaArea;$i;5;ALP_Cell_RightIconID;12047)
							Else 
								atEVLG_Muestra{$i}:=Char:C90(160)+"^"+String:C10(Use PicRef:K28:4+12047)
							End if 
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
					End case 
					AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;$l_celdaEditable)  //***
					AL_SetCellStyle ($l_referenciaArea;4;$i;4;$i;$aEnterableCells;0)
					
				: (alEVLG_TipoEvaluación{$i}=2)  //binario para ejes y dimensiones
					If (Application version:C493>="14@")
						atEVLG_Muestra{$i}:=""
						AL_SetCellLongProperty ($l_referenciaArea;$i;5;ALP_Cell_RightIconID;12047)
					Else 
						atEVLG_Muestra{$i}:=Char:C90(160)+"^"+String:C10(Use PicRef:K28:4+12047)
					End if 
					AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
					AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;$l_celdaEditable)  //***
					AL_SetCellStyle ($l_referenciaArea;4;$i;4;$i;$aEnterableCells;0)
					
				: (alEVLG_TipoEvaluación{$i}=3)  //indicadores de aprendizaje
					atEVLG_Muestra{$i}:=String:C10($ar_minimoEscalaEjes{$i})+" - "+String:C10($ar_maximoEscalaEjes{$i})
					AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
					AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;$l_celdaEditable)  //***
					AL_SetCellStyle ($l_referenciaArea;4;$i;4;$i;$aEnterableCells;5)
					
			End case 
			$id:=alEVLG_IdEje{$i}
			$date:=!00-00-00!
			  //adEVLG_FechaLogro{$i}:=!00-00-0000!
			
		: (alEVLG_TipoObjeto{$i}=Dimension_Aprendizaje)
			  //atEVLG_Competencia{$i}:=Char(202)*2+$at_NombreDimension{$i}
			atEVLG_Competencia{$i}:=$at_NombreDimension{$i}
			alEVLG_TipoEvaluación{$i}:=$ai_TipoEvalDimension{$i}
			alEVLG_RefEstiloEvaluacion{$i}:=$al_IdEstiloDimension{$i}
			$b_periodoAbierto:=(((adSTR_Periodos_Cierre{vlSTR_PeriodoSeleccionado}>Current date:C33(*)) | (adSTR_Periodos_Cierre{vlSTR_PeriodoSeleccionado}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0)) & ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado"))
			$b_usuarioAutorizado:=(((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])))
			$l_celdaEditable:=Num:C11($b_usuarioAutorizado & $b_periodoAbierto & $b_DimensionesIngresables)
			If (<>vb_BloquearModifSituacionFinal)
				$l_celdaEditable:=0
			End if 
			AL_SetRowStyle ($l_referenciaArea;$i;3)
			AL_SetRowRGBColor ($l_referenciaArea;$i;0;0;0;255;255;215)
			Case of 
				: ($b_DimensionesIngresables=False:C215)
					AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
					AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;0)
					  //AL_SetCellStyle ($l_referenciaArea;4;$i;4;$i;$aEnterableCells;0)
					Case of 
						: (alEVLG_TipoEvaluación{$i}=1)
							$estilo:=alEVLG_RefEstiloEvaluacion{$i}
							EVS_ReadStyleData ($estilo)
							Case of 
								: (iEvaluationMode=Notas)
									atEVLG_Muestra{$i}:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
									atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Notas;iGradesDec)
								: (iEvaluationMode=Puntos)
									atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
									atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Puntos;iPointsDec)
								: (iEvaluationMode=Porcentaje)
									atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
									atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Porcentaje;1)
								: (iEvaluationMode=Simbolos)
									atEVLG_Muestra{$i}:=""
									atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Simbolos)
							End case 
						: (alEVLG_TipoEvaluación{$i}=2)
							atEVLG_Muestra{$i}:=""
						: (alEVLG_TipoEvaluación{$i}=3)
							atEVLG_Muestra{$i}:=String:C10($ar_minimoEscalaDimension{$i})+" - "+String:C10($ar_maximoEscalaDimension{$i})
					End case 
				: (alEVLG_TipoEvaluación{$i}=1)  //estilo de evaluación en el caso de ejes y dimensiones
					$estilo:=alEVLG_RefEstiloEvaluacion{$i}
					EVS_ReadStyleData ($estilo)
					Case of 
						: (iEvaluationMode=Notas)
							atEVLG_Muestra{$i}:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
							AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;$l_celdaEditable)
						: (iEvaluationMode=Puntos)
							atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
							AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;$l_celdaEditable)
						: (iEvaluationMode=Porcentaje)
							atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
							AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;$l_celdaEditable)
						: (iEvaluationMode=Simbolos)
							If (Application version:C493>="14@")
								atEVLG_Muestra{$i}:=""
								AL_SetCellLongProperty ($l_referenciaArea;$i;5;ALP_Cell_RightIconID;12047)
							Else 
								atEVLG_Muestra{$i}:=Char:C90(160)+"^"+String:C10(Use PicRef:K28:4+12047)
							End if 
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
							If (vlEVLG_mostrarObservacion=0)
								AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;0)
							Else 
								AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;$l_celdaEditable)
							End if 
					End case 
					AL_SetCellStyle ($l_referenciaArea;4;$i;4;$i;$aEnterableCells;3)
					
				: (alEVLG_TipoEvaluación{$i}=2)  //binario para ejes y dimensiones
					If (Application version:C493>="14@")
						atEVLG_Muestra{$i}:=""
						AL_SetCellLongProperty ($l_referenciaArea;$i;5;ALP_Cell_RightIconID;12047)
					Else 
						atEVLG_Muestra{$i}:=Char:C90(160)+"^"+String:C10(Use PicRef:K28:4+12047)
					End if 
					AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
					AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;$l_celdaEditable)  //***
					AL_SetCellStyle ($l_referenciaArea;4;$i;4;$i;$aEnterableCells;0)
					
				: (alEVLG_TipoEvaluación{$i}=3)
					atEVLG_Muestra{$i}:=String:C10($ar_minimoEscalaDimension{$i})+" - "+String:C10($ar_maximoEscalaDimension{$i})
					AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
					AL_SetCellEnter ($l_referenciaArea;3;$i;3;$i;$aEnterableCells;$l_celdaEditable)  //***
					AL_SetCellStyle ($l_referenciaArea;4;$i;4;$i;$aEnterableCells;3)
			End case 
			$id:=alEVLG_IdDimension{$i}
			$date:=!00-00-00!
			  //adEVLG_FechaLogro{$i}:=!00-00-0000!
			
		: (alEVLG_TipoObjeto{$i}=Logro_Aprendizaje)
			  //atEVLG_Competencia{$i}:=Char(202)*4+$at_NombreCompetencia{$i}
			atEVLG_Competencia{$i}:=$at_NombreCompetencia{$i}
			alEVLG_TipoEvaluación{$i}:=$ai_TipoEvalCompetencia{$i}
			alEVLG_RefEstiloEvaluacion{$i}:=$al_IdEstiloCompetencia{$i}
			$b_periodoAbierto:=(((adSTR_Periodos_Cierre{vlSTR_PeriodoSeleccionado}>Current date:C33(*)) | (adSTR_Periodos_Cierre{vlSTR_PeriodoSeleccionado}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0)) & ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado"))
			$b_usuarioAutorizado:=(((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
			$l_celdaEditable:=Num:C11($b_usuarioAutorizado & $b_periodoAbierto)
			If (<>vb_BloquearModifSituacionFinal)
				$l_celdaEditable:=0
			End if 
			Case of 
				: (alEVLG_TipoEvaluación{$i}=3)
					$estilo:=alEVLG_RefEstiloEvaluacion{$i}
					EVS_ReadStyleData ($estilo)
					
					Case of 
						: (iEvaluationMode=Notas)
							atEVLG_Muestra{$i}:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
							atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Notas;iGradesDec)
						: (iEvaluationMode=Puntos)
							atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
							atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Puntos;iPointsDec)
						: (iEvaluationMode=Porcentaje)
							atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
							atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Porcentaje;1)
						: (iEvaluationMode=Simbolos)
							atEVLG_Muestra{$i}:=""
							atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Simbolos)
					End case 
					Case of 
						: (iEvaluationMode=Notas)
							atEVLG_Muestra{$i}:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
							atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Notas;iGradesDec)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
						: (iEvaluationMode=Puntos)
							atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
							atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Puntos;iPointsDec)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
						: (iEvaluationMode=Porcentaje)
							atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
							atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Porcentaje;1)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
						: (iEvaluationMode=Simbolos)
							If (Application version:C493>="14@")
								atEVLG_Muestra{$i}:=""
								AL_SetCellLongProperty ($l_referenciaArea;$i;5;ALP_Cell_RightIconID;12047)
							Else 
								atEVLG_Muestra{$i}:=Char:C90(160)+"^"+String:C10(Use PicRef:K28:4+12047)
							End if 
							atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Simbolos)
							AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
					End case 
				: ((alEVLG_TipoEvaluación{$i}=1) | (alEVLG_TipoEvaluación{$i}=2))
					atEVLG_Muestra{$i}:=""
					AL_SetCellLongProperty ($l_referenciaArea;$i;5;ALP_Cell_RightIconID;12047)
					AL_SetCellEnter ($l_referenciaArea;2;$i;2;$i;$aEnterableCells;$l_celdaEditable)
			End case 
			AL_SetRowStyle ($l_referenciaArea;$i;0)
			AL_SetRowRGBColor ($l_referenciaArea;$i;0;0;0;255;255;255)
			$id:=alEVLG_IdCompetencia{$i}
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_IdMatriz;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Competencia:5=$id)
			$date:=[MPA_ObjetosMatriz:204]FechaEstimadaLogro:26
	End case 
	  //$date:=$aFechaEst{$i}
	If ($date#!00-00-00!)
		atMPA_FechaEstimada{$i}:=String:C10($date;7)
	Else 
		atMPA_FechaEstimada{$i}:=""
	End if 
	If (adEVLG_FechaLogro{$i}#!00-00-00!)
		atMPA_FechaLogro{$i}:=String:C10(adEVLG_FechaLogro{$i};7)
	Else 
		atMPA_FechaLogro{$i}:=""
	End if 
End for 

If (vlEVLG_mostrarObservacion=0)
	AL_SetEnterable ($l_referenciaArea;3;0)
Else 
	AL_SetEnterable ($l_referenciaArea;3;1)
End if 
AL_UpdateArrays ($l_referenciaArea;-2)

$l_recNum:=Find in field:C653([Alumnos:2]numero:1;$l_IdAlumno)
EVLG_DatosAlumno ($l_recNum)

$l_periodo:=vl_periodoSeleccionado
Case of 
	: ($l_periodo=1)
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
	: ($l_periodo=2)
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
	: ($l_periodo=3)
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
	: ($l_periodo=4)
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
	: ($l_periodo=5)
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
	: ($l_periodo=-1)
		$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
End case 
EV2_CargaRegistro ([Asignaturas:18]Numero:1;$l_IdAlumno)
vtObservaciones:=$y_campoObsAsignatura->
EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
If ($l_periodo>0)
	EV2_ObtieneDatosPeriodoActual ($l_periodo)
	For ($i;1;12)
		$t_nombreCampoLiteral:="[Alumnos_Calificaciones]PeriodoActual_Eval"+String:C10($i;"00")+"_Literal"
		$t_nombreCampoReal:="[Alumnos_Calificaciones]PeriodoActual_Eval"+String:C10($i;"00")+"_Real"
		$y_campoReal:=KRL_GetFieldPointerByName ($t_nombreCampoReal)
		$y_campoLiteral:=KRL_GetFieldPointerByName ($t_nombreCampoLiteral)
		Case of 
			: ($y_campoReal->=-1)
				OBJECT SET COLOR:C271($y_campoLiteral->;-239)
			: ($y_campoReal->=-2)
				OBJECT SET COLOR:C271($y_campoLiteral->;-9)
			: ($y_campoReal->=-4)
				OBJECT SET COLOR:C271($y_campoLiteral->;-16)
			: ($y_campoReal-><rPctMinimum)
				OBJECT SET COLOR:C271($y_campoLiteral->;-3)
			Else 
				OBJECT SET COLOR:C271($y_campoLiteral->;-6)
		End case 
	End for 
	OBJECT SET VISIBLE:C603(*;"vsNta@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"vsNta@";False:C215)
End if 
For ($i;1;5)
	$t_nombreCampoLiteral:="[Alumnos_Calificaciones]P"+String:C10($i;"00")+"_Final_Literal"
	$t_nombreCampoReal:="[Alumnos_Calificaciones]P"+String:C10($i;"00")+"_Final_Real"
	$y_campoReal:=KRL_GetFieldPointerByName ($t_nombreCampoReal)
	$y_campoLiteral:=KRL_GetFieldPointerByName ($t_nombreCampoLiteral)
	Case of 
		: ($y_campoReal->=-1)
			OBJECT SET COLOR:C271($y_campoLiteral->;-239)
		: ($y_campoReal->=-2)
			OBJECT SET COLOR:C271($y_campoLiteral->;-9)
		: ($y_campoReal->=-4)
			OBJECT SET COLOR:C271($y_campoLiteral->;-16)
		: ($y_campoReal-><rPctMinimum)
			OBJECT SET COLOR:C271($y_campoLiteral->;-3)
		Else 
			OBJECT SET COLOR:C271($y_campoLiteral->;-6)
	End case 
End for 

Case of 
	: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-1)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-239)
	: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-2)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-9)
	: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-4)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-16)
	: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<rPctMinimum)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-3)
	Else 
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;-6)
End case 

Case of 
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-1)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-239)
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-2)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-9)
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-4)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-16)
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-3)
	Else 
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-6)
End case 

$l_IdEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_de_alumnos:49;->[xxSTR_Niveles:6]EvStyle_oficial:23)
Case of 
	: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-1)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-239)
	: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-2)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-9)
	: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-4)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-16)
	: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<rPctMinimum)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-3)
	Else 
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-6)
End case 

Case of 
	: (Size of array:C274(atSTR_Periodos_Nombre)=1)
		OBJECT SET VISIBLE:C603(*;"vsT1";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT2";False:C215)
		OBJECT SET VISIBLE:C603(*;"vsT3";False:C215)
		OBJECT SET VISIBLE:C603(*;"vsT4";False:C215)
		OBJECT SET VISIBLE:C603(*;"vsT5";False:C215)
	: (Size of array:C274(atSTR_Periodos_Nombre)=2)
		OBJECT SET VISIBLE:C603(*;"vsT1";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT2";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT3";False:C215)
		OBJECT SET VISIBLE:C603(*;"vsT4";False:C215)
		OBJECT SET VISIBLE:C603(*;"vsT5";False:C215)
	: (Size of array:C274(atSTR_Periodos_Nombre)=3)
		OBJECT SET VISIBLE:C603(*;"vsT1";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT2";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT3";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT4";False:C215)
		OBJECT SET VISIBLE:C603(*;"vsT5";False:C215)
	: (Size of array:C274(atSTR_Periodos_Nombre)=4)
		OBJECT SET VISIBLE:C603(*;"vsT1";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT2";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT3";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT4";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT5";False:C215)
	: (Size of array:C274(atSTR_Periodos_Nombre)=5)
		OBJECT SET VISIBLE:C603(*;"vsT1";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT2";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT3";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT4";True:C214)
		OBJECT SET VISIBLE:C603(*;"vsT5";True:C214)
End case 

If ([Alumnos_Calificaciones:208]ExamenAnual_Literal:20="")
	OBJECT SET VISIBLE:C603(*;"vsTEX";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"vsTEX";True:C214)
End if 

$b_calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
If ($b_calculosSobreCompetencias)
	OBJECT SET VISIBLE:C603(*;"vsNta@";False:C215)
	OBJECT SET VISIBLE:C603(*;"EvaluacionAprendizajes@";True:C214)
Else 
	If ($l_periodo>0)
		OBJECT SET VISIBLE:C603(*;"vsNta@";True:C214)
	End if 
	OBJECT SET VISIBLE:C603(*;"EvaluacionAprendizajes@";False:C215)
End if 

MPA_AparienciaEvaluaciones ($l_referenciaArea)

AL_UpdateArrays ($l_referenciaArea;-1)
