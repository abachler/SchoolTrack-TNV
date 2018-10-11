//%attributes = {}
  // Método: UD_v20170710_SimbolosMapas
  //
  //
  // por Alberto Bachler Klein
  // creación 10/07/17, 11:36:49
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($i_registros;$l_idAlumno;$l_idAsignatura;$l_progress;$l_recNumCompetencia;$l_registros)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_asunto;$t_copia;$t_copiaCC;$t_Cuerpo;$t_destinatario;$t_error;$t_rutaArchivo;$t_simbolo;$t_versionBaseDeDatos;$t_versionEstructura)

ARRAY LONGINT:C221($al_idCompetencia;0)
ARRAY LONGINT:C221($al_Periodo;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY POINTER:C280($ay_columnas;0)
ARRAY REAL:C219($ar_realCorregido;0)
ARRAY REAL:C219($ar_realF;0)
ARRAY REAL:C219($ar_realP1;0)
ARRAY REAL:C219($ar_realP2;0)
ARRAY REAL:C219($ar_realP3;0)
ARRAY REAL:C219($ar_realP4;0)
ARRAY REAL:C219($ar_realP5;0)
ARRAY REAL:C219($ar_RealRegistrado;0)
ARRAY TEXT:C222($at_adjuntos;0)
ARRAY TEXT:C222($at_alumno;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_competencia;0)
ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_estilosFuleros;0)
ARRAY TEXT:C222($at_simboloF;0)
ARRAY TEXT:C222($at_simboloP1;0)
ARRAY TEXT:C222($at_simboloP2;0)
ARRAY TEXT:C222($at_simboloP3;0)
ARRAY TEXT:C222($at_simboloP4;0)
ARRAY TEXT:C222($at_simboloP5;0)
ARRAY TEXT:C222($at_simboloRegistrado;0)

<>vb_ImportHistoricos_STX:=True:C214

ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
CREATE EMPTY SET:C140([xxSTR_EstilosEvaluacion:44];"$enSimbolos")

$y_tabla:=->[xxSTR_EstilosEvaluacion:44]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
READ ONLY:C145($y_tabla->)
For ($i_registros;1;Records in selection:C76($y_tabla->))
	GOTO RECORD:C242($y_tabla->;$al_recNums{$i_registros})
	EVS_ReadStyleData ([xxSTR_EstilosEvaluacion:44]ID:1)
	If (iEvaluationMode=Simbolos)
		ADD TO SET:C119([xxSTR_EstilosEvaluacion:44];"$enSimbolos")
	End if 
End for 


USE SET:C118("$enSimbolos")

KRL_RelateSelection (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->[xxSTR_EstilosEvaluacion:44]ID:1)
KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;->[MPA_DefinicionCompetencias:187]ID:1)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>GYEAR;*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID:90;>;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;>)

SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];$al_recNums;[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13;$at_simboloP1;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11;$ar_realP1;[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25;$at_simboloP2;[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23;$ar_realP2;[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37;$at_simboloP3;[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35;$ar_realP3;[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49;$at_simboloP4;[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47;$ar_realP4;[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66;$at_simboloP5;[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64;$ar_realP5;[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61;$at_simboloF;[Alumnos_EvaluacionAprendizajes:203]Final_Real:59;$ar_realF;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;$al_idCompetencia)

$l_progress:=Progress New 
Progress SET TITLE ($l_progress;"Verificando equivalencias símbolos-numéricos…";0;"en registros de evaluación de aprendizajes…")
Progress SET ICON ($l_progress;<>p_iconoColegium)
$l_registros:=Size of array:C274($al_recNums)
$y_tabla:=->[Alumnos_EvaluacionAprendizajes:203]
For ($i_registros;1;$l_registros)
	
	
	
	$b_guardarRegistro:=False:C215
	GOTO RECORD:C242($y_tabla->;$al_recNums{$i_registros})
	$l_recNumCompetencia:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
	$l_idAlumno:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
	$l_idAsignatura:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
	
	If ($l_recNumCompetencia>No current record:K29:2)
		READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
		GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$l_recNumCompetencia)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_idAsignatura)
		EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
		
		
		$t_simbolo:=EV2_Real_a_Literal ($ar_realP1{$i_registros};Simbolos)
		If ($t_simbolo#$at_simboloP1{$i_registros})
			[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=EV2_Simbolo_a_Real ($at_simboloP1{$i_registros})
			$b_guardarRegistro:=True:C214
			APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
			APPEND TO ARRAY:C911($at_asignaturas;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]Asignatura:3))
			APPEND TO ARRAY:C911($at_alumno;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]apellidos_y_nombres:40))
			APPEND TO ARRAY:C911($at_competencia;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($al_Periodo;1)
			APPEND TO ARRAY:C911($ar_RealRegistrado;$ar_realP1{$i_registros})
			APPEND TO ARRAY:C911($at_simboloRegistrado;$at_simboloP1{$i_registros})
			APPEND TO ARRAY:C911($ar_realCorregido;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11)
		End if 
		
		$t_simbolo:=EV2_Real_a_Literal ($ar_realP2{$i_registros};Simbolos)
		If ($t_simbolo#$at_simboloP2{$i_registros})
			[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=EV2_Simbolo_a_Real ($at_simboloP2{$i_registros})
			$b_guardarRegistro:=True:C214
			APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
			APPEND TO ARRAY:C911($at_asignaturas;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]Asignatura:3))
			APPEND TO ARRAY:C911($at_alumno;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]apellidos_y_nombres:40))
			APPEND TO ARRAY:C911($at_competencia;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($al_Periodo;2)
			APPEND TO ARRAY:C911($ar_RealRegistrado;$ar_realP2{$i_registros})
			APPEND TO ARRAY:C911($at_simboloRegistrado;$at_simboloP2{$i_registros})
			APPEND TO ARRAY:C911($ar_realCorregido;[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23)
		End if 
		
		
		$t_simbolo:=EV2_Real_a_Literal ($ar_realP3{$i_registros};Simbolos)
		If ($t_simbolo#$at_simboloP3{$i_registros})
			[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=EV2_Simbolo_a_Real ($at_simboloP3{$i_registros})
			$b_guardarRegistro:=True:C214
			APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
			APPEND TO ARRAY:C911($at_asignaturas;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]Asignatura:3))
			APPEND TO ARRAY:C911($at_alumno;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]apellidos_y_nombres:40))
			APPEND TO ARRAY:C911($at_competencia;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($al_Periodo;3)
			APPEND TO ARRAY:C911($ar_RealRegistrado;$ar_realP3{$i_registros})
			APPEND TO ARRAY:C911($at_simboloRegistrado;$at_simboloP3{$i_registros})
			APPEND TO ARRAY:C911($ar_realCorregido;[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35)
		End if 
		
		$t_simbolo:=EV2_Real_a_Literal ($ar_realP4{$i_registros};Simbolos)
		If ($t_simbolo#$at_simboloP4{$i_registros})
			[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=EV2_Simbolo_a_Real ($at_simboloP4{$i_registros})
			$b_guardarRegistro:=True:C214
			APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
			APPEND TO ARRAY:C911($at_asignaturas;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]Asignatura:3))
			APPEND TO ARRAY:C911($at_alumno;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]apellidos_y_nombres:40))
			APPEND TO ARRAY:C911($at_competencia;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($al_Periodo;4)
			APPEND TO ARRAY:C911($ar_RealRegistrado;$ar_realP4{$i_registros})
			APPEND TO ARRAY:C911($at_simboloRegistrado;$at_simboloP4{$i_registros})
			APPEND TO ARRAY:C911($ar_realCorregido;[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47)
		End if 
		
		$t_simbolo:=EV2_Real_a_Literal ($ar_realP5{$i_registros};Simbolos)
		If ($t_simbolo#$at_simboloP5{$i_registros})
			[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=EV2_Simbolo_a_Real ($at_simboloP5{$i_registros})
			$b_guardarRegistro:=True:C214
			APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
			APPEND TO ARRAY:C911($at_asignaturas;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]Asignatura:3))
			APPEND TO ARRAY:C911($at_alumno;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]apellidos_y_nombres:40))
			APPEND TO ARRAY:C911($at_competencia;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($al_Periodo;5)
			APPEND TO ARRAY:C911($ar_RealRegistrado;$ar_realP5{$i_registros})
			APPEND TO ARRAY:C911($at_simboloRegistrado;$at_simboloP5{$i_registros})
			APPEND TO ARRAY:C911($ar_realCorregido;[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64)
		End if 
		
		$t_simbolo:=EV2_Real_a_Literal ($ar_realF{$i_registros};Simbolos)
		If ($t_simbolo#$at_simboloF{$i_registros})
			[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=EV2_Simbolo_a_Real ($at_simboloF{$i_registros})
			$b_guardarRegistro:=True:C214
			APPEND TO ARRAY:C911($at_estilosFuleros;[xxSTR_EstilosEvaluacion:44]Name:2)
			APPEND TO ARRAY:C911($at_asignaturas;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]Asignatura:3))
			APPEND TO ARRAY:C911($at_alumno;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]apellidos_y_nombres:40))
			APPEND TO ARRAY:C911($at_competencia;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($al_Periodo;0)
			APPEND TO ARRAY:C911($ar_RealRegistrado;$ar_realF{$i_registros})
			APPEND TO ARRAY:C911($at_simboloRegistrado;$at_simboloF{$i_registros})
			APPEND TO ARRAY:C911($ar_realCorregido;[Alumnos_EvaluacionAprendizajes:203]Final_Real:59)
		End if 
		
		  //verifico la fecha de aprobación y corrijo cuando es necesario
		$l_periodoAprobacion:=0
		$r_minimoAdquisicion:=[MPA_DefinicionCompetencias:187]PctParaAprobacion:22
		If ($r_minimoAdquisicion>0)
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
			[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63
			Case of 
				: (([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11>=$r_minimoAdquisicion) & ([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?? 1))
					[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=Choose:C955(([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89=!00-00-00!) | ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>adSTR_Periodos_Hasta{1});adSTR_Periodos_Hasta{1};[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89)
					$l_periodoAprobacion:=1
				: (([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23>=$r_minimoAdquisicion) & ([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?? 2))
					[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=Choose:C955(([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89=!00-00-00!) | ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>adSTR_Periodos_Hasta{2});adSTR_Periodos_Hasta{2};[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89)
					$l_periodoAprobacion:=2
				: (([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35>=$r_minimoAdquisicion) & ([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?? 3))
					[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=Choose:C955(([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89=!00-00-00!) | ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>adSTR_Periodos_Hasta{3});adSTR_Periodos_Hasta{3};[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89)
					$l_periodoAprobacion:=3
				: (([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47>=$r_minimoAdquisicion) & ([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?? 4))
					[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=Choose:C955(([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89=!00-00-00!) | ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>adSTR_Periodos_Hasta{4});adSTR_Periodos_Hasta{4};[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89)
					$l_periodoAprobacion:=4
				: (([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64>=$r_minimoAdquisicion) & ([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?? 5))
					[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=Choose:C955(([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89=!00-00-00!) | ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>adSTR_Periodos_Hasta{5});adSTR_Periodos_Hasta{5};[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89)
					$l_periodoAprobacion:=5
				: (([Alumnos_EvaluacionAprendizajes:203]Final_Real:59>=$r_minimoAdquisicion) & ([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?? 0))
					[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=Choose:C955(([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89=!00-00-00!);vdSTR_Periodos_FinEjercicio;[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89)
			End case 
			
			If ($l_periodoAprobacion>0)
				  // si la comptencia fue adquirida y la opción de aprobación y reporte fue establecida la reporto hacia adelante en los períodos siguientes
				  // SOLO SI NO HAY evaluaciones registradas en esos períodos
				Case of 
					: ($l_periodoAprobacion=1)
						$r_real:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
						$t_nativoLiteral:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
						$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
						$r_nativoNumerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
						$t_nivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NivelLogroEnunciado:16
						$l_IdNivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NivelLogroID:15
						$t_Observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
						
					: ($l_periodoAprobacion=2)
						$r_real:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
						$t_nativoLiteral:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
						$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
						$r_nativoNumerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
						$t_nivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroEnunciado:28
						$l_IdNivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroID:27
						$t_Observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
						
					: ($l_periodoAprobacion=3)
						$r_real:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
						$t_nativoLiteral:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
						$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
						$r_nativoNumerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
						$t_nivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroEnunciado:40
						$l_IdNivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroID:39
						$t_Observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
						
					: ($l_periodoAprobacion=4)
						$r_real:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
						$t_nativoLiteral:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
						$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
						$r_nativoNumerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
						$t_nivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroEnunciado:52
						$l_IdNivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroID:51
						$t_Observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82
						
					: ($l_periodoAprobacion=5)
						$r_real:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
						$t_nativoLiteral:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
						$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
						$r_nativoNumerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
						$t_nivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroEnunciado:69
						$l_IdNivelLogro:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroID:68
						$t_Observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
				End case 
				
				
				For ($l_periodos;$l_periodoAprobacion+1;viSTR_Periodos_NumeroPeriodos)
					Case of 
						: (($l_periodos=2) & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23=-10))
							[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=$r_real
							[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=$t_nativoLiteral
							[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=$t_indicador
							[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=$r_nativoNumerico
							[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroEnunciado:28:=$t_nivelLogro
							[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroID:27:=$l_IdNivelLogro
							[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=$t_Observaciones
							[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 2
							$b_guardarRegistro:=True:C214
							
						: (($l_periodos=3) & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35=-10))
							[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=$r_real
							[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=$t_nativoLiteral
							[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=$t_indicador
							[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=$r_nativoNumerico
							[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroEnunciado:40:=$t_nivelLogro
							[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroID:39:=$l_IdNivelLogro
							[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=$t_Observaciones
							[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 3
							$b_guardarRegistro:=True:C214
							
						: (($l_periodos=4) & ([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47=-10))
							[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=$r_real
							[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=$t_nativoLiteral
							[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=$t_indicador
							[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=$r_nativoNumerico
							[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroEnunciado:52:=$t_nivelLogro
							[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroID:51:=$l_IdNivelLogro
							[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82:=$t_Observaciones
							[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 4
							$b_guardarRegistro:=True:C214
							
						: (($l_periodos=5) & ([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64=-10))
							[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=$r_real
							[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66:=$t_nativoLiteral
							[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=$t_indicador
							[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=$r_nativoNumerico
							[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroEnunciado:69:=$t_nivelLogro
							[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroID:68:=$l_IdNivelLogro
							[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83:=$t_Observaciones
							[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 5
							$b_guardarRegistro:=True:C214
					End case 
				End for 
				
				If ([Alumnos_EvaluacionAprendizajes:203]Final_Real:59=-10)
					[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_real
					[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_nativoLiteral
					[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_indicador
					[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_nativoNumerico
					[Alumnos_EvaluacionAprendizajes:203]Final_NivelLogroEnunciado:102:=$t_nivelLogro
					[Alumnos_EvaluacionAprendizajes:203]Final_NivelLogroID:103:=$l_IdNivelLogro
					[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_Observaciones
					[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 0
				End if 
				
			Else 
				[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=0
			End if 
			
		Else 
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!
			[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=0
		End if 
		
		
		If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89#Old:C35([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89))
			$b_guardarRegistro:=True:C214
		End if 
		If ($b_guardarRegistro)
			SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
		End if 
	End if 
	Progress SET PROGRESS ($l_progress;$i_registros/$l_registros)
End for 
Progress QUIT ($l_progress)


If (Size of array:C274($at_estilosFuleros)>0)
	AT_AppendItems2TextArray (->$at_encabezados;"Estilo evaluación";"Asignatura";"Alumno";"Competencia";"Periodo";"Simbolo";"Real Registrado";"Real corregido")
	APPEND TO ARRAY:C911($ay_columnas;->$at_estilosFuleros)
	APPEND TO ARRAY:C911($ay_columnas;->$at_asignaturas)
	APPEND TO ARRAY:C911($ay_columnas;->$at_alumno)
	APPEND TO ARRAY:C911($ay_columnas;->$at_competencia)
	APPEND TO ARRAY:C911($ay_columnas;->$al_Periodo)
	APPEND TO ARRAY:C911($ay_columnas;->$at_simboloRegistrado)
	APPEND TO ARRAY:C911($ay_columnas;->$ar_RealRegistrado)
	APPEND TO ARRAY:C911($ay_columnas;->$ar_realCorregido)
	
	MULTI SORT ARRAY:C718($at_alumno;>;$at_asignaturas;>;$at_competencia;>;$at_estilosFuleros;>;$al_Periodo;>;$at_simboloRegistrado;$ar_RealRegistrado;$ar_realCorregido)
	$t_rutaArchivo:=Get 4D folder:C485(Logs folder:K5:19)+"Ajuste de equivalencias simbolos-real en aprendizajes.xls"
	XLS_GeneraArchivo ($t_rutaArchivo;"";"";->$at_encabezados;->$ay_columnas)
	APPEND TO ARRAY:C911($at_adjuntos;$t_rutaArchivo)
	
	$t_asunto:="Ajuste de equivalencias símbolos-reales en registros de evaluaciones de aprendizaje ["+<>gCustom+"]"
	$t_Cuerpo:="Durante la actualización a la versión ^2 se detectaron y corrigieron inconsistencias en las equivalencias de simbolos en evaluaciones de aprendizaje."
	$t_Cuerpo:=$t_Cuerpo+"\r\rEl documento adjunto contiene información detallada de todas las correcciones realizadas."
	$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("Nombre del computador: ")+Current machine:C483
	$t_Cuerpo:=$t_Cuerpo+"\r"+__ ("Nombre del usuario activo: ")+Current system user:C484
	$t_Cuerpo:=$t_Cuerpo+"\r"+__ ("Ruta de la base de datos: \r")+Data file:C490
	$t_asunto:=Replace string:C233($t_asunto;"^2";$t_versionEstructura)
	$t_Cuerpo:=Replace string:C233($t_Cuerpo;"^1";$t_versionBaseDeDatos)
	$t_Cuerpo:=Replace string:C233($t_Cuerpo;"^2";$t_versionEstructura)
	$t_destinatario:="laravena@colegium.com"
	$t_copia:="qa@colegium.com"
	$t_copiaCC:="abachler@colegium.com,rcatalan@colegium.com,abustamante@colegium.com"
	$t_error:=Mail_EnviaNotificacion ($t_asunto;$t_Cuerpo;$t_destinatario;$t_copia;$t_copiaCC;->$at_adjuntos;__ ("Enviando informe de actualización a Colegium..."))
	
End if 
<>vb_ImportHistoricos_STX:=False:C215



