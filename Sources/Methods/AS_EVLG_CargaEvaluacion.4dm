//%attributes = {}
  // MÉTODO: AS_EVLG_CargaEvaluacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/12/11, 17:57:35
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // AS_EVLG_CargaEvaluacion()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_BOOLEAN:C305($b_createRecord;$b_devolverPeriodoMasCercano;$b_dimensionesIngresables;$b_EjesIngresables;$b_RegistroEditable;$b_UsuarioAutorizado)
C_DATE:C307($d_FechaEstimadaLogro)
C_LONGINT:C283($l_id_Alumno)
C_LONGINT:C283($i;$l_CeldaEsEditable;$l_ID_Competencia;$l_idAsignatura;$l_recNum)
C_POINTER:C301($y_Indicador;$y_Literal;$y_Numerico;$y_ObsAsignatura;$y_ObsCompetencia;$y_Periodo;$y_Real)
C_TEXT:C284($t_llaveRegistro;$t_sexoAlumno)

ARRAY DATE:C224(adEVLG_FechaLogro;0)
ARRAY LONGINT:C221($al_EnterableCells;0)
ARRAY LONGINT:C221($al_ID_EstiloCompetencia;0)
ARRAY LONGINT:C221($al_ID_EstiloDimension;0)
ARRAY LONGINT:C221($al_ID_EstiloEje;0)
ARRAY LONGINT:C221($al_ID_EstiloEvaluacion;0)
ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY INTEGER:C220($ai_OrdenCompetencia;0)
ARRAY INTEGER:C220($ai_OrdenDimension;0)
ARRAY INTEGER:C220($ai_OrdenEje;0)
ARRAY INTEGER:C220($ai_TipoEvalCompetencia;0)
ARRAY INTEGER:C220($ai_TipoEvalDimension;0)
ARRAY INTEGER:C220($ai_TipoEvalEje;0)
ARRAY TEXT:C222($at_NombreCompetencia;0)
ARRAY TEXT:C222($at_NombreDimension;0)
ARRAY TEXT:C222($at_NombreEje;0)
ARRAY TEXT:C222($at_Status;0)
If (False:C215)
	C_LONGINT:C283(AS_EVLG_CargaEvaluacion ;$1)
	C_LONGINT:C283(AS_EVLG_CargaEvaluacion ;$2)
	C_LONGINT:C283(AS_EVLG_CargaEvaluacion ;$3)
	C_LONGINT:C283(AS_EVLG_CargaEvaluacion ;$4)
End if 


C_LONGINT:C283(VlEVLG_currentID;vl_PeriodoSeleccionado;vlEVLG_nivelEvaluacion)
C_REAL:C285(vrEVLG_Evaluacion_Minimo;vrEVLG_MaximoEvaluacion;vrEVLG_Requerido;vlEVLG_Decimals;vrEVLG_Interval)


  // CODIGO PRINCIPAL
vbEVLG_EvaluacionesModificadas:=False:C215
vlEVLG_nivelEvaluacion:=$1
$l_idAsignatura:=$2
VlEVLG_currentID:=$3
vl_PeriodoSeleccionado:=$4

Case of 
	: (vlEVLG_nivelEvaluacion=Finales_Aprendizajes)
		vtEVLG_nivelEvaluacion:="Finales"
	: (vlEVLG_nivelEvaluacion=Eje_Aprendizaje)
		vtEVLG_nivelEvaluacion:="Eje"
	: (vlEVLG_nivelEvaluacion=Dimension_Aprendizaje)
		vtEVLG_nivelEvaluacion:="Dimension"
	: (vlEVLG_nivelEvaluacion=Logro_Aprendizaje)
		vtEVLG_nivelEvaluacion:="Logros"
	: (vlEVLG_nivelEvaluacion=Instancia_Aprendizaje)
		vtEVLG_nivelEvaluacion:="Instancias"
End case 

If (vl_PeriodoSeleccionado=0)
	$b_devolverPeriodoMasCercano:=True:C214
	vl_PeriodoSeleccionado:=PERIODOS_PeriodosActuales (Current date:C33(*);$b_devolverPeriodoMasCercano)
