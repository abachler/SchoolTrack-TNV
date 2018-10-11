//%attributes = {}
  //EVLG_xALP_Aprendizajes
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_conAnotacion;$b_dimensionesIngresables;$b_editable;$b_ejesIngresables;$b_guardarRegistro;$b_MostrarMenu;$b_muestraMenu;$b_promediosModificados;$b_usuarioAutorizado)
C_LONGINT:C283($i;$l_accionUsuario;$l_columna;$l_estiloFuente;$l_fila;$l_filaEnunciados;$l_IdEstiloEvaluacion;$l_idObjeto;$l_itemSeleccionado;$l_periodos_a_recalcular)
C_LONGINT:C283($l_recNum;$l_recNumObjeto;$l_referenciaArea;$l_refLista;$l_tamañoFuente;$l_tamañoFuenteColum;$l_tipoObjeto;$l_valorIndicador)
C_POINTER:C301($y_Description;$y_Indicador;$y_literal;$y_numerico;$y_Real;$y_Simbolos)
C_REAL:C285($r_evaluacionAnterior;$r_minimoAprobatorio;$r_valorNumerico)
C_TEXT:C284($t_decripcionIndicador;$t_evaluacionAnterior;$t_evento;$t_fecha;$t_indicador;$t_indicadorAnterior;$t_jSon;$t_llaveAnotacion;$t_llaveRegistroEvaluacion;$t_logEnunciado)
C_TEXT:C284($t_logTipoObj;$t_mensaje;$t_menuItems;$t_menuRef;$t_MPA_detalleCambio;$t_MPA_oldValue;$t_nombreFuente;$t_nombreObjeto;$t_nuevaEvaluacion;$t_periodo)
C_TEXT:C284($t_refJson;$t_textoMuestra;$t_tituloVentana)

ARRAY INTEGER:C220($ai_valor;0)
ARRAY TEXT:C222($at_descripcion;0)
ARRAY TEXT:C222($at_indicador;0)



If (False:C215)
	C_LONGINT:C283(EVLG_xALP_Aprendizajes ;$1)
End if 

C_TEXT:C284(vtEVLG_VistaActual)
C_BOOLEAN:C305(vb_MostrarFechas)
$l_referenciaArea:=$1

$l_columna:=AL_GetColumn ($l_referenciaArea)
$l_fila:=AL_GetClickedRow ($l_referenciaArea)




