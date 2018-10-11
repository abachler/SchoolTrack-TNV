//%attributes = {}
  // PERIODOS_ValidaCambiosFecha()
  // Por: Alberto Bachler: 19/08/13, 11:14:46
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
ARRAY LONGINT:C221($al_recNumSesiones;0)
ARRAY LONGINT:C221($al_RecNumsHorarios;0)



READ ONLY:C145([xxSTR_Niveles:6])
$l_recNumPeriodo:=Record number:C243([xxSTR_DatosPeriodos:132])
  //20131016 ASM se perdia el periodo al crear las sesiones
$l_RecNumPeriodoConf:=Record number:C243([xxSTR_Periodos:100])

Case of 
	: ((vd_periodoFin#[xxSTR_DatosPeriodos:132]FechaTermino:4) & ([xxSTR_DatosPeriodos:132]NumeroPeriodo:1=viSTR_Periodos_NumeroPeriodos))
		  // CAMBIO EN LA FECHA DE TERMINO DEL ULTIMO PERIODO
		$d_fechaTermino_anterior:=[xxSTR_DatosPeriodos:132]FechaTermino:4
		$d_fechaTermino_nueva:=vd_periodoFin
		Case of 
			: (vd_periodoFin>[xxSTR_DatosPeriodos:132]FechaTermino:4)  //extension de la duración del período (retraso del fin de período)
				  // Inicializo el componente IT_Confirmacion
				IT_Confirmacion_Inicializa 
				
				  //Cargo los elementos que se mostrarán en el mensaje de confirmación
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("94/0_EncabezadoExtensionTermino"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("95/btn1_ExtenderFechaTermino"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("96/btn2_MantenerFechaDeTermino"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("97/btn3_Cancelar"))
				
				  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
				$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaTermino_anterior";String:C10($d_fechaTermino_anterior;System date abbreviated:K1:2))
				$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaTermino_nueva";String:C10($d_fechaTermino_nueva;System date abbreviated:K1:2))
				
				  // Muestro el cuadro de diálogo de confirmación
				  // pasa en $t_textoLog el encabezado para el registro de actividades
				$t_Textolog:="Retraso de la fecha de término del año escolar en la configuración de períodos ^0."
				$t_Textolog:=Replace string:C233($t_Textolog;"^0";[xxSTR_Periodos:100]Nombre_Configuracion:2+" ("+String:C10([xxSTR_Periodos:100]ID:1)+")")
				$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
				Case of 
					: ($l_opcionUsuario=0)
						vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
					: ($l_opcionUsuario=1)  // extender
						  // guardo los cambios en la configuración y vuelvo a cargarlos para poder validar las fechas en el horario
						CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
						PERIODOS_Init 
						PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
						
						QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
						KRL_RelateSelection (->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]NoNivel:5)
						QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13;>=;$d_fechaTermino_anterior-7)
						ARRAY LONGINT:C221($al_RecNums;0)
						LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_RecNums;"")
						For ($i_registros;1;Size of array:C274($al_RecNums))
							READ WRITE:C146([TMT_Horario:166])
							GOTO RECORD:C242([TMT_Horario:166];$al_RecNums{$i_registros})
							$d_fecha:=$d_fechaTermino_nueva
							$b_FechaValida:=TMT_FechaDiaValidos (->$d_fecha;[TMT_Horario:166]SesionesDesde:12;[TMT_Horario:166]NumeroDia:1)
							If ($b_FechaValida)
								[TMT_Horario:166]SesionesHasta:13:=$d_fecha
								SAVE RECORD:C53([TMT_Horario:166])
							End if 
						End for 
						KRL_UnloadReadOnly (->[TMT_Horario:166])
						If ($d_fechaTermino_anterior>=Current date:C33(*))
							dbu_CreaSesiones (False:C215;$d_fechaTermino_anterior;$d_fechaTermino_nueva)
							GOTO RECORD:C242([xxSTR_Periodos:100];$l_RecNumPeriodoConf)
							PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)  // MONO 147819 
						End if 
						
					: ($l_opcionUsuario=2)  // mantener termino en asignaciones de horario
						vb_CambiosEnCalendario:=True:C214
						CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
						
				End case 
				
				
				
				
			: (vd_periodoFin<[xxSTR_DatosPeriodos:132]FechaTermino:4)  // reducción de la duración de período (adelantamiento del fin de período)
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
				KRL_RelateSelection (->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]NoNivel:5)
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13;>;$d_fechaTermino_nueva)
				LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_RecNumsHorarios;"")
				If (Size of array:C274($al_RecNumsHorarios)>0)
					KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[TMT_Horario:166]ID_Asignatura:5)
					QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>;$d_fechaTermino_nueva)
					LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_recNumSesiones)
					$l_sesionesFueraDePeriodo:=Records in selection:C76([Asignaturas_RegistroSesiones:168])
					KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
					$l_inasistenciasFueraDePeriodo:=Records in selection:C76([Asignaturas_Inasistencias:125])
					
					  // Inicializo el componente IT_Confirmacion
					IT_Confirmacion_Inicializa 
					
					  //Cargo los elementos que se mostrarán en el mensaje de confirmación
					If ($l_sesionesFueraDePeriodo>0)
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("103/0_EncabezadoRestriccionTermino_conSesiones"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("101/btn1_AdelantaTermino_y_EliminaSesiones"))
					Else 
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("99/0_EncabezadoRestriccionTermino_sinSesiones"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("102/btn1_AdelantaTermino_sinSesiones"))
					End if 
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("100/btn0_Cancelar"))
					
					  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaTermino_anterior";String:C10($d_fechaTermino_anterior;System date abbreviated:K1:2))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaTermino_nueva";String:C10($d_fechaTermino_nueva;System date abbreviated:K1:2))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_InasistenciasFueraDePeriodo";String:C10($l_InasistenciasFueraDePeriodo))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_sesionesFueraDePeriodo";String:C10($l_sesionesFueraDePeriodo))
					
					  // Muestro el cuadro de diálogo de confirmación
					  // pasa en $t_textoLog el encabezado para el registro de actividades
					$t_Textolog:="Adelanto del término del año escolar en la configuración de períodos ^0"
					$t_Textolog:=Replace string:C233($t_Textolog;"^0";[xxSTR_Periodos:100]Nombre_Configuracion:2+" ("+String:C10([xxSTR_Periodos:100]ID:1)+")")
					$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
					
					Case of 
						: ($l_opcionUsuario=0)
							vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
						: ($l_opcionUsuario=1)
							If ($l_sesionesFueraDePeriodo>0)
								$l_sesionesEliminadas:=ASrs_EliminaSesiones (->$al_recNumSesiones)
							Else 
								$l_sesionesEliminadas:=1
							End if 
							If ($l_sesionesEliminadas=1)
								  // guardo los cambios en la configuración y vuelvo a cargarlos para poder validar las fechas en el horario
								CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
								PERIODOS_Init 
								PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
								
								For ($i_registros;1;Size of array:C274($al_RecNumsHorarios))
									READ WRITE:C146([TMT_Horario:166])
									GOTO RECORD:C242([TMT_Horario:166];$al_RecNumsHorarios{$i_registros})
									$d_fecha:=$d_fechaTermino_nueva
									$b_FechaValida:=TMT_FechaDiaValidos (->$d_fecha;$d_fechaTermino_nueva-7;[TMT_Horario:166]NumeroDia:1)
									If ($b_FechaValida)
										[TMT_Horario:166]SesionesHasta:13:=$d_fecha
										SAVE RECORD:C53([TMT_Horario:166])
									End if 
								End for 
								vb_CambiosEnCalendario:=True:C214
							Else 
								  // no fue posible eliminar las sesiones
								  // es necesario restablecer la fecha de término anterior
								CD_Dlog (0;__ ("No fue posible aplicar el cambio de fecha.\r\rPor intente nuevamente más tarde."))
								  // en caso que la selección actual del periodo haya cambiado durante la ejecución de este método
								  // vuelvo a leer los datos del período y reestablezco la fecha de termino anterior
								vl_RecNumPeriodos:=$l_recNumPeriodo
								SELECT LIST ITEMS BY REFERENCE:C630(hl_periodosEscolares;$l_recNumPeriodo)
								CFG_STR_PeriodosEscolares_NEW ("LeeDatosPeriodo")
								vd_periodoFin:=$d_fechaTermino_anterior
								  // guardo la configuración reestablecida
							End if 
					End case 
				Else 
					vb_CambiosEnCalendario:=True:C214
				End if 
		End case 
		
		
		
		
	: ((vd_periodoInicio#[xxSTR_DatosPeriodos:132]FechaInicio:3) & ([xxSTR_DatosPeriodos:132]NumeroPeriodo:1=1))
		  // CAMBIO EN LA FECHA DE INICIO DEL PRIMER PERIODO
		$d_fechaInicio_nueva:=vd_periodoInicio
		$d_fechaInicio_anterior:=[xxSTR_DatosPeriodos:132]FechaInicio:3
		Case of 
			: (vd_periodoInicio<[xxSTR_DatosPeriodos:132]FechaInicio:3)  //extension de la duración del período (adelantamiento del inicio del período)
				  // Inicializo el componente IT_Confirmacion
				IT_Confirmacion_Inicializa 
				
				  //Cargo los elementos que se mostrarán en el mensaje de confirmación
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("104/0_EncabezadoExtensionInicio"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("105/btn1_ExtenderFechaInicio"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("106/btn2_MantenerFechaDeInicio"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("97/btn3_Cancelar"))
				
				  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
				$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaInicio_anterior";String:C10($d_fechaInicio_anterior;System date abbreviated:K1:2))
				$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaInicio_nueva";String:C10($d_fechaInicio_nueva;System date abbreviated:K1:2))
				
				  // Muestro el cuadro de diálogo de confirmación
				  // pasa en $t_textoLog el encabezado para el registro de actividades
				$t_Textolog:="Adelantamiento de la fecha de inicio del año escolar en la configuración de períodos ^0."
				$t_Textolog:=Replace string:C233($t_Textolog;"^0";[xxSTR_Periodos:100]Nombre_Configuracion:2+" ("+String:C10([xxSTR_Periodos:100]ID:1)+")")
				$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
				
				Case of 
					: ($l_opcionUsuario=0)
						vd_periodoInicio:=[xxSTR_DatosPeriodos:132]FechaInicio:3
					: ($l_opcionUsuario=1)  // extender
						  // guardo los cambios en la configuración y vuelvo a cargarlos para poder validar las fechas en el horario
						CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
						PERIODOS_Init 
						PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
						
						QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
						KRL_RelateSelection (->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]NoNivel:5)
						QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12;>=;$d_fechaInicio_anterior;*)
						QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12;<=;$d_fechaInicio_anterior+7)
						ARRAY LONGINT:C221($al_RecNums;0)
						LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_RecNums;"")
						For ($i_registros;1;Size of array:C274($al_RecNums))
							READ WRITE:C146([TMT_Horario:166])
							GOTO RECORD:C242([TMT_Horario:166];$al_RecNums{$i_registros})
							$d_fecha:=$d_fechaInicio_nueva
							$b_FechaValida:=TMT_FechaDiaValidos (->$d_fecha;[TMT_Horario:166]SesionesDesde:12-1;[TMT_Horario:166]NumeroDia:1)
							If ($b_FechaValida)
								[TMT_Horario:166]SesionesDesde:12:=$d_fecha
								SAVE RECORD:C53([TMT_Horario:166])
							End if 
						End for 
						KRL_UnloadReadOnly (->[TMT_Horario:166])
						dbu_CreaSesiones (False:C215;$d_fechaInicio_nueva;$d_fechaInicio_anterior-1)
						GOTO RECORD:C242([xxSTR_Periodos:100];$l_RecNumPeriodoConf)
						PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)  // MONO 147819 
					: ($l_opcionUsuario=2)  // mantener termino en asignaciones de horario
						vb_CambiosEnCalendario:=True:C214
						CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
						
				End case 
				
				
				
				
				
				
			: (vd_periodoInicio>[xxSTR_DatosPeriodos:132]FechaInicio:3)  // reducción de la duración de período  (retraso del inicio de período)
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
				KRL_RelateSelection (->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]NoNivel:5)
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12;<;$d_fechaInicio_nueva)
				LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_RecNumsHorarios;"")
				If (Size of array:C274($al_RecNumsHorarios)>0)
					KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[TMT_Horario:166]ID_Asignatura:5)
					QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<;$d_fechaInicio_nueva)
					LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_recNumSesiones)
					$l_sesionesFueraDePeriodo:=Records in selection:C76([Asignaturas_RegistroSesiones:168])
					KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
					$l_inasistenciasFueraDePeriodo:=Records in selection:C76([Asignaturas_Inasistencias:125])
					
					  // Inicializo el componente IT_Confirmacion
					IT_Confirmacion_Inicializa 
					  //Cargo los elementos que se mostrarán en el mensaje de confirmación
					If ($l_sesionesFueraDePeriodo>0)
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("108/0_EncabezadoRestriccionInicio_conSesiones"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("110/btn1_RetrasaInicio_y_EliminaSesiones"))
					Else 
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("109/0_EncabezadoRestriccionInicio_sinSesiones"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("111/btn1_RetrasaInicio_sinsesiones"))
					End if 
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("100/btn0_Cancelar"))
					  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaInicio_nueva";String:C10($d_fechaInicio_nueva;System date abbreviated:K1:2))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_InasistenciasFueraDePeriodo";String:C10($l_InasistenciasFueraDePeriodo))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_sesionesFueraDePeriodo";String:C10($l_sesionesFueraDePeriodo))
					
					  // Muestro el cuadro de diálogo de confirmación
					  // pasa en $t_textoLog el encabezado para el registro de actividades
					$t_Textolog:="Retraso del inicio del año escolar en la configuración de períodos ^0"
					$t_Textolog:=Replace string:C233($t_Textolog;"^0";[xxSTR_Periodos:100]Nombre_Configuracion:2+" ("+String:C10([xxSTR_Periodos:100]ID:1)+")")
					$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
					
					Case of 
						: ($l_opcionUsuario=0)
							vd_periodoInicio:=[xxSTR_DatosPeriodos:132]FechaInicio:3
						: ($l_opcionUsuario=1)
							If ($l_sesionesFueraDePeriodo>0)
								$l_sesionesEliminadas:=ASrs_EliminaSesiones (->$al_recNumSesiones)
							Else 
								$l_sesionesEliminadas:=1
							End if 
							If ($l_sesionesEliminadas=1)
								  // guardo los cambios en la configuración y vuelvo a cargarlos para poder validar las fechas en el horario
								CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
								PERIODOS_Init 
								PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
								
								For ($i_registros;1;Size of array:C274($al_RecNumsHorarios))
									READ WRITE:C146([TMT_Horario:166])
									GOTO RECORD:C242([TMT_Horario:166];$al_RecNumsHorarios{$i_registros})
									$d_fecha:=$d_fechaInicio_nueva
									$b_FechaValida:=TMT_FechaDiaValidos (->$d_fecha;$d_fechaInicio_nueva+7;[TMT_Horario:166]NumeroDia:1)
									If ($b_FechaValida)
										[TMT_Horario:166]SesionesDesde:12:=$d_fecha
										SAVE RECORD:C53([TMT_Horario:166])
									End if 
								End for 
								vb_CambiosEnCalendario:=True:C214
							Else 
								  // no fue posible eliminar las sesiones
								  // es necesario restablecer la fecha de término anterior
								CD_Dlog (0;__ ("No fue posible aplicar el cambio de fecha.\r\rPor intente nuevamente más tarde."))
								  // en caso que la selección actual del periodo haya cambiado durante la ejecución de este método
								  // vuelvo a leer los datos del período y reestablezco la fecha de termino anterior
								vl_RecNumPeriodos:=$l_recNumPeriodo
								SELECT LIST ITEMS BY REFERENCE:C630(hl_periodosEscolares;$l_recNumPeriodo)
								CFG_STR_PeriodosEscolares_NEW ("LeeDatosPeriodo")
								vd_periodoInicio:=$d_fechaInicio_anterior
								  // guardo la configuración reestablecida
							End if 
					End case 
				End if 
				
				
				
		End case 
		
		
		
	Else 
		  // CAMBIOS EN LAS FECHA DE INICIO O TERMINO DE CUALQUIER OTRO PERIODO
		Case of 
			: (vd_periodoInicio<[xxSTR_DatosPeriodos:132]FechaInicio:3)
				  // adelantamiento de la fecha de inicio de un período intermedio
				  // será necesario crear nuevas sesiones de clases entre la fecha de inicio anterior y la nueva fecha de inicio
				  // si la fecha de inicio anterior es inferior a la fecha actual
				$d_fechaInicio_nueva:=vd_periodoInicio
				$d_fechaInicio_anterior:=[xxSTR_DatosPeriodos:132]FechaInicio:3
				$t_NombrePeriodo:=[xxSTR_DatosPeriodos:132]Nombre:8
				
				If (Current date:C33(*)>$d_fechaInicio_nueva)
					  // Inicializo el componente IT_Confirmacion
					IT_Confirmacion_Inicializa 
					
					  //Cargo los elementos que se mostrarán en el mensaje de confirmación
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("125/0_Encabezado"))
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("126/btn1_AdelantarInicio"))
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("127/btn0_Cancelar"))
					
					  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaInicio_nueva";String:C10($d_fechaInicio_nueva;System date abbreviated:K1:2))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_NombrePeriodo";$t_NombrePeriodo)
					
					  // Muestro el cuadro de diálogo de confirmación
					  // pasa en $t_textoLog el encabezado para el registro de actividades
					$t_Textolog:="Adelantamiento de la fecha de inicio del período ^1 en la configuración de períodos ^0"
					$t_Textolog:=Replace string:C233($t_Textolog;"^0";[xxSTR_Periodos:100]Nombre_Configuracion:2+" ("+String:C10([xxSTR_Periodos:100]ID:1)+")")
					$t_Textolog:=Replace string:C233($t_Textolog;"^1";$t_NombrePeriodo)
					$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
					
				Else 
					$l_opcionUsuario:=1
				End if 
				
				Case of 
					: ($l_opcionUsuario=0)
						vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
						
					: ($l_opcionUsuario=1)
						  // guardo los cambios en la configuración y vuelvo a cargarlos para poder validar las fechas en el horario
						CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
						PERIODOS_Init 
						PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
						
						QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
						KRL_RelateSelection (->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]NoNivel:5)
						QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12;>=;$d_fechaInicio_anterior;*)
						QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12;<=;$d_fechaInicio_anterior+7)
						ARRAY LONGINT:C221($al_RecNums;0)
						LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_RecNums;"")
						For ($i_registros;1;Size of array:C274($al_RecNums))
							READ WRITE:C146([TMT_Horario:166])
							GOTO RECORD:C242([TMT_Horario:166];$al_RecNums{$i_registros})
							$d_fecha:=$d_fechaInicio_nueva
							$b_FechaValida:=TMT_FechaDiaValidos (->$d_fecha;$d_fechaInicio_nueva-7;[TMT_Horario:166]NumeroDia:1)
							If ($b_FechaValida)
								[TMT_Horario:166]SesionesDesde:12:=$d_fecha
								SAVE RECORD:C53([TMT_Horario:166])
							End if 
						End for 
						KRL_UnloadReadOnly (->[TMT_Horario:166])
						dbu_CreaSesiones (False:C215;$d_fechaInicio_nueva;$d_fechaInicio_anterior-1)
						GOTO RECORD:C242([xxSTR_Periodos:100];$l_RecNumPeriodoConf)
						PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)  // MONO 147819 
				End case 
				
				
			: (vd_periodoInicio>[xxSTR_DatosPeriodos:132]FechaInicio:3)
				$d_fechaInicio_nueva:=vd_periodoInicio
				$d_fechaInicio_anterior:=[xxSTR_DatosPeriodos:132]FechaInicio:3
				$t_NombrePeriodo:=[xxSTR_DatosPeriodos:132]Nombre:8
				
				  // obtengo una selección de asignaciones a bloques horarios en los nieveles en los que aplica la configuración de períodos
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
				KRL_RelateSelection (->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]NoNivel:5)
				CREATE SET:C116([TMT_Horario:166];"$horariosNivel")
				
				  // obtengo una selección de sesiones de clases registradas en fechas superior o igual a la fecha de termino de período establecida previamente
				  // e inferior o igual a la nueva fecha de termino de período: estas sesiones deberán ser eliminadas después de la confirmación del usuario
				KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[TMT_Horario:166]ID_Asignatura:5)
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>=;$d_fechaInicio_anterior;*)
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<;$d_fechaInicio_nueva)
				LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_recNumSesiones)
				$l_sesionesFueraDePeriodo:=Records in selection:C76([Asignaturas_RegistroSesiones:168])
				KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
				$l_inasistenciasFueraDePeriodo:=Records in selection:C76([Asignaturas_Inasistencias:125])
				
				  // obtengo las asignaciones de horario con fecha de término superior o igual a la fecha de termino de período establecida previamente
				  // e inferior o igual a la nueva fecha de término de período:
				USE SET:C118("$horariosNivel")
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12;>=;$d_fechaInicio_anterior;*)
				QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]SesionesDesde:12;<;$d_fechaInicio_nueva)
				LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_RecNumsHorarios;"")
				
				If (Size of array:C274($al_recNumSesiones)>0)
					  // Inicializo el componente IT_Confirmacion
					IT_Confirmacion_Inicializa 
					
					  //Cargo los elementos que se mostrarán en el mensaje de confirmación
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("128/0_Encabezado"))
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("129/btn1_RetrasarInicioPeriodo"))
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("130/btn0_Cancelar"))
					
					  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaInicio_Anterior";String:C10($d_fechaInicio_Anterior;System date abbreviated:K1:2))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_FechaInicio_nueva";String:C10($d_FechaInicio_nueva;System date abbreviated:K1:2))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_inasistenciasFueraDePeriodo";String:C10($l_inasistenciasFueraDePeriodo))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_sesionesFueraDePeriodo";String:C10($l_sesionesFueraDePeriodo))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_NombrePeriodo";$t_NombrePeriodo)
					
					  // Muestro el cuadro de diálogo de confirmación
					  // pasa en $t_textoLog el encabezado para el registro de actividades
					$t_Textolog:="Retraso de la fecha de inicio del período ^1 en la configuración de períodos ^0"
					$t_Textolog:=Replace string:C233($t_Textolog;"^0";[xxSTR_Periodos:100]Nombre_Configuracion:2+" ("+String:C10([xxSTR_Periodos:100]ID:1)+")")
					$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
					
					
				Else 
					$l_opcionUsuario:=1
				End if 
				
				Case of 
					: ($l_opcionUsuario=0)
						vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
						
					: ($l_opcionUsuario=1)
						If (Size of array:C274($al_recNumSesiones)>0)
							$l_sesionesEliminadas:=ASrs_EliminaSesiones (->$al_recNumSesiones)
						Else 
							$l_sesionesEliminadas:=1
						End if 
						If ($l_sesionesEliminadas=1)
							  // guardo los cambios en la configuración y vuelvo a cargarlos para poder validar las fechas en el horario
							CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
							PERIODOS_Init 
							PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
							
							  // modifico las fechas de inicio de asignaciones horarios que podían entrar en conflicto con la nueva fecha
							For ($i_registros;1;Size of array:C274($al_RecNumsHorarios))
								READ WRITE:C146([TMT_Horario:166])
								GOTO RECORD:C242([TMT_Horario:166];$al_RecNumsHorarios{$i_registros})
								$d_fecha:=$d_fechaInicio_nueva
								$b_FechaValida:=TMT_FechaDiaValidos (->$d_fecha;$d_fechaInicio_nueva+7;[TMT_Horario:166]NumeroDia:1)
								If ($b_FechaValida)
									[TMT_Horario:166]SesionesDesde:12:=$d_fecha
									SAVE RECORD:C53([TMT_Horario:166])
								End if 
							End for 
							vb_CambiosEnCalendario:=True:C214
						Else 
							  // no fue posible eliminar las sesiones
							  // es necesario restablecer la fecha de término anterior
							CD_Dlog (0;__ ("No fue posible aplicar el cambio de fecha.\r\rPor intente nuevamente más tarde."))
							  // en caso que la selección actual del periodo haya cambiado durante la ejecución de este método
							  // vuelvo a leer los datos del período y reestablezco la fecha de termino anterior
							vl_RecNumPeriodos:=$l_recNumPeriodo
							SELECT LIST ITEMS BY REFERENCE:C630(hl_periodosEscolares;$l_recNumPeriodo)
							CFG_STR_PeriodosEscolares_NEW ("LeeDatosPeriodo")
							vd_periodoInicio:=$d_fechaInicio_anterior
							  // guardo la configuración reestablecida
						End if 
				End case 
				
				
				
			: (vd_periodoFin<[xxSTR_DatosPeriodos:132]FechaTermino:4)
				$d_fechaTermino_anterior:=[xxSTR_DatosPeriodos:132]FechaTermino:4
				$d_fechaTermino_nueva:=vd_periodoFin
				$t_NombrePeriodo:=[xxSTR_DatosPeriodos:132]Nombre:8
				  // obtengo una selección de asignaciones a bloques horarios en los nievels enl os que aplica la configuración de períodos
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
				KRL_RelateSelection (->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]NoNivel:5)
				CREATE SET:C116([TMT_Horario:166];"$horariosNivel")
				  // obtengo una selección de sesiones de clases registradas en fechas superior o igual a la fecha de termino de período establecida previamente
				  // e inferior o igual a la nueva fecha de termino de período: estas sesiones deberán ser eliminadas después de la confirmación del usuario
				KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[TMT_Horario:166]ID_Asignatura:5)
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>;$d_fechaTermino_nueva;*)
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<=;$d_fechaTermino_anterior)
				LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_recNumSesiones)
				$l_sesionesFueraDePeriodo:=Records in selection:C76([Asignaturas_RegistroSesiones:168])
				KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
				$l_inasistenciasFueraDePeriodo:=Records in selection:C76([Asignaturas_Inasistencias:125])
				
				  // obtengo las asignaciones de horario con fecha de término superior o igual a la fecha de termino de período establecida previamente
				  // e inferior o igual a la nueva fecha de término de período:
				USE SET:C118("$horariosNivel")
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13;>;$d_fechaTermino_nueva;*)
				QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13;<=;$d_fechaTermino_anterior)
				LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_RecNumsHorarios;"")
				
				If (Size of array:C274($al_recNumSesiones)>0)
					  // Inicializo el componente IT_Confirmacion
					IT_Confirmacion_Inicializa 
					
					  //Cargo los elementos que se mostrarán en el mensaje de confirmación
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("116/0_Encabezado_con_Sesiones"))
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("118/btn1_EliminacionSesiones"))
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("120/btn0_Cancelar"))
					
					  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaTermino_Anterior";String:C10($d_fechaTermino_Anterior;System date abbreviated:K1:2))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_FechaTermino_nueva";String:C10($d_FechaTermino_nueva;System date abbreviated:K1:2))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_inasistenciasFueraDePeriodo";String:C10($l_inasistenciasFueraDePeriodo))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_sesionesFueraDePeriodo";String:C10($l_sesionesFueraDePeriodo))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_NombrePeriodo";$t_NombrePeriodo)
					
					  // Muestro el cuadro de diálogo de confirmación
					  // pasa en $t_textoLog el encabezado para el registro de actividades
					$t_Textolog:="Adelantamiento de la fecha de fin del período ^1 en la configuración de períodos ^0"
					$t_Textolog:=Replace string:C233($t_Textolog;"^0";[xxSTR_Periodos:100]Nombre_Configuracion:2+" ("+String:C10([xxSTR_Periodos:100]ID:1)+")")
					$t_Textolog:=Replace string:C233($t_Textolog;"^1";$t_NombrePeriodo)
					$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
				Else 
					$l_opcionUsuario:=1
				End if 
				
				Case of 
					: ($l_opcionUsuario=0)
						vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
					: ($l_opcionUsuario=1)
						If (Size of array:C274($al_recNumSesiones)>0)
							$l_sesionesEliminadas:=ASrs_EliminaSesiones (->$al_recNumSesiones)
						Else 
							$l_sesionesEliminadas:=1
						End if 
						If ($l_sesionesEliminadas=1)
							  // guardo los cambios en la configuración y vuelvo a cargarlos para poder validar las fechas en el horario
							CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
							PERIODOS_Init 
							PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
							
							  // modifico las fechas de termino de asignaciones horarios que podían entrar en conflicto con la nueva fecha
							For ($i_registros;1;Size of array:C274($al_RecNumsHorarios))
								READ WRITE:C146([TMT_Horario:166])
								GOTO RECORD:C242([TMT_Horario:166];$al_RecNumsHorarios{$i_registros})
								$d_fecha:=$d_fechaTermino_nueva
								$b_FechaValida:=TMT_FechaDiaValidos (->$d_fecha;$d_fechaTermino_nueva-7;[TMT_Horario:166]NumeroDia:1)
								If ($b_FechaValida)
									[TMT_Horario:166]SesionesHasta:13:=$d_fecha
									SAVE RECORD:C53([TMT_Horario:166])
								End if 
							End for 
							vb_CambiosEnCalendario:=True:C214
						Else 
							  // no fue posible eliminar las sesiones
							  // es necesario restablecer la fecha de término anterior
							CD_Dlog (0;__ ("No fue posible aplicar el cambio de fecha.\r\rPor intente nuevamente más tarde."))
							  // en caso que la selección actual del periodo haya cambiado durante la ejecución de este método
							  // vuelvo a leer los datos del período y reestablezco la fecha de termino anterior
							vl_RecNumPeriodos:=$l_recNumPeriodo
							SELECT LIST ITEMS BY REFERENCE:C630(hl_periodosEscolares;$l_recNumPeriodo)
							CFG_STR_PeriodosEscolares_NEW ("LeeDatosPeriodo")
							vd_periodoInicio:=$d_fechaInicio_anterior
							  // guardo la configuración reestablecida
						End if 
				End case 
				
				
			: (vd_periodoFin>[xxSTR_DatosPeriodos:132]FechaTermino:4)
				$d_fechaTermino_anterior:=[xxSTR_DatosPeriodos:132]FechaTermino:4
				$d_fechaTermino_nueva:=vd_periodoFin
				$t_NombrePeriodo:=[xxSTR_DatosPeriodos:132]Nombre:8
				
				If (Current date:C33(*)>$d_fechaTermino_nueva)
					  // Inicializo el componente IT_Confirmacion
					IT_Confirmacion_Inicializa 
					
					  //Cargo los elementos que se mostrarán en el mensaje de confirmación
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("121/0_Encabezado"))
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("122/btn1_CrearSesiones"))
					IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("123/btn0_Cancelar"))
					
					  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$d_fechaTermino_Anterior";String:C10($d_fechaTermino_Anterior;System date abbreviated:K1:2))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_NombrePeriodo";$t_NombrePeriodo)
					
					  // Muestro el cuadro de diálogo de confirmación
					  // pasa en $t_textoLog el encabezado para el registro de actividades
					$t_Textolog:="Retraso de la fecha de termino del período ^1 en la configuración de períodos ^0"
					$t_Textolog:=Replace string:C233($t_Textolog;"^0";[xxSTR_Periodos:100]Nombre_Configuracion:2+" ("+String:C10([xxSTR_Periodos:100]ID:1)+")")
					$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
				Else 
					$l_opcionUsuario:=1
				End if 
				
				Case of 
					: ($l_opcionUsuario=0)
						vd_periodoFin:=[xxSTR_DatosPeriodos:132]FechaTermino:4
						
					: ($l_opcionUsuario=1)
						  // obtengo una selección de asignaciones a bloques horarios en los nievels enl os que aplica la configuración de períodos
						QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
						KRL_RelateSelection (->[TMT_Horario:166]Nivel:10;->[xxSTR_Niveles:6]NoNivel:5)
						QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13;>=;$d_fechaTermino_anterior-7;*)
						QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13;<;$d_fechaTermino_anterior)
						LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_RecNumsHorarios;"")
						
						  // guardo los cambios en la configuración y vuelvo a cargarlos para poder validar las fechas en el horario
						CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
						PERIODOS_Init 
						PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
						
						For ($i_registros;1;Size of array:C274($al_RecNumsHorarios))
							READ WRITE:C146([TMT_Horario:166])
							GOTO RECORD:C242([TMT_Horario:166];$al_RecNumsHorarios{$i_registros})
							$d_fecha:=$d_fechaTermino_nueva
							$b_FechaValida:=TMT_FechaDiaValidos (->$d_fecha;$d_fechaTermino_nueva-7;[TMT_Horario:166]NumeroDia:1)
							If ($b_FechaValida)
								[TMT_Horario:166]SesionesHasta:13:=$d_fecha
								SAVE RECORD:C53([TMT_Horario:166])
							End if 
						End for 
						KRL_UnloadReadOnly (->[TMT_Horario:166])
						dbu_CreaSesiones (False:C215;$d_fechaTermino_anterior;$d_fechaTermino_nueva)
						GOTO RECORD:C242([xxSTR_Periodos:100];$l_RecNumPeriodoConf)
						vb_CambiosEnCalendario:=True:C214
						PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)  // MONO 147819 
				End case 
		End case 
		
		
		
End case 


KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
