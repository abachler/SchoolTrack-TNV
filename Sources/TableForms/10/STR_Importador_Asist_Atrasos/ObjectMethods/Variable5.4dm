If (vi_PageNumber=2)
	If (vt_g1#"")
		
		If (vt_g1#vt_g1Temp)
			
			C_POINTER:C301($vp_campo)
			vt_g1Temp:=vt_g1
			
			Case of 
				: (C_op1=1)
					$vp_campo:=->[Alumnos:2]RUT:5
				: (C_op1=2)
					$vp_campo:=->[Alumnos:2]IDNacional_2:71
				: (C_op1=3)
					$vp_campo:=->[Alumnos:2]IDNacional_3:70
				: (C_op1=4)
					$vp_campo:=->[Alumnos:2]NoPasaporte:87
				: (C_op1=5)
					$vp_campo:=->[Alumnos:2]Codigo_interno:6
			End case 
			
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([xxSTR_Periodos:100])
			
			QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=<>al_NumeroNivelesActivos{1};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)})
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo@")
			QUERY SELECTION:C341([Alumnos:2];$vp_campo->#"")
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>)
			
			ARRAY LONGINT:C221($al_RN_alu;0)
			ARRAY TEXT:C222($at_ID_alu_stx;0)
			SELECTION TO ARRAY:C260([Alumnos:2];$al_RN_alu;$vp_campo->;$at_ID_alu_stx)
			
			C_LONGINT:C283($x;$size;$t;$i;$fia;$vl_segundos;$min_atrasos;$ris)
			C_TEXT:C284($text;$delimiter)
			C_BOOLEAN:C305($vb_fecha valida)
			C_TIME:C306($vh_hora1;$vh_hora2)
			
			ARRAY TEXT:C222($at_ID_alu_arch;0)
			ARRAY TEXT:C222($at_hora;0)
			ARRAY DATE:C224($ad_fecha;0)
			
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
				
				While ($text#"")
					
					APPEND TO ARRAY:C911($at_ID_alu_arch;ST_GetWord ($text;1;"\t"))
					APPEND TO ARRAY:C911($ad_fecha;Date:C102(ST_GetWord ($text;2;"\t")))
					APPEND TO ARRAY:C911($at_hora;ST_GetWord ($text;3;"\t"))
					
					RECEIVE PACKET:C104($ref;$text;$delimiter)
					
					If (r2=1)
						$text:=_O_Win to Mac:C464($text)
					End if 
					
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479(vt_g1))
					
				End while 
				
				CLOSE DOCUMENT:C267($ref)
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				  //$vt_usuarioactual:=USR_GetUserName 
				
				$id_config_Periodos_nivel:=0
				
				C_TEXT:C284($mensaje)
				ARRAY DATE:C224($ad_dist_fechas;0)
				COPY ARRAY:C226($ad_fecha;$ad_dist_fechas)
				AT_DistinctsArrayValues (->$ad_dist_fechas)
				ARRAY TEXT:C222($aRegnoImport;0)
				
				For ($t;1;Size of array:C274($ad_dist_fechas))
					ARRAY BOOLEAN:C223($ab_presente;0)
					ARRAY BOOLEAN:C223($ab_presente;Size of array:C274($al_RN_alu))
					
					$ad_fecha{0}:=$ad_dist_fechas{$t}
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->$ad_fecha;"=";->$DA_Return)
					
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cargando Registros de Asistencia y Atrasos para la fecha: ")+String:C10($ad_dist_fechas{$t}))
					
					For ($index;1;Size of array:C274($DA_return))
						
						$fia:=Find in array:C230($at_ID_alu_stx;$at_ID_alu_arch{$DA_return{$index}})
						
						If ($fia>0)
							
							$ab_presente{$fia}:=True:C214
							QUERY:C277([Alumnos:2];$vp_campo->=$at_ID_alu_arch{$DA_return{$index}})
							
							If (Records in selection:C76([Alumnos:2])=1)
								
								If (Hora_p=1)
									  //CONFIGURACION DE PERIODOS PARA LA CONFIGURACIÓN DEL HORARIO
									
									If ($id_config_Periodos_nivel#[Alumnos:2]nivel_numero:29)
										$id_config_Periodos_nivel:=[Alumnos:2]nivel_numero:29
										PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
										If (Size of array:C274(alSTR_Horario_Desde)>0)
											$vh_hora2:=Time:C179(Substring:C12(Time string:C180(alSTR_Horario_Desde{1});1;5))
										Else 
											$vh_hora2:=?25:00:00?
										End if 
									End if 
								Else 
									$vh_hora2:=vh_hora
								End if 
								
								$vb_fecha valida:=False:C215
								
								For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
									If (Not:C34($vb_fecha valida))
										If (($ad_fecha{$DA_return{$index}}>=adSTR_Periodos_Desde{$i}) & ($ad_fecha{$DA_return{$index}}<=adSTR_Periodos_Hasta{$i}))
											$fia:=Find in array:C230(adSTR_Calendario_Feriados;$ad_fecha{$DA_return{$index}})
											If ($fia=-1)
												$vb_fecha valida:=True:C214
											End if 
										End if 
									End if 
								End for 
								
								  //Fecha dentro de la config de periodos
								If ($vb_fecha valida=True:C214)
									
									If ($vh_hora2#?25:00:00?)
										
										$vl_segundos:=0
										$vh_hora1:=Time:C179($at_hora{$DA_Return{$index}})
										$vl_segundos:=($vh_hora2-$vh_hora1)*1
										
										$reg_atraso:=True:C214
										$reg_inasistencia:=False:C215
										
										If ($vl_segundos<0)
											
											  //si la llegada es demasiado tarde (depende lo que configuró el usuario) debemos generar una inasistencia
											If (cb_gen_too_late)
												If ($vh_hora1>vh_hora_too_late)
													$reg_atraso:=False:C215
													$reg_inasistencia:=True:C214
												End if 
											End if 
											
											If ($reg_atraso)
												QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
												QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$ad_fecha{$DA_return{$index}};*)
												QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
												
												If ((Records in selection:C76([Alumnos_Atrasos:55]))=0)
													READ WRITE:C146([Alumnos_Atrasos:55])
													CREATE RECORD:C68([Alumnos_Atrasos:55])
													[Alumnos_Atrasos:55]Alumno_numero:1:=[Alumnos:2]numero:1
													[Alumnos_Atrasos:55]Año:6:=<>gyear
													[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4:=False:C215
													[Alumnos_Atrasos:55]Fecha:2:=$ad_fecha{$DA_return{$index}}
													[Alumnos_Atrasos:55]Observaciones:3:=$at_hora{$DA_Return{$index}}
													$min_atrasos:=Abs:C99(Round:C94(($vl_segundos/60);0))
													If ($min_atrasos<1)
														$min_atrasos:=1
													End if 
													[Alumnos_Atrasos:55]MinutosAtraso:5:=$min_atrasos
													[Alumnos_Atrasos:55]Nivel_Numero:8:=[Alumnos:2]nivel_numero:29
													SAVE RECORD:C53([Alumnos_Atrasos:55])
													KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
													LOG_RegisterEvt ("Conducta - Registro de atraso: Importador "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
													APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($DA_return{$index})+"): "+$at_ID_alu_arch{$DA_return{$index}}+" Es registrado con un atraso de "+String:C10(Round:C94(($vl_segundos/60);0))+" minutos para la fecha "+String:C10($ad_fecha{$DA_Return{$index}}))
												End if 
											End if 
										End if 
										  //SI SE ENCUENTRA UNA INASISTENCIA PARA UN ALUMNO QUE VIENE EN EL ARCHIVO HAY QUE ELIMINARSELA
										READ WRITE:C146([Alumnos_Inasistencias:10])
										QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
										QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$ad_fecha{$DA_return{$index}})
										
										$vb_exist_ina:=False:C215
										If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
											DELETE SELECTION:C66([Alumnos_Inasistencias:10])
											$vb_exist_ina:=True:C214
											APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($DA_return{$index})+"): "+[Alumnos:2]apellidos_y_nombres:40+" estaba ausente el "+String:C10($ad_fecha{$DA_return{$index}})+" esta inasistencia fue eliminada por encontrarse el alumno en el archivo de impor"+"tación de dicha fecha")
											LOG_RegisterEvt ("Se elimina inasistencia "+String:C10($ad_fecha{$DA_return{$index}})+"del alumno(a) "+[Alumnos:2]apellidos_y_nombres:40+" por encontrarse en la importación de Asistencia y Atrasos")
										Else 
											If ($reg_inasistencia)
												CREATE RECORD:C68([Alumnos_Inasistencias:10])
												[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
												[Alumnos_Inasistencias:10]Fecha:1:=$ad_fecha{$DA_return{$index}}
												[Alumnos_Inasistencias:10]Nivel_Numero:9:=[Alumnos:2]nivel_numero:29
												[Alumnos_Inasistencias:10]Observaciones:3:="Es cosiderada una inasistencia llegar a clases a las "+$at_hora{$DA_Return{$index}}
												[Alumnos_Inasistencias:10]Año:8:=Year of:C25($ad_fecha{$DA_return{$index}})
												SAVE RECORD:C53([Alumnos_Inasistencias:10])
												APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($DA_return{$index})+"): "+[Alumnos:2]apellidos_y_nombres:40+" queda inasistente por llegar a las "+$at_hora{$DA_Return{$index}}+" el día"+String:C10($ad_fecha{$DA_return{$index}}))
												LOG_RegisterEvt ([Alumnos:2]apellidos_y_nombres:40+" queda inasistente por llegar a las "+$at_hora{$DA_Return{$index}}+" el día"+String:C10($ad_fecha{$DA_return{$index}})+". Generado en la importación de Asistencia y Atrasos")
											End if 
										End if 
										
										KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
										
									End if 
								Else 
									APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($DA_return{$index})+"): "+$at_ID_alu_arch{$index}+" La Fecha "+String:C10($ad_fecha{$index})+" no corresponde a ningún periodo periodo configurado para el alumno(a) "+[Alumnos:2]apellidos_y_nombres:40+" del curso "+[Alumnos:2]curso:20)
								End if 
							Else 
								APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($DA_return{$index})+"): "+String:C10(Records in selection:C76([Alumnos:2]))+" registro(s) de alumno asociado(s) a "+$at_ID_alu_arch{$index})
							End if 
						Else 
							APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($DA_return{$index})+"): "+$at_ID_alu_arch{$index}+" no se encuentra en la selección de alumnos que pertenecen niveles activos de Sch"+"ooltrack, con estado Activo como alumno")
						End if 
						
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$index/(Size of array:C274($DA_return)))
						
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					
					
					If (cb_gen_inasistencias=1)
						  //Creación de inasistencias
						$fia:=Find in array:C230($ab_presente;False:C215)
						$id_config_Periodos_nivel:=0
						
						If ($fia>0)
							APPEND TO ARRAY:C911($aRegnoImport;"Inasistencias creadas para la fecha "+String:C10($ad_dist_fechas{$t}))
							
							$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando las inasistencias para la fecha: ")+String:C10($ad_dist_fechas{$t}))
							
							For ($x;1;Size of array:C274($al_RN_alu))
								If (Not:C34($ab_presente{$x}))
									GOTO RECORD:C242([Alumnos:2];$al_RN_alu{$x})
									
									If ($id_config_Periodos_nivel#[Alumnos:2]nivel_numero:29)
										$id_config_Periodos_nivel:=[Alumnos:2]nivel_numero:29
										PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
										$vb_fecha valida:=False:C215
										For ($i;1;Size of array:C274(adSTR_Periodos_Desde))
											If (Not:C34($vb_fecha valida))
												If (($ad_dist_fechas{$t}>=adSTR_Periodos_Desde{$i}) & ($ad_dist_fechas{$t}<=adSTR_Periodos_Hasta{$i}))
													$fia:=Find in array:C230(adSTR_Calendario_Feriados;$ad_dist_fechas{$t})
													If ($fia=-1)
														$vb_fecha valida:=True:C214
													End if 
												End if 
											End if 
										End for 
									End if 
									
									If ($vb_fecha valida)
										QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
										QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$ad_dist_fechas{$t})
										If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
											READ WRITE:C146([Alumnos_Inasistencias:10])
											CREATE RECORD:C68([Alumnos_Inasistencias:10])
											[Alumnos_Inasistencias:10]Año:8:=<>gyear
											[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
											[Alumnos_Inasistencias:10]Fecha:1:=$ad_dist_fechas{$t}
											[Alumnos_Inasistencias:10]RegistradaEl:11:=Current date:C33(*)
											[Alumnos_Inasistencias:10]RegistradaPor:10:=<>tUSR_CurrentUser
											SAVE RECORD:C53([Alumnos_Inasistencias:10])
											UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
											LOG_RegisterEvt ("Conducta - Registro de inasistencia diaria: (importador) "+String:C10($ad_dist_fechas{$t};7)+" - "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
											APPEND TO ARRAY:C911($aRegnoImport;[Alumnos:2]apellidos_y_nombres:40+" "+[Alumnos:2]curso:20)
											
											  //si se crea una inasistencia se eliminan los atrasos de ese día 
											GOTO RECORD:C242([Alumnos:2];$al_RN_alu{$x})
											READ WRITE:C146([Alumnos_Atrasos:55])
											QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1)
											
											$ris:=Records in selection:C76([Alumnos_Atrasos:55])
											If ($ris>0)
												DELETE SELECTION:C66([Alumnos_Atrasos:55])
												LOG_RegisterEvt (String:C10($ris)+" Atraso(s) del "+String:C10($ad_dist_fechas{$t};7)+" del alumno "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20+" fueron eliminados por inasistencia de este día")
											End if 
											KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
										End if 
									End if 
									
								End if 
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$x/(Size of array:C274($al_RN_alu)))
							End for 
						End if 
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					End if 
					
				End for 
				
				vi_PageNumber:=3
				FORM GOTO PAGE:C247(vi_PageNumber)
				POST KEY:C465(Character code:C91("+");256)
				C_LONGINT:C283($resp)
				
				  //$msg:="Se generará un archivo con un detalle de las funciones realizadas por el importad"+"or"
				ok:=CD_Dlog (0;__ ("Se generará un archivo con un detalle de las funciones realizadas por el importador."))
				$ref:=Create document:C266("")
				
				If (ok=1)
					
					  //CREACIÓN DEL ARCHIVO CON LOS REGISTROS NO IMPORTADOS
					
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
