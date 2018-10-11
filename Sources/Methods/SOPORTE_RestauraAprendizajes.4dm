//%attributes = {}
  // SOPORTE_RestauraAprendizajes()
  //
  // Descripción
  // Lee el archivo de datos exportado desde otra base de datos con el método SOPORTE_ExportaAprendizajes
  // - Verifica si el registro de evaluación de aprendizajes existe en la base de datos
  // - Si el registro existe actualiza las evaluaciones sólo cuando la evaluación no existía (jamás se sobreescribe una evaluación existente)
  // - Si el registro no existe, se crea (solo si la asignatura el alumno y la definición del enunciado existen)
  // Este método debe ser utilizado cuando se requiere restaurar registros de evaluyación de aprendizajes perdidos por alguna razón
  // Al final del método se llama a MPAdbu_ReconstruyeMatrices, actualizando las matrices en función de los atributos de los registros de evaluación de aprendizajes
  // En el centro de notificaciones de mostrará la lista de los registros actualizados o creados
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 14/12/12, 10:34:02
  // ---------------------------------------------
C_BOOLEAN:C305($b_guardar)
C_LONGINT:C283($i;$l_año;$l_bitPeriodos;$l_idAlumno;$l_IdAsignatura;$l_IdCompetencia;$l_IdDimension;$l_IdEje;$l_IdMatriz;$l_IdProceso)
C_LONGINT:C283($l_nivel;$l_recNumAlumno;$l_recNumAsignatura;$l_recNumDefinicion;$l_recNumMatriz;$l_registros;$l_TipoObjeto)
C_TIME:C306($h_refArchivo)
C_REAL:C285($r_FINAL_nativoNumerico;$r_FINAL_nativoReal;$r_P01_nativoNumerico;$r_P01_nativoReal;$r_P02_nativoNumerico;$r_P02_nativoReal;$r_P03_nativoNumerico;$r_P03_nativoReal;$r_P04_nativoNumerico;$r_P04_nativoReal)
C_REAL:C285($r_P05_nativoNumerico;$r_P05_nativoReal)
C_TEXT:C284($t_competencia;$t_contenidoTexto;$t_descripcion;$t_Encabezado;$t_FINAL_FinalLiteral;$t_FINAL_indicador;$t_FINAL_observaciones;$t_llaveAlumno;$t_llaveAprendizajes;$t_llaveAsignatura)
C_TEXT:C284($t_llaveCalificaciones;$t_P01_FinalLiteral;$t_P01_indicador;$t_P01_observaciones;$t_P02_FinalLiteral;$t_P02_indicador;$t_P02_observaciones;$t_P03_FinalLiteral;$t_P03_indicador;$t_P03_observaciones)
C_TEXT:C284($t_P04_FinalLiteral;$t_P04_indicador;$t_P04_observaciones;$t_P05_FinalLiteral;$t_P05_indicador;$t_P05_observaciones;$t_record;$t_refAsignatura;$t_separadorColumnas;$t_separadorFilas)
C_TEXT:C284($t_uuid)

ARRAY LONGINT:C221(al_Colores;0)
ARRAY LONGINT:C221(al_estilos;0)
ARRAY LONGINT:C221(al_recNumAsignaturas;0)
ARRAY TEXT:C222(at_Asignatura;0)
ARRAY TEXT:C222(at_errores;0)
ARRAY TEXT:C222(at_TitulosColumnas;0)

  // CODIGO
