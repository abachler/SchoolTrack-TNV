  // [Asignaturas].Input.evaluacion6()
  //
  //
  // creado por: Alberto Bachler Klein: 16-12-16, 17:58:54
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_esEditable;$b_guardar;$b_promediosModificados)
C_DATE:C307($d_fecha)
C_LONGINT:C283($l_abajoObjeto;$l_abajoVentana;$l_altoFormulario;$l_anchoFormulario;$l_arribaObjeto;$l_arribaObjetoOffset;$l_arribaVentana;$l_boton;$l_columna;$l_derechaObjeto)
C_LONGINT:C283($l_derechaVentana;$l_fila;$l_IdEstiloEvaluacion;$l_idObjeto;$l_itemSeleccionado;$l_izquierdaObjeto;$l_izquierdaObjetoOffset;$l_izquierdaVentana;$l_mouseX;$l_mouseY)
C_LONGINT:C283($l_posicionAbajo;$l_posicionArriba;$l_posicionDerecha;$l_posicionIzquierda;$l_recNumObjeto;$l_refLista;$l_tipoObjeto;$l_recNum;$l_refVentana)
C_POINTER:C301($y_Indicador;$y_Literal;$y_Numerico;$y_Real)
C_REAL:C285($r_miniAprobatorio;$r_valorReal)
C_TEXT:C284($t_descripcionIndicador;$t_fecha;$t_itemsMenu;$t_key;$t_nombreObjeto;$t_logEnunciado;$t_logTipoObj;$t_MPA_oldValue)

C_BOOLEAN:C305(vb_MostrarFechas)

$l_columna:=AL_GetColumn (Self:C308->)
$l_fila:=AL_GetClickedRow (Self:C308->)


