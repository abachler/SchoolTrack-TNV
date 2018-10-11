//%attributes = {}
  // MÉTODO: xALP_CB_EX_Aprendizajes
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 14/03/12, 13:29:56
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // xALP_CB_EX_Aprendizajes()
  // ----------------------------------------------------

  // MOD Ticket N° 215084 Patricio Aliaga 20180924
  // Agrego validacion para realizar o no AL_GotoCell, para no retener al usuario si es que esta saliendo de la pagina de aprendizajes
  // Codigo agregado If (($2#7) & ($2#8)) ... End If

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_guardarRegistro;$b_promediosModificados)
C_LONGINT:C283($i;$l_columna;$l_elemento;$l_fila;$l_IdAlumno;$l_IdAsignatura;$l_IdEstiloEvaluacionInterno;$l_IdEstiloEvaluacionOficial;$l_periodos_a_recalcular;$l_referenciaArea)
C_POINTER:C301($y_campoLiteral;$y_campoReal;$y_evaluacionIndicador;$y_evaluacionLiteral;$y_evaluacionNumerico;$y_evaluacionObservaciones;$y_evaluacionReal)
C_REAL:C285($r_valorReal;$r_minimoAprobatorio)
C_TEXT:C284($t_descripcionIndicador;$t_llaveCalificaciones;$t_llaveMatrizEvaluacion;$t_nombreCampoLiteral;$t_nombreCampoReal;$t_valorLogrado;$t_valorNoLogrado)

ARRAY INTEGER:C220($al_arregloD2Celdas;0)

C_TEXT:C284($t_MPA_detalleCambio;$t_logTipoObj;$t_logEnunciado;$t_MPA_oldValue)  //log //MONO - ticket 165579

If (False:C215)
	C_BOOLEAN:C305(xALP_CB_EX_Aprendizajes ;$0)
	C_LONGINT:C283(xALP_CB_EX_Aprendizajes ;$1)
	C_LONGINT:C283(xALP_CB_EX_Aprendizajes ;$2)
End if 


$l_referenciaArea:=$1
$0:=True:C214

If (vl_periodoSeleccionado>0)
	$t_periodo:=atSTR_Periodos_Nombre{vl_periodoSeleccionado}
Else 
	$t_periodo:=__ ("Periodo Final")  //MONO Ticket 187803
End if 

  // CODIGO PRINCIPAL

