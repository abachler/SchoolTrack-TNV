//%attributes = {}
  // MÉTODO: xALCB_EX_Evaluaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 14/03/12, 12:40:26
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // xALCB_EX_Evaluaciones()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_calcularPromedios;$b_calificacionAceptada;$b_GuardarRegistro;$b_inasistenciaAceptada;$b_promediosModificados)
C_LONGINT:C283($i;$l_celdaEditable;$l_errorALP;$l_itemEncontrado;$l_milisegundos;$l_periodoRecalculo;$l_primeraColumnaParciales;$l_recNumCalificaciones)
C_POINTER:C301($y_arregloColumnaActivaLiteral;$y_arregloColumnaActivaReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_real;$y_campoCalificaciones_simbolo)
C_REAL:C285($r_valorAnteriorReal;$r_valorEditadoReal)
C_TEXT:C284($t_valorAnteriorLiteral;$t_valorEditadoLiteral)

ARRAY LONGINT:C221($al_arregloD2Celdas;0)
ARRAY TEXT:C222($at_ArrayNames;0)
If (False:C215)
	C_BOOLEAN:C305(xALCB_EX_Evaluaciones ;$0)
	C_LONGINT:C283(xALCB_EX_Evaluaciones ;$1)
	C_LONGINT:C283(xALCB_EX_Evaluaciones ;$2)
End if 