End if 
ARRAY TEXT:C222(atEVLG_Competencia;0)
ARRAY TEXT:C222(atEVLG_Indicador;0)
ARRAY TEXT:C222(atEVLG_Observacion;0)
ARRAY REAL:C219(arEVLG_Indicador;0)
ARRAY LONGINT:C221(alEVLG_TipoEvaluación;0)
ARRAY LONGINT:C221(alEVLG_RefEstiloEvaluacion;0)
ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
ARRAY LONGINT:C221(alEVLG_RecNum;0)
ARRAY TEXT:C222(atEVLG_Muestra;0)
ARRAY DATE:C224(adEVLG_FechaLogro;0)
ARRAY TEXT:C222(atMPA_FechaLogro;0)
Case of 
	: (vl_PeriodoSeleccionado=1)
		$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
		$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
		$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
		$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
		$y_ObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
		$y_ObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
		$y_Periodo:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
		
	: (vl_PeriodoSeleccionado=2)
		$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
		$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
		$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
		$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
		$y_ObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
		$y_ObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
		$y_Periodo:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
		
	: (vl_PeriodoSeleccionado=3)
		$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
		$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
		$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
		$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
		$y_ObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
		$y_ObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
		$y_Periodo:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
		
	: (vl_PeriodoSeleccionado=4)
		$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
		$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
		$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
		$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
		$y_ObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82
		$y_ObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
		$y_Periodo:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
		
	: (vl_PeriodoSeleccionado=5)
		$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
		$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
		$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
		$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
		$y_ObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
		$y_ObsAsignatura:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
		$y_Periodo:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
		
	: (vl_PeriodoSeleccionado=-1)
		$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
		$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
		$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
		$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
		$y_ObsCompetencia:=->[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84
		
End case 

  //****CUERPO****
READ ONLY:C145([MPA_AsignaturasMatrices:189])
READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
READ ONLY:C145([MPA_DefinicionCompetencias:187])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])

vtEVLG_ObjetoEvaluado:=""

AL_UpdateArrays (xALP_EValuaciones;0)