<>vb_ImportHistoricos_STX:=True:C214
$t_separadorFilas:=Char:C90(Carriage return:K15:38)
$t_separadorColumnas:=Char:C90(Tab:K15:37)
$h_refArchivo:=Open document:C264("";"TEXT";Read mode:K24:5)
RECEIVE PACKET:C104($h_refArchivo;$t_record;$t_separadorFilas)
$l_registros:=Num:C11($t_record)
$l_IdProceso:=IT_Progress (1;0;0;"Restaurando evaluaciones en 1er semestre")
$i:=0
RECEIVE PACKET:C104($h_refArchivo;$t_record;$t_separadorFilas)
While ($t_record#"")
	$i:=$i+1
	$t_llaveAprendizajes:=ST_GetWord ($t_record;1;$t_separadorColumnas)
	$l_año:=Num:C11(ST_GetWord ($t_record;2;$t_separadorColumnas))
	$l_IdAsignatura:=Num:C11(ST_GetWord ($t_record;3;$t_separadorColumnas))
	$l_idAlumno:=Num:C11(ST_GetWord ($t_record;4;$t_separadorColumnas))
	$l_IdMatriz:=Num:C11(ST_GetWord ($t_record;5;$t_separadorColumnas))
	$l_nivel:=Num:C11(ST_GetWord ($t_record;6;$t_separadorColumnas))
	$l_IdEje:=Num:C11(ST_GetWord ($t_record;7;$t_separadorColumnas))
	$l_IdDimension:=Num:C11(ST_GetWord ($t_record;8;$t_separadorColumnas))
	$l_IdCompetencia:=Num:C11(ST_GetWord ($t_record;9;$t_separadorColumnas))
	$t_llaveAlumno:=ST_GetWord ($t_record;10;$t_separadorColumnas)
	$t_llaveAsignatura:=ST_GetWord ($t_record;11;$t_separadorColumnas)
	$t_llaveCalificaciones:=ST_GetWord ($t_record;12;$t_separadorColumnas)
	$l_TipoObjeto:=Num:C11(ST_GetWord ($t_record;13;$t_separadorColumnas))
	$l_bitPeriodos:=Num:C11(ST_GetWord ($t_record;14;$t_separadorColumnas))
	
	$t_P01_FinalLiteral:=ST_GetWord ($t_record;15;$t_separadorColumnas)
	$t_P01_indicador:=ST_GetWord ($t_record;16;$t_separadorColumnas)
	$r_P01_nativoNumerico:=Num:C11(ST_GetWord ($t_record;17;$t_separadorColumnas))
	$r_P01_nativoReal:=Num:C11(ST_GetWord ($t_record;18;$t_separadorColumnas))
	$t_P01_observaciones:=ST_GetWord ($t_record;19;$t_separadorColumnas)
	
	$t_P02_FinalLiteral:=ST_GetWord ($t_record;20;$t_separadorColumnas)
	$t_P02_indicador:=ST_GetWord ($t_record;21;$t_separadorColumnas)
	$r_P02_nativoNumerico:=Num:C11(ST_GetWord ($t_record;22;$t_separadorColumnas))
	$r_P02_nativoReal:=Num:C11(ST_GetWord ($t_record;23;$t_separadorColumnas))
	$t_P02_observaciones:=ST_GetWord ($t_record;24;$t_separadorColumnas)
	
	$t_P03_FinalLiteral:=ST_GetWord ($t_record;25;$t_separadorColumnas)
	$t_P03_indicador:=ST_GetWord ($t_record;26;$t_separadorColumnas)
	$r_P03_nativoNumerico:=Num:C11(ST_GetWord ($t_record;27;$t_separadorColumnas))
	$r_P03_nativoReal:=Num:C11(ST_GetWord ($t_record;28;$t_separadorColumnas))
	$t_P03_observaciones:=ST_GetWord ($t_record;29;$t_separadorColumnas)
	
	$t_P04_FinalLiteral:=ST_GetWord ($t_record;30;$t_separadorColumnas)
	$t_P04_indicador:=ST_GetWord ($t_record;31;$t_separadorColumnas)
	$r_P04_nativoNumerico:=Num:C11(ST_GetWord ($t_record;32;$t_separadorColumnas))
	$r_P04_nativoReal:=Num:C11(ST_GetWord ($t_record;33;$t_separadorColumnas))
	$t_P04_observaciones:=ST_GetWord ($t_record;34;$t_separadorColumnas)
	
	$t_P05_FinalLiteral:=ST_GetWord ($t_record;35;$t_separadorColumnas)
	$t_P05_indicador:=ST_GetWord ($t_record;36;$t_separadorColumnas)
	$r_P05_nativoNumerico:=Num:C11(ST_GetWord ($t_record;37;$t_separadorColumnas))
	$r_P05_nativoReal:=Num:C11(ST_GetWord ($t_record;38;$t_separadorColumnas))
	$t_P05_observaciones:=ST_GetWord ($t_record;39;$t_separadorColumnas)
	
	$t_FINAL_FinalLiteral:=ST_GetWord ($t_record;40;$t_separadorColumnas)
	$t_FINAL_indicador:=ST_GetWord ($t_record;41;$t_separadorColumnas)
	$r_FINAL_nativoNumerico:=Num:C11(ST_GetWord ($t_record;42;$t_separadorColumnas))
	$r_FINAL_nativoReal:=Num:C11(ST_GetWord ($t_record;43;$t_separadorColumnas))
	$t_FINAL_observaciones:=ST_GetWord ($t_record;44;$t_separadorColumnas)
	
	$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura)
	$l_recNumAlumno:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_IdAsignatura)
	$l_recNumMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IdMatriz)
	Case of 
		: ($l_TipoObjeto=Logro_Aprendizaje)
			$l_recNumDefinicion:=KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionCompetencias:187]ID:1;->$l_IdCompetencia)
		: ($l_TipoObjeto=Dimension_Aprendizaje)
			$l_recNumDefinicion:=KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->$l_IdDimension)
		: ($l_TipoObjeto=Eje_Aprendizaje)
			$l_recNumDefinicion:=KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->$l_IdEje)
	End case 
	
	If (($l_recNumAsignatura>=0) & ($l_recNumAlumno>=0) & ($l_recNumDefinicion>=0) & ($l_recNumMatriz>=0))
		READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Key:8;=;$t_llaveAprendizajes)
		
		$b_guardar:=False:C215
		If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])=0)
			CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
			[Alumnos_EvaluacionAprendizajes:203]Key:8:=$t_llaveAprendizajes
			[Alumnos_EvaluacionAprendizajes:203]Año:77:=$l_año
			[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=$l_IdAsignatura
			[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=$l_idAlumno
			[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=$l_IdMatriz
			[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91:=$l_nivel
			[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=$l_IdEje
			[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=$l_IdDimension
			[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=$l_IdCompetencia
			[Alumnos_EvaluacionAprendizajes:203]LlaveAlumno:92:=$t_llaveAlumno
			[Alumnos_EvaluacionAprendizajes:203]LlaveAsignatura:93:=$t_llaveAsignatura
			[Alumnos_EvaluacionAprendizajes:203]LLaveCalificaciones:76:=$t_llaveCalificaciones
			[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=$l_TipoObjeto
			[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=$l_bitPeriodos
			
			[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=$t_P01_FinalLiteral
			[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=$t_P01_indicador
			[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=$r_P01_nativoNumerico
			[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=$r_P01_nativoReal
			[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=$t_P01_observaciones
			
			[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=$t_P02_FinalLiteral
			[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=$t_P02_indicador
			[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=$r_P02_nativoNumerico
			[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=$r_P02_nativoReal
			[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=$t_P02_observaciones
			
			[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=$t_P03_FinalLiteral
			[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=$t_P03_indicador
			[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=$r_P03_nativoNumerico
			[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=$r_P03_nativoReal
			[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=$t_P03_observaciones
			
			[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=$t_P04_FinalLiteral
			[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=$t_P04_indicador
			[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=$r_P04_nativoNumerico
			[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=$r_P04_nativoReal
			[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82:=$t_P04_observaciones
			
			[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66:=$t_P05_FinalLiteral
			[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=$t_P05_indicador
			[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=$r_P05_nativoNumerico
			[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=$r_P05_nativoReal
			[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83:=$t_P05_observaciones
			
			[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_FINAL_FinalLiteral
			[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_FINAL_indicador
			[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_FINAL_nativoNumerico
			[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_FINAL_nativoReal
			[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_FINAL_observaciones
			
			SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
			$b_guardar:=True:C214
		Else 
			
			If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13="") & ($t_P01_FinalLiteral#""))
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=$t_P01_FinalLiteral
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=$t_P01_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=$r_P01_nativoNumerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=$r_P01_nativoReal
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=$t_P01_observaciones
				If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>1) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 1)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 1
				End if 
				[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?+ 1
				$b_guardar:=True:C214
			End if 
			
			If (([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25="") & ($t_P02_FinalLiteral#""))
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=$t_P02_FinalLiteral
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=$t_P02_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=$r_P02_nativoNumerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=$r_P02_nativoReal
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=$t_P02_observaciones
				If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>2) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 2)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 2
				End if 
				[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?+ 2
				$b_guardar:=True:C214
			End if 
			
			If (([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37="") & ($t_P03_FinalLiteral#""))
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=$t_P03_FinalLiteral
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=$t_P03_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=$r_P03_nativoNumerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=$r_P03_nativoReal
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=$t_P03_observaciones
				If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>3) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 3)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 3
				End if 
				[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?+ 3
				$b_guardar:=True:C214
			End if 
			
			If (([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49="") & ($t_P04_FinalLiteral#""))
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=$t_P04_FinalLiteral
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=$t_P04_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=$r_P04_nativoNumerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=$r_P04_nativoReal
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82:=$t_P04_observaciones
				If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>4) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 4)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 4
				End if 
				[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?+ 4
				$b_guardar:=True:C214
			End if 
			
			If (([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66="") & ($t_P05_FinalLiteral#""))
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66:=$t_P05_FinalLiteral
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=$t_P05_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=$r_P05_nativoNumerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=$r_P05_nativoReal
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83:=$t_P05_observaciones
				If (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10>5) & (Not:C34([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 5)))
					[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?+ 5
				End if 
				[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?+ 5
				$b_guardar:=True:C214
			End if 
			
			If (([Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61="") & ($t_FINAL_FinalLiteral#""))
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_FINAL_FinalLiteral
				[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_FINAL_indicador
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_FINAL_nativoNumerico
				[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_FINAL_nativoReal
				[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_FINAL_observaciones
				$b_guardar:=True:C214
				[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63:=[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?+ 0
			End if 
		End if 
		
		If ($b_guardar)
			Case of 
				: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
					$t_competencia:="{Competencia} "+KRL_GetTextFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;->[MPA_DefinicionCompetencias:187]Competencia:6)
				: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
					$t_competencia:="{Dimension} "+KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[MPA_DefinicionDimensiones:188]Dimensión:4)
				: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
					$t_competencia:="{Eje} "+KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[MPA_DefinicionEjes:185]Nombre:3)
			End case 
			KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
			$t_refAsignatura:="["+String:C10([Asignaturas:18]Numero:1;"000000")+"]"+[Asignaturas:18]denominacion_interna:16+","+[Asignaturas:18]Curso:5+": "+$t_competencia
			If (Find in array:C230(at_Asignatura;$t_refAsignatura)<0)
				APPEND TO ARRAY:C911(at_Asignatura;$t_refAsignatura)
				APPEND TO ARRAY:C911(at_errores;"Evaluaciones faltantes restauradas")
				APPEND TO ARRAY:C911(al_estilos;0)
				APPEND TO ARRAY:C911(al_Colores;Green:K11:9)
				APPEND TO ARRAY:C911(al_recNumAsignaturas;Record number:C243([Asignaturas:18]))
			End if 
			SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
		End if 
	End if 
	$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/$l_registros;"Restaurando evaluaciones de aprendizajes")
	RECEIVE PACKET:C104($h_refArchivo;$t_record;$t_separadorFilas)
End while 
$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
<>vb_ImportHistoricos_STX:=False:C215

KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])

If (Size of array:C274(at_errores)>0)
	MESSAGES ON:C181
	FLUSH CACHE:C297
	
	SORT ARRAY:C229(at_Asignatura;at_errores;al_estilos;al_Colores;>)
	
	APPEND TO ARRAY:C911(at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911(at_TitulosColumnas;"Asignatura/Competencia")
	
	$t_Encabezado:="Restauracion de evaluaciones faltantes"
	$t_descripcion:="Se restauraron evaluaciones del 1er semestre que se habían perdido debido a un defecto en la aplicación"
	$t_descripcion:=$t_descripcion+"Las evaluaciones fueron rescatadas desde una copia anterior de la base de datos\r"
	$t_descripcion:=$t_descripcion+"Sólo se restauraron evaluaciones que no existían en esta base de datos.\r\r"
	$t_descripcion:=$t_descripcion+"La lista de asignaturas/competencias con evaluaciones restauradas es la siguiente:\r"
	$t_contenidoTexto:=""
	
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->at_TitulosColumnas;->at_errores;->at_Asignatura)
	NTC_Mensaje_EstilosColores ($t_uuid;->al_estilos;->al_Colores)
	NTC_Mensaje_DatosExplorador ($t_uuid;"SchoolTrack";Table:C252(->[Asignaturas:18]);->al_recNumAsignaturas)
	
End if 