C_LONGINT:C283(vCol;vRow)
C_LONGINT:C283(vl_EV2_calculosEnServidor)

  // CODIGO PRINCIPAL
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	
	AL_GetCurrCell (xALP_ASNotas;vCol;vRow)
	AL_GetCellEnter (xALP_ASNotas;vCol;vRow;$l_celdaEditable)
	If (AL_GetCellMod (xALP_ASNotas)=1)
		modNotas:=True:C214
		$l_recNumCalificaciones:=aNtaRecNum{vRow}
		$l_primeraColumnaParciales:=vi_PrimeraColumnaParciales
		vi_Parcial:=Abs:C99(vCol-$l_primeraColumnaParciales)+1
		
		AL_GetCurrCell (xALP_ASNotas;vCol;vRow)
		If ((vCol>2) & (vRow>0))
			$l_errorALP:=AL_GetArrayNames (xALP_ASNotas;$at_ArrayNames)
			
			  //obtengo punteros sobre el arreglo literal editado y su par real
			$y_arregloColumnaActivaLiteral:=Get pointer:C304($at_ArrayNames{vCol})
			$y_arregloColumnaActivaReal:=Get pointer:C304("aReal"+Substring:C12($at_ArrayNames{vCol};2))
			
			  // obtengo punteros sobre los campos en los que almacenarán las calificaciones
			$y_campoCalificaciones_real:=ASev2_punteroReal ($at_ArrayNames{vCol};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
			$y_campoCalificaciones_nota:=ASev2_punteroNota ($at_ArrayNames{vCol};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
			$y_campoCalificaciones_puntos:=ASev2_punteroPuntos ($at_ArrayNames{vCol};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
			$y_campoCalificaciones_simbolo:=ASev2_punteroSimbolo ($at_ArrayNames{vCol};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
			$y_campoCalificaciones_literal:=ASev2_punteroLiteral ($at_ArrayNames{vCol};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
			
			  // asigno a variables los valores reales y literales anteriores y los valores editados
			If (($at_ArrayNames{vCol}#"aNtaEsfuerzo") & ($at_ArrayNames{vCol}#"alSTR_InasistenciasPeriodo"))
				$r_valorAnteriorReal:=$y_arregloColumnaActivaReal->{vRow}
				$t_valorAnteriorLiteral:=$y_arregloColumnaActivaLiteral->{0}
				$r_valorEditadoReal:=$y_arregloColumnaActivaReal->{vRow}
				$t_valorEditadoLiteral:=$y_arregloColumnaActivaLiteral->{vRow}
			End if 
			
			Case of 
					  // si el ingreso se hizo en la columna Bonificación extra-académica
					  //: ($at_ArrayNames{vCol}="aNtaBX")
					  //$b_calificacionAceptada:=EV2_validaCalificacion ($t_valorEditadoLiteral;->$t_valorEditadoLiteral;->$r_valorEditadoReal)
					  //If ($b_calificacionAceptada)
					  //
					  //End if 
					
					
					  // si el ingreso se hizo en la columna esfuerzo
				: ($at_ArrayNames{vCol}="aNtaEsfuerzo")
					$b_calificacionAceptada:=ASev2_registraEsfuerzo ($l_recNumCalificaciones;aNtaEsfuerzo{vRow};$y_campoCalificaciones_literal)
					If (Not:C34($b_calificacionAceptada))
						aNtaEsfuerzo{vRow}:=aNtaEsfuerzo{0}
						AL_GotoCell (xALP_ASNotas;vCol;vRow)
					Else 
						If ((([Asignaturas:18]Pondera_Esfuerzo:61) & (r1_EvEsfuerzoIndicadores=1)) | (r2_EvEsfuerzoBonificacion=1))
							$b_calcularPromedios:=True:C214
						End if 
						If (r1_EvEsfuerzoIndicadores=1)  //para que muestre el valor configurado independiente de si lo ingreso en mayus o minus 20121120 JHB
							$l_indiceIndicadorEsfuerzo:=Find in array:C230(aIndEsfuerzo;aNtaEsfuerzo{vRow})
							  // 20140526 ASM , ticket 133273 .
							If ($l_indiceIndicadorEsfuerzo=-1)
								aNtaEsfuerzo{vRow}:=""
							Else 
								aNtaEsfuerzo{vRow}:=aIndEsfuerzo{$l_indiceIndicadorEsfuerzo}
							End if 
							  //aNtaEsfuerzo{vRow}:=aIndEsfuerzo{$l_indiceIndicadorEsfuerzo}
						End if 
					End if 
					
					  // si el ingreso se hizo en la columna inasistencia
				: ($at_ArrayNames{vCol}="alSTR_InasistenciasPeriodo")
					$b_inasistenciaAceptada:=ASev2_RegistraInasistencia ($l_recNumCalificaciones;alSTR_InasistenciasPeriodo{vRow};$y_campoCalificaciones_real)
					If (Not:C34($b_inasistenciaAceptada))
						alSTR_InasistenciasPeriodo{vRow}:=alSTR_InasistenciasPeriodo{0}
						AL_GotoCell (xALP_ASNotas;vCol;vRow)
						AL_UpdateArrays (xALP_ASNotas;-1)
					End if 
					
					  // si el ingreso se hizo en la columna nota final y corresponde a un examen recuperatorio
				: (($at_ArrayNames{vCol}="aNtaF") & (vr_MinimoExRecuperatorio>=vrNTA_MinimoEscalaReferencia) & (AS_PromediosSonCalculados ))
					$t_valorEditadoLiteral:=aNtaF{vRow}
					$b_calificacionAceptada:=EV2_validaCalificacion ($t_valorEditadoLiteral;->$t_valorEditadoLiteral;->$r_valorEditadoReal)
					If ($b_calificacionAceptada)
						aNtaF{vRow}:=$t_valorEditadoLiteral
						aRealNtaF{vRow}:=$r_valorEditadoReal
						ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
						ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98)
						$l_periodoRecalculo:=0
						$b_calcularPromedios:=True:C214
					Else 
						aNtaF{vRow}:=$t_valorAnteriorLiteral
						aRealNtaF{vRow}:=$r_valorAnteriorReal
						AL_GotoCell (xALP_ASNotas;vCol;vRow)
					End if 
					AL_SetCellStyle (xALP_ASNotas;vCol;$i;vCol;$i;$al_arregloD2Celdas;Underline:K14:4+Bold:K14:2)
					
				Else 
					
					  // si el ingreso se hizo en cualquier otra columna de calificaciones
					$t_valorEditadoLiteral:=$y_arregloColumnaActivaLiteral->{vRow}
					$b_calificacionAceptada:=EV2_validaCalificacion ($t_valorEditadoLiteral;->$t_valorEditadoLiteral;->$r_valorEditadoReal)
					If ($b_calificacionAceptada)
						$y_arregloColumnaActivaReal->{vRow}:=$r_valorEditadoReal
						KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumCalificaciones;False:C215)
						  // si se editaron las notas de los examenes finales calculamos los promedios
						Case of 
							: (($at_ArrayNames{vCol}="aNtaEX") & ([Alumnos_Calificaciones:208]ExamenAnual_Real:16#$r_valorEditadoReal))
								ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo)
								EV2_Calculos_PromediosFinales ($l_recNumCalificaciones)
								aNtaF{vRow}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
								aRealNtaF{vRow}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
							: (($at_ArrayNames{vCol}="aNtaEXX") & ([Alumnos_Calificaciones:208]ExamenExtra_Real:21#$r_valorEditadoReal))
								ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo)
								EV2_Calculos_PromediosFinales ($l_recNumCalificaciones)
								aNtaF{vRow}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
								aRealNtaF{vRow}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
							Else 
								$b_GuardarRegistro:=[Asignaturas:18]Consolidacion_EsConsolidante:35 | [Asignaturas:18]Resultado_no_calculado:47
								ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
								$b_calcularPromedios:=True:C214
						End case 
						
						
						
						If (iviewMode=iPrintMode)
							$y_arregloColumnaActivaLiteral->{vRow}:=$y_campoCalificaciones_literal->
							$y_arregloColumnaActivaReal->{vRow}:=$y_campoCalificaciones_real->
						Else 
							$y_arregloColumnaActivaLiteral->{vRow}:=EV2_Real_a_Literal ($y_arregloColumnaActivaReal->{vRow};iViewMode;vlNTA_DecimalesParciales)
							$y_arregloColumnaActivaReal->{vRow}:=$y_campoCalificaciones_real->
						End if 
						
						
						  // si el ingreso es en la columna Nota Final y los resultados son no calculados se copian las calificaciones a la nota oficial
						If ([Asignaturas:18]Resultado_no_calculado:47 & ($at_ArrayNames{vCol}="aNtaF"))
							aNtaOF{vRow}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
							aRealNtaOficial{vRow}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32
						End if 
						
						  // si había un valor ingresado para un examen recuperatorio y se deja vacio el examen normal o el examen extraordinario hay que borrar el examen recuperatorio
						  // (no puede haber examen recuperatorio si no hay examen normal y extraordinario)
						Case of 
							: (($at_ArrayNames{vCol}="aNtaEX") & (aNtaEX{vRow}="") & ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95>-10))
								ASev2_RegistraCalificacion ($l_recNumCalificaciones;-10;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98;[Asignaturas:18]Consolidacion_EsConsolidante:35)
							: (($at_ArrayNames{vCol}="aNtaEXX") & (aNtaEXX{vRow}="") & ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95>-10))
								ASev2_RegistraCalificacion ($l_recNumCalificaciones;-10;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98;[Asignaturas:18]Consolidacion_EsConsolidante:35)
						End case 
						
					Else 
						$y_arregloColumnaActivaLiteral->{vRow}:=$t_valorAnteriorLiteral
						$y_arregloColumnaActivaReal->{vRow}:=$r_valorAnteriorReal
						AL_GotoCell (xALP_ASNotas;vCol;vRow)
					End if 
			End case 
			
			If (($b_calcularPromedios) & (AS_PromediosSonCalculados ))
				If (vl_EV2_calculosEnServidor=1)
					vl_ExecOnServer_Count:=vl_ExecOnServer_Count+1
					$l_milisegundos:=Milliseconds:C459
					SAVE RECORD:C53([Alumnos_Calificaciones:208])
					UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
					EV2_Calculos_Server (aNtaRecNum{vRow};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
					KRL_GotoRecord (->[Alumnos_Calificaciones:208];aNtaRecNum{vRow};False:C215)
					vl_ExecOnServer_ms:=vl_ExecOnServer_ms+Milliseconds:C459-$l_milisegundos
					vl_ExecOnServer_average:=vl_ExecOnServer_ms/vl_ExecOnServer_Count
				Else 
					vl_ExecOnClient_Count:=vl_ExecOnClient_Count+1
					$l_milisegundos:=Milliseconds:C459
					$b_promediosModificados:=EV2_Calculos (aNtaRecNum{vRow};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
					KRL_GotoRecord (->[Alumnos_Calificaciones:208];aNtaRecNum{vRow};False:C215)
					vl_ExecOnClient_ms:=vl_ExecOnClient_ms+Milliseconds:C459-$l_milisegundos
					vl_ExecOnClient_average:=vl_ExecOnClient_ms/vl_ExecOnClient_Count
				End if 
				ASev2_RefrescaPromedios 
			End if 
			
			If ((EV2_CalificacionesModificadas ) & ($b_promediosModificados=False:C215))
				SAVE RECORD:C53([Alumnos_Calificaciones:208])
			End if 
			
			
			$l_itemEncontrado:=Find in array:C230(aIdAlumnos_a_Recalcular;aNtaIdAlumno{vRow})
			If ($l_itemEncontrado<0)
				APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;aNtaIdAlumno{vRow})  // agrego el id del alumno para la creación de tarea de calculo de promedio general del alumno en EV2_TareasPostEdicion
			End if 
			
			If (($at_ArrayNames{vCol}#"aNtaEsfuerzo") & ($at_ArrayNames{vCol}#"alSTR_InasistenciasPeriodo"))
				ASev2_refrescaPlanilla ($y_arregloColumnaActivaReal)
			End if 
			
		End if 
	End if 
	AL_SetCellStyle (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;0;"Tahoma")
End if 