If (($l_fila>0) & ($l_fila<=Size of array:C274(alEVLG_RecNum)))  //MONO 19-06-2019 Ticket 209074: $l_fila queda con valor -2, cuando hacemos click en una linea que sobrepasa el tamaño de los arrays usados en el área. 
	  //MONO FIX
	$r_evaluacionAnterior:=arEVLG_Indicador{$l_fila}
	$t_indicadorAnterior:=atEVLG_Indicador{$l_fila}
	$t_decripcionIndicador:=atEVLG_Observacion{$l_fila}
	
	$b_esEditable:=((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
	$b_esEditable:=$b_esEditable & ((((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
	If ($b_esEditable)
		$l_IdEstiloEvaluacion:=alEVLG_RefEstiloEvaluacion{$l_fila}
		EVS_ReadStyleData ($l_IdEstiloEvaluacion)
		$r_miniAprobatorio:=rPctMinimum
		
		$l_refLista:=(OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados"))->
		GET LIST ITEM:C378($l_refLista;Selected list items:C379($l_refLista);$l_recNumObjeto;$t_nombreObjeto)
		GET LIST ITEM PARAMETER:C985($l_refLista;$l_recNumObjeto;"TipoObjeto";$l_tipoObjeto)
		GET LIST ITEM PARAMETER:C985($l_refLista;$l_recNumObjeto;"IdObjeto";$l_idObjeto)
		
		Case of 
			: ((alProEvt=AL Column click event) | (alProEvt=AL Column control click event)) & ($l_fila=0)  // clic derecho en el encabezado
				$t_itemsMenu:=__ ("Mostrar descripción del Indicador;Mostrar Observaciones")
				$l_itemSeleccionado:=Pop up menu:C542($t_itemsMenu)
				If ($l_itemSeleccionado>0)
					vlEVLG_mostrarObservacion:=$l_itemSeleccionado-1
					PREF_Set (0;"Indicador/Observación";String:C10(vlEVLG_mostrarObservacion))
					AS_EVLG_CargaEvaluacion ($l_tipoObjeto;[Asignaturas:18]Numero:1;$l_idObjeto;vl_PeriodoSeleccionado)
				End if 
				
				
			: ((((alProEvt=AL Single click event) & (IT_AltKeyIsDown  & Shift down:C543 & (Macintosh command down:C546 | Windows Ctrl down:C562)) & ($l_columna=2)) | (($l_columna=4) & (vb_MostrarFechas) & (alProEvt=AL Single Control Click))) & (atEVLG_Indicador{$l_fila}#"") & (alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje) & (arEVLG_Indicador{$l_fila}>$r_miniAprobatorio))
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila};True:C214)
				If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89#!00-00-00!)
					$d_fecha:=DT_PopCalendar 
					$t_fecha:=String:C10($d_fecha)
				Else 
					$d_fecha:=DT_PopCalendar 
					$t_fecha:=String:C10($d_fecha)
				End if 
				If ($t_fecha#"")
					$d_fecha:=DT_StringDate2Date ($t_fecha)
					If ($d_fecha#!00-00-00!)
						If (DateIsValid ($d_fecha))
							[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=$d_fecha
							SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
							atMPA_FechaLogro{$l_fila}:=String:C10([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;7)
						End if 
					End if 
				End if 
				
			: ((alProEvt=AL Single Control Click) | (($l_columna=5) & (alProEvt=AL Single click event)))
				KRL_GotoRecord (->[Alumnos:2];alEVLG_RecNumAlumnos{$l_fila})
				If ((<>vb_BloquearModifSituacionFinal) | ([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]Status:50="Promovido anticipadamente@") | ([Alumnos:2]Status:50="Egresado"))
					BEEP:C151
					  //nada, registro de información bloqueado
				Else 
					
					Case of 
							
						: ((alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje) & ($l_columna>1))
							$b_guardar:=False:C215
							Case of 
								: (alEVLG_TipoEvaluación{$l_fila}=1)  //indicadores de logro
									KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila})
									$l_recNum:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
									KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNum)
									$r_miniAprobatorio:=[MPA_DefinicionCompetencias:187]PctParaAprobacion:22
									GET WINDOW RECT:C443($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana)
									OBJECT GET COORDINATES:C663(Self:C308->;$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
									FORM GET PROPERTIES:C674([MPA_DefinicionCompetencias:187];"Indicadores";$l_anchoFormulario;$l_altoFormulario)
									GET MOUSE:C468($l_mouseX;$l_mouseY;$l_boton;*)
									$l_arribaObjetoOffset:=$l_arribaVentana+$l_arribaObjeto+16  //23 alto del header del area
									$l_izquierdaObjetoOffset:=$l_izquierdaVentana
									$l_posicionIzquierda:=$l_izquierdaObjetoOffset+$l_izquierdaObjeto+250+1  //250 anchos de las columnas 1 y 2
									$l_posicionArriba:=$l_arribaObjetoOffset+(($l_fila)*26)
									If (($l_mouseX+$l_anchoFormulario)<$l_derechaVentana)
										$l_posicionDerecha:=$l_posicionIzquierda+$l_anchoFormulario-2
									Else 
										$l_posicionIzquierda:=$l_derechaVentana-$l_anchoFormulario
										$l_posicionDerecha:=$l_posicionIzquierda+$l_anchoFormulario
									End if 
									$l_posicionAbajo:=$l_posicionArriba+$l_altoFormulario-2
									If ($l_posicionAbajo>$l_abajoVentana)
										$l_posicionArriba:=$l_abajoVentana-$l_altoFormulario
										$l_posicionAbajo:=$l_posicionArriba+$l_altoFormulario-2
									End if 
									$l_refVentana:=Open window:C153($l_posicionIzquierda;$l_posicionArriba;$l_posicionDerecha;$l_posicionAbajo;2)
									WDW_SetWindowIcon ($l_refVentana)
									DIALOG:C40([MPA_DefinicionCompetencias:187];"Indicadores")
									CLOSE WINDOW:C154
									If (OK=1)
										atEVLG_Indicador{$l_fila}:=atEVLG_Indicadores_Concepto{atEVLG_Indicadores_Descripcion}
										$t_descripcionIndicador:=atEVLG_Indicadores_Descripcion{atEVLG_Indicadores_Descripcion}
										arEVLG_Indicador{$l_fila}:=Round:C94(aiEVLG_Indicadores_Valor{atEVLG_Indicadores_Descripcion}/[MPA_DefinicionCompetencias:187]Maximo_Indicadores:9*100;11)
										$r_valorReal:=aiEVLG_Indicadores_Valor{atEVLG_Indicadores_Descripcion}
										$b_guardar:=True:C214
									End if 
									
								: (alEVLG_TipoEvaluación{$l_fila}=3)  //estilo de evaluación
									
									$l_IdEstiloEvaluacion:=alEVLG_RefEstiloEvaluacion{$l_fila}
									EVS_ReadStyleData ($l_IdEstiloEvaluacion)
									  //$r_miniAprobatorio:=rPctMinimum
									  //MONO FIX 212957
									Case of 
										: (alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje)
											$r_minimoAprobatorio:=[MPA_DefinicionCompetencias:187]PctParaAprobacion:22
											
										: (alEVLG_TipoObjeto{$l_fila}=Dimension_Aprendizaje)
											$r_minimoAprobatorio:=[MPA_DefinicionDimensiones:188]PctParaAprobacion:14
											
										: (alEVLG_TipoObjeto{$l_fila}=Eje_Aprendizaje)
											$r_minimoAprobatorio:=[MPA_DefinicionEjes:185]PctParaAprobacion:16
											
									End case 
									
									If (iEvaluationMode=Simbolos)  //si son símbolos despliego el popup cion la lista
										$t_itemsMenu:=AT_array2text (->aSymbDesc;";")+";(-;Borrar"
										$l_itemSeleccionado:=Pop up menu:C542($t_itemsMenu;0)
										If ($l_itemSeleccionado>0)
											If ($l_itemSeleccionado<=Size of array:C274(aSymbol))
												If (aSymbPctEqu{$l_itemSeleccionado}>=vrNTA_MinimoEscalaReferencia)
													atEVLG_Indicador{$l_fila}:=aSymbol{$l_itemSeleccionado}
													$t_descripcionIndicador:=aSymbDesc{$l_itemSeleccionado}
													atEVLG_Observacion{$l_fila}:=$t_descripcionIndicador
													arEVLG_Indicador{$l_fila}:=aSymbPctEqu{$l_itemSeleccionado}
													$r_valorReal:=aSymbGradesEqu{$l_itemSeleccionado}
												Else 
													CD_Dlog (0;__ ("No se ha definido la equivalencia numérica para el símbolo ingresado en el estilo de evaluación utilizado por la comptencia.\r\rEl símbolo ingresado no puede ser acepatado."))
													$t_descripcionIndicador:=atEVLG_Observacion{$l_fila}
													$r_valorReal:=arEVLG_Indicador{$l_fila}
												End if 
											Else 
												atEVLG_Indicador{$l_fila}:=""
												$t_descripcionIndicador:=""
												atEVLG_Observacion{$l_fila}:=$t_descripcionIndicador
												arEVLG_Indicador{$l_fila}:=-10
												$r_valorReal:=-10
											End if 
											AL_UpdateArrays (Self:C308->;-1)
											$b_guardar:=True:C214
										End if 
									End if 
							End case 
							
							If ($b_guardar)
								Case of 
									: (vl_PeriodoSeleccionado=1)
										$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
										$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
										$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
										$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
									: (vl_PeriodoSeleccionado=2)
										$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
										$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
										$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
										$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
									: (vl_PeriodoSeleccionado=3)
										$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
										$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
										$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
										$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
									: (vl_PeriodoSeleccionado=4)
										$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
										$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
										$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
										$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
									: (vl_PeriodoSeleccionado=5)
										$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
										$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
										$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
										$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
									: (vl_PeriodoSeleccionado=-1)
										$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
										$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
										$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
										$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
										
								End case 
								
								KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila};True:C214)
								
								
								  //MONO FIX 212957 Cambio de evaluación en una competencia con adquirida 
								  /////////////////////////////////////////////////////////////////////////////////////////////////
								If (($b_guardar) & (arEVLG_Indicador{$l_fila}<$r_minimoAprobatorio) & (adEVLG_FechaLogro{$l_fila}#!00-00-00!) & (arEVLG_Indicador{$l_fila}<$r_evaluacionAnterior))
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
										atMPA_FechaLogro{$l_fila}:=""
										MPA_AnulaEvaluacionAdquirida (alEVLG_RecNum{$l_fila};vl_PeriodoSeleccionado+1;viSTR_Periodos_NumeroPeriodos)
									Else 
										arEVLG_Indicador{$l_fila}:=$r_evaluacionAnterior
										atEVLG_Indicador{$l_fila}:=$t_indicadorAnterior
										atEVLG_Observacion{$l_fila}:=$t_decripcionIndicador
										$b_guardar:=False:C215
									End if 
								End if 
							End if 
							  /////////////////////////////////////////////////////////////////////////////////////////////////
							
							If ((OK=1) & ($b_guardar))  //MONO FIX 212957
								$y_Literal->:=atEVLG_Indicador{$l_fila}
								$y_Real->:=arEVLG_Indicador{$l_fila}
								$y_Numerico->:=$r_valorReal
								$y_Indicador->:=$t_descripcionIndicador
								  //20180730 ASM Ticket 21957.
								MPA_CompetenciaAdquirida ($y_Real->;vl_PeriodoSeleccionado)
								If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89#!00-00-00!)
									adEVLG_FechaLogro{$l_fila}:=[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89
									atMPA_FechaLogro{$l_fila}:=String:C10([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;Internal date short:K1:7)  //MONO FIX 212957
								Else 
									adEVLG_FechaLogro{$l_fila}:=!00-00-00!  //MONO FIX 212957
									atMPA_FechaLogro{$l_fila}:=""
								End if 
								
								$t_MPA_oldValue:=Old:C35($y_literal->)
								SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
								
								  //MONO - ticket 165579
								QR_AluEvAprendizaje_GetData ([Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->$t_logEnunciado;->$t_logTipoObj)
								$t_MPA_detalleCambio:="Periodo "+String:C10(vl_PeriodoSeleccionado)+" "+$t_logTipoObj+": "+$t_logEnunciado+" - Evaluación "+$t_MPA_oldValue+" >> "+$y_literal->
								LOG_RegisterEvt ("Modificación en evaluación de aprendizajes para "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20+" en "+[Asignaturas:18]Asignatura:3+" - "+$t_MPA_detalleCambio)
								
								KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
								
								MPA_Calculos (Record number:C243([Alumnos_EvaluacionAprendizajes:203]);vl_PeriodoSeleccionado)
								If (([MPA_AsignaturasMatrices:189]Convertir_a_Notas:9) & (vl_PeriodoSeleccionado>0))
									$t_key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
									$b_promediosModificados:=MPA_Aprendizajes_a_Notas ([Asignaturas:18]EVAPR_IdMatriz:91;$t_key;vl_PeriodoSeleccionado)
									If ($b_promediosModificados)
										modNotas:=True:C214
									End if 
								End if 
								
								MPA_AparienciaEvaluaciones (Self:C308->)  //MONO FIX 212957
								AL_UpdateArrays (Self:C308->;-1)
								If (vlEVLG_mostrarObservacion=0)
									atEVLG_Observacion{$l_fila}:=$t_descripcionIndicador
								End if 
							End if 
							
							  //20120829 ASM  para desplegar los indicadores.
							
						: ((alEVLG_TipoObjeto{$l_fila}=Eje_Aprendizaje) | (alEVLG_TipoObjeto{$l_fila}=Dimension_Aprendizaje) & ($l_columna>1))
							Case of 
								: (alEVLG_TipoObjeto{$l_fila}=Eje_Aprendizaje)
									$b_ingresable:=([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Eje_Aprendizaje)
								: (alEVLG_TipoObjeto{$l_fila}=Dimension_Aprendizaje)
									$b_ingresable:=([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Dimension_Aprendizaje)
							End case 
							If ($b_ingresable)
								$b_guardar:=False:C215
								Case of 
									: (alEVLG_TipoEvaluación{$l_fila}=1)
										$l_IdEstiloEvaluacion:=alEVLG_RefEstiloEvaluacion{$l_fila}
										EVS_ReadStyleData ($l_IdEstiloEvaluacion)
										$r_miniAprobatorio:=rPctMinimum
										If (iEvaluationMode=Simbolos)  //si son símbolos despliego el popup cion la lista
											$t_itemsMenu:=AT_array2text (->aSymbDesc;";")+";(-;Borrar"
											$l_itemSeleccionado:=Pop up menu:C542($t_itemsMenu;0)
											If ($l_itemSeleccionado>0)
												If ($l_itemSeleccionado<=Size of array:C274(aSymbol))
													If (aSymbPctEqu{$l_itemSeleccionado}>=vrNTA_MinimoEscalaReferencia)
														atEVLG_Indicador{$l_fila}:=aSymbol{$l_itemSeleccionado}
														$t_descripcionIndicador:=aSymbDesc{$l_itemSeleccionado}
														arEVLG_Indicador{$l_fila}:=aSymbPctEqu{$l_itemSeleccionado}
														$r_valorReal:=aSymbGradesEqu{$l_itemSeleccionado}
													Else 
														CD_Dlog (0;__ ("No se ha definido la equivalencia numérica para el símbolo ingresado en el estilo de evaluación utilizado por la comptencia.\r\rEl símbolo ingresado no puede ser acepatado."))
														$t_descripcionIndicador:=atEVLG_Observacion{$l_fila}
														$r_valorReal:=arEVLG_Indicador{$l_fila}
													End if 
												Else 
													atEVLG_Indicador{$l_fila}:=""
													$t_descripcionIndicador:=""
													arEVLG_Indicador{$l_fila}:=-10
													$r_valorReal:=-10
												End if 
												AL_UpdateArrays (Self:C308->;-1)
												$b_guardar:=True:C214
											End if 
										End if 
								End case 
								
								
								If ($b_guardar)
									Case of 
										: (vl_PeriodoSeleccionado=1)
											$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
											$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
										: (vl_PeriodoSeleccionado=2)
											$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
											$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
										: (vl_PeriodoSeleccionado=3)
											$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
											$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
										: (vl_PeriodoSeleccionado=4)
											$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
											$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
										: (vl_PeriodoSeleccionado=5)
											$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
											$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
										: (vl_PeriodoSeleccionado=-1)
											$y_Literal:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
											$y_Real:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
											$y_Numerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
											$y_Indicador:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
											
									End case 
									KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila};True:C214)
									If (OK=1)
										$y_Literal->:=atEVLG_Indicador{$l_fila}
										$y_Real->:=arEVLG_Indicador{$l_fila}
										$y_Numerico->:=$r_valorReal
										$y_Indicador->:=$t_descripcionIndicador
										
										If (viSTR_Periodos_NumeroPeriodos=1)
											If ((atMPA_FechaEstimada{$l_fila}#"") & (alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje))
												If ($y_Literal->#"")
													If ($y_Real->>=$r_miniAprobatorio)
														If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89=!00-00-00!)
															[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=Current date:C33(*)
														End if 
													Else 
														[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!
													End if 
												Else 
													[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!
												End if 
											Else 
												[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!
											End if 
											If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89#!00-00-00!)
												atMPA_FechaLogro{$l_fila}:=String:C10([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89;7)
											Else 
												atMPA_FechaLogro{$l_fila}:=""
											End if 
										End if 
										SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
										LOG_RegisterEvt ("Modificación en evaluación de aprendizajes para "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20+" en "+[Asignaturas:18]Asignatura:3)
										KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
										
										MPA_Calculos (Record number:C243([Alumnos_EvaluacionAprendizajes:203]);vl_PeriodoSeleccionado)
										If (([MPA_AsignaturasMatrices:189]Convertir_a_Notas:9) & (vl_PeriodoSeleccionado>0))
											$t_key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
											$b_promediosModificados:=MPA_Aprendizajes_a_Notas ([Asignaturas:18]EVAPR_IdMatriz:91;$t_key;vl_PeriodoSeleccionado)
											If ($b_promediosModificados)
												modNotas:=True:C214
											End if 
										End if 
										
										AL_UpdateArrays (Self:C308->;-1)
										If (vlEVLG_mostrarObservacion=0)
											atEVLG_Observacion{$l_fila}:=$t_descripcionIndicador
										End if 
									End if 
								End if 
							End if 
							
					End case 
					
				End if 
		End case 
	End if 
End if 