Case of 
	: (((alProEvt=AL Column control click event) | (alProEvt=AL Column click event)) & ($l_fila=0))
		  // clic derecho en el encabezado
		$t_menuItems:="Mostrar descripción del Indicador;Mostrar Observaciones"
		$l_itemSeleccionado:=Pop up menu:C542($t_menuItems)
		If ($l_itemSeleccionado>0)
			Case of 
				: ($l_itemSeleccionado=1)
					vlEVLG_mostrarObservacion:=0
					AL_SetHeaders ($l_referenciaArea;3;1;__ ("Descripción del indicador"))
				: ($l_itemSeleccionado=2)
					vlEVLG_mostrarObservacion:=1
					AL_SetHeaders ($l_referenciaArea;3;1;__ ("Observaciones"))
			End case 
			
			
			PREF_Set (0;"Indicador/Observación";String:C10(vlEVLG_mostrarObservacion))
			Case of 
				: (Table:C252(yBWR_currentTable)=(Table:C252(->[Alumnos:2])))
					AL_PaginaAprendizajes 
				: (Table:C252(yBWR_currentTable)=(Table:C252(->[Asignaturas:18])))
					
					Case of 
						: (vtEVLG_VistaActual="alumnos")
							AS_PageEVLG (vtEVLG_VistaActual)
							
						: (vtEVLG_VistaActual="aprendizajes")
							$l_refLista:=(OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados"))->
							GET LIST ITEM:C378($l_refLista;Selected list items:C379($l_refLista);$l_recNumObjeto;$t_nombreObjeto)
							GET LIST ITEM PARAMETER:C985($l_refLista;$l_recNumObjeto;"TipoObjeto";$l_tipoObjeto)
							GET LIST ITEM PARAMETER:C985($l_refLista;$l_recNumObjeto;"IdObjeto";$l_idObjeto)
							AS_EVLG_CargaEvaluacion ($l_tipoObjeto;[Asignaturas:18]Numero:1;$l_idObjeto;vl_PeriodoSeleccionado)
					End case 
			End case 
		End if 
		
		
	: (($l_fila>0) & (Size of array:C274(alEVLG_RecNum)>0))
		$r_evaluacionAnterior:=arEVLG_Indicador{$l_fila}
		$t_indicadorAnterior:=atEVLG_Indicador{$l_fila}
		$t_decripcionIndicador:=atEVLG_Observacion{$l_fila}
		If (vl_year<<>gYear)
			If ((alProEvt=AL Single click event) | (alProEvt=AL Single Control Click))
				If ((atEVLG_Muestra{$l_fila}#"") & ($l_columna=2))
					$t_textoMuestra:=Replace string:C233(atEVLG_Muestra{$l_fila};", ";";")
					$t_textoMuestra:=Replace string:C233($t_textoMuestra;"-";"–")
					If (ST_CountWords ($t_textoMuestra;1;";")>1)
						$l_itemSeleccionado:=Pop up menu:C542("(Información: ;"+$t_textoMuestra)
					Else 
						$l_itemSeleccionado:=Pop up menu:C542("(Información: ;"+"Escala de "+$t_textoMuestra)
					End if 
				Else 
					  //vlEVLG_mostrarObservacion muestro las observaciones
					If ($l_columna=3)
						  //20120512 JVP para mostrar las observaciones  ticket (161207 )
						ARRAY TEXT:C222(at_lineas;0)
						C_TEXT:C284(vt_Observacion)
						If (vlEVLG_mostrarObservacion=1)
							If (atEVLG_Observacion{$l_fila}#"")
								vt_Observacion:=atEVLG_Observacion{$l_fila}
								AL_GetWidths (xALP_Aprendizajes;$l_columna;$l_columna;$l_tamañoFuenteColum)
								AL_GetStyle (xALP_Aprendizajes;$l_columna;$t_nombreFuente;$l_tamañoFuente;$l_estiloFuente)
								hmFree_TEXT2ARRAY (vt_Observacion;at_lineas;$l_tamañoFuenteColum;$t_nombreFuente;$l_tamañoFuente;$l_estiloFuente)
								If (vi_LineasPorFila<Size of array:C274(at_lineas))
									WDW_OpenPopupWindow (->vt_Observacion;->[Alumnos_EvaluacionAprendizajes:203];"Observaciones";32)
									DIALOG:C40([Alumnos_EvaluacionAprendizajes:203];"Observaciones";*)
								End if 
							End if 
						Else 
							$t_textoMuestra:=Replace string:C233(atEVLG_Muestra{$l_fila};", ";";")
							$t_textoMuestra:=Replace string:C233($t_textoMuestra;"-";"–")
							If (ST_CountWords ($t_textoMuestra;1;";")>1)
								$l_itemSeleccionado:=Pop up menu:C542("(Información: ;"+$t_textoMuestra)
							Else 
								$l_itemSeleccionado:=Pop up menu:C542("(Información: ;"+"Escala de "+$t_textoMuestra)
							End if 
						End if 
					End if 
				End if 
			End if 
			
		Else 
			$b_editable:=((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
			$b_usuarioAutorizado:=((((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
			If ($b_usuarioAutorizado & $b_editable)
				$b_ejesIngresables:=([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Eje_Aprendizaje)
				$b_dimensionesIngresables:=([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Dimension_Aprendizaje)
				
				If (Size of array:C274(alEVLG_RefEstiloEvaluacion)>=$l_fila)
					$l_IdEstiloEvaluacion:=alEVLG_RefEstiloEvaluacion{$l_fila}
					EVS_ReadStyleData ($l_IdEstiloEvaluacion)
					If ((alProEvt=AL Single Control Click) | (($l_columna=5) & (alProEvt=AL Single click event)))
						If ((<>vb_BloquearModifSituacionFinal) | ([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]Status:50="Promovido anticipadamente@") | ([Alumnos:2]Status:50="Egresado"))
							BEEP:C151
						Else 
							
							If ($l_columna>1)
								$b_guardarRegistro:=False:C215
								KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila})
								Case of 
									: (alEVLG_TipoEvaluación{$l_fila}=2)  //binario
										
										$b_MostrarMenu:=True:C214
										Case of 
											: (alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje)
												$l_recNum:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
												KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNum)
												$y_Description:=->[MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18
												$y_Simbolos:=->[MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17
												$r_minimoAprobatorio:=[MPA_DefinicionCompetencias:187]PctParaAprobacion:22
												
												
											: (alEVLG_TipoObjeto{$l_fila}=Dimension_Aprendizaje)
												$l_recNum:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
												KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNum)
												$y_Description:=->[MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16
												$y_Simbolos:=->[MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17
												$r_minimoAprobatorio:=[MPA_DefinicionDimensiones:188]PctParaAprobacion:14
												
												
											: (alEVLG_TipoObjeto{$l_fila}=Eje_Aprendizaje)
												$l_recNum:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
												KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNum)
												$y_Description:=->[MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15
												$y_Simbolos:=->[MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14
												$r_minimoAprobatorio:=[MPA_DefinicionEjes:185]PctParaAprobacion:16
												
											Else 
												$b_MostrarMenu:=False:C215
										End case 
										
										If ($b_MostrarMenu)
											$l_itemSeleccionado:=Pop up menu:C542($y_Description->;0)
											Case of 
												: ($l_itemSeleccionado=1)
													atEVLG_Indicador{$l_fila}:=ST_GetWord ($y_Simbolos->;$l_itemSeleccionado;";")
													$t_decripcionIndicador:=ST_GetWord ($y_Description->;$l_itemSeleccionado;";")
													arEVLG_Indicador{$l_fila}:=1
													$r_valorNumerico:=1
													$b_guardarRegistro:=True:C214
												: ($l_itemSeleccionado=2)
													atEVLG_Indicador{$l_fila}:=ST_GetWord ($y_Simbolos->;$l_itemSeleccionado;";")
													$t_decripcionIndicador:=ST_GetWord ($y_Description->;$l_itemSeleccionado;";")
													arEVLG_Indicador{$l_fila}:=0
													$r_valorNumerico:=0
													$b_guardarRegistro:=True:C214
											End case 
										End if 
										
									: ((alEVLG_TipoEvaluación{$l_fila}=3) | (alEVLG_TipoEvaluación{$l_fila}=1))
										
										  //estilo de evaluación para competencias, dimensiones y ejes
										$l_IdEstiloEvaluacion:=alEVLG_RefEstiloEvaluacion{$l_fila}
										EVS_ReadStyleData ($l_IdEstiloEvaluacion)
										
										Case of 
											: (alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje)
												$r_minimoAprobatorio:=[MPA_DefinicionCompetencias:187]PctParaAprobacion:22
												$b_muestraMenu:=True:C214
												
											: (alEVLG_TipoObjeto{$l_fila}=Dimension_Aprendizaje)
												$r_minimoAprobatorio:=[MPA_DefinicionDimensiones:188]PctParaAprobacion:14
												$b_muestraMenu:=$b_dimensionesIngresables
												
											: (alEVLG_TipoObjeto{$l_fila}=Eje_Aprendizaje)
												$r_minimoAprobatorio:=[MPA_DefinicionEjes:185]PctParaAprobacion:16
												$b_muestraMenu:=$b_ejesIngresables
												
										End case 
										
										If ($b_muestraMenu)
											If (iEvaluationMode=Simbolos)  //si son símbolos despliego el popup con la lista
												$t_menuItems:=""
												For ($i;1;Size of array:C274(aSymbDesc))
													If (Length:C16(aSymbDesc{$i})>76)
														  // MOD Ticket N° 211584 Patricio Aliaga 20180730 
														  // Reemplazo de ( )  por [ ], ya que los parentesis desactivan la opcion del menú.
														  //$t_menuItems:=$t_menuItems+ST_GetCleanString (Substring(aSymbDesc{$i};1;125))+"...;"
														$t_menuItems:=$t_menuItems+Replace string:C233(Replace string:C233(ST_GetCleanString (Substring:C12(aSymbDesc{$i};1;125));"(";"[");")";"]")+"...;"
													Else 
														  // MOD Ticket N° 211584 Patricio Aliaga 20180730
														  // Reemplazo de ( )  por [ ], ya que los parentesis desactivan la opcion del menú.
														  //$t_menuItems:=$t_menuItems+ST_GetCleanString (aSymbDesc{$i})+";"
														$t_menuItems:=$t_menuItems+Replace string:C233(Replace string:C233(ST_GetCleanString (aSymbDesc{$i});"(";"[");")";"]")+";"
													End if 
												End for 
												If ($t_indicadorAnterior#"")
													$t_menuItems:=$t_menuItems+"(-;Borrar"
												Else 
													$t_menuItems:=$t_menuItems+"(-;(Borrar"
												End if 
												$t_llaveAnotacion:=String:C10(Table:C252(->[Alumnos_EvaluacionAprendizajes:203]))+"."+atMPA_uuidRegistro{$l_fila}+"."+String:C10(vl_periodoSeleccionado)
												$b_conAnotacion:=(Find in field:C653([xShell_RecordNotes:283]Llave:4;$t_llaveAnotacion)>No current record:K29:2)
												If ($b_conAnotacion)
													$t_menuItems:=$t_menuItems+";(-;Mostrar anotaciones..."
												Else 
													$t_menuItems:=$t_menuItems+";(-;(Mostrar anotaciones..."
												End if 
												
												$l_itemSeleccionado:=Pop up menu:C542($t_menuItems;0)
												If ($l_itemSeleccionado>0)
													Case of 
														: ($l_itemSeleccionado<=Size of array:C274(aSymbol))  // asignar indicador de evaluación
															If (aSymbPctEqu{$l_itemSeleccionado}>=vrNTA_MinimoEscalaReferencia)
																atEVLG_Indicador{$l_fila}:=aSymbol{$l_itemSeleccionado}
																atEVLG_Observacion{$l_fila}:=Choose:C955(vlEVLG_mostrarObservacion=0;aSymbDesc{$l_itemSeleccionado};atEVLG_Observacion{$l_fila})
																arEVLG_Indicador{$l_fila}:=aSymbPctEqu{$l_itemSeleccionado}
																$r_valorNumerico:=aSymbGradesEqu{$l_itemSeleccionado}
																$t_decripcionIndicador:=aSymbDesc{$l_itemSeleccionado}
															Else 
																CD_Dlog (0;__ ("No se ha definido la equivalencia numérica para el símbolo ingresado en el estilo de evaluación utilizado por la comptencia.\r\rEl símbolo ingresado no puede ser acepatado."))
																$t_decripcionIndicador:=atEVLG_Observacion{$l_fila}
																$r_valorNumerico:=arEVLG_Indicador{$l_fila}
															End if 
															AL_UpdateArrays ($l_referenciaArea;-1)
															$b_guardarRegistro:=True:C214
															
														: ($l_itemSeleccionado=(Size of array:C274(aSymbol)+2))  // eliminar evaluacion
															atEVLG_Indicador{$l_fila}:=""
															atEVLG_Observacion{$l_fila}:=""
															arEVLG_Indicador{$l_fila}:=-10
															$t_decripcionIndicador:=""
															$r_valorNumerico:=-10
															$b_guardarRegistro:=True:C214
															
														: ($l_itemSeleccionado=(Size of array:C274(aSymbol)+4))  // ver anotaciones
															QUERY:C277([xShell_RecordNotes:283];[xShell_RecordNotes:283]Llave:4=$t_llaveAnotacion)
															XSNota_MuestraLista 
													End case 
													
												End if 
											End if 
										End if 
								End case 
								
								
								KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila};True:C214)
								If (($b_guardarRegistro) & (arEVLG_Indicador{$l_fila}<$r_minimoAprobatorio) & (adEVLG_FechaLogro{$l_fila}#!00-00-00!) & (arEVLG_Indicador{$l_fila}<$r_evaluacionAnterior))
									If (arEVLG_Indicador{$l_fila}>-10)
										$t_fecha:=atMPA_FechaLogro{$l_fila}
										$t_evento:=__ ("Reevaluación en ^0 de competencia adquirida previamente el ^1: ^2 en lugar de ^3")
										$t_nuevaEvaluacion:=atEVLG_Indicador{$l_fila}
										$t_evaluacionAnterior:=atEVLG_Indicador{0}
										$t_periodo:=atSTR_Periodos_Nombre{vl_periodoSeleccionado}
										$t_evento:=Replace string:C233($t_evento;"^0";$t_periodo)
										$t_evento:=Replace string:C233($t_evento;"^1";$t_fecha)
										$t_evento:=Replace string:C233($t_evento;"^2";IT_SetTextStyle_Bold (->$t_nuevaEvaluacion))
										$t_evento:=Replace string:C233($t_evento;"^3";IT_SetTextStyle_Bold (->$t_indicadorAnterior;True:C214))
										
										$t_tituloVentana:="Modificación de la evaluación de una competencia adquirida"
										$t_mensaje:=__ ("Usted acaba de registrar una calificación no aprobatoria en ^1 para una competencia evaluada y adquirida el ^0.\r\r"+"Si confirma la modificación que acaba de introducir se mantendrán las evaluaciones indicadoras de adquisición en "+"períodos anteriores pero la competencia se considerará no adquirida y se eliminarán las evaluaciones aprobatorias reportadas desde períodos anteriores.\r\r"+"Por favor ingrese un comentario que explique por qué considera que la competencia no ha sido adquirida")
										$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_fecha))
										$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_periodo;True:C214))
									Else 
										$t_fecha:=atMPA_FechaLogro{$l_fila}
										$t_evento:=__ ("Eliminación de una evaluación aprobatoria (^3) en ^0 en una competencia adquirida previamente el ^1")
										$t_nuevaEvaluacion:=atEVLG_Indicador{$l_fila}
										$t_evento:=Replace string:C233($t_evento;"^0";vt_periodo)
										$t_evento:=Replace string:C233($t_evento;"^1";$t_fecha)
										$t_evento:=Replace string:C233($t_evento;"^3";IT_SetTextStyle_Bold (->$t_indicadorAnterior;True:C214))
										
										$t_tituloVentana:="Eliminación de la evaluación en una competencia adquirida"
										$t_mensaje:=__ ("Usted solicitó borrar una evaluación aprobatoria (^2) en ^1 para una competencia evaluada y adquirida el ^0.\r\r"+"Si confirma la eliminación de la evaluación se mantendrán las evaluaciones indicadoras de adquisición en "+"períodos anteriores pero la competencia se considerará no adquirida y se eliminarán las evaluaciones aprobatorias reportadas desde períodos anteriores.\r\r"+"Por favor ingrese un comentario que explique por qué elimina esta evaluación.")
										$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_fecha))
										$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->vt_periodo;True:C214))
										$t_mensaje:=Replace string:C233($t_mensaje;"^2";IT_SetTextStyle_Bold (->$t_indicadorAnterior;True:C214))
									End if 
									
									
									$l_accionUsuario:=XSnota_RegistraNota (->[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->vl_PeriodoSeleccionado;$t_evento;$t_mensaje;$t_tituloVentana;__ ("Confirmar");__ ("Cancelar"))
									If ($l_accionUsuario=1)
										adEVLG_FechaLogro{$l_fila}:=!00-00-00!
										atMPA_FechaLogro{$l_fila}:=""
										atEVLG_Observacion{$l_fila}:=""
										MPA_AnulaEvaluacionAdquirida (alEVLG_RecNum{$l_fila};vl_PeriodoSeleccionado+1;viSTR_Periodos_NumeroPeriodos)
									Else 
										arEVLG_Indicador{$l_fila}:=$r_evaluacionAnterior
										atEVLG_Indicador{$l_fila}:=$t_indicadorAnterior
										  //atEVLG_Observacion{$l_fila}:=$t_decripcionIndicador 20181008 ASM Ticket 217933
										$b_guardarRegistro:=False:C215
										AL_UpdateArrays ($l_referenciaArea;-2)  // 20181008 ASM Ticket 217933
									End if 
								End if 
								
								
								If ($b_guardarRegistro)
									Case of 
										: (vl_PeriodoSeleccionado=1)
											$y_literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
											$y_numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
										: (vl_PeriodoSeleccionado=2)
											$y_literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
											$y_numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
										: (vl_PeriodoSeleccionado=3)
											$y_literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
											$y_numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
										: (vl_PeriodoSeleccionado=4)
											$y_literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
											$y_numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
										: (vl_PeriodoSeleccionado=5)
											$y_literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
											$y_numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
										: (vl_PeriodoSeleccionado=-1)
											$y_literal:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
											$y_numerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
									End case 
									
									KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila};True:C214)
									If (OK=1)
										$y_literal->:=atEVLG_Indicador{$l_fila}
										$y_real->:=arEVLG_Indicador{$l_fila}
										$y_numerico->:=$r_valorNumerico
										$y_indicador->:=$t_decripcionIndicador
										
										MPA_CompetenciaAdquirida ($y_real->;vl_periodoSeleccionado)
										If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89#!00-00-00!)
											atMPA_FechaLogro{$l_fila}:=String:C10([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;Internal date short:K1:7)
											adEVLG_FechaLogro{$l_fila}:=[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89
										Else 
											atMPA_FechaLogro{$l_fila}:=""
											adEVLG_FechaLogro{$l_fila}:=!00-00-00!
										End if 
										$l_periodos_a_recalcular:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ vl_PeriodoSeleccionado
										$t_MPA_oldValue:=Old:C35($y_literal->)
										SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
										$l_recnumAEA:=Record number:C243([Alumnos_EvaluacionAprendizajes:203])  //MONO 207220
										If (vl_PeriodoSeleccionado>0)  //MONO ticket 207220
											For ($i;1;viSTR_Periodos_NumeroPeriodos)
												If ($l_periodos_a_recalcular ?? $i)
													$b_promediosModificados:=$b_promediosModificados & MPA_Calculos ($l_recnumAEA;$i)
													If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])=0)
														KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recnumAEA)
													End if 
												End if 
											End for 
										Else   //MONO ticket 207220
											If ($l_periodos_a_recalcular ?? vl_PeriodoSeleccionado)
												$b_promediosModificados:=$b_promediosModificados & MPA_Calculos ($l_recnumAEA;vl_PeriodoSeleccionado)
												If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])=0)
													KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recnumAEA)
												End if 
											End if 
										End if 
										
										  //MONO - ticket 165579
										QR_AluEvAprendizaje_GetData ([Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->$t_logEnunciado;->$t_logTipoObj)
										$t_MPA_detalleCambio:="Periodo "+String:C10(vl_PeriodoSeleccionado)+" "+$t_logTipoObj+": "+$t_logEnunciado+" - Evaluación "+$t_MPA_oldValue+" >> "+$y_literal->
										
										LOG_RegisterEvt ("Modificación en evaluación de aprendizajes para "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20+" en "+[Asignaturas:18]Asignatura:3+" - "+$t_MPA_detalleCambio)
										KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
										vtEVLG_VistaActual:="Alumnos"
										
										If (([MPA_AsignaturasMatrices:189]Convertir_a_Notas:9) & (vl_PeriodoSeleccionado>0))
											$t_llaveRegistroEvaluacion:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
											$b_promediosModificados:=MPA_Aprendizajes_a_Notas ([Asignaturas:18]EVAPR_IdMatriz:91;$t_llaveRegistroEvaluacion)
											If ($b_promediosModificados)
												modNotas:=True:C214
											End if 
										End if 
										
										If (vlEVLG_mostrarObservacion=0)
											atEVLG_Observacion{$l_fila}:=$t_decripcionIndicador
										End if 
										
										
										MPA_AparienciaEvaluaciones ($l_referenciaArea)
										AL_UpdateArrays ($l_referenciaArea;-1)
										
									End if 
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
End case 