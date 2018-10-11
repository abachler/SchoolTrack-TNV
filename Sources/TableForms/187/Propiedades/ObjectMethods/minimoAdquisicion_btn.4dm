  // [MPA_DefinicionCompetencias].Propiedades.minimoAdquisicion_btn()
  // Por: Alberto Bachler K.: 03-03-15, 12:24:50
  //  ---------------------------------------------
  // 
  //
  //  --------------------------------------------- 
C_BOOLEAN:C305($b_promediosModificados)
$y_minimo:=OBJECT Get pointer:C1124(Object named:K67:5;"minimoAdquisicion_var")
$t_minimoActual:=$y_minimo->

atEVLG_TiposEvaluacion:=[MPA_DefinicionCompetencias:187]TipoEvaluacion:12
Case of 
	: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1)  // evaluacion por indicadores
		BLOB_Blob2Vars (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->atEVLG_Indicadores_Descripcion;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Concepto)
		$l_itemSeleccionado:=Pop up menu:C542(AT_array2text (->atEVLG_Indicadores_Concepto;";")+";(-;"+__ ("No manejar la adquisición"))
		Case of 
			: ($l_itemSeleccionado>Size of array:C274(atEVLG_Indicadores_Descripcion))
				[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=0
				$y_minimo->:=""
				
			: ($l_itemSeleccionado>0)
				[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=Round:C94(aiEVLG_Indicadores_Valor{$l_itemSeleccionado}/[MPA_DefinicionCompetencias:187]Escala_Maximo:21*100;11)
				$y_minimo->:=atEVLG_Indicadores_Concepto{$l_itemSeleccionado}
		End case 
		
	: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2)  // evaluación binaria
		$l_itemSeleccionado:=Pop up menu:C542(vsEVLG_Simbolo_True+";"+vsEVLG_Simbolo_False+";(-;"+__ ("No manejar la adquisición"))
		If ($l_itemSeleccionado>0)
			Case of 
				: ($l_itemSeleccionado=1)
					[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=100
					$y_minimo->:=vsEVLG_Simbolo_True
					
				: ($l_itemSeleccionado=2)
					[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=1
					$y_minimo->:=vsEVLG_Simbolo_False
					
				: ($l_itemSeleccionado=4)
				: ($l_itemSeleccionado>Size of array:C274(aSymbol))
					[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=0
					$y_minimo->:=""
			End case 
		End if 
		
	: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=3)  // estilos de evaluacion
		$l_itemSeleccionado:=Pop up menu:C542(AT_array2text (->aSymbol;";")+";(-;"+__ ("No manejar la adquisición"))
		Case of 
			: ($l_itemSeleccionado>Size of array:C274(aSymbol))
				[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=0
				$y_minimo->:=""
				
			: ($l_itemSeleccionado>0)
				[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=aSymbPctEqu{$l_itemSeleccionado}
				$y_minimo->:=aSymbol{$l_itemSeleccionado}
		End case 
End case 


If ($t_minimoActual#$y_minimo->)
	START TRANSACTION:C239
	SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
	READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
	SET QUERY AND LOCK:C661(True:C214)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_DefinicionCompetencias:187]ID:1)
	
	If (OK=1) & (Records in set:C195("lockedSet")=0)
		ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91;>)
		
		ARRAY LONGINT:C221($al_RecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_RecNums;"")
		
		
		$l_idTermometro:=IT_Progress (1;0;0;"...")
		For ($i_registros;1;Size of array:C274($al_RecNums))
			READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
			GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_RecNums{$i_registros})
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!
			Case of 
				: (($t_minimoActual#"") & ($y_minimo->=""))
					  // se elimina el manejo de adquisicion de la competencia
					  // solicitamos confirmación y eliminamos la adquisición de la competencia para el año actual conservando las evaluaciones registradas
					If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 1)
						[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=""
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 1
					End if 
					If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 2)
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=""
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 2
					End if 
					If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 3)
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=""
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 3
					End if 
					If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 4)
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82:=""
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 4
					End if 
					If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 5)
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66:=""
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=-10
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83:=""
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 5
					End if 
					If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 0)
						[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=-10
						[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=""
						[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=""
						[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=-10
						[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=""
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 0
					End if 
					SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
					
					
					
				: ($t_minimoActual#$y_minimo->)
					  // se modifica el indicador que consituye aprobación de la competencia
					  // recalculamos la fecha de adquisición, reportamos las evaluaciones indicadoras de adquisición a los períodos siguiente
					[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=0
					For ($i_periodos;1;viSTR_Periodos_NumeroPeriodos)
						Case of 
							: ($i_periodos=1)
								$r_evaluacion:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
							: ($i_periodos=2)
								$r_evaluacion:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
							: ($i_periodos=3)
								$r_evaluacion:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
							: ($i_periodos=4)
								$r_evaluacion:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
							: ($i_periodos=5)
								$r_evaluacion:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
						End case 
						MPA_CompetenciaAdquirida ($r_evaluacion;$i_periodos)
					End for 
					$r_evaluacion:=[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
					MPA_CompetenciaAdquirida ($r_evaluacion;-1)
					SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
					
					For ($i_periodos;1;viSTR_Periodos_NumeroPeriodos)
						If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? $i_periodos)
							$b_promediosModificados:=$b_promediosModificados & MPA_Calculos (Record number:C243([Alumnos_EvaluacionAprendizajes:203]);$i_periodos)
						End if 
					End for 
					If ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 0)
						$b_promediosModificados:=$b_promediosModificados & MPA_Calculos (Record number:C243([Alumnos_EvaluacionAprendizajes:203]);-1)
					End if 
					
			End case 
			$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
		End for 
		
		$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
		KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
	End if 
	SET QUERY AND LOCK:C661(False:C215)
	VALIDATE TRANSACTION:C240
End if 
