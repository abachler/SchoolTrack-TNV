If (vi_PageNumber=2)
	If (vt_g1#"")
		
		If (vt_g1#vt_g1Temp)
			
			vt_g1Temp:=vt_g1
			
			READ ONLY:C145([Asignaturas:18])
			READ ONLY:C145([Cursos:3])
			READ ONLY:C145([TMT_Horario:166])
			READ ONLY:C145([TMT_Salas:167])
			READ ONLY:C145([xxSTR_Periodos:100])
			READ ONLY:C145([xxSTR_Niveles:6])
			READ ONLY:C145([Alumnos_Calificaciones:208])
			
			C_LONGINT:C283($size;$t)
			_O_C_INTEGER:C282($index;$reg_encontrados;$i;$total_bloques;$bloques_permitidos)
			C_TEXT:C284($cod_int_asig;$motivo_sala_ocup;$asig_ocupa_bloques)
			C_BOOLEAN:C305($vb_continuar_bloque)
			C_TEXT:C284($text;$delimiter)
			
			ARRAY TEXT:C222($aCurso;0)
			ARRAY TEXT:C222($aCursoArchivo;0)
			ARRAY TEXT:C222($aHoraDesde;0)
			ARRAY TEXT:C222($aHoraHasta;0)
			ARRAY LONGINT:C221($aId_asignatura;0)
			ARRAY LONGINT:C221($aId_sala;0)
			ARRAY LONGINT:C221($aId_profesor;0)
			ARRAY INTEGER:C220($aNivel;0)
			ARRAY INTEGER:C220($aNCiclo;0)
			ARRAY INTEGER:C220($aNDia;0)
			ARRAY INTEGER:C220($aNHora;0)  // numero de bloque
			ARRAY TEXT:C222($aObs;0)
			ARRAY DATE:C224($aSessionDesde;0)
			ARRAY DATE:C224($aSessionHasta;0)
			
			  //Periodos para sesiones
			ARRAY TEXT:C222(at_IMPHperiodo1;0)
			ARRAY TEXT:C222(at_IMPHperiodo2;0)
			ARRAY TEXT:C222(at_IMPHperiodo3;0)
			ARRAY TEXT:C222(at_IMPHperiodo4;0)
			ARRAY TEXT:C222(at_IMPHperiodo5;0)
			
			ARRAY INTEGER:C220($aCantHora;0)  // cant de bloques
			ARRAY TEXT:C222($aSet;0)  // un numero que todavía no se para que es
			ARRAY TEXT:C222($aAbrvAsig;0)
			ARRAY TEXT:C222($aNomAsigoficial;0)
			ARRAY TEXT:C222($aInicProfe;0)
			ARRAY TEXT:C222($aNomSala;0)
			
			  //ARREGLOS NUEVOS
			ARRAY LONGINT:C221($asignatura_ocupa_sala;0)
			ARRAY TEXT:C222($asig_nomb_ocu_sala;0)
			ARRAY TEXT:C222($nivel_asig_nomb_ocu_sala;0)
			ARRAY TEXT:C222($curso_asig_ocu_sala;0)
			ARRAY TEXT:C222($asig_ocupa_bloque;0)
			
			
			$delimiter:=ACTabc_DetectDelimiter (vt_g1)
			$ref:=Open document:C264(vt_g1;"";Read mode:K24:5)
			
			If (ok=1)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Pre importando archivo..."))
				
				_O_C_INTEGER:C282($lindex;$sumli)
				If (cb_TieneEncabezado=1)
					RECEIVE PACKET:C104($ref;$text;$delimiter)
					$sumli:=1
				Else 
					$sumli:=0
				End if 
				
				RECEIVE PACKET:C104($ref;$text;$delimiter)
				
				If (r2=1)
					$text:=_O_Win to Mac:C464($text)
				End if 
				
				  //PRE IMPORTACIÓN CARGA DE LOS ARREGLOS
				
				C_LONGINT:C283($id_config_Periodos_nivel)
				
				$id_config_Periodos_nivel:=999999
				
				While ($text#"")
					
					APPEND TO ARRAY:C911($aNDia;Num:C11(ST_GetWord ($text;1;"\t")))
					APPEND TO ARRAY:C911($aNHora;Num:C11(ST_GetWord ($text;2;"\t")))
					APPEND TO ARRAY:C911($aCantHora;Num:C11(ST_GetWord ($text;3;"\t")))
					APPEND TO ARRAY:C911($aAbrvAsig;ST_GetWord ($text;4;"\t"))
					APPEND TO ARRAY:C911($aNivel;Num:C11(ST_GetWord ($text;5;"\t")))
					APPEND TO ARRAY:C911($aCursoArchivo;ST_GetWord ($text;6;"\t"))
					APPEND TO ARRAY:C911($aSet;ST_GetWord ($text;7;"\t"))
					APPEND TO ARRAY:C911($aInicProfe;ST_GetWord ($text;8;"\t"))
					APPEND TO ARRAY:C911($aNomSala;ST_GetWord ($text;9;"\t"))
					
					APPEND TO ARRAY:C911(at_IMPHperiodo1;ST_GetWord ($text;10;"\t"))
					APPEND TO ARRAY:C911(at_IMPHperiodo2;ST_GetWord ($text;11;"\t"))
					APPEND TO ARRAY:C911(at_IMPHperiodo3;ST_GetWord ($text;12;"\t"))
					APPEND TO ARRAY:C911(at_IMPHperiodo4;ST_GetWord ($text;13;"\t"))
					APPEND TO ARRAY:C911(at_IMPHperiodo5;ST_GetWord ($text;14;"\t"))
					
					$cod_int_asig:=""
					$cod_int_asig:=$aAbrvAsig{Size of array:C274($aAbrvAsig)}+$aCursoArchivo{Size of array:C274($aCursoArchivo)}+$aSet{Size of array:C274($aSet)}
					
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Codigo_interno:48=$cod_int_asig)
					APPEND TO ARRAY:C911($aCurso;[Asignaturas:18]Curso:5)
					
					$reg_encontrados:=0
					$reg_encontrados:=Records in selection:C76([Asignaturas:18])
					
					If ($reg_encontrados=1)
						APPEND TO ARRAY:C911($aId_asignatura;[Asignaturas:18]Numero:1)
						APPEND TO ARRAY:C911($aId_profesor;[Asignaturas:18]profesor_numero:4)
					Else 
						APPEND TO ARRAY:C911($aId_asignatura;999999999)
						APPEND TO ARRAY:C911($aId_profesor;999999999)
					End if 
					
					
					If ($aNomSala{Size of array:C274($aNomSala)}="")
						APPEND TO ARRAY:C911($aId_sala;-1)
					Else 
						QUERY:C277([TMT_Salas:167];[TMT_Salas:167]NombreSala:2=$aNomSala{Size of array:C274($aNomSala)})
						$reg_encontrados:=0
						$reg_encontrados:=Records in selection:C76([TMT_Salas:167])
						
						If ($reg_encontrados=1)
							APPEND TO ARRAY:C911($aId_sala;[TMT_Salas:167]ID_Sala:1)
						Else 
							APPEND TO ARRAY:C911($aId_sala;999999999)
						End if 
					End if 
					
					RECEIVE PACKET:C104($ref;$text;$delimiter)
					
					If (r2=1)
						$text:=_O_Win to Mac:C464($text)
					End if 
					
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479(vt_g1))
					
				End while 
				
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				  //ELIMINACIÓN DE LOS HORARIOS DE LAS ASIGNATURAS INVOLUCRADAS EN LA IMPORTACIÓN
				ARRAY LONGINT:C221($al_recNumAsignacionesHorario;0)
				C_TEXT:C284($mensaje)
				
				Case of 
					: (op1=1)
						
						$readOnlyState:=KRL_ReadWrite (->[TMT_Horario:166])
						ALL RECORDS:C47([TMT_Horario:166])
						LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_recNumAsignacionesHorario)
						$mensaje:="Eliminando el Horario Completo..."
						
					: (op2=1)
						
						READ ONLY:C145([Alumnos_Calificaciones:208])
						ARRAY LONGINT:C221($aID_asigCopia;0)
						ARRAY LONGINT:C221($a_asignaturas_involucradas;0)
						COPY ARRAY:C226($aId_asignatura;$aID_asigCopia)
						AT_DistinctsArrayValues (->$aID_asigCopia)
						
						QUERY WITH ARRAY:C644([TMT_Horario:166]ID_Asignatura:5;$aID_asigCopia)
						LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_recNumAsignacionesHorario)
						$mensaje:="Eliminando Horarios Actuales de las Asignaturas Involucradas..."
						
					: (op3=1)
						
						QUERY:C277([TMT_Horario:166];[TMT_Horario:166]Nivel:10>=al_NivelDesdeInf{al_NivelDesdeInf};*)
						QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]Nivel:10<=al_NivelHastaInf{al_NivelHastaInf})
						
						LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_recNumAsignacionesHorario;"")
						
						If (al_NivelDesdeInf#al_NivelHastaInf)
							$mensaje:="Eliminando los Horarios de los Niveles "+at_NivelDesdeInf{al_NivelDesdeInf}+" al "+at_NivelHastaInf{al_NivelHastaInf}
						Else 
							$mensaje:="Eliminando Los Horarios de "+at_NivelDesdeInf{al_NivelDesdeInf}
						End if 
						
				End case 
				
				  //ELIMINANDO LOS BLOQUES
				
				
				If (viTMT_EliminaSesiones=1)
					$ok:=TMT_EliminaSesionesAsociadas (->$al_recNumAsignacionesHorario)
				End if 
				
				If (Size of array:C274($al_recNumAsignacionesHorario)>0)
					$p:=IT_UThermometer (1;0;$mensaje)
					CREATE SELECTION FROM ARRAY:C640([TMT_Horario:166];$al_recNumAsignacionesHorario)
					KRL_DeleteSelection (->[TMT_Horario:166])
					IT_UThermometer (-2;$p)
				End if 
				
				  //FIN DE LA ELIMINACIÓN DE LOS HORARIOS DE LOS CURSOS INVOLUCRADOS EN LA IMPORTACIÓN
				  //CARGA DE BLOQUES DE BLOQUES A LOS HORARIOS
				
				$size:=Size of array:C274($aNDia)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cargando los Registros de Horario…"))
				ARRAY TEXT:C222($aRegnoImport;0)
				$v_usuarioactual:=USR_GetUserID 
				
				For ($index;1;Size of array:C274($aNDia))
					
					$lindex:=$index+$sumli
					  //CONFIGURACION DE PERIODOS PARA LA CONFIGURACIÓN DEL HORARIO
					QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$aNivel{$index})
					If ($id_config_Periodos_nivel#[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
						
						$id_config_Periodos_nivel:=[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44
						QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1=[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
						
						  //If (BLOB size([xxSTR_Periodos]Horarios)>0)
						  //$OTref_Horario:=OT BLOBToObject ([xxSTR_Periodos]Horarios)
						  //OT GetArray ($OTref_Horario;"aiSTR_Horario_HoraNo";aiSTR_Horario_HoraNo)
						  //OT GetArray ($OTref_Horario;"alSTR_Horario_Desde";alSTR_Horario_Desde)
						  //OT GetArray ($OTref_Horario;"alSTR_Horario_Hasta";alSTR_Horario_Hasta)
						  //OT GetArray ($OTref_Horario;"alSTR_Horario_Duracion";alSTR_Horario_Duracion)
						  //vlSTR_Horario_TipoCiclos:=OT GetLong ($OTref_Horario;"vlSTR_Horario_TipoCiclos")
						  //vlSTR_Horario_NoCiclos:=OT GetLong ($OTref_Horario;"vlSTR_Horario_NoCiclos")
						  //vlSTR_Horario_DiasCiclo:=OT GetLong ($OTref_Horario;"vlSTR_Horario_DiasCiclo")
						  //vlSTR_Horario_DiaInicioCiclo:=OT GetLong ($OTref_Horario;"vlSTR_Horario_DiaInicioCiclo")
						  //vlSTR_Horario_SabadoLabor:=OT GetLong ($OTref_Horario;"vlSTR_Horario_SabadoLabor")
						  //vlSTR_Horario_ResetCiclos:=OT GetLong ($OTref_Horario;"vlSTR_Horario_ResetCiclos")
						  //OT GetArray ($l_refObjetoOT;"alSTR_Horario_RefTipoHora";alSTR_Horario_RefTipoHora)
						  //OT GetArray ($OTref_Horario;"adSTR_Periodos_InicioCiclos";adSTR_Periodos_InicioCiclos)
						  //OT Clear ($OTref_Horario)
						  //End if 
						If (OB Is defined:C1231([xxSTR_Periodos:100]Horario:14))  //MONO Ticket 144924
							OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"ai_HoraNo";aiSTR_Horario_HoraNo)
							OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"at_HoraAlias";atSTR_Horario_HoraAlias)
							OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"al_Desde";alSTR_Horario_Desde)
							OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"al_Hasta";alSTR_Horario_Hasta)
							OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"al_Duracion";alSTR_Horario_Duracion)
							vlSTR_Horario_TipoCiclos:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_TipoCiclos")
							vlSTR_Horario_NoCiclos:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_NoCiclos")
							vlSTR_Horario_DiasCiclo:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_DiasCiclo")
							vlSTR_Horario_DiaInicioCiclo:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_DiaInicioCiclo")
							vlSTR_Horario_SabadoLabor:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_SabadoLabor")
							vlSTR_Horario_ResetCiclos:=OB Get:C1224([xxSTR_Periodos:100]Horario:14;"l_ResetCiclos")
							OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"ad_InicioCiclos";adSTR_Periodos_InicioCiclos)
							OB GET ARRAY:C1229([xxSTR_Periodos:100]Horario:14;"al_RefTipoHora";alSTR_Horario_RefTipoHora)
						End if 
						
						$bloques_permitidos:=Size of array:C274(alSTR_Horario_Desde)
						
					End if 
					
					$total_bloques:=0
					
					If ($aCantHora{$index}>0)
						$vb_crear_bloque:=False:C215
						$vt_msg_error:="Línea n°("+String:C10($lindex)+"): El valor de la columna n° 3 (Duración), no puede ser menor a 1"
					End if 
					
					If ($aCantHora{$index}>0)
						
						If ($aCantHora{$index}>1)
							$total_bloques:=$aNHora{$index}+($aCantHora{$index}-1)
						Else 
							$total_bloques:=$aNHora{$index}
						End if 
						
						If ($total_bloques<=$bloques_permitidos)
							
							For ($i;1;$aCantHora{$index})
								
								If ($aId_asignatura{$index}#999999999)
									
									$reg_encontrados:=0
									
									QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$aId_asignatura{$index})
									$reg_encontrados:=Records in selection:C76([Alumnos_Calificaciones:208])
									
									If ($reg_encontrados>0)
										
										$reg_encontrados:=0
										ARRAY TEXT:C222($aCursosEncontrados;0)
										KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
										AT_DistinctsFieldValues (->[Asignaturas:18]Curso:5;->$aCursosEncontrados)
										$reg_encontrados:=Find in array:C230($aCursosEncontrados;$aCurso{$index})
										
										If ($reg_encontrados#-1)
											_O_C_INTEGER:C282($num_bloque)
											
											If ($i=1)
												$num_bloque:=$aNHora{$index}
											Else 
												$num_bloque:=($aNHora{$index})+($i-1)
											End if 
											
											  //Verificación de inicio y fin de periodos para indicar la creación para las sesiones
											C_LONGINT:C283($indi;$per_ini;$per_fin;$topeblanco)
											C_POINTER:C301($ptrper)
											C_DATE:C307($vd_sesionini;$vd_sesionfin)
											C_BOOLEAN:C305($vb_ok_sesion)
											
											$per_ini:=0
											$per_fin:=0
											$topeblanco:=0
											$vb_ok_sesion:=False:C215
											
											For ($indi;1;5)
												$ptrper:=Get pointer:C304("at_IMPHperiodo"+String:C10($indi))
												If ($ptrper->{$index}#"")
													Case of 
														: ($per_ini=0)
															$per_ini:=$indi
															$per_fin:=$indi
															$topeblanco:=0
														Else 
															If (($topeblanco=0) | ($per_ini=0))
																$per_fin:=$indi
															End if 
													End case 
												Else 
													$topeblanco:=1
												End if 
											End for 
											
											If (($per_ini>0) & ($per_fin>0))
												PERIODOS_LoadData ($aNivel{$index})
												
												If (((Size of array:C274(adSTR_Periodos_Desde))>=$per_ini) & ((Size of array:C274(adSTR_Periodos_Hasta))>=$per_fin))
													$vd_sesionini:=adSTR_Periodos_Desde{$per_ini}
													$vd_sesionfin:=adSTR_Periodos_Hasta{$per_fin}
												Else 
													$vd_sesionini:=!00-00-00!
													$vd_sesionfin:=!00-00-00!
												End if 
												
											End if 
											
											  //REVISAMOS QUE PASA EN ESTE BLOQUE PARA LOS ALUMNOS DEL NIVEL
											
											QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$aNDia{$index};*)
											QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroHora:2=$num_bloque;*)
											QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]Nivel:10=$aNivel{$index})
											
											$reg_encontrados:=0
											$reg_encontrados:=Records in selection:C76([TMT_Horario:166])
											
											  //INICIO NUEVA VALIDACION
											
											$vb_continuar_bloque:=True:C214
											
											If ($reg_encontrados>0)
												
												  //VER SI EL BLOQUE DE LA ASIGNATURA EXISTE DE ANTES EN EL MISMO HORARIO PARA AMPLIAR SU FECHA DE SESIONES HASTA SI ES MAYOR 
												CREATE SET:C116([TMT_Horario:166];"bloques_encontrados")
												QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=$aId_asignatura{$index})
												
												If (Records in selection:C76([TMT_Horario:166])=1)
													  //SI ENCONTRAMOS ESTE BLOQUE LO QUE HACEMOS ES DEFINIR EL NUEVO HASTA
													If ([TMT_Horario:166]SesionesHasta:13<$vd_sesionfin)
														KRL_ReloadInReadWriteMode (->[TMT_Horario:166])
														[TMT_Horario:166]SesionesHasta:13:=$vd_sesionfin
														SAVE RECORD:C53([TMT_Horario:166])
														KRL_UnloadReadOnly (->[TMT_Horario:166])
													End if 
													$vb_continuar_bloque:=False:C215
													
												Else 
													  //YA QUE HAY BLOQUES DEL UN GRUPO
													  //VERIFICAMOS SI HAY TOPE DE HORARIOS POR ALUMNO
													  //buscamos a los alumnos que ya estan en las asignaturas en este bloque
													ARRAY LONGINT:C221($al_id_alu_en_este_bloque;0)
													USE SET:C118("bloques_encontrados")
													KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[TMT_Horario:166]ID_Asignatura:5;"")
													AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$al_id_alu_en_este_bloque)
													  //buscamos a los alumnos de la asignatura que queremos ingresar a este bloque
													ARRAY LONGINT:C221($al_id_alu_nuevo_bloque;0)
													QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$aId_asignatura{$index})
													SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_id_alu_nuevo_bloque)
													$cant_alu:=0
													For ($idc;1;Size of array:C274($al_id_alu_nuevo_bloque))
														$cia:=Count in array:C907($al_id_alu_en_este_bloque;$al_id_alu_nuevo_bloque{$idc})
														$cant_alu:=$cant_alu+$cia
													End for 
													
													If ($cant_alu>0)
														APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($lindex)+"): Existe un tope de horarios para uno o varios alumnos inscritos en la asignatur"+"a que se desea agregar al bloque "+String:C10($num_bloque)+" del "+String:C10($aNDia{$index})+"° día")
														$vb_continuar_bloque:=False:C215
													End if 
												End if 
												CLEAR SET:C117("bloques_encontrados")
											End if 
											  //FIN NUEVA VALIDACION
											
											If ($vb_continuar_bloque)
												
												Case of 
													: ($aId_sala{$index}=-1)  //no se ingreso sala en el archivo
														  //nada y continuar
														
													: ($aId_sala{$index}#999999999)
														
														QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Sala:6=$aId_sala{$index};*)
														QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=$aNDia{$index};*)
														QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroHora:2=$num_bloque)
														$reg_encontrados:=0
														$reg_encontrados:=Records in selection:C76([TMT_Horario:166])
														
														If ($reg_encontrados>0)
															
															AT_DistinctsFieldValues (->[TMT_Horario:166]ID_Asignatura:5;->$asignatura_ocupa_sala)
															QUERY WITH ARRAY:C644([Asignaturas:18]Numero:1;$asignatura_ocupa_sala)
															SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$asig_nomb_ocu_sala;[Asignaturas:18]Nivel:30;$nivel_asig_nomb_ocu_sala;[Asignaturas:18]Curso:5;$curso_asig_ocu_sala)
															
															$motivo_sala_ocup:=AT_Arrays2Text (", ";" de ";->$asig_nomb_ocu_sala;->$nivel_asig_nomb_ocu_sala;->$curso_asig_ocu_sala)
															
															$vb_continuar_bloque:=False:C215
															APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($lindex)+"): La Sala "+$aNomSala{$index}+" ya se encuentra ocupada en el bloque "+String:C10($num_bloque)+" del día "+String:C10($aNDia{$index})+" por "+$motivo_sala_ocup+".")
															
														End if 
														
													Else 
														  //la sala ingresada pero marcada como 999999999 o sea no existe
														$vb_continuar_bloque:=False:C215
														APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($lindex)+"): La Sala "+$aNomSala{$index}+" no se encuentra registrada en Schooltrack.")
												End case 
												
												
												If ($vd_sesionini=!00-00-00!) | ($vd_sesionfin=!00-00-00!)
													$vb_continuar_bloque:=False:C215
													APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($lindex)+"): Configuración no valida de inicio o fin para las sesiones, revíse la configuración de periodos del nivel "+String:C10($aNivel{$index}))
												End if 
												
												If ($vb_continuar_bloque)
													
													READ WRITE:C146([TMT_Horario:166])
													CREATE RECORD:C68([TMT_Horario:166])
													[TMT_Horario:166]Curso:11:=$aCurso{$index}
													[TMT_Horario:166]Desde:3:=alSTR_Horario_Desde{$aNHora{$index}}
													[TMT_Horario:166]Hasta:4:=alSTR_Horario_Hasta{$aNHora{$index}}
													[TMT_Horario:166]ID_Asignatura:5:=$aId_asignatura{$index}
													[TMT_Horario:166]ID_Sala:6:=$aId_sala{$index}
													[TMT_Horario:166]ID_Teacher:9:=$aId_profesor{$index}
													[TMT_Horario:166]Nivel:10:=$aNivel{$index}
													[TMT_Horario:166]No_Ciclo:14:=1
													[TMT_Horario:166]NumeroDia:1:=$aNDia{$index}
													[TMT_Horario:166]NumeroHora:2:=$num_bloque
													[TMT_Horario:166]Sala:8:=$aNomSala{$index}
													[TMT_Horario:166]SesionesDesde:12:=$vd_sesionini
													[TMT_Horario:166]SesionesHasta:13:=$vd_sesionfin
													[TMT_Horario:166]TipoHora:16:=1
													SAVE RECORD:C53([TMT_Horario:166])
													KRL_ReloadAsReadOnly (->[TMT_Horario:166])
													$0:=Record number:C243([TMT_Horario:166])
													  //20120225 RCH se agrega parametro a llamado
													TMT_CreaSesiones (Record number:C243([TMT_Horario:166]))
													READ ONLY:C145([TMT_Horario:166])
													
												End if 
												
											End if 
											
										Else 
											
											APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($lindex)+"):  La Asignatura no esta asociada al curso o grupo que se indica.")
											
										End if 
									Else 
										
										APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($lindex)+"):  La Asignatura número "+String:C10($aId_asignatura{$index})+" no tiene alumnos inscritos.")
										
									End if 
									
								Else 
									APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($lindex)+"):  La Asignatura no existe.")
								End if 
								
							End for 
							
						Else 
							
							APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($lindex)+"):  El total de bloques que se quieren asignar a la asignatura, sobrepasan el lím"+"ite de bloques del horario")
							
						End if 
						
					Else 
						
						APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($lindex)+"): El valor de la columna n° 3 (Duración), no puede ser menor a 1")
						
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$index/$size)
					
				End for 
				
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				  //FIN DE CARGA DE BLOQUES A LOS HORARIOS
				
				CLOSE DOCUMENT:C267($ref)
				vi_PageNumber:=3
				FORM GOTO PAGE:C247(vi_PageNumber)
				POST KEY:C465(Character code:C91("+");256)
				
				_O_C_INTEGER:C282($num_reg_malos;$resp)
				$num_reg_malos:=Size of array:C274($aRegnoImport)
				
				If ($num_reg_malos>0)
					
					ok:=CD_Dlog (0;__ ("Hubo ")+String:C10($num_reg_malos)+__ (" registros de bloques, no importados, se creará un archivo con el detalle de los registros no importados."))
					$ref:=Create document:C266("")
					
					If (ok=1)  //CREACIÓN DEL ARCHIVO CON LOS REGISTROS NO IMPORTADOS
						
						For ($i;1;Size of array:C274($aRegnoImport))
							$line:=$aRegnoImport{$i}+"\r"
							IO_SendPacket ($ref;$line)
						End for 
						
						CLOSE DOCUMENT:C267($ref)
						
						$path:=document
						
						CD_Dlog (0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
						CANCEL:C270
					End if 
					
				Else 
					
					$resp:=CD_Dlog (0;__ ("Todos los registros fueron importados con éxito."))
					CANCEL:C270
				End if 
				
				
			Else 
				CD_Dlog (0;__ ("Error en la lectura del archivo para importar, pruebe traspasando al información a otro archivo."))
			End if 
		Else 
			If (vt_g1=vt_g1Temp)
				CANCEL:C270
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("No ha indicado el archivo a importar."))
	End if 
Else 
	vi_PageNumber:=2
	_O_ENABLE BUTTON:C192(bPrev)
	FORM GOTO PAGE:C247(vi_PageNumber)
	POST KEY:C465(Character code:C91("+");256)
End if 