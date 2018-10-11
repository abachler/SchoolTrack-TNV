//%attributes = {}
  // STWA2_AJAX_SendMapas()
  //
  //
  // modificado y normalizado por: Alberto Bachler Klein: 27-11-15, 20:02:19
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_BOOLEAN:C305($b_calculosSobreCompetencias;$b_creaRegistro;$b_DimensionesIngresables;$b_EjesIngresables;$b_enunciadoDefinido;$b_periodoAbierto;$b_usuarioAutorizado)
C_DATE:C307($d_fecha)
C_LONGINT:C283($i;$l_celdaEditable;$l_IdAlumno;$l_idEnunciado;$l_idEstilo;$l_idEstiloEvaluacion;$l_IdMatriz;$l_noModifcarNotas;$l_periodo;$l_periodoActual)
C_LONGINT:C283($l_profID;$l_recNum;$l_recnumDefinicion;$l_recNumEnunciado;$l_recNumEval;$l_recNumObservacion;$l_requerido;$l_tipoEvaluacion;$l_tipoObjeto;$l_userID)
C_PICTURE:C286($p_foto)
C_POINTER:C301($y_campoIndicador;$y_campoLiteral;$y_campoNumerico;$y_campoObsAsignatura;$y_campoObsCompetencia;$y_campoPeriodo;$y_campoReal)
C_REAL:C285($r_MinEscala;$r_Minimo;$r_minimoEscala)
C_TEXT:C284($t_llave;$t_MinEscalaNotaSim;$t_minimoEscalaSimbolo;$t_minimoSimbolo;$t_MinSimbolo;$t_nombreMatriz;$t_Observacion;$t_sexoAlumno)
C_OBJECT:C1216($ob_json;$ob_nodo_alumnos;$ob_nodo_confarmado;$ob_nodo_Enunciado;$ob_nodo_estiloAsignatura;$ob_nodo_estilos;$ob_nodo_modoEvaluacion;$ob_nodo_modoImpresion;$ob_nodo_paramtipo;$ob_nodo_periodos)
C_OBJECT:C1216($ob_nodoEstiloEvaluacion;$ob_Parametros)

