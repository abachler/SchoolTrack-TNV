//%attributes = {}
  // Método: dbu_FijaIndicadoresAprendizaje
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 15/10/09, 20:34:39
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283($i)

  // Código principal
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando descripción de indicadores..."))

For ($i;1;Size of array:C274($aRecNums))
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
	
	READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
	GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$aRecNums{$i})
	Case of 
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
			$recNum:=KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
			If ($recNum>=0)
				Case of 
					: ([MPA_DefinicionEjes:185]TipoEvaluación:12=1)
						EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
						
						If (iEvaluationMode=Simbolos)
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=aSymbDesc{$el}
								End if 
							End if 
							
						End if 
						
					: ([MPA_DefinicionEjes:185]TipoEvaluación:12=2)
						$true:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14;1;";")
						$false:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14;2;";")
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;2;";")
							End case 
						End if 
						
				End case 
			End if 
			
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
			$recNum:=KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
			If ($recNum>=0)
				Case of 
					: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=1)
						EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
						
						If (iEvaluationMode=Simbolos)
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=aSymbDesc{$el}
								End if 
							End if 
							
						End if 
						
					: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=2)
						$true:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;1;";")
						$false:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;2;";")
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;2;";")
							End case 
						End if 
						
				End case 
			End if 
			
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
			$recNum:=KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionCompetencias:187]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
			If ($recNum>=0)
				Case of 
					: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1)
						ARRAY TEXT:C222(atEVLG_Indicadores_Descripcion;0)
						ARRAY INTEGER:C220(aiEVLG_Indicadores_Valor;0)
						_O_ARRAY STRING:C218(5;atEVLG_Indicadores_Concepto;0)
						BLOB_Blob2Vars (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->atEVLG_Indicadores_Descripcion;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Concepto)
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"")
							$el:=Find in array:C230(atEVLG_Indicadores_Concepto;[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
							If ($el>0)
								[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=atEVLG_Indicadores_Descripcion{$el}
							End if 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"")
							$el:=Find in array:C230(atEVLG_Indicadores_Concepto;[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25)
							If ($el>0)
								[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=atEVLG_Indicadores_Descripcion{$el}
							End if 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"")
							$el:=Find in array:C230(atEVLG_Indicadores_Concepto;[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37)
							If ($el>0)
								[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=atEVLG_Indicadores_Descripcion{$el}
							End if 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"")
							$el:=Find in array:C230(atEVLG_Indicadores_Concepto;[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
							If ($el>0)
								[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=atEVLG_Indicadores_Descripcion{$el}
							End if 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"")
							$el:=Find in array:C230(atEVLG_Indicadores_Concepto;[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
							If ($el>0)
								[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=atEVLG_Indicadores_Descripcion{$el}
							End if 
						End if 
						
					: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2)
						$true:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;1;";")
						$false:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;2;";")
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;2;";")
							End case 
						End if 
						
						If ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"")
							Case of 
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66=$true)
									[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;1;";")
									
								: ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66=$false)
									[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;2;";")
							End case 
						End if 
						
					: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=3)
						EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
						
						If (iEvaluationMode=Simbolos)
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=aSymbDesc{$el}
								End if 
							End if 
							
							If ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"")
								$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66)
								If ($el>0)
									[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=aSymbDesc{$el}
								End if 
							End if 
							
						End if 
				End case 
			End if 
	End case 
	
	
	SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)



