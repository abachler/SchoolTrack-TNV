//%attributes = {}
  // MÉTODO: MPA_Calculos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/11/11, 09:37:31
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_Calculos()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_PromediosModificados)
C_LONGINT:C283($l_IDAlumno;$l_IdAsignatura;$l_IdDimension;$l_IdEje;$l_item;$l_Periodo;$l_RecNum;$l_recNumDimension;$l_recNumEje;$l_tipoObjeto)
C_POINTER:C301($y_punteroDescriptor;$y_punteroLiteral;$y_punteroNumerico;$y_punteroReal)
C_REAL:C285($vr_Numerico;$vr_Real)
C_TEXT:C284($vt_Descriptor;$vt_Literal)

If (False:C215)
	C_LONGINT:C283(MPA_Calculos ;$1)
	C_LONGINT:C283(MPA_Calculos ;$2)
End if 



$vr_Numerico:=0
$vr_Real:=0
$vt_Literal:=""
$vt_Descriptor:=""
$l_RecNum:=$1
$l_Periodo:=$2
vb_ActualizaEnPlanilla:=True:C214
If (Record number:C243([Alumnos_EvaluacionAprendizajes:203])#$l_RecNum)
	KRL_LoadRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_RecNum)
End if 
If ([MPA_AsignaturasMatrices:189]ID_Matriz:1#[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
	KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;False:C215)
End if 