If (AL_GetCellMod ($l_referenciaArea)=1)
	AL_GetCurrCell ($l_referenciaArea;$l_columna;$l_fila)
	$r_evaluacionAnterior:=arEVLG_Indicador{$l_fila}
	Case of 
		: ($l_columna=2)
			$b_guardarRegistro:=False:C215
			KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila};True:C214)
			Case of 
				: (alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje)
					KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionCompetencias:187]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;False:C215)
					Case of 
						: (atEVLG_Indicador{$l_fila}="")
							arEVLG_Indicador{$l_fila}:=-10  //-10 corresponde a un valor nulo, sin información
							$t_descripcionIndicador:=""
							$r_valorReal:=0
							$b_guardarRegistro:=True:C214
						: (atEVLG_Indicador{$l_fila}="*")
							arEVLG_Indicador{$l_fila}:=-4
							$t_descripcionIndicador:="No evaluado"
							$r_valorReal:=0
							$b_guardarRegistro:=True:C214
						: (atEVLG_Indicador{$l_fila}="P")
							arEVLG_Indicador{$l_fila}:=-2
							$t_descripcionIndicador:="Pendiente"
							$r_valorReal:=0
							$b_guardarRegistro:=True:C214
						Else 
							Case of 
								: (alEVLG_TipoEvaluación{$l_fila}=1)  //indicadores de logro
									$l_elemento:=Find in array:C230(atEVLG_Indicadores_Concepto;atEVLG_Indicador{$l_fila})
									If ($l_elemento<0)
										CD_Dlog (0;__ ("El indicador ingresado no es válido.\rPor favor ingrese un indicado válido o selecciónelo en la lista desplegable en la última columna."))
										atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
										If (($2#7) & ($2#8))
											AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
										End if 
									Else 
										atEVLG_Indicador{$l_fila}:=atEVLG_Indicadores_Concepto{$l_elemento}
										$t_descripcionIndicador:=atEVLG_Indicadores_Descripcion{$l_elemento}
										arEVLG_Indicador{$l_fila}:=Round:C94(aiEVLG_Indicadores_Valor{$l_elemento}/[MPA_DefinicionCompetencias:187]Maximo_Indicadores:9*100;11)
										$r_valorReal:=aiEVLG_Indicadores_Valor{$l_elemento}
										$b_guardarRegistro:=True:C214
									End if 
									
								: (alEVLG_TipoEvaluación{$l_fila}=2)  //binario
									$t_valorLogrado:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;1;";")
									$t_valorNoLogrado:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;2;";")
									Case of 
										: (atEVLG_Indicador{$l_fila}=$t_valorLogrado)
											atEVLG_Indicador{$l_fila}:=$t_valorLogrado  //reasigno para respetar mayúsculas definidas en caso de haber digitado minúsculas
											$t_descripcionIndicador:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;1;";")
											$r_valorReal:=1
											$b_guardarRegistro:=True:C214
										: (atEVLG_Indicador{$l_fila}=$t_valorNoLogrado)
											atEVLG_Indicador{$l_fila}:=$t_valorNoLogrado  //reasigno para respetar mayúsculas definidas en caso de haber digitado minúsculas
											$t_descripcionIndicador:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;2;";")
											$r_valorReal:=0
											$b_guardarRegistro:=True:C214
										Else 
											CD_Dlog (0;__ ("El símbolo ingresado no está definido en la lista de indicadores de logros con los que es posible evaluar este aprendizaje. \r\rPor favor ingrese un símbolo válido o seleccione el indicador en la lista."))
											atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
											If (($2#7) & ($2#8))
												AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
											End if 
									End case 
									
								: (alEVLG_TipoEvaluación{$l_fila}=3)  //estilo de evaluación
									$l_IdEstiloEvaluacionInterno:=alEVLG_RefEstiloEvaluacion{$l_fila}
									EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
									vi_lastGradeView:=iEvaluationMode
									Case of 
										: (iEvaluationMode=Notas)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Literal ($r_valorReal;Notas;iGradesDec)
												  //20110428 RCH Se convierte real a nota para pasar a texto, se estaba convirtiendo el real...
												  //$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True)+" sobre "+ST_Num2Text (rGradesTo;False)
												$t_descripcionIndicador:=ST_Num2Text (EV2_Real_a_Nota ($r_valorReal;0;iGradesDec);True:C214)+" sobre "+ST_Num2Text (rGradesTo;False:C215)
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
										: (iEvaluationMode=Puntos)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Literal ($r_valorReal;Puntos;iPointsDec)
												$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text (rPointsTo;False:C215)
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
										: (iEvaluationMode=Porcentaje)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Literal ($r_valorReal;Porcentaje;1)
												$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text (100;False:C215)
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
										: (iEvaluationMode=Simbolos)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Simbolo ($r_valorReal;1)
												$l_elemento:=Find in array:C230(aSymbol;atEVLG_Indicador{$l_fila})
												If ($l_elemento>0)
													$t_descripcionIndicador:=aSymbDesc{$l_elemento}
												End if 
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
									End case 
							End case 
					End case 
					$r_minimoAprobatorio:=[MPA_DefinicionCompetencias:187]PctParaAprobacion:22
					
				: (alEVLG_TipoObjeto{$l_fila}=Dimension_Aprendizaje)
					KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;False:C215)
					
					Case of 
						: (atEVLG_Indicador{$l_fila}="")
							arEVLG_Indicador{$l_fila}:=-10  //-10 corresponde a un valor nulo, sin información
							atEVLG_Observacion{$l_fila}:=""
							$r_valorReal:=0
							$b_guardarRegistro:=True:C214
						: (atEVLG_Indicador{$l_fila}="*")
							arEVLG_Indicador{$l_fila}:=-4
							atEVLG_Observacion{$l_fila}:="No evaluado"
							$r_valorReal:=0
							$b_guardarRegistro:=True:C214
						: (atEVLG_Indicador{$l_fila}="P")
							arEVLG_Indicador{$l_fila}:=-2
							atEVLG_Observacion{$l_fila}:="Pendiente"
							$r_valorReal:=0
							$b_guardarRegistro:=True:C214
						Else 
							Case of 
								: (alEVLG_TipoEvaluación{$l_fila}=1)  //estilo de evaluación
									$l_IdEstiloEvaluacionInterno:=alEVLG_RefEstiloEvaluacion{$l_fila}
									EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
									vi_lastGradeView:=iEvaluationMode
									Case of 
										: (iEvaluationMode=Notas)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Literal ($r_valorReal;Notas;iGradesDec)
												$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text (rGradesTo;False:C215)
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
										: (iEvaluationMode=Puntos)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Literal ($r_valorReal;Puntos;iPointsDec)
												$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text (rPointsTo;False:C215)
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
										: (iEvaluationMode=Porcentaje)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Literal ($r_valorReal;Porcentaje;1)
												$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text (100;False:C215)
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
										: (iEvaluationMode=Simbolos)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Simbolo ($r_valorReal;1)
												$l_elemento:=Find in array:C230(aSymbol;atEVLG_Indicador{$l_fila})
												If ($l_elemento>0)
													$t_descripcionIndicador:=aSymbDesc{$l_elemento}
												End if 
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
									End case 
									
								: (alEVLG_TipoEvaluación{$l_fila}=2)  //binario
									$t_valorLogrado:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;1;";")
									$t_valorNoLogrado:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;2;";")
									Case of 
										: (atEVLG_Indicador{$l_fila}=$t_valorLogrado)
											atEVLG_Indicador{$l_fila}:=$t_valorLogrado  //reasigno para respetar mayúsculas definidas en caso de haber digitado minúsculas
											$t_descripcionIndicador:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;1;";")
											$b_guardarRegistro:=True:C214
											$r_valorReal:=1
										: (atEVLG_Indicador{$l_fila}=$t_valorNoLogrado)
											atEVLG_Indicador{$l_fila}:=$t_valorNoLogrado  //reasigno para respetar mayúsculas definidas en caso de haber digitado minúsculas
											$t_descripcionIndicador:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;2;";")
											$b_guardarRegistro:=True:C214
											$r_valorReal:=0
										Else 
											CD_Dlog (0;__ ("El símbolo ingresado no está definido en la lista de indicadores de logros con los que es posible evaluar este aprendizaje. \r\rPor favor ingrese un símbolo válido o seleccione el indicador en la lista."))
											atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
											If (($2#7) & ($2#8))
												AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
											End if 
									End case 
									
								: (alEVLG_TipoEvaluación{$l_fila}=3)  //escala independiente
									$r_valorReal:=Num:C11(atEVLG_Indicador{$l_fila})
									If (($r_valorReal<[MPA_DefinicionDimensiones:188]Escala_Minimo:12) | ($r_valorReal>[MPA_DefinicionDimensiones:188]Escala_Maximo:13))
										CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("La evaluación ingresada está fuera del rango permitido.\r\rDebe situarse entre ^0 y ^1.");__ ("^0");String:C10([MPA_DefinicionDimensiones:188]Escala_Minimo:12));__ ("^1");String:C10([MPA_DefinicionDimensiones:188]Escala_Maximo:13)))
										atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
										$r_valorReal:=Num:C11(atEVLG_Indicador{0})
										If (($2#7) & ($2#8))
											AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
										End if 
									Else 
										arEVLG_Indicador{$l_fila}:=Round:C94($r_valorReal/[MPA_DefinicionDimensiones:188]Escala_Maximo:13*100;11)
										$r_valorReal:=Num:C11(atEVLG_Indicador{$l_fila})
										$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text ([MPA_DefinicionDimensiones:188]Escala_Maximo:13;False:C215)
										$b_guardarRegistro:=True:C214
									End if 
									
							End case 
					End case 
					$r_minimoAprobatorio:=[MPA_DefinicionDimensiones:188]PctParaAprobacion:14
					
				: (alEVLG_TipoObjeto{$l_fila}=Eje_Aprendizaje)
					KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;False:C215)
					
					Case of 
						: (atEVLG_Indicador{$l_fila}="")
							arEVLG_Indicador{$l_fila}:=-10  //-10 corresponde a un valor nulo, sin información
							$t_descripcionIndicador:=""
							$r_valorReal:=0
							$b_guardarRegistro:=True:C214
						: (atEVLG_Indicador{$l_fila}="*")
							arEVLG_Indicador{$l_fila}:=-4
							$t_descripcionIndicador:="No evaluado"
							$r_valorReal:=0
							$b_guardarRegistro:=True:C214
						: (atEVLG_Indicador{$l_fila}="P")
							arEVLG_Indicador{$l_fila}:=-2
							$t_descripcionIndicador:="Pendiente"
							$r_valorReal:=0
							$b_guardarRegistro:=True:C214
						Else 
							Case of 
								: (alEVLG_TipoEvaluación{$l_fila}=1)  //estilo de evaluación
									$l_IdEstiloEvaluacionInterno:=alEVLG_RefEstiloEvaluacion{$l_fila}
									EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
									vi_lastGradeView:=iEvaluationMode
									Case of 
										: (iEvaluationMode=Notas)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Literal ($r_valorReal;Notas;iGradesDec)
												$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text (rGradesTo;False:C215)
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
										: (iEvaluationMode=Puntos)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Literal ($r_valorReal;Puntos;iPointsDec)
												$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text (rPointsTo;False:C215)
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
										: (iEvaluationMode=Porcentaje)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Literal ($r_valorReal;Porcentaje;1)
												$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text (100;False:C215)
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
											
										: (iEvaluationMode=Simbolos)
											$r_valorReal:=EV2_ValidaIngreso (atEVLG_Indicador{$l_fila})
											If ($r_valorReal>-10)
												arEVLG_Indicador{$l_fila}:=$r_valorReal
												atEVLG_Indicador{$l_fila}:=EV2_Real_a_Simbolo ($r_valorReal;1)
												$l_elemento:=Find in array:C230(aSymbol;atEVLG_Indicador{$l_fila})
												If ($l_elemento>0)
													$t_descripcionIndicador:=aSymbDesc{$l_elemento}
												End if 
												$b_guardarRegistro:=True:C214
											Else 
												atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
												If (($2#7) & ($2#8))
													AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
												End if 
											End if 
									End case 
									
								: (alEVLG_TipoEvaluación{$l_fila}=2)  //binario
									$t_valorLogrado:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14;1;";")
									$t_valorNoLogrado:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14;2;";")
									Case of 
										: (atEVLG_Indicador{$l_fila}=$t_valorLogrado)
											atEVLG_Indicador{$l_fila}:=$t_valorLogrado  //reasigno para respetar mayúsculas definidas en caso de haber digitado minúsculas
											$b_guardarRegistro:=True:C214
											$r_valorReal:=1
										: (atEVLG_Indicador{$l_fila}=$t_valorNoLogrado)
											atEVLG_Indicador{$l_fila}:=$t_valorNoLogrado  //reasigno para respetar mayúsculas definidas en caso de haber digitado minúsculas
											$b_guardarRegistro:=True:C214
											$r_valorReal:=0
										Else 
											CD_Dlog (0;__ ("El símbolo ingresado no está definido en la lista de indicadores de logros con los que es posible evaluar este aprendizaje. \r\rPor favor ingrese un símbolo válido o seleccione el indicador en la lista."))
											atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
											If (($2#7) & ($2#8))
												AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
											End if 
									End case 
									$r_minimoAprobatorio:=100
									
								: (alEVLG_TipoEvaluación{$l_fila}=3)  //escala independiente
									$r_valorReal:=Num:C11(atEVLG_Indicador{$l_fila})
									If (($r_valorReal<[MPA_DefinicionEjes:185]Escala_Minimo:17) | ($r_valorReal>[MPA_DefinicionEjes:185]Escala_Maximo:18))
										CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("La evaluación ingresada está fuera del rango permitido.\r\rDebe situarse entre ^0 y ^1.");__ ("^0");String:C10([MPA_DefinicionEjes:185]Escala_Minimo:17));__ ("^1");String:C10([MPA_DefinicionEjes:185]Escala_Maximo:18)))
										atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
										$r_valorReal:=Num:C11(atEVLG_Indicador{0})
										If (($2#7) & ($2#8))
											AL_GotoCell ($l_referenciaArea;$l_columna;$l_fila)
										End if 
									Else 
										arEVLG_Indicador{$l_fila}:=Round:C94($r_valorReal/[MPA_DefinicionEjes:185]Escala_Maximo:18*100;11)
										$r_valorReal:=Num:C11(atEVLG_Indicador{$l_fila})
										$t_descripcionIndicador:=ST_Num2Text ($r_valorReal;True:C214)+" sobre "+ST_Num2Text ([MPA_DefinicionEjes:185]Escala_Maximo:18;False:C215)
										$b_guardarRegistro:=True:C214
									End if 
							End case 
					End case 
					$r_minimoAprobatorio:=[MPA_DefinicionEjes:185]PctParaAprobacion:16
			End case 
			
		: ($l_columna=3)
			$b_guardarRegistro:=True:C214
	End case 
	
	
	
	KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila};True:C214)
	If (($b_guardarRegistro) & (arEVLG_Indicador{$l_fila}<$r_minimoAprobatorio) & (adEVLG_FechaLogro{$l_fila}#!00-00-00!) & (arEVLG_Indicador{$l_fila}<$r_evaluacionAnterior))
		
		If (atEVLG_Indicador{$l_fila}#"")
			$t_fecha:=atMPA_FechaLogro{$l_fila}
			$t_evento:=__ ("Reevaluación en ^0 de competencia adquirida previamente el ^1: ^2 en lugar de ^3")
			$t_nuevaEvaluacion:=atEVLG_Indicador{$l_fila}
			$t_evaluacionAnterior:=atEVLG_Indicador{0}
			$t_evento:=Replace string:C233($t_evento;"^0";$t_periodo)
			$t_evento:=Replace string:C233($t_evento;"^1";$t_fecha)
			$t_evento:=Replace string:C233($t_evento;"^2";IT_SetTextStyle_Bold (->$t_nuevaEvaluacion))
			$t_evento:=Replace string:C233($t_evento;"^3";IT_SetTextStyle_Bold (->$t_evaluacionAnterior))
			
			$t_tituloVentana:="Modificación de la evaluación de una competencia adquirida"
			$t_mensaje:=__ ("Usted acaba de registrar una calificación no aprobatoria en ^1 para una competencia evaluada y adquirida el ^0.\r\r")
			$t_mensaje:=$t_mensaje+__ ("Si confirma la modificación que acaba de introducir se mantendrán las evaluaciones indicadoras de adquisición en períodos anteriores pero la competencia se considerará no adquirida y se eliminarán las evaluaciones aprobatorias reportadas desde p"+"eríodos anteriores.")+"\r\r"
			$t_mensaje:=$t_mensaje+__ ("Por favor ingrese un comentario que explique por qué considera que la competencia no ha sido adquirida")
			$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_fecha))
			$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_periodo;True:C214))
		Else 
			$t_fecha:=atMPA_FechaLogro{$l_fila}
			$t_evento:=__ ("Eliminación de una evaluación aprobatoria (^3) en ^0 en una competencia adquirida previamente el ^1")
			$t_nuevaEvaluacion:=atEVLG_Indicador{$l_fila}
			$t_evaluacionAnterior:=atEVLG_Indicador{0}
			$t_evento:=Replace string:C233($t_evento;"^0";$t_periodo)
			$t_evento:=Replace string:C233($t_evento;"^1";$t_fecha)
			$t_evento:=Replace string:C233($t_evento;"^3";IT_SetTextStyle_Bold (->$t_evaluacionAnterior;True:C214))
			
			$t_tituloVentana:="Eliminación de la evaluación en una competencia adquirida"
			$t_mensaje:=__ ("Usted acaba de eliminar una evaluación aprobatoria (^2) en ^1 para una competencia evaluada y adquirida el ^0.")+"\r\r"
			$t_mensaje:=$t_mensaje+__ ("Si confirma la eliminación de la evaluación se mantendrán las evaluaciones indicadoras de adquisición en períodos anteriores pero la competencia se considerará no adquirida y se eliminarán las evaluaciones aprobatorias reportadas desde período"+"s anteriores.")+"\r\r"
			$t_mensaje:=$t_mensaje+__ ("Por favor ingrese un comentario que explique por qué elimina esta evaluación.")
			$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_fecha))
			$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_periodo;True:C214))
			$t_mensaje:=Replace string:C233($t_mensaje;"^2";IT_SetTextStyle_Bold (->$t_evaluacionAnterior;True:C214))
		End if 
		
		$l_accionUsuario:=XSnota_RegistraNota (->[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->vl_PeriodoSeleccionado;$t_evento;$t_mensaje;$t_tituloVentana;__ ("Confirmar");__ ("Cancelar"))
		If ($l_accionUsuario=1)
			adEVLG_FechaLogro{$l_fila}:=!00-00-00!
			atMPA_FechaLogro{$l_fila}:=""
			MPA_AnulaEvaluacionAdquirida (alEVLG_RecNum{$l_fila};vl_PeriodoSeleccionado+1;viSTR_Periodos_NumeroPeriodos)
		Else 
			arEVLG_Indicador{$l_fila}:=arEVLG_Indicador{0}
			atEVLG_Indicador{$l_fila}:=atEVLG_Indicador{0}
			$r_valorReal:=Num:C11(atEVLG_Indicador{0})
			$b_guardarRegistro:=False:C215
		End if 
	End if 
	
	
	If ($b_guardarRegistro)
		Case of 
			: (vl_PeriodoSeleccionado=1)
				$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
				$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
				$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
				$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
				$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
			: (vl_PeriodoSeleccionado=2)
				$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
				$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
				$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
				$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
				$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
			: (vl_PeriodoSeleccionado=3)
				$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
				$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
				$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
				$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
				$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
			: (vl_PeriodoSeleccionado=4)
				$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
				$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
				$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
				$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
				$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82
			: (vl_PeriodoSeleccionado=5)
				$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
				$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
				$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
				$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
				$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
			: (vl_PeriodoSeleccionado=-1)
				$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
				$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
				$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
				$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
				$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84
		End case 
		
		KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila};True:C214)
		If (OK=1)
			If (arEVLG_Indicador{$l_fila}<0)
				atEVLG_Indicador{$l_fila}:=Uppercase:C13(atEVLG_Indicador{$l_fila})
			End if 
			
			$y_evaluacionReal->:=arEVLG_Indicador{$l_fila}
			$y_evaluacionLiteral->:=atEVLG_Indicador{$l_fila}
			$y_evaluacionNumerico->:=$r_valorReal
			If (vlEVLG_mostrarObservacion=1)
				If (ST_ExactlyEqual ($y_evaluacionObservaciones->;atEVLG_Observacion{$l_fila})=0)
					SN3_MarcarRegistros (SN3_DTi_CalificacionesMPA)
				End if 
				$y_evaluacionObservaciones->:=atEVLG_Observacion{$l_fila}
				If ($l_columna=2)
					$y_evaluacionIndicador->:=$t_descripcionIndicador
				End if 
			Else 
				$y_evaluacionIndicador->:=$t_descripcionIndicador
			End if 
			
			
			MPA_CompetenciaAdquirida ($r_valorReal;vl_PeriodoSeleccionado)  // determino si la competencia fue adquirida y reporto la calificación aprobatoria a los períodos siguientes si corresponde
			If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89#!00-00-00!)
				atMPA_FechaLogro{$l_fila}:=String:C10([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;Internal date short:K1:7)
				adEVLG_FechaLogro{$l_fila}:=[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89
			Else 
				atMPA_FechaLogro{$l_fila}:=""
				adEVLG_FechaLogro{$l_fila}:=!00-00-00!
			End if 
			$l_periodos_a_recalcular:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ vl_PeriodoSeleccionado
			$t_MPA_oldValue:=Old:C35($y_evaluacionLiteral->)
			SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
			
			  // calculo de promedios para ejes, dimensiones y conversion a notas
			$l_IdAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
			$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
			$t_llaveCalificaciones:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10($l_IdAsignatura)+"."+String:C10($l_IdAlumno)
			For ($i;1;viSTR_Periodos_NumeroPeriodos)
				If ($l_periodos_a_recalcular ?? $i)
					$b_promediosModificados:=$b_promediosModificados & MPA_Calculos (Record number:C243([Alumnos_EvaluacionAprendizajes:203]);$i)
				End if 
			End for 
			
			If ($l_periodos_a_recalcular ?? 0)
				$b_promediosModificados:=$b_promediosModificados & MPA_Calculos (Record number:C243([Alumnos_EvaluacionAprendizajes:203]);-1)
			End if 
			
			AS_PropEval_Lectura ("";vl_PeriodoSeleccionado)
			$b_promediosModificados:=MPA_Aprendizajes_a_Notas ([Asignaturas:18]EVAPR_IdMatriz:91;$t_llaveCalificaciones)
			If ($b_promediosModificados)
				modNotas:=True:C214
				If (Find in array:C230(aIdAlumnos_a_Recalcular;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)=-1)
					APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
				End if 
			End if 
			LOAD RECORD:C52([Alumnos_Calificaciones:208])  // Para recargar el registro modificado en el servidor.
			EV2_ObtieneDatosPeriodoActual (vl_PeriodoSeleccionado)
			  //MONO - ticket 165579
			QR_AluEvAprendizaje_GetData ([Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->$t_logEnunciado;->$t_logTipoObj)
			$t_MPA_detalleCambio:="Periodo "+String:C10(vl_PeriodoSeleccionado)+" "+$t_logTipoObj+": "+$t_logEnunciado+" - Evaluación "+$t_MPA_oldValue+" >> "+$y_evaluacionLiteral->
			
			LOG_RegisterEvt ("Modificación en evaluación de aprendizajes para "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20+" en "+[Asignaturas:18]Asignatura:3+" - "+$t_MPA_detalleCambio)
			KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
		End if 
		
		
		
		
		If (vlEVLG_mostrarObservacion=0)
			atEVLG_Observacion{$l_fila}:=$t_descripcionIndicador
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
		
		$l_IdEstiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_de_alumnos:49;->[xxSTR_Niveles:6]EvStyle_oficial:23)
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
		
		$0:=True:C214
	End if 
	
	MPA_AparienciaEvaluaciones ($l_referenciaArea)
	AL_UpdateArrays ($l_referenciaArea;-2)
End if 