AS_LoadStudentList 
GOTO RECORD:C242([MPA_AsignaturasMatrices:189];vlEVLG_MatrizLogros_RecNum)
$b_EjesIngresables:=([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Eje_Aprendizaje)
$b_dimensionesIngresables:=([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Dimension_Aprendizaje)
Case of 
	: (vlEVLG_nivelEvaluacion=Finales_Aprendizajes)
	: (vlEVLG_nivelEvaluacion=Eje_Aprendizaje)
		VlEVLG_currentID:=VlEVLG_currentID
		vl_PeriodoSeleccionado:=vl_PeriodoSeleccionado
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3;=;VlEVLG_currentID;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1;=;[Asignaturas:18]EVAPR_IdMatriz:91;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Eje_Aprendizaje)
		For ($i;1;Size of array:C274(aNtaIDAlumno))
			$t_llaveRegistro:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10(aNtaIDAlumno{$i})+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+".0.0"
			$l_recNum:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistro)
			If ($l_recNum<0)
				CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
				[Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78:=<>gInstitucion
				[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
				[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=aNtaIDAlumno{$i}
				[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=[Asignaturas:18]Numero:1
				[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=[Asignaturas:18]EVAPR_IdMatriz:91
				[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
				[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=Eje_Aprendizaje
				[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
				SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
				MPA_RecuperaEvalCicloAnterior 
			End if 
		End for 
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignatura;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=VlEVLG_currentID;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
		QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->aNtaIDAlumno;True:C214)
		
	: (vlEVLG_nivelEvaluacion=Dimension_Aprendizaje)
		VlEVLG_currentID:=VlEVLG_currentID
		vl_PeriodoSeleccionado:=vl_PeriodoSeleccionado
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4;=;VlEVLG_currentID;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1;=;[Asignaturas:18]EVAPR_IdMatriz:91;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Dimension_Aprendizaje)
		For ($i;1;Size of array:C274(aNtaIDAlumno))
			$t_llaveRegistro:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10(aNtaIDAlumno{$i})+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+".0"
			$l_recNum:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistro)
			If ($l_recNum<0)
				CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
				[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=aNtaIDAlumno{$i}
				[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=[Asignaturas:18]Numero:1
				[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
				[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=[MPA_ObjetosMatriz:204]ID_Dimension:4
				[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=Dimension_Aprendizaje
				[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=[Asignaturas:18]EVAPR_IdMatriz:91
				[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
				[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
				SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
				MPA_RecuperaEvalCicloAnterior 
			End if 
		End for 
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignatura;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=VlEVLG_currentID;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
		QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->aNtaIDAlumno;True:C214)
		
	: (vlEVLG_nivelEvaluacion=Logro_Aprendizaje)
		  // verificamos que todos los alumnos inscritos en la asignatura tengan registros de  ` evaluación para el logro seleccionado
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5;=;VlEVLG_currentID;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1;=;[Asignaturas:18]EVAPR_IdMatriz:91;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Logro_Aprendizaje)
		RELATE ONE:C42([MPA_ObjetosMatriz:204]ID_Competencia:5)
		$y_alumnosSexo:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosSexo")
		For ($i;1;Size of array:C274(aNtaIDAlumno))
			$t_sexoAlumno:=$y_alumnosSexo->{$i}
			$l_idAlumno:=aNtaIDAlumno{$i}
			Case of 
				: (([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje))
					$t_llaveRegistro:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_id_Alumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
					$b_createRecord:=(Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistro)<0)
					
				: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
					RELATE ONE:C42([MPA_ObjetosMatriz:204]ID_Competencia:5)
					Case of 
						: ([MPA_DefinicionCompetencias:187]RestriccionSexo:27=0)
							$t_llaveRegistro:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
							$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistro)
							$b_createRecord:=($l_recNumEval<0)
							
						: ((([MPA_DefinicionCompetencias:187]RestriccionSexo:27=1) & ($t_sexoAlumno="F")) | (([MPA_DefinicionCompetencias:187]RestriccionSexo:27=2) & ($t_sexoAlumno="M")))
							$t_llaveRegistro:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($l_IdAlumno)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
							$l_recNumEval:=Find in field:C653([Alumnos_EvaluacionAprendizajes:203]Key:8;$t_llaveRegistro)
							$b_createRecord:=($l_recNumEval<0)
					End case 
			End case 
			
			If ($b_createRecord)
				CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
				[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=aNtaIDAlumno{$i}
				[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=[Asignaturas:18]Numero:1
				[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=[Asignaturas:18]EVAPR_IdMatriz:91
				[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=[MPA_ObjetosMatriz:204]ID_Competencia:5
				[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
				[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=[MPA_ObjetosMatriz:204]ID_Dimension:4
				[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=Logro_Aprendizaje
				[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
				[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
				SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
				MPA_RecuperaEvalCicloAnterior 
			End if 
		End for 
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignatura;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=VlEVLG_currentID;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
		QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->aNtaIDAlumno;True:C214)
		
	: (vlEVLG_nivelEvaluacion=Instancia_Aprendizaje)
End case 

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)

If (vlEVLG_mostrarObservacion=0)
	SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum;[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;atMPA_uuidRegistro;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;$al_IdAlumnos;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;alEVLG_IdEje;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;alEVLG_IdDimension;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;alEVLG_IdCompetencia;[Alumnos:2]apellidos_y_nombres:40;atEVLG_Alumnos;[Alumnos:2]Status:50;$at_Status;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;alEVLG_TipoObjeto;$y_Literal->;atEVLG_Indicador;$y_Real->;arEVLG_Indicador;$y_Indicador->;atEVLG_Observacion;[MPA_DefinicionEjes:185]Nombre:3;$at_NombreEje;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$ai_OrdenEje;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_NombreDimension;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$ai_OrdenDimension;[MPA_DefinicionCompetencias:187]Competencia:6;$at_NombreCompetencia;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;$ai_OrdenCompetencia;[MPA_DefinicionEjes:185]TipoEvaluación:12;$ai_TipoEvalEje;[MPA_DefinicionEjes:185]EstiloEvaluación:13;$al_ID_EstiloEje;[MPA_DefinicionDimensiones:188]TipoEvaluacion:15;$ai_TipoEvalDimension;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;$al_ID_EstiloDimension;[MPA_DefinicionCompetencias:187]TipoEvaluacion:12;$ai_TipoEvalCompetencia;[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;$al_ID_EstiloCompetencia;[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;adEVLG_FechaLogro)
Else 
	SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum;[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;atMPA_uuidRegistro;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;$al_IdAlumnos;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;alEVLG_IdEje;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;alEVLG_IdDimension;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;alEVLG_IdCompetencia;[Alumnos:2]apellidos_y_nombres:40;atEVLG_Alumnos;[Alumnos:2]Status:50;$at_Status;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;alEVLG_TipoObjeto;$y_Literal->;atEVLG_Indicador;$y_Real->;arEVLG_Indicador;$y_ObsCompetencia->;atEVLG_Observacion;[MPA_DefinicionEjes:185]Nombre:3;$at_NombreEje;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$ai_OrdenEje;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_NombreDimension;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$ai_OrdenDimension;[MPA_DefinicionCompetencias:187]Competencia:6;$at_NombreCompetencia;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;$ai_OrdenCompetencia;[MPA_DefinicionEjes:185]TipoEvaluación:12;$ai_TipoEvalEje;[MPA_DefinicionEjes:185]EstiloEvaluación:13;$al_ID_EstiloEje;[MPA_DefinicionDimensiones:188]TipoEvaluacion:15;$ai_TipoEvalDimension;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;$al_ID_EstiloDimension;[MPA_DefinicionCompetencias:187]TipoEvaluacion:12;$ai_TipoEvalCompetencia;[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;$al_ID_EstiloCompetencia;[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;adEVLG_FechaLogro)
End if 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
  //excluyo registros de evaluación de aprendizajes no relacionados con los objetos d  `efinidos en el mapa

For ($i;Size of array:C274(alEVLG_RecNum);1;-1)
	Case of 
		: ((alEVLG_TipoObjeto{$i}=Eje_Aprendizaje) & ($at_NombreEje{$i}=""))
			AT_Delete ($i;1;->$al_IdAlumnos;->$at_Status;->$ai_OrdenEje;->$ai_OrdenDimension;->$ai_OrdenCompetencia;->$at_NombreEje;->$at_NombreDimension;->$at_NombreCompetencia;->$ai_TipoEvalEje;->$ai_TipoEvalDimension;->$ai_TipoEvalCompetencia;->$al_ID_EstiloEje;->$al_ID_EstiloDimension;->$al_ID_EstiloCompetencia;->alEVLG_RecNum;->alEVLG_TipoObjeto;->atEVLG_Indicador;->arEVLG_Indicador;->atEVLG_Observacion;->alEVLG_IdCompetencia;->alEVLG_IdDimension;->alEVLG_IdEje;->adEVLG_FechaLogro;->atMPA_uuidRegistro)
		: ((alEVLG_TipoObjeto{$i}=Dimension_Aprendizaje) & ($at_NombreDimension{$i}=""))
			AT_Delete ($i;1;->$al_IdAlumnos;->$at_Status;->$ai_OrdenEje;->$ai_OrdenDimension;->$ai_OrdenCompetencia;->$at_NombreEje;->$at_NombreDimension;->$at_NombreCompetencia;->$ai_TipoEvalEje;->$ai_TipoEvalDimension;->$ai_TipoEvalCompetencia;->$al_ID_EstiloEje;->$al_ID_EstiloDimension;->$al_ID_EstiloCompetencia;->alEVLG_RecNum;->alEVLG_TipoObjeto;->atEVLG_Indicador;->arEVLG_Indicador;->atEVLG_Observacion;->alEVLG_IdCompetencia;->alEVLG_IdDimension;->alEVLG_IdEje;->adEVLG_FechaLogro;->atMPA_uuidRegistro)
		: ((alEVLG_TipoObjeto{$i}=Logro_Aprendizaje) & ($at_NombreCompetencia{$i}=""))
			AT_Delete ($i;1;->$al_IdAlumnos;->$at_Status;->$ai_OrdenEje;->$ai_OrdenDimension;->$ai_OrdenCompetencia;->$at_NombreEje;->$at_NombreDimension;->$at_NombreCompetencia;->$ai_TipoEvalEje;->$ai_TipoEvalDimension;->$ai_TipoEvalCompetencia;->$al_ID_EstiloEje;->$al_ID_EstiloDimension;->$al_ID_EstiloCompetencia;->alEVLG_RecNum;->alEVLG_TipoObjeto;->atEVLG_Indicador;->arEVLG_Indicador;->atEVLG_Observacion;->alEVLG_IdCompetencia;->alEVLG_IdDimension;->alEVLG_IdEje;->adEVLG_FechaLogro;->atMPA_uuidRegistro)
	End case 
End for 

  //AT_MultiLevelSort (">>>";->$ai_OrdenEje;->$ai_OrdenDimension;->$ai_OrdenCompetencia;->$al_IdAlumnos;->$at_Status;->$at_NombreEje;->$at_NombreDimension;->$at_NombreCompetencia;->$ai_TipoEvalEje;->$ai_TipoEvalDimension;->$ai_TipoEvalCompetencia;->$al_ID_EstiloEje;->$al_ID_EstiloDimension;->$al_ID_EstiloCompetencia;->alEVLG_RecNum;->alEVLG_TipoObjeto;->atEVLG_Indicador;->arEVLG_Indicador;->atEVLG_Observacion;->alEVLG_IdCompetencia;->alEVLG_IdDimension;->alEVLG_IdEje;->adEVLG_FechaLogro)
AT_RedimArrays (Size of array:C274(alEVLG_RecNum);->alEVLG_RecNumAlumnos;->atEVLG_Competencia;->alEVLG_TipoEvaluación;->alEVLG_RefEstiloEvaluacion;->atEVLG_Muestra;->atMPA_FechaEstimada;->atMPA_FechaLogro)
xALSET_EVLG_Evaluaciones 

If (Application version:C493>="14@")
	GET PICTURE FROM LIBRARY:C565(12047;$p_imagen)
	AL_SetIcon ($l_referenciaArea;12047;$p_imagen)
	GET PICTURE FROM LIBRARY:C565(5381;$p_imagen)
	AL_SetIcon ($l_referenciaArea;5381;$p_imagen)
End if 
For ($i;1;Size of array:C274(alEVLG_RecNum))
	alEVLG_RecNumAlumnos{$i}:=Find in field:C653([Alumnos:2]numero:1;$al_IdAlumnos{$i})
	
	atMPA_FechaLogro{$i}:=Choose:C955(adEVLG_FechaLogro{$i}#!00-00-00!;String:C10(adEVLG_FechaLogro{$i};Internal date short special:K1:4);"")
	
	If (<>vb_BloquearModifSituacionFinal)
		$l_CeldaEsEditable:=0
	Else 
		$b_RegistroEditable:=(((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0)) & ($at_Status{$i}#"Retirado@") & ($at_Status{$i}#"Promovido anticipadamente@") & ($at_Status{$i}#"Egresado"))
		$b_UsuarioAutorizado:=(((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])))
		$l_CeldaEsEditable:=Num:C11($b_RegistroEditable & $b_UsuarioAutorizado)
	End if 
	
	
	
	Case of 
		: (alEVLG_TipoObjeto{$i}=Eje_Aprendizaje)
			atEVLG_Competencia{$i}:=$at_NombreEje{$i}
			alEVLG_TipoEvaluación{$i}:=$ai_TipoEvalEje{$i}
			alEVLG_RefEstiloEvaluacion{$i}:=$al_ID_EstiloEje{$i}
			$l_CeldaEsEditable:=Num:C11(($l_CeldaEsEditable=1) & ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Eje_Aprendizaje))
			
		: (alEVLG_TipoObjeto{$i}=Dimension_Aprendizaje)
			atEVLG_Competencia{$i}:=" "*2+$at_NombreDimension{$i}
			alEVLG_TipoEvaluación{$i}:=$ai_TipoEvalDimension{$i}
			alEVLG_RefEstiloEvaluacion{$i}:=$al_ID_EstiloDimension{$i}
			$l_CeldaEsEditable:=Num:C11(($l_CeldaEsEditable=1) & ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Dimension_Aprendizaje))
			
			
		: (alEVLG_TipoObjeto{$i}=Logro_Aprendizaje)
			atEVLG_Competencia{$i}:=" "*4+$at_NombreCompetencia{$i}
			alEVLG_TipoEvaluación{$i}:=$ai_TipoEvalCompetencia{$i}
			alEVLG_RefEstiloEvaluacion{$i}:=$al_ID_EstiloCompetencia{$i}
			AL_SetRowStyle (xALP_Evaluaciones;$i;0)
			AL_SetRowRGBColor (xALP_Evaluaciones;$i;0;0;0;255;255;255)
			$l_ID_Competencia:=alEVLG_IdCompetencia{$i}
	End case 
	
	$al_ID_EstiloEvaluacion:=alEVLG_RefEstiloEvaluacion{$i}
	EVS_ReadStyleData ($al_ID_EstiloEvaluacion)
	Case of 
		: (((alEVLG_TipoEvaluación{$i}=3) & (alEVLG_TipoObjeto{$i}=Logro_Aprendizaje)) | ((alEVLG_TipoEvaluación{$i}=1) & (alEVLG_TipoObjeto{$i}=Eje_Aprendizaje) & ($b_EjesIngresables)) | ((alEVLG_TipoEvaluación{$i}=1) & (alEVLG_TipoObjeto{$i}=Dimension_Aprendizaje) & ($b_dimensionesIngresables)))
			Case of 
				: (iEvaluationMode=Notas)
					atEVLG_Muestra{$i}:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
					atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Notas;iGradesDec)
					AL_SetCellEnter (xALP_Evaluaciones;2;$i;2;$i;$al_EnterableCells;$l_CeldaEsEditable)
				: (iEvaluationMode=Puntos)
					atEVLG_Muestra{$i}:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
					atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Puntos;iPointsDec)
					AL_SetCellEnter (xALP_Evaluaciones;2;$i;2;$i;$al_EnterableCells;$l_CeldaEsEditable)
				: (iEvaluationMode=Porcentaje)
					atEVLG_Muestra{$i}:=String:C10(0)+" - "+String:C10(100)
					atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Porcentaje;1)
					AL_SetCellEnter (xALP_Evaluaciones;2;$i;2;$i;$al_EnterableCells;$l_CeldaEsEditable)
				: (iEvaluationMode=Simbolos)
					If (Application version:C493>="14@")
						atEVLG_Muestra{$i}:=""
						AL_SetCellLongProperty (xALP_Evaluaciones;$i;5;ALP_Cell_RightIconID;12047)
					Else 
						atEVLG_Muestra{$i}:=Char:C90(160)+"^"+String:C10(Use PicRef:K28:4+12047)
					End if 
					atEVLG_Indicador{$i}:=EV2_Real_a_Literal (arEVLG_Indicador{$i};Simbolos)
					AL_SetCellEnter (xALP_Evaluaciones;2;$i;2;$i;$al_EnterableCells;$l_CeldaEsEditable)
			End case 
		: ((alEVLG_TipoEvaluación{$i}=1) & (alEVLG_TipoObjeto{$i}=Logro_Aprendizaje))
			If (Application version:C493>="14@")
				atEVLG_Muestra{$i}:=""
				AL_SetCellLongProperty (xALP_Evaluaciones;$i;5;ALP_Cell_RightIconID;12047)
			Else 
				atEVLG_Muestra{$i}:=Char:C90(160)+"^"+String:C10(Use PicRef:K28:4+12047)
			End if 
			AL_SetCellEnter (xALP_Evaluaciones;2;$i;2;$i;$al_EnterableCells;$l_CeldaEsEditable)
		Else 
			If (Application version:C493>="14@")
				atEVLG_Muestra{$i}:=""
				AL_SetCellLongProperty (xALP_Evaluaciones;$i;5;ALP_Cell_RightIconID;5381)
			Else 
				atEVLG_Muestra{$i}:=Char:C90(160)+"^"+String:C10(Use PicRef:K28:4+5381)
			End if 
			AL_SetCellEnter (xALP_Evaluaciones;2;$i;2;$i;$al_EnterableCells;$l_CeldaEsEditable)
	End case 
	
	
	
End for 
If (vlEVLG_mostrarObservacion=0)
	AL_SetEnterable (xALP_Evaluaciones;3;0)
Else 
	If ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado")
		AL_SetEnterable (xALP_Evaluaciones;3;1)
	Else 
		AL_SetEnterable (xALP_Evaluaciones;3;0)
	End if 
End if 
AL_UpdateArrays (xALP_Evaluaciones;-2)
AL_SetSort (xALP_Evaluaciones;1)

MPA_AparienciaEvaluaciones (xALP_Evaluaciones)

AL_SetLine (xALP_Evaluaciones;1)
$l_recNum:=alEVLG_RecNumAlumnos{1}
EVLG_DatosAlumno ($l_recNum)