If (([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje) | ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10>=Dimension_Aprendizaje) | ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23>=Eje_Aprendizaje))
	
	  // según el período creo punteros sobre los campos en los que se amalcena el resultado de los cálculos
	Case of 
		: ($l_Periodo=1)
			$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
			$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
			$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
			$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
		: ($l_Periodo=2)
			$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
			$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
			$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
			$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
		: ($l_Periodo=3)
			$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
			$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
			$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
			$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
		: ($l_Periodo=4)
			$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
			$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
			$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
			$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
		: ($l_Periodo=5)
			$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
			$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
			$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
			$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
		: ($l_Periodo=-1)
			$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
			$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
			$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
			$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
	End case 
	
	$l_tipoObjeto:=[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4
	
	Case of 
			
			  // CALCULOS BASADOS EN COMPETENCIAS
			  // El tipo de objeto es una competencia. Procedo a calculas promedios en cascada inversa (dimensiones, ejes, final)
		: (($l_tipoObjeto=Logro_Aprendizaje) & (([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje) | ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Logro_Aprendizaje) | ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)))
			
			  //si el resultado las dimensiones es calulado sobre la base de las evaluaciones de las competencias, calculo la dimensión a la que esta asociada la competencia
			If ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje)
				$l_IdDimension:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
				$l_IDAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
				$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_IDAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Dimension_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_IdDimension)
				QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $l_Periodo) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
				
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])=0)
					QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[Asignaturas:18]EVAPR_IdMatriz:91;*)
					QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4;=;$l_IdDimension;*)
					QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
					QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_Periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
					If (Records in selection:C76([MPA_ObjetosMatriz:204])=1)
						CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
						[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=$l_IDAlumno
						[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=$l_IdAsignatura
						[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
						[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=[MPA_ObjetosMatriz:204]ID_Dimension:4
						[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=Dimension_Aprendizaje
						[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=[Asignaturas:18]EVAPR_IdMatriz:91
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
						[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
						SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
						MPA_RecuperaEvalCicloAnterior 
					End if 
				End if 
				
				$l_recNumDimension:=Record number:C243([Alumnos_EvaluacionAprendizajes:203])
				KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->$l_IdDimension)
				$b_PromediosModificados:=MPA_Calculos_Dimension ($l_recNumDimension;$l_Periodo;[MPA_DefinicionDimensiones:188]TipoEvaluacion:15;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;[MPA_DefinicionDimensiones:188]Escala_Minimo:12;[MPA_DefinicionDimensiones:188]Escala_Maximo:13)
				If ($b_PromediosModificados)
					If (Type:C295(alEVLG_RecNum)=LongInt array:K8:19)
						If (Size of array:C274(alEVLG_RecNum)>0)
							$l_item:=Find in array:C230(alEVLG_RecNum;$l_recNumDimension)
							If ($l_item>0)
								atEVLG_Indicador{$l_item}:=$y_punteroLiteral->
								arEVLG_Indicador{$l_item}:=$y_punteroReal->
								atEVLG_Observacion{$l_item}:=$y_punteroDescriptor->
							End if 
						End if 
					End if 
				End if 
				
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNumDimension;True:C214)
				
				  // si los ejes o la evaluación final son calculados sobre la base de las dimensiones llamo recursivamente este mismo método
				  // para calcular el eje o el resultado final
				If (([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Dimension_Aprendizaje) | ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje))
					$b_PromediosModificados:=MPA_Calculos ($l_recNumDimension;$l_Periodo)
				End if 
				
			End if 
			
			  //si el resultado de los ejes es calculado sobre la base de las evaluaciones de competencias, calculo el eje sobre la base de las competencias
			If ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Logro_Aprendizaje)
				$l_IdEje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
				$l_IDAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
				$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_IDAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Eje_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje)
				QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $l_Periodo) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
				
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])=0)
					QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[Asignaturas:18]EVAPR_IdMatriz:91;*)
					QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$l_IdEje;*)
					QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
					QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_Periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
					If (Records in selection:C76([MPA_ObjetosMatriz:204])=1)
						CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
						[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=$l_IDAlumno
						[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=$l_IdAsignatura
						[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
						[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=Eje_Aprendizaje
						[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=[Asignaturas:18]EVAPR_IdMatriz:91
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
						[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
						SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
						MPA_RecuperaEvalCicloAnterior 
					End if 
				End if 
				
				$l_recNumEje:=Record number:C243([Alumnos_EvaluacionAprendizajes:203])
				KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->$l_IdEje)
				$b_promediosModificados:=MPA_Calculos_Eje ($l_recNumEje;$l_Periodo;[MPA_DefinicionEjes:185]TipoEvaluación:12;[MPA_DefinicionEjes:185]EstiloEvaluación:13;[MPA_DefinicionEjes:185]Escala_Minimo:17;[MPA_DefinicionEjes:185]Escala_Maximo:18)
				If ($b_PromediosModificados)
					If (Type:C295(alEVLG_RecNum)=LongInt array:K8:19)
						If (Size of array:C274(alEVLG_RecNum)>0)
							$l_item:=Find in array:C230(alEVLG_RecNum;$l_recNumEje)
							If ($l_item>0)
								atEVLG_Indicador{$l_item}:=$y_punteroLiteral->
								arEVLG_Indicador{$l_item}:=$y_punteroReal->
								atEVLG_Observacion{$l_item}:=$y_punteroDescriptor->
							End if 
						End if 
					End if 
				End if 
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNumEje;True:C214)
				
				  // si la evaluación final es calculada sobre la base de los ejes llamo recursivamente este mismo método
				  // para calcular el resultado final
				If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
					$b_PromediosModificados:=MPA_Calculos ($l_recNumDimension;$l_Periodo)
				End if 
			End if 
			
			  // si el resultado final se calcula sobre la base de las evaluaciones de competencias calculos los promedios
			If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)
				MPA_Calculos_FinalPeriodo ($l_IdAsignatura;$l_IDAlumno;$l_Periodo)
			End if 
			
			  // CALCULOS BASADOS EN DIMENSIONES
			  // El tipo de objeto es una DIMENSIÓN. Procedo a calculas promedios en cascada inversa ( ejes, final)
		: (($l_tipoObjeto=Dimension_Aprendizaje) & (([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Dimension_Aprendizaje) | ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)))
			$l_IdEje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
			$l_IDAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
			$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
			If ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Dimension_Aprendizaje)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_IDAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Eje_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje)
				QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $l_Periodo) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))
				
				
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])=0)
					QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[Asignaturas:18]EVAPR_IdMatriz:91;*)
					QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$l_IdEje;*)
					QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
					QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_Periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
					If (Records in selection:C76([MPA_ObjetosMatriz:204])=1)
						CREATE RECORD:C68([Alumnos_EvaluacionAprendizajes:203])
						[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=$l_IDAlumno
						[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=$l_IdAsignatura
						[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=[MPA_ObjetosMatriz:204]ID_Eje:3
						[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4:=Eje_Aprendizaje
						[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=[Asignaturas:18]EVAPR_IdMatriz:91
						[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10:=[MPA_ObjetosMatriz:204]Periodos:7
						[Alumnos_EvaluacionAprendizajes:203]Año:77:=<>gYear
						SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
						MPA_RecuperaEvalCicloAnterior 
					End if 
				End if 
				
				
				$l_recNumEje:=Record number:C243([Alumnos_EvaluacionAprendizajes:203])
				KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->$l_IdEje)
				$b_promediosModificados:=MPA_Calculos_Eje ($l_recNumEje;$l_Periodo;[MPA_DefinicionEjes:185]TipoEvaluación:12;[MPA_DefinicionEjes:185]EstiloEvaluación:13;[MPA_DefinicionEjes:185]Escala_Minimo:17;[MPA_DefinicionEjes:185]Escala_Maximo:18)
				If ($b_PromediosModificados)
					If (Type:C295(alEVLG_RecNum)=LongInt array:K8:19)
						If (Size of array:C274(alEVLG_RecNum)>0)
							$l_item:=Find in array:C230(alEVLG_RecNum;$l_recNumEje)
							If ($l_item>0)
								atEVLG_Indicador{$l_item}:=$y_punteroLiteral->
								arEVLG_Indicador{$l_item}:=$y_punteroReal->
								atEVLG_Observacion{$l_item}:=$y_punteroDescriptor->
							End if 
						End if 
					End if 
				End if 
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNumEje;True:C214)
				
				  // si la evaluación final es calculada sobre la base de los ejes llamo recursivamente este mismo método
				  // para calcular el resultado final
				If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
					$b_PromediosModificados:=MPA_Calculos ($l_recNumEje;$l_Periodo)
				End if 
			End if 
			
			  // si el resultado final se calcula sobre la base de las evaluaciones de DIMENSIONES calculos los promedios
			If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)
				MPA_Calculos_FinalPeriodo ($l_IdAsignatura;$l_IDAlumno;$l_Periodo)
			End if 
			
		: (($l_tipoObjeto=Eje_Aprendizaje) & ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje))
			$l_IDAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
			$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
			
			  // si el resultado final se calcula sobre la base de las evaluaciones de DIMENSIONES calculos los promedios
			If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
				MPA_Calculos_FinalPeriodo ($l_IdAsignatura;$l_IDAlumno;$l_Periodo)
			End if 
			
	End case 
End if 

$0:=$b_PromediosModificados
