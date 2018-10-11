Case of 
	: (alProEvt=0)
		AL_ExitCell (Self:C308->)
		
		
	: (alproevt=1)
		$l_columna:=AL_GetColumn (Self:C308->)
		$l_fila:=AL_GetLine (Self:C308->)
		If (vl_year=<>gYear)
			$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
			If (($l_fila>0) & ((USR_checkRights ("D";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36)))
				_O_ENABLE BUTTON:C192(bDelLine)
			Else 
				_O_DISABLE BUTTON:C193(bdelLine)
			End if 
		Else 
			_O_DISABLE BUTTON:C193(bdelLine)
		End if 
		
		  //20120814 ASM para mostrar las observaciones  ticket (112524)
		ARRAY TEXT:C222(at_lineas;0)
		C_TEXT:C284(vt_Observacion)
		
		$page:=Selected list items:C379(vltab_Conducta)
		
		Case of 
			: ($page=1)
				$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
				If ($l_modoRegistroAsistencia=2)
					_O_DISABLE BUTTON:C193(bdelLine)
					_O_DISABLE BUTTON:C193(bAddLine)
				End if 
			: ($page=5)
				If ($l_columna=5)
					  //GOTO RECORD([Alumnos_Anotaciones];alSTRal_RecNumItemAnotacion{$l_fila})
					GOTO RECORD:C242([Alumnos_Anotaciones:11];<>aCdtaRecNo{$l_fila})
					vt_Observacion:=[Alumnos_Anotaciones:11]Observaciones:4
					AL_GetWidths (xALP_ConductaAlumnos;$l_columna;$l_columna;$sizeColum)
					AL_GetStyle (xALP_ConductaAlumnos;$l_columna;$fontName;$size;$style)
					hmFree_TEXT2ARRAY (vt_Observacion;at_lineas;$sizeColum;$fontName;$size;$style)
					If (vi_LineasPorFila<Size of array:C274(at_lineas))
						WDW_OpenPopupWindow (->vt_Observacion;->[Alumnos_Anotaciones:11];"Observaciones";32)
						DIALOG:C40([Alumnos_Anotaciones:11];"Observaciones";*)
					End if 
				End if 
				
			: ($page=2)
				
				Case of 
					: ($l_columna=4)
						
						$l_modoRegistroInasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->vl_nivelSeleccionado;->[xxSTR_Niveles:6]AttendanceMode:3)
						If ($l_modoRegistroInasistencia=2)
							
							$l_inasistencias:=Num:C11(String:C10(ST_GetWord (at_AbsencesTotal{$l_fila};1;"(")))
							If ($l_inasistencias>0)
								USE SET:C118("$Inasistencias")
								QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Asignatura:6=al_IDAsignaturas{$l_fila})
								SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]dateSesion:4;$ad_fechasInasistencia;[Asignaturas_Inasistencias:125]Hora:8;$al_NumeroHora)
								AT_MultiLevelSort ("<<";->$ad_fechasInasistencia;->$al_NumeroHora)
								$t_Text:=""
								For ($i;1;Size of array:C274($ad_fechasInasistencia))
									$t_text:=$t_text+"- "+String:C10($ad_fechasInasistencia{$i};System date long:K1:3)+", Hora Nº "+String:C10($al_NumeroHora{$i};"00")+"\r"
								End for 
								$t_text:=Substring:C12($t_text;1;Length:C16($t_text)-1)
								  //IT_MuestraInfoDetallada_Texto ($t_text;"Inasistencias registradas en "+at_subjectName{$l_fila}) no funciona cuando el detalle es grande
								IT_ShowScrollableText ($t_text;"Inasistencias registradas en "+at_subjectName{$l_fila})
							End if 
							
						End if 
						
					: ($l_columna=3)
						  //QUERY WITH ARRAY([Asignaturas_RegistroSesiones]ID_Asignatura;al_IDAsignaturas)
						  //mono ticket 143138
						QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=al_IDAsignaturas{$l_fila};*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Año:13=vl_Year)
						SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$ad_fechasSesiones;[Asignaturas_RegistroSesiones:168]Hora:4;$al_NumeroHora)
						AT_MultiLevelSort ("<<";->$ad_fechasSesiones;->$al_NumeroHora)
						$t_Text:=""
						For ($i;1;Size of array:C274($ad_fechasSesiones))
							$t_text:=$t_text+"- "+String:C10($ad_fechasSesiones{$i};System date long:K1:3)+", Hora Nº "+String:C10($al_NumeroHora{$i};"00")+"\r"
						End for 
						$t_text:=Substring:C12($t_text;1;Length:C16($t_text)-1)
						  //IT_MuestraInfoDetallada_Texto ($t_text;"Sesiones de clases "+at_subjectName{$l_fila})
						IT_ShowScrollableText ($t_text;"Sesiones de clases "+at_subjectName{$l_fila})
				End case 
		End case 
		
		
		
	: (alproevt=5)
		$page:=Selected list items:C379(vltab_Conducta)
		Case of 
			: ($page=5)  //anotaciones
				$line:=AL_GetLine (Self:C308->)
				$l_columna:=AL_GetColumn (Self:C308->)
				If (vl_year=<>gYear)
					If (($l_columna=3) & ((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36)))
						$choice:=AL_MuestraListaAnotaciones 
						If ($choice>0)
							$motivo:=vtHL_SelectedElementText
							$el:=Find in array:C230(<>atSTR_Anotaciones_motivo;$motivo)
							If ($el>0)
								$categoria:=<>atSTR_Anotaciones_categorias{$el}
								$matriz:=<>aiID_Matriz{$el}
								$puntaje:=<>aiSTR_Anotaciones_puntaje{$el}
								$el2:=Find in array:C230(aiSTR_IDCategoria;$matriz)
								If ($el2>0)
									
									Case of 
										: (ai_TipoAnotacion{$el2}>0)
											$signo:="+"
										: (ai_TipoAnotacion{$el2}=0)
											$signo:="="
											$puntaje:=0
										: (ai_TipoAnotacion{$el2}<0)
											$signo:="-"
											$puntaje:=$puntaje*-1
									End case 
									  //GOTO RECORD([Alumnos_Anotaciones];alSTRal_RecNumItemAnotacion{$line})
									GOTO RECORD:C242([Alumnos_Anotaciones:11];<>aCdtaRecNo{$line})
									If (Not:C34(KRL_IsRecordLocked (->[Alumnos_Anotaciones:11])))
										alSTRal_PuntosAnotacion{$line}:=$puntaje
										atSTRal_CategoriaAnotacion{$line}:=$categoria
										atSTRal_MotivoAnotacion{$line}:=$motivo
										atSTRal_TipoAnotacion{$line}:=$signo
										[Alumnos_Anotaciones:11]Categoria:8:=$categoria
										[Alumnos_Anotaciones:11]Puntos:9:=$puntaje
										[Alumnos_Anotaciones:11]Signo:7:=$signo
										[Alumnos_Anotaciones:11]Motivo:3:=$motivo
										SAVE RECORD:C53([Alumnos_Anotaciones:11])
										AL_UpdateArrays (Self:C308->;-1)
										For ($i;1;Size of array:C274(<>aCdtaRecNo))
											Case of 
												: (atSTRal_TipoAnotacion{$i}="-")
													AL_SetRowColor (xALP_ConductaAlumnos;$i;"Red")
												: (atSTRal_TipoAnotacion{$i}="=")
													AL_SetRowColor (xALP_ConductaAlumnos;$i;"Blue")
												: (atSTRal_TipoAnotacion{$i}="+")
													AL_SetRowColor (xALP_ConductaAlumnos;$i;"Green")
											End case 
										End for 
									End if 
								End if 
							End if 
						End if 
					End if 
				End if 
				
				
			: ($page=6)
				  // JVP se crea nueva visualizacion para las medidas, debido a que cuando el texto es muy extenso no se visualizan
				  //de manera correcta, se uso como base lo realizado en la columna motivo de las anotaciones
				  //ticket 149034  27-08-2015
				
				$line:=AL_GetLine (Self:C308->)
				$l_columna:=AL_GetColumn (Self:C308->)
				If (vl_year=<>gYear)
					If (($l_columna=2) & ((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36)))
						$choice:=0
						$choice:=AL_MuestraListaMedidas 
						If ($choice#0)
							$motivo:=vtHL_SelectedElementText
							$el:=Find in array:C230(<>atSTRal_MotivosCastigo;$motivo)
							If ($el>0)
								$categoria:=<>atSTRal_MotivosCastigo{$el}
								GOTO RECORD:C242([Alumnos_Castigos:9];<>aCdtaRecNo{$line})
								If (Not:C34(KRL_IsRecordLocked (->[Alumnos_Castigos:9])))
									atSTRal_MotivosCastigo{$line}:=$categoria
									
									<>aCdtaText1{$line}:=$categoria
									[Alumnos_Castigos:9]Motivo:2:=$categoria
									SAVE RECORD:C53([Alumnos_Castigos:9])
									AL_UpdateArrays (Self:C308->;-1)
								End if 
								
							End if 
						End if 
					End if 
				End if 
			: ($page=4)  //Atrasos
				C_BOOLEAN:C305($b_menufraccion;$b_continuar)  ///159627
				$b_menufraccion:=False:C215  //add
				$b_continuar:=False:C215
				$line:=AL_GetLine (Self:C308->)
				$l_columna:=AL_GetColumn (Self:C308->)
				$modo_asistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
				If ($modo_asistencia=2)
					If (vi_RegistrarMinutosEnAtrasos>0)
						
						If (($l_columna=6) & (USR_checkRights ("M";->[Alumnos_Atrasos:55])))
							$b_continuar:=True:C214
						End if 
						
						If (vi_RegistrarMinutosEnAtrasos=2)  //es fraccion//159627
							  //si es fraccion mostrar menu de fraccion//159627//ABC 20180227
							If (($l_columna=4) & (USR_checkRights ("M";->[Alumnos_Atrasos:55])))
								$b_menufraccion:=True:C214
							End if 
						End if 
						
					Else 
						If (($l_columna=5) & (USR_checkRights ("M";->[Alumnos_Atrasos:55])))
							$b_continuar:=True:C214
						End if 
					End if 
				Else 
					
					If (vi_RegistrarMinutosEnAtrasos>0)
						
						If (($l_columna=6) & (USR_checkRights ("M";->[Alumnos_Atrasos:55])))
							$b_continuar:=True:C214
						End if 
						
						If (vi_RegistrarMinutosEnAtrasos=2)  //es fraccion//159627
							  //si es fraccion mostrar menu de fraccion//159627
							If (($l_columna=4) & (USR_checkRights ("M";->[Alumnos_Atrasos:55])))
								$b_menufraccion:=True:C214
							End if 
						End if 
						
					Else 
						If (($l_columna=4) & (USR_checkRights ("M";->[Alumnos_Atrasos:55])))
							$b_continuar:=True:C214
						End if 
					End if 
				End if 
				
				  ///ABC//159627//ABC 20180227
				If ($b_menufraccion)
					  //C_LONGINT(vi_TiempoAtraso)
					$choice:=Pop up menu:C542(Replace string:C233(vt_intervalos;",";";"))
					If ($choice>0)  //rch desde acá
						vi_TiempoAtraso:=ATSTRAL_FALTACONV{$choice}
						C_DATE:C307(dfrom)
						C_REAL:C285($resultado)
						dfrom:=<>aCdtaDate{$line}
						READ WRITE:C146([Alumnos_Atrasos:55])
						GOTO RECORD:C242([Alumnos_Atrasos:55];<>aCdtaRecNo{$line})
						al_alMinutosAtraso{$line}:=vi_TiempoAtraso
						at_fraccion{$line}:=ATSTRAL_FALTATIPO{$choice}
						[Alumnos_Atrasos:55]MinutosAtraso:5:=vi_TiempoAtraso
						SAVE RECORD:C53([Alumnos_Atrasos:55])
						LOG_RegisterEvt ("Conducta -Se asigna Fracción : ("+at_fraccion{$line}+") para el Alumno -"+String:C10([Alumnos:2]apellidos_y_nombres:40)+" en el  el atraso  del día : "+String:C10([Alumnos_Atrasos:55]Fecha:2))
						KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
						AL_UpdateArrays (xALP_ConductaAlumnos;-1)
					End if 
					  //ABC
				End if 
				
				If ($b_continuar)
					ST_JustificacionAtrasos ("cargaVariables")
					vt_justificacionNombre:=AT_array2text (->at_JustificacionNombre;";")
					$choice:=Pop up menu:C542(Replace string:C233(vt_justificacionNombre;",";";"))
					If ($choice>0)  //rch desde acá
						at_NombreJustificacion{$line}:=at_JustificacionNombre{$choice}
						READ WRITE:C146([Alumnos_Atrasos:55])
						GOTO RECORD:C242([Alumnos_Atrasos:55];<>aCdtaRecNo{$line})
						[Alumnos_Atrasos:55]id_justificacion:13:=al_JustificacionID{$choice}
						SAVE RECORD:C53([Alumnos_Atrasos:55])
						LOG_RegisterEvt ("Conducta - Se asigna motivo de justificación ("+String:C10(at_JustificacionNombre{$choice})+") para el atraso del día :"+String:C10([Alumnos_Atrasos:55]Fecha:2))
						KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
						AL_UpdateArrays (xALP_ConductaAlumnos;-1)
					End if 
				End if 
		End case 
End case 