ARRAY DATE:C224($ad_MPA_FechaLogro;0)
ARRAY INTEGER:C220($ai_EVLG_indicadores_Valor;0)
ARRAY INTEGER:C220($ai_OrdenCompetencia;0)
ARRAY INTEGER:C220($ai_OrdenDimension;0)
ARRAY INTEGER:C220($ai_OrdenEje;0)
ARRAY INTEGER:C220($ai_TipoEvalCompetencia;0)
ARRAY INTEGER:C220($ai_TipoEvalDimension;0)
ARRAY INTEGER:C220($ai_TipoEvalEje;0)
ARRAY LONGINT:C221($al_Enterable;0)
ARRAY LONGINT:C221($al_Enterable3;0)
ARRAY LONGINT:C221($al_FilaEstilos;0)
ARRAY LONGINT:C221($al_IdCompetencia;0)
ARRAY LONGINT:C221($al_IdDimension;0)
ARRAY LONGINT:C221($al_IdEje;0)
ARRAY LONGINT:C221($al_IdEstiloCompetencia;0)
ARRAY LONGINT:C221($al_IdEstiloDimension;0)
ARRAY LONGINT:C221($al_IdEstiloEje;0)
ARRAY LONGINT:C221($al_IdEstilosEvaluacion;0)
ARRAY LONGINT:C221($al_RecNumObjetosMatriz;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($al_TipoObjeto;0)
ARRAY REAL:C219($ar_maximoEscalaDimension;0)
ARRAY REAL:C219($ar_maximoEscalaEjes;0)
ARRAY REAL:C219($ar_minimoEscalaDimension;0)
ARRAY REAL:C219($ar_minimoEscalaEjes;0)
ARRAY TEXT:C222($at_descripcionSimbolos;0)
ARRAY TEXT:C222($at_EVLG_Indicadores_Concepto;0)
ARRAY TEXT:C222($at_EVLG_Indicadores_Descripcion;0)
ARRAY TEXT:C222($at_llaveRegistros;0)
ARRAY TEXT:C222($at_nombreAlumnos;0)
ARRAY TEXT:C222($at_NombreCompetencia;0)
ARRAY TEXT:C222($at_NombreDimension;0)
ARRAY TEXT:C222($at_nombreEje;0)
ARRAY TEXT:C222($at_simbolos;0)
ARRAY TEXT:C222(at_colorCeldas;0)

If (False:C215)
	C_LONGINT:C283(STWA2_AJAX_SendMapas ;$1)
	C_LONGINT:C283(STWA2_AJAX_SendMapas ;$2)
	C_LONGINT:C283(STWA2_AJAX_SendMapas ;$3)
	C_LONGINT:C283(STWA2_AJAX_SendMapas ;$4)
	C_LONGINT:C283(STWA2_AJAX_SendMapas ;$5)
End if 

$l_IdAlumno:=$1
$l_IdMatriz:=$2
$l_periodo:=$3

$l_userID:=$4
$l_profID:=$5


$ob_json:=OB_Create   // creacion del nodo raiz para respuesta

PERIODOS_Init 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
If (($l_periodo=0) | ($l_periodo>aiSTR_Periodos_Numero{Size of array:C274(aiSTR_Periodos_Numero)}))
	$l_periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
End if 


If ($l_IdMatriz=0)  // no hay matriz
	OB_SET_Text ($ob_json;"-60002";"NOMATRIX")
	$ob_Parametros:=OB_Create 
	OB_SET ($ob_Parametros;->$l_periodo;"periodo")
	OB_SET ($ob_Parametros;->$l_periodoActual;"periodoactual")
	OB_SET ($ob_json;->$ob_Parametros;"parametros")
	
	
Else 
	  //Aca hay que verificar la matriz, permisos, recrecacion desde matriz por defecto, etc.
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIdAlumno;[Alumnos:2]Nombre_Común:30;aNtaStdNme;[Alumnos:2]apellidos_y_nombres:40;$at_nombreAlumnos)
	SORT ARRAY:C229($at_nombreAlumnos;aNtaStdNme;aNtaIdAlumno;>)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	$l_recNum:=Find in field:C653([MPA_AsignaturasMatrices:189]ID_Matriz:1;$l_IdMatriz)
	KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNum)
	$t_nombreMatriz:=[MPA_AsignaturasMatrices:189]NombreMatriz:2
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
					$t_llave:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
					APPEND TO ARRAY:C911($at_llaveRegistros;$t_llave)
					$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llave)
					$b_creaRegistro:=($l_recNumEval<0)
				: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
					If (([MPA_DefinicionCompetencias:187]RestriccionSexo:27=0) | (([MPA_DefinicionCompetencias:187]RestriccionSexo:27=1) & ($t_sexoAlumno="F")) | (([MPA_DefinicionCompetencias:187]RestriccionSexo:27=2) & ($t_sexoAlumno="M")))
						$t_llave:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
						APPEND TO ARRAY:C911($at_llaveRegistros;$t_llave)
						$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llave)
						$b_creaRegistro:=($l_recNumEval<0)
					Else 
						$t_llave:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
						APPEND TO ARRAY:C911($at_llaveRegistros;$t_llave)
						$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llave)
						$b_creaRegistro:=($l_recNumEval<0)
					End if 
			End case 
			
			
			If ($b_creaRegistro)
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
	ARRAY TEXT:C222(atEVLG_DescIndicador;0)
	ARRAY REAL:C219(arEVLG_Indicador;0)
	ARRAY LONGINT:C221(alEVLG_TipoEvaluación;0)
	ARRAY LONGINT:C221(alEVLG_RefEstiloEvaluacion;0)
	ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
	ARRAY LONGINT:C221(alEVLG_RecNum;0)
	ARRAY TEXT:C222(atEVLG_Muestra;0)
	ARRAY TEXT:C222(atMPA_FechaEstimada;0)
	ARRAY TEXT:C222(atMPA_FechaLogro;0)
	Case of 
		: ($l_periodo=1)
			$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
			$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
			$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
			$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
			$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
			$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
			$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
			
		: ($l_periodo=2)
			$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
			$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
			$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
			$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
			$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
			$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
			$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
			
		: ($l_periodo=3)
			$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
			$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
			$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
			$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
			$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
			$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
			$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
			
		: ($l_periodo=4)
			$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
			$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
			$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
			$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
			$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82
			$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
			$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
			
		: ($l_periodo=5)
			$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
			$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
			$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
			$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
			$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
			$y_campoObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
			$y_campoPeriodo:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
			
		: ($l_periodo=-1)
			$y_campoLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
			$y_campoReal:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
			$y_campoNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
			$y_campoIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
			$y_campoObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84
			
	End case 
	
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_IdAlumno;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;[Asignaturas:18]Numero:1)
	QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $l_periodo) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	
	  // retenemos solos registros de evaluación que están efectivamente definidos en la matriz y en las tablas de definición ([MPA_DefinicionEjes], [MPA_DefinicionDimensiones], [MPA_DefinicionCompetencias])
	  // (las llaves de acceso a esos registros fueron construidas más arriba en el código)
	QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]Key:8;->$at_llaveRegistros;True:C214)
	ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
	SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;alEVLG_IdEje;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;alEVLG_IdDimension;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;\
		alEVLG_IdCompetencia;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;alEVLG_TipoObjeto;$y_campoLiteral->;atEVLG_Indicador;$y_campoReal->;arEVLG_Indicador;$y_campoIndicador->;atEVLG_DescIndicador;$y_campoObsCompetencia->;atEVLG_Observacion;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEje;\
		[MPA_DefinicionDimensiones:188]Dimensión:4;$at_NombreDimension;[MPA_DefinicionCompetencias:187]Competencia:6;$at_NombreCompetencia;[MPA_DefinicionEjes:185]TipoEvaluación:12;$ai_TipoEvalEje;[MPA_DefinicionEjes:185]EstiloEvaluación:13;$al_IdEstiloEje;\
		[MPA_DefinicionDimensiones:188]TipoEvaluacion:15;$ai_TipoEvalDimension;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;$al_IdEstiloDimension;[MPA_DefinicionCompetencias:187]TipoEvaluacion:12;$ai_TipoEvalCompetencia;\
		[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;$al_IdEstiloCompetencia;[MPA_DefinicionEjes:185]Escala_Minimo:17;$ar_minimoEscalaEjes;[MPA_DefinicionEjes:185]Escala_Maximo:18;$ar_maximoEscalaEjes;[MPA_DefinicionDimensiones:188]Escala_Minimo:12;\
		$ar_minimoEscalaDimension;[MPA_DefinicionDimensiones:188]Escala_Maximo:13;$ar_maximoEscalaDimension;[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;$ad_MPA_FechaLogro;[MPA_DefinicionEjes:185]color_rgb:26;$al_colorEjes;[MPA_DefinicionDimensiones:188]color_rgb:26;$al_colorDimension;[MPA_DefinicionCompetencias:187]color_rgb:33;$al_colorCompetencia)
	
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	
	AT_RedimArrays (Size of array:C274(alEVLG_RecNum);->atEVLG_Competencia;->alEVLG_TipoEvaluación;->alEVLG_RefEstiloEvaluacion;->atEVLG_Muestra;->atMPA_FechaEstimada;->atMPA_FechaLogro)
	For ($i;1;Size of array:C274(alEVLG_RecNum))
		Case of 
			: (alEVLG_TipoObjeto{$i}=Eje_Aprendizaje)
				atEVLG_Competencia{$i}:=$at_nombreEje{$i}
				alEVLG_TipoEvaluación{$i}:=$ai_TipoEvalEje{$i}
				alEVLG_RefEstiloEvaluacion{$i}:=$al_IdEstiloEje{$i}
				APPEND TO ARRAY:C911(at_colorCeldas;String:C10($al_colorEjes{$i}))  //ASM color agregado.
				
				If ($l_periodo=-1)
					$b_periodoAbierto:=(((adSTR_Periodos_Cierre{Size of array:C274(adSTR_Periodos_Cierre)}>Current date:C33(*)) | (adSTR_Periodos_Cierre{Size of array:C274(adSTR_Periodos_Cierre)}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001;$l_userID))) & ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado"))
				Else 
					$b_periodoAbierto:=(((adSTR_Periodos_Cierre{$l_periodo}>Current date:C33(*)) | (adSTR_Periodos_Cierre{$l_periodo}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001;$l_userID))) & ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado"))
				End if 
				$b_usuarioAutorizado:=(((<>viSTR_FirmantesAutorizados=1) & ($l_profID=[Asignaturas:18]profesor_firmante_numero:33)) | ($l_profID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208];$l_userID)))
				$l_celdaEditable:=Num:C11($b_usuarioAutorizado & $b_periodoAbierto & $b_EjesIngresables)
				If (<>vb_BloquearModifSituacionFinal)
					$l_celdaEditable:=0
				End if 
				APPEND TO ARRAY:C911($al_FilaEstilos;5)
				Case of 
					: ($b_EjesIngresables=False:C215)
						APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
						APPEND TO ARRAY:C911($al_Enterable3;0)
						Case of 
							: (alEVLG_TipoEvaluación{$i}=1)
								$l_idEstilo:=alEVLG_RefEstiloEvaluacion{$i}
								EVS_ReadStyleData ($l_idEstilo)
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
						$l_idEstilo:=alEVLG_RefEstiloEvaluacion{$i}
						EVS_ReadStyleData ($l_idEstilo)
						Case of 
							: (iEvaluationMode=Notas)
								atEVLG_Muestra{$i}:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
							: (iEvaluationMode=Puntos)
								atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
							: (iEvaluationMode=Porcentaje)
								atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
							: (iEvaluationMode=Simbolos)
								atEVLG_Muestra{$i}:="icono"
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
						End case 
						APPEND TO ARRAY:C911($al_Enterable3;0)
					: (alEVLG_TipoEvaluación{$i}=2)  //binario para ejes y dimensiones
						atEVLG_Muestra{$i}:="icono"
						APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
						APPEND TO ARRAY:C911($al_Enterable3;0)
					: (alEVLG_TipoEvaluación{$i}=3)  //indicadores de aprendizaje
						atEVLG_Muestra{$i}:=String:C10($ar_minimoEscalaEjes{$i})+" - "+String:C10($ar_maximoEscalaEjes{$i})
						APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
						APPEND TO ARRAY:C911($al_Enterable3;0)
				End case 
				$l_idEnunciado:=alEVLG_IdEje{$i}
				$d_fecha:=!00-00-00!
				$ad_MPA_FechaLogro{$i}:=!00-00-00!
				
			: (alEVLG_TipoObjeto{$i}=Dimension_Aprendizaje)
				atEVLG_Competencia{$i}:=$at_NombreDimension{$i}
				alEVLG_TipoEvaluación{$i}:=$ai_TipoEvalDimension{$i}
				alEVLG_RefEstiloEvaluacion{$i}:=$al_IdEstiloDimension{$i}
				APPEND TO ARRAY:C911(at_colorCeldas;String:C10($al_colorDimension{$i}))  //ASM color agregado.
				
				If ($l_periodo=-1)
					$b_periodoAbierto:=(((adSTR_Periodos_Cierre{Size of array:C274(adSTR_Periodos_Cierre)}>Current date:C33(*)) | (adSTR_Periodos_Cierre{Size of array:C274(adSTR_Periodos_Cierre)}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001;$l_userID))) & ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado"))
				Else 
					$b_periodoAbierto:=(((adSTR_Periodos_Cierre{$l_periodo}>Current date:C33(*)) | (adSTR_Periodos_Cierre{$l_periodo}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001;$l_userID))) & ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado"))
				End if 
				$b_usuarioAutorizado:=(((<>viSTR_FirmantesAutorizados=1) & ($l_profID=[Asignaturas:18]profesor_firmante_numero:33)) | ($l_profID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208];$l_userID)))
				$l_celdaEditable:=Num:C11($b_usuarioAutorizado & $b_periodoAbierto & $b_DimensionesIngresables)
				If (<>vb_BloquearModifSituacionFinal)
					$l_celdaEditable:=0
				End if 
				APPEND TO ARRAY:C911($al_FilaEstilos;3)
				Case of 
					: ($b_DimensionesIngresables=False:C215)
						APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
						APPEND TO ARRAY:C911($al_Enterable3;0)
						Case of 
							: (alEVLG_TipoEvaluación{$i}=1)
								$l_idEstilo:=alEVLG_RefEstiloEvaluacion{$i}
								EVS_ReadStyleData ($l_idEstilo)
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
						$l_idEstilo:=alEVLG_RefEstiloEvaluacion{$i}
						EVS_ReadStyleData ($l_idEstilo)
						Case of 
							: (iEvaluationMode=Notas)
								atEVLG_Muestra{$i}:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
								APPEND TO ARRAY:C911($al_Enterable3;0)
							: (iEvaluationMode=Puntos)
								atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
								APPEND TO ARRAY:C911($al_Enterable3;0)
							: (iEvaluationMode=Porcentaje)
								atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
								APPEND TO ARRAY:C911($al_Enterable3;0)
							: (iEvaluationMode=Simbolos)
								atEVLG_Muestra{$i}:="icono"
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
								APPEND TO ARRAY:C911($al_Enterable3;0)
						End case 
					: (alEVLG_TipoEvaluación{$i}=2)  //binario para ejes y dimensiones
						atEVLG_Muestra{$i}:="icono"
						APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
						APPEND TO ARRAY:C911($al_Enterable3;0)
					: (alEVLG_TipoEvaluación{$i}=3)
						atEVLG_Muestra{$i}:=String:C10($ar_minimoEscalaDimension{$i})+" - "+String:C10($ar_maximoEscalaDimension{$i})
						APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
						APPEND TO ARRAY:C911($al_Enterable3;0)
				End case 
				$l_idEnunciado:=alEVLG_IdDimension{$i}
				$d_fecha:=!00-00-00!
				$ad_MPA_FechaLogro{$i}:=!00-00-00!
				
			: (alEVLG_TipoObjeto{$i}=Logro_Aprendizaje)
				atEVLG_Competencia{$i}:=$at_NombreCompetencia{$i}
				alEVLG_TipoEvaluación{$i}:=$ai_TipoEvalCompetencia{$i}
				alEVLG_RefEstiloEvaluacion{$i}:=$al_IdEstiloCompetencia{$i}
				APPEND TO ARRAY:C911(at_colorCeldas;String:C10($al_colorCompetencia{$i}))  //ASM color agregado
				
				If ($l_periodo=-1)
					$b_periodoAbierto:=(((adSTR_Periodos_Cierre{Size of array:C274(adSTR_Periodos_Cierre)}>Current date:C33(*)) | (adSTR_Periodos_Cierre{Size of array:C274(adSTR_Periodos_Cierre)}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001;$l_userID))) & ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado"))
				Else 
					$b_periodoAbierto:=(((adSTR_Periodos_Cierre{$l_periodo}>Current date:C33(*)) | (adSTR_Periodos_Cierre{$l_periodo}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001;$l_userID))) & ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado"))
				End if 
				$b_usuarioAutorizado:=(((<>viSTR_FirmantesAutorizados=1) & ($l_profID=[Asignaturas:18]profesor_firmante_numero:33)) | ($l_profID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208];$l_userID)))
				$l_celdaEditable:=Num:C11($b_usuarioAutorizado & $b_periodoAbierto)
				If (<>vb_BloquearModifSituacionFinal)
					$l_celdaEditable:=0
				End if 
				Case of 
					: (alEVLG_TipoEvaluación{$i}=3)
						$l_idEstilo:=alEVLG_RefEstiloEvaluacion{$i}
						EVS_ReadStyleData ($l_idEstilo)
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
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
								APPEND TO ARRAY:C911($al_Enterable3;0)
							: (iEvaluationMode=Puntos)
								atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
								atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Puntos;iPointsDec)
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
								APPEND TO ARRAY:C911($al_Enterable3;0)
							: (iEvaluationMode=Porcentaje)
								atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
								atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Porcentaje;1)
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
								APPEND TO ARRAY:C911($al_Enterable3;0)
							: (iEvaluationMode=Simbolos)
								atEVLG_Muestra{$i}:="icono"
								atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Simbolos)
								APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
								APPEND TO ARRAY:C911($al_Enterable3;0)
						End case 
					: ((alEVLG_TipoEvaluación{$i}=1) | (alEVLG_TipoEvaluación{$i}=2))
						atEVLG_Muestra{$i}:="icono"
						APPEND TO ARRAY:C911($al_Enterable;$l_celdaEditable)
						APPEND TO ARRAY:C911($al_Enterable3;0)
				End case 
				APPEND TO ARRAY:C911($al_FilaEstilos;0)
				$l_idEnunciado:=alEVLG_IdCompetencia{$i}
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_IdMatriz;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Competencia:5=$l_idEnunciado)
				$d_fecha:=[MPA_ObjetosMatriz:204]FechaEstimadaLogro:26
		End case 
		If ($d_fecha#!00-00-00!)
			atMPA_FechaEstimada{$i}:=String:C10($d_fecha;7)
		Else 
			atMPA_FechaEstimada{$i}:=""
		End if 
		If ($ad_MPA_FechaLogro{$i}#!00-00-00!)
			atMPA_FechaLogro{$i}:=String:C10($ad_MPA_FechaLogro{$i};7)
		Else 
			atMPA_FechaLogro{$i}:=""
		End if 
	End for 
	
	EV2_CargaRegistro ([Asignaturas:18]Numero:1;$l_IdAlumno)
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	
	If ($l_periodo>-1)
		ARRAY TEXT:C222($aNotasLiteralesParciales;12)
		ARRAY REAL:C219($aNotasRealesParciales;12)
		For ($i;1;12)
			$aNotasLiteralesParciales{$i}:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Eval"+String:C10($i;"0#")+"_Literal")->
			$aNotasRealesParciales{$i}:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Eval"+String:C10($i;"0#")+"_Real")->
		End for 
	End if 
	
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
	  //$l_recNumObservacion:=Record number([Alumnos_ComplementoEvaluacion])
	$l_recNumObservacion:=Record number:C243([Alumnos_Calificaciones:208])  //ASM ticket 115068
	$b_calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
	
	
	  //**********   EVALUACIONES    **********
	OB_SET ($ob_json;->atEVLG_Competencia;"competencias";"")
	OB_SET ($ob_json;->atEVLG_Indicador;"indicadores";"")
	OB_SET ($ob_json;->arEVLG_Indicador;"indicadoresreales";"")
	OB_SET ($ob_json;->atEVLG_Observacion;"observaciones";"")
	OB_SET ($ob_json;->atEVLG_DescIndicador;"descindicador";"")
	OB_SET ($ob_json;->atEVLG_Muestra;"muestras";"")
	OB_SET ($ob_json;->alEVLG_TipoObjeto;"tipos";"")
	OB_SET ($ob_json;->alEVLG_RefEstiloEvaluacion;"refestilos";"")
	OB_SET ($ob_json;->alEVLG_TipoEvaluación;"tipoevaluacion";"")
	OB_SET ($ob_json;->alEVLG_IdCompetencia;"idscompetencias";"########0")
	OB_SET ($ob_json;->alEVLG_IdDimension;"idsdimensiones";"########0")
	OB_SET ($ob_json;->atMPA_FechaEstimada;"fechaestimada";"")
	OB_SET ($ob_json;->atMPA_FechaLogro;"fechalogro";"")
	OB_SET ($ob_json;->alEVLG_IdEje;"idsejes";"########0")
	OB_SET ($ob_json;->alEVLG_RecNum;"recnums";"########0")
	OB_SET ($ob_json;->at_colorCeldas;"colorceldas";"")  //agregado ASM∫
	
	$t_Observacion:=$y_campoObsAsignatura->
	OB_SET ($ob_json;->$t_Observacion;"observacion")
	OB_SET ($ob_json;->$l_recNumObservacion;"rnobservacion")
	If ($l_periodo>-1)
		OB_SET ($ob_json;->$aNotasLiteralesParciales;"parciales";"")
		OB_SET ($ob_json;->$aNotasRealesParciales;"parcialesREAL";"")
	End if 
	Case of 
		: (Size of array:C274(atSTR_Periodos_Nombre)=5)
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Literal:116;"p1")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P02_Final_Literal:191;"p2")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P03_Final_Literal:266;"p3")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P04_Final_Literal:341;"p4")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P05_Final_Literal:416;"p5")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Real:112;"p1REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P02_Final_Real:187;"p2REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P03_Final_Real:262;"p3REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P04_Final_Real:337;"p4REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P05_Final_Real:412;"p5REAL")
		: (Size of array:C274(atSTR_Periodos_Nombre)=4)
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Literal:116;"p1")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P02_Final_Literal:191;"p2")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P03_Final_Literal:266;"p3")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P04_Final_Literal:341;"p4")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Real:112;"p1REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P02_Final_Real:187;"p2REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P03_Final_Real:262;"p3REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P04_Final_Real:337;"p4REAL")
		: (Size of array:C274(atSTR_Periodos_Nombre)=3)
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Literal:116;"p1")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P02_Final_Literal:191;"p2")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P03_Final_Literal:266;"p3")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Real:112;"p1REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P02_Final_Real:187;"p2REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P03_Final_Real:262;"p3REAL")
		: (Size of array:C274(atSTR_Periodos_Nombre)=2)
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Literal:116;"p1")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P02_Final_Literal:191;"p2")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Real:112;"p1REAL")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P02_Final_Real:187;"p2REAL")
		: (Size of array:C274(atSTR_Periodos_Nombre)=1)
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Literal:116;"p1")
			OB_SET ($ob_json;->[Alumnos_Calificaciones:208]P01_Final_Real:112;"p1REAL")
	End case 
	If ([Alumnos_Calificaciones:208]ExamenAnual_Literal:20#"")
		OB_SET ($ob_json;->[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;"examen")
		OB_SET ($ob_json;->[Alumnos_Calificaciones:208]ExamenAnual_Real:16;"examenREAL")
	End if 
	OB_SET ($ob_json;->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;"final")
	OB_SET ($ob_json;->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;"finalREAL")
	OB_SET ($ob_json;->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;"oficial")
	OB_SET ($ob_json;->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;"oficialREAL")
	$l_valor:=Num:C11($b_calculosSobreCompetencias)
	OB_SET ($ob_json;->$l_valor;"calculossobrecompetencias")
	
	
	  //**********   PROPIEDADES DE LOS ESTILOS DE EVALUACION   **********
	  // nodo con todos los estilos de evaluacion
	$ob_nodo_estilos:=OB_Create 
	COPY ARRAY:C226(alEVLG_RefEstiloEvaluacion;$al_IdEstilosEvaluacion)
	AT_DistinctsArrayValues (->$al_IdEstilosEvaluacion)
	For ($i;1;Size of array:C274($al_IdEstilosEvaluacion))
		$l_idEstiloEvaluacion:=$al_IdEstilosEvaluacion{$i}
		EVS_ReadStyleData ($l_idEstiloEvaluacion)
		$t_MinSimbolo:=""
		$t_MinEscalaNotaSim:=""
		$ob_nodoEstiloEvaluacion:=OB_Create 
		Case of 
			: (iEvaluationMode=Notas)
				$r_Minimo:=EV2_Real_a_Nota (rPctMinimum;0;iGradesDec)
				$r_MinEscala:=EV2_Real_a_Nota (vrNTA_MinimoEscalaReferencia;0;iGradesDec)
				$t_modo:="notas"
				OB_SET ($ob_nodoEstiloEvaluacion;->$t_modo;"evaluationmode")
				OB_SET ($ob_nodoEstiloEvaluacion;->rGradesFrom;"desde")
				OB_SET ($ob_nodoEstiloEvaluacion;->rGradesTo;"hasta")
				OB_SET ($ob_nodoEstiloEvaluacion;->iGradesDec;"decimales")
				OB_SET ($ob_nodoEstiloEvaluacion;->rGradesInterval;"intervalo")
				OB_SET ($ob_nodoEstiloEvaluacion;->$r_Minimo;"minimo")
				OB_SET ($ob_nodoEstiloEvaluacion;->$r_MinEscala;"minimoescala")
				If (iConversionTable=1)
					OB_SET ($ob_nodoEstiloEvaluacion;->arEVS_ConvGrades;"BON";vs_GradesFormat)
				End if 
				
			: (iEvaluationMode=Puntos)
				$r_minimo:=EV2_Real_a_Puntos (rPctMinimum;0;iPointsDec)
				$r_MinEscala:=EV2_Real_a_Puntos (vrNTA_MinimoEscalaReferencia;0;iPointsDec)
				$t_modo:="puntos"
				OB_SET ($ob_nodoEstiloEvaluacion;->$t_modo;"evaluationmode")
				OB_SET ($ob_nodoEstiloEvaluacion;->rPointsFrom;"desde")
				OB_SET ($ob_nodoEstiloEvaluacion;->rPointsTo;"hasta")
				OB_SET ($ob_nodoEstiloEvaluacion;->iPointsDec;"decimales")
				OB_SET ($ob_nodoEstiloEvaluacion;->rPointsInterval;"intervalo")
				OB_SET ($ob_nodoEstiloEvaluacion;->$r_minimo;"minimo")
				OB_SET ($ob_nodoEstiloEvaluacion;->$r_MinEscala;"minimoescala")
				If (iConversionTable=1)
					OB_SET ($ob_nodoEstiloEvaluacion;->arEVS_ConvPoints;"BON";vs_pointsFormat)
				End if 
				
			: (iEvaluationMode=Simbolos)
				$t_MinSimbolo:=EV2_Real_a_Simbolo (rPctMinimum)
				$t_MinEscalaNotaSim:=EV2_Real_a_Simbolo (vrNTA_MinimoEscalaReferencia)
				$t_modo:="simbolos"
				OB_SET ($ob_nodoEstiloEvaluacion;->$t_modo;"evaluationmode")
				OB_SET ($ob_nodoEstiloEvaluacion;->aSymbol;"simbolos")
				OB_SET ($ob_nodoEstiloEvaluacion;->aSymbDesc;"descripciones")
				OB_SET ($ob_nodoEstiloEvaluacion;->$t_MinSimbolo;"minimo")
				OB_SET ($ob_nodoEstiloEvaluacion;->$t_MinEscalaNotaSim;"minimoescala")
				OB_SET ($ob_nodoEstiloEvaluacion;->rPctMinimum;"minimoreal")
				OB_SET ($ob_nodoEstiloEvaluacion;->vrNTA_MinimoEscalaReferencia;"minimoescalareal")
				
			: (iEvaluationMode=Porcentaje)
				$r_Minimo:=rPctMinimum
				$r_MinEscala:=vrNTA_MinimoEscalaReferencia
				$t_modo:="porcentaje"
				OB_SET ($ob_nodoEstiloEvaluacion;->$t_modo;"evaluationmode")
				OB_SET ($ob_nodoEstiloEvaluacion;->$r_Minimo;"minimo")
				OB_SET ($ob_nodoEstiloEvaluacion;->$r_MinEscala;"minimoescala")
		End case 
		OB_SET ($ob_nodoEstiloEvaluacion;-><>tXS_RS_DecimalSeparator;"separador")
		  // agrego las propiedades de cada estilo al nodo estilos
		OB_SET ($ob_nodo_estilos;->$ob_nodoEstiloEvaluacion;String:C10($al_IdEstilosEvaluacion{$i}))
	End for 
	  // y agregon el nodo "estilos" a la raiz
	OB_SET ($ob_json;->$ob_nodo_estilos;"estilos")
	
	
	  //**********   PROPIEDADES DE LOS ENUNCIADOS   **********
	  //creo el nodo "paramtipo" (propiedades para cada enunciado)
	$ob_nodo_paramtipo:=OB_Create 
	For ($i;1;Size of array:C274(alEVLG_TipoEvaluación))
		$ob_nodo_Enunciado:=OB_Create   // creo un nodo para almacenar las propiedades de cada enunciado
		$l_tipoEvaluacion:=alEVLG_TipoEvaluación{$i}
		$l_tipoObjeto:=alEVLG_TipoObjeto{$i}
		
		Case of 
			: ($l_tipoObjeto=Logro_Aprendizaje)
				$l_recnumDefinicion:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;alEVLG_IdCompetencia{$i})
			: ($l_tipoObjeto=Dimension_Aprendizaje)
				$l_recnumDefinicion:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;alEVLG_IdDimension{$i})
			: ($l_tipoObjeto=Eje_Aprendizaje)
				$l_recnumDefinicion:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;alEVLG_IdEje{$i})
		End case 
		
		If ($l_recnumDefinicion>No current record:K29:2)
			Case of 
				: ($l_tipoEvaluacion=1)  //indicadores de logro para competencias, estilo de evaluación en caso de dimensiones y ejes
					If ($l_tipoObjeto=Logro_Aprendizaje)
						KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$i};False:C215)
						$l_recNumEnunciado:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
						KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumEnunciado;False:C215)
						BLOB_Blob2Vars (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->$at_EVLG_Indicadores_Descripcion;->$ai_EVLG_indicadores_Valor;->$at_EVLG_Indicadores_Concepto)
						OB_SET ($ob_nodo_Enunciado;->$at_EVLG_Indicadores_Descripcion;"descripciones";"")
						OB_SET ($ob_nodo_Enunciado;->$at_EVLG_Indicadores_Concepto;"simbolos";"")
						OB_SET ($ob_nodo_Enunciado;->$ai_EVLG_indicadores_Valor;"valores";"")
						OB_SET_Text ($ob_nodo_Enunciado;String:C10([MPA_DefinicionCompetencias:187]Requerido_Indicadores:8);"requerido")
					End if 
				: ($l_tipoEvaluacion=2)  //Binario para todo
					Case of 
						: ($l_tipoObjeto=Logro_Aprendizaje)
							$l_recNumEnunciado:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;alEVLG_IdCompetencia{$i})
							KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumEnunciado;False:C215)
							AT_Text2Array (->$at_simbolos;[MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17)
							AT_Text2Array (->$at_descripcionSimbolos;[MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18)
							OB_SET ($ob_nodo_Enunciado;->$at_simbolos;"simbolos";"")
							OB_SET ($ob_nodo_Enunciado;->$at_descripcionSimbolos;"descripciones";"")
							
						: ($l_tipoObjeto=Dimension_Aprendizaje)
							$l_recNumEnunciado:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;alEVLG_IdDimension{$i})
							KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumEnunciado;False:C215)
							AT_Text2Array (->$at_simbolos;[MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17)
							AT_Text2Array (->$at_descripcionSimbolos;[MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16)
							OB_SET ($ob_nodo_Enunciado;->$at_simbolos;"simbolos";"")
							OB_SET ($ob_nodo_Enunciado;->$at_descripcionSimbolos;"descripciones";"")
							
						: ($l_tipoObjeto=Eje_Aprendizaje)
							$l_recNumEnunciado:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;alEVLG_IdEje{$i})
							KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEnunciado;False:C215)
							AT_Text2Array (->$at_simbolos;[MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14)
							AT_Text2Array (->$at_descripcionSimbolos;[MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15)
							OB_SET ($ob_nodo_Enunciado;->$at_simbolos;"simbolos";"")
							OB_SET ($ob_nodo_Enunciado;->$at_descripcionSimbolos;"descripciones";"")
					End case 
					
				: ($l_tipoEvaluacion=3)  //estilo de evaluación para competencias, escala numerica para ejes y dimensiones
					Case of 
						: ($l_tipoObjeto=Dimension_Aprendizaje)
							$l_recNumEnunciado:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;alEVLG_IdDimension{$i})
							KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumEnunciado;False:C215)
							$l_requerido:=Round:C94([MPA_DefinicionDimensiones:188]Escala_Maximo:13*[MPA_DefinicionDimensiones:188]PctParaAprobacion:14/100;0)
							OB_SET ($ob_nodo_Enunciado;->[MPA_DefinicionDimensiones:188]Escala_Minimo:12;"minimo")
							OB_SET ($ob_nodo_Enunciado;->[MPA_DefinicionDimensiones:188]Escala_Maximo:13;"maximo")
							OB_SET ($ob_nodo_Enunciado;->$l_requerido;"requerido")
						: ($l_tipoObjeto=Eje_Aprendizaje)
							$l_recNumEnunciado:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;alEVLG_IdEje{$i})
							KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEnunciado;False:C215)
							$l_requerido:=Round:C94([MPA_DefinicionEjes:185]Escala_Maximo:18*[MPA_DefinicionEjes:185]PctParaAprobacion:16/100;0)
							OB_SET ($ob_nodo_Enunciado;->[MPA_DefinicionEjes:185]Escala_Minimo:17;"minimo")
							OB_SET ($ob_nodo_Enunciado;->[MPA_DefinicionEjes:185]Escala_Maximo:18;"maximo")
							OB_SET ($ob_nodo_Enunciado;->$l_requerido;"requerido")
					End case 
			End case 
		End if 
		If (OB_GetSize ($ob_nodo_Enunciado)>0)
			  // agrego el nodo con las propiedades del enuncioado al nodo "paramtipo"
			$llave:=String:C10(alEVLG_TipoObjeto{$i};"####")+"_"+String:C10(alEVLG_IdCompetencia{$i};"#####0")+"_"+String:C10(alEVLG_IdDimension{$i};"#####0")+"_"+String:C10(alEVLG_IdEje{$i};"#####0")
			OB_SET ($ob_nodo_paramtipo;->$ob_nodo_Enunciado;$llave)
		End if 
	End for 
	  //y agrego el nodo paramtipo a la raiz
	OB_SET ($ob_json;->$ob_nodo_paramtipo;"paramtipo")
	
	  //**********   PROPIEDADES DEL ESTILO EVALUCION DE LA ASIGNATURA **********
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	$ob_nodo_estiloAsignatura:=OB_Create   //estiloEv
	
	$t_minimoSimbolo:=""
	$t_minimoEscalaSimbolo:=""
	$ob_nodo_modoEvaluacion:=OB_Create   //evaluationmode
	Case of 
		: (iEvaluationMode=Notas)
			$r_minimo:=EV2_Real_a_Nota (rPctMinimum;0;iGradesDec)
			$r_minimoEscala:=EV2_Real_a_Nota (vrNTA_MinimoEscalaReferencia;0;iGradesDec)
			$t_modo:="notas"
			OB_SET ($ob_nodo_modoEvaluacion;->$t_modo;"evaluationmode")
			OB_SET ($ob_nodo_modoEvaluacion;->rGradesFrom;"desde")
			OB_SET ($ob_nodo_modoEvaluacion;->rGradesTo;"hasta")
			OB_SET ($ob_nodo_modoEvaluacion;->iGradesDec;"decimales")
			OB_SET ($ob_nodo_modoEvaluacion;->rGradesInterval;"intervalo")
			OB_SET ($ob_nodo_modoEvaluacion;->$r_minimo;"minimo")
			OB_SET ($ob_nodo_modoEvaluacion;->$r_minimoEscala;"minimoescala")
		: (iEvaluationMode=Puntos)
			$r_minimo:=EV2_Real_a_Puntos (rPctMinimum;0;iPointsDec)
			$r_minimoEscala:=EV2_Real_a_Puntos (vrNTA_MinimoEscalaReferencia;0;iPointsDec)
			$t_modo:="puntos"
			OB_SET ($ob_nodo_modoEvaluacion;->$t_modo;"evaluationmode")
			OB_SET ($ob_nodo_modoEvaluacion;->rPointsFrom;"desde")
			OB_SET ($ob_nodo_modoEvaluacion;->rPointsTo;"hasta")
			OB_SET ($ob_nodo_modoEvaluacion;->iPointsDec;"decimales")
			OB_SET ($ob_nodo_modoEvaluacion;->rPointsInterval;"intervalo")
			OB_SET ($ob_nodo_modoEvaluacion;->$r_minimo;"minimo")
			OB_SET ($ob_nodo_modoEvaluacion;->$r_minimoEscala;"minimoescala")
		: (iEvaluationMode=Simbolos)
			$t_minimoSimbolo:=EV2_Real_a_Simbolo (rPctMinimum)
			$t_minimoEscalaSimbolo:=EV2_Real_a_Simbolo (vrNTA_MinimoEscalaReferencia)
			$t_modo:="simbolos"
			OB_SET ($ob_nodo_modoEvaluacion;->$t_modo;"evaluationmode")
			OB_SET ($ob_nodo_modoEvaluacion;->aSymbol;"simbolos")
			OB_SET ($ob_nodo_modoEvaluacion;->$t_minimoSimbolo;"minimo")
			OB_SET ($ob_nodo_modoEvaluacion;->$t_minimoEscalaSimbolo;"minimoescala")
			OB_SET ($ob_nodo_modoEvaluacion;->rPctMinimum;"minimoreal")
			OB_SET ($ob_nodo_modoEvaluacion;->vrNTA_MinimoEscalaReferencia;"minimoescalareal")
		: (iEvaluationMode=Porcentaje)
			$r_minimo:=rPctMinimum
			$r_minimoEscala:=vrNTA_MinimoEscalaReferencia
			$t_modo:="porcentaje"
			OB_SET ($ob_nodo_modoEvaluacion;->$t_modo;"evaluationmode")
			OB_SET ($ob_nodo_modoEvaluacion;->$r_minimo;"minimo")
			OB_SET ($ob_nodo_modoEvaluacion;->$r_minimoEscala;"minimoescala")
	End case 
	OB_SET ($ob_nodo_modoEvaluacion;-><>tXS_RS_DecimalSeparator;"separador")
	
	$ob_nodo_modoImpresion:=OB_Create   //printmode
	Case of 
		: (iPrintMode=Notas)
			$r_minimo:=EV2_Real_a_Nota (rPctMinimum;0;iGradesDec)
			$r_minimoEscala:=EV2_Real_a_Nota (vrNTA_MinimoEscalaReferencia;0;iGradesDec)
			$t_modo:="notas"
			OB_SET ($ob_nodo_modoImpresion;->$t_modo;"evaluationmode")
			OB_SET ($ob_nodo_modoImpresion;->rGradesFrom;"desde")
			OB_SET ($ob_nodo_modoImpresion;->rGradesTo;"hasta")
			OB_SET ($ob_nodo_modoImpresion;->iGradesDec;"decimales")
			OB_SET ($ob_nodo_modoImpresion;->rGradesInterval;"intervalo")
			OB_SET ($ob_nodo_modoImpresion;->$r_minimo;"minimo")
			OB_SET ($ob_nodo_modoImpresion;->$r_minimoEscala;"minimoescala")
		: (iPrintMode=Puntos)
			$r_minimo:=EV2_Real_a_Puntos (rPctMinimum;0;iPointsDec)
			$r_minimoEscala:=EV2_Real_a_Puntos (vrNTA_MinimoEscalaReferencia;0;iPointsDec)
			$t_modo:="puntos"
			OB_SET ($ob_nodo_modoImpresion;->$t_modo;"evaluationmode")
			OB_SET ($ob_nodo_modoImpresion;->rPointsFrom;"desde")
			OB_SET ($ob_nodo_modoImpresion;->rPointsTo;"hasta")
			OB_SET ($ob_nodo_modoImpresion;->iPointsDec;"decimales")
			OB_SET ($ob_nodo_modoImpresion;->rPointsInterval;"intervalo")
			OB_SET ($ob_nodo_modoImpresion;->$r_minimo;"minimo")
			OB_SET ($ob_nodo_modoImpresion;->$r_minimoEscala;"minimoescala")
		: (iPrintMode=Simbolos)
			$t_minimoSimbolo:=EV2_Real_a_Simbolo (rPctMinimum)
			$t_minimoEscalaSimbolo:=EV2_Real_a_Simbolo (vrNTA_MinimoEscalaReferencia)
			$t_modo:="simbolos"
			OB_SET ($ob_nodo_modoImpresion;->$t_modo;"evaluationmode")
			OB_SET ($ob_nodo_modoImpresion;->aSymbol;"simbolos")
			OB_SET ($ob_nodo_modoImpresion;->$t_minimoSimbolo;"minimo")
			OB_SET ($ob_nodo_modoImpresion;->$t_minimoEscalaSimbolo;"minimoescala")
			OB_SET ($ob_nodo_modoImpresion;->rPctMinimum;"minimoreal")
			OB_SET ($ob_nodo_modoImpresion;->vrNTA_MinimoEscalaReferencia;"minimoescalareal")
		: (iPrintMode=Porcentaje)
			$r_minimo:=rPctMinimum
			$r_minimoEscala:=vrNTA_MinimoEscalaReferencia
			$t_modo:="porcentaje"
			OB_SET ($ob_nodo_modoImpresion;->$t_modo;"evaluationmode")
			OB_SET ($ob_nodo_modoImpresion;->$r_minimo;"minimo")
			OB_SET ($ob_nodo_modoImpresion;->$r_minimoEscala;"minimoescala")
	End case 
	OB_SET ($ob_nodo_modoImpresion;-><>tXS_RS_DecimalSeparator;"separador")
	
	
	
	  //agrego los nodos "evaluationmode" y "printMode" al nodo "estiloEv"
	OB_SET ($ob_nodo_estiloAsignatura;->$ob_nodo_modoEvaluacion;"evaluationmode")
	OB_SET ($ob_nodo_estiloAsignatura;->$ob_nodo_modoImpresion;"printmode")
	OB_SET ($ob_nodo_estiloAsignatura;->rPctMinimum;"minREAL")
	  // y agrego el nodo "estiloEv" al nodo raiz
	OB_SET ($ob_json;->$ob_nodo_estiloAsignatura;"estiloEV")
	
	
	
	$ob_nodo_confarmado:=OB_Create 
	OB_SET ($ob_nodo_ConfArmado;->$al_Enterable;"ingresablecol2";"")
	OB_SET ($ob_nodo_ConfArmado;->$al_Enterable3;"ingresablecol3";"")
	OB_SET ($ob_nodo_ConfArmado;->$al_FilaEstilos;"estilofila";"")
	OB_SET ($ob_json;->$ob_nodo_ConfArmado;"confarmado")
	
	$ob_nodo_alumnos:=OB_Create 
	OB_SET ($ob_nodo_alumnos;->aNtaIdAlumno;"ids";"########0")
	OB_SET ($ob_nodo_alumnos;->$at_nombreAlumnos;"nombres";"")
	OB_SET ($ob_json;->$ob_nodo_alumnos;"alumnos")
	
	
	$ob_nodo_periodos:=OB_Create 
	OB_SET ($ob_nodo_periodos;->atSTR_Periodos_Nombre;"nombres";"")
	OB_SET ($ob_nodo_periodos;->aiSTR_Periodos_Numero;"numeros";"###0")
	OB_SET ($ob_nodo_periodos;->adSTR_Periodos_Desde;"desde";"MM/DD/YYYY")
	OB_SET ($ob_nodo_periodos;->adSTR_Periodos_Hasta;"hasta";"MM/DD/YYYY")
	OB_SET ($ob_nodo_periodos;->adSTR_Periodos_Cierre;"cierre";"MM/DD/YYYY")
	OB_SET ($ob_json;->$ob_nodo_periodos;"periodos")
	
	
	$l_noModifcarNotas:=<>viSTR_NoModificarNotas
	If (USR_IsGroupMember_by_GrpID (-15001;$l_userId))
		$l_noModifcarNotas:=0
	End if 
	$l_periodoActual:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
	$l_BloquearModifSituacionFinal:=Num:C11(<>vb_BloquearModifSituacionFinal)
	
	$ob_Parametros:=OB_Create 
	OB_SET ($ob_Parametros;-><>vd_FechaBloqueoSchoolTrack;"fechabloqueo";String:C10(Internal date short:K1:7))
	OB_SET ($ob_Parametros;->$l_BloquearModifSituacionFinal;"bloqueo")
	OB_SET ($ob_Parametros;->$l_periodo;"periodo")
	OB_SET ($ob_Parametros;->$l_periodoActual;"periodoactual")
	OB_SET ($ob_Parametros;->$l_noModifcarNotas;"nomodificarnotas")
	OB_SET ($ob_Parametros;->$t_nombreMatriz;"nombrematriz")
	OB_SET ($ob_Parametros;->$l_IdAlumno;"alumnoactual")
	OB_SET ($ob_json;->$ob_Parametros;"parametros")
	
	$p_foto:=KRL_GetPictureFieldData (->[Alumnos:2]numero:1;->$l_IdAlumno;->[Alumnos:2]Fotografía:78)
	STWA2_AdjustPicture (->$p_foto;85;85)
	OB_SET ($ob_json;->$p_foto;"fotoalumno")
	
	
End if 


$0:=OB_Object2Json ($ob_json)







