//%attributes = {}
  // AS_xALP_EdicionNotas()
  // Por: Alberto Bachler K.: 31-01-14, 20:11:17
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

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
	C_BOOLEAN:C305(AS_xALP_EdicionNotas ;$0)
	C_LONGINT:C283(AS_xALP_EdicionNotas ;$1)
	C_LONGINT:C283(AS_xALP_EdicionNotas ;$2)
End if 

C_LONGINT:C283($l_columna;$l_fila)
C_LONGINT:C283(vl_EV2_calculosEnServidor)

$l_area:=$1
$l_modoSalida:=$2
$b_edicionValida:=True:C214

$l_columna:=AL_GetAreaLongProperty ($l_area;ALP_Area_EntryColumn)
$l_fila:=AL_GetAreaLongProperty ($l_area;ALP_Area_EntryRow)
$l_celdaModificada:=AL_GetAreaLongProperty ($l_area;ALP_Area_EntryModified)


modNotas:=True:C214
$l_recNumCalificaciones:=aNtaRecNum{$l_fila}
$l_primeraColumnaParciales:=vi_PrimeraColumnaParciales
vi_Parcial:=Abs:C99($l_columna-$l_primeraColumnaParciales)+1

If (($l_columna>2) & ($l_fila>0) & ($l_celdaModificada>0))
	$l_error:=AL_GetObjects ($l_area;ALP_Object_Source;$at_ArrayNames)
	
	  //obtengo punteros sobre el arreglo literal editado y su par real
	$y_arregloColumnaActivaLiteral:=Get pointer:C304($at_ArrayNames{$l_columna})
	$y_arregloColumnaActivaReal:=Get pointer:C304("aReal"+Substring:C12($at_ArrayNames{$l_columna};2))
	
	  // obtengo punteros sobre los campos en los que almacenarán las calificaciones
	$y_campoCalificaciones_real:=ASev2_punteroReal ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	$y_campoCalificaciones_nota:=ASev2_punteroNota ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	$y_campoCalificaciones_puntos:=ASev2_punteroPuntos ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	$y_campoCalificaciones_simbolo:=ASev2_punteroSimbolo ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	$y_campoCalificaciones_literal:=ASev2_punteroLiteral ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	
	  // asigno a variables los valores reales y literales anteriores y los valores editados
	If (($at_ArrayNames{$l_columna}#"aNtaEsfuerzo") & ($at_ArrayNames{$l_columna}#"alSTR_InasistenciasPeriodo"))
		$r_valorAnteriorReal:=$y_arregloColumnaActivaReal->{$l_fila}
		$t_valorAnteriorLiteral:=$y_arregloColumnaActivaLiteral->{0}
		$r_valorEditadoReal:=$y_arregloColumnaActivaReal->{$l_fila}
		$t_valorEditadoLiteral:=$y_arregloColumnaActivaLiteral->{$l_fila}
	End if 
	
	Case of 
			  // si el ingreso se hizo en la columna esfuerzo
		: ($at_ArrayNames{$l_columna}="aNtaEsfuerzo")
			$b_calificacionAceptada:=ASev2_registraEsfuerzo ($l_recNumCalificaciones;aNtaEsfuerzo{$l_fila};$y_campoCalificaciones_literal)
			If (Not:C34($b_calificacionAceptada))
				aRealNtaEsfuerzo{$l_fila}:=aRealNtaEsfuerzo{0}  //MONO Ticket 172479
				aNtaEsfuerzo{$l_fila}:=aNtaEsfuerzo{0}
				$b_edicionValida:=False:C215
				  //AL_GotoCell (xALP_ASNotas;$l_columna;$l_fila)
			Else 
				If ((([Asignaturas:18]Pondera_Esfuerzo:61) & (r1_EvEsfuerzoIndicadores=1)) | (r2_EvEsfuerzoBonificacion=1))
					$b_calcularPromedios:=True:C214
				End if 
				If (r1_EvEsfuerzoIndicadores=1)  //para que muestre el valor configurado independiente de si lo ingreso en mayus o minus 20121120 JHB
					$l_indiceIndicadorEsfuerzo:=Find in array:C230(aIndEsfuerzo;aNtaEsfuerzo{$l_fila})
					If ($l_indiceIndicadorEsfuerzo>0)
						aNtaEsfuerzo{$l_fila}:=aIndEsfuerzo{$l_indiceIndicadorEsfuerzo}
					End if 
				Else 
					aRealNtaEsfuerzo{$l_fila}:=aRealNtaEsfuerzo{0}
					aNtaEsfuerzo{$l_fila}:=aNtaEsfuerzo{0}  //Mono Actualiza con el valor ingresado formateado
				End if 
			End if 
			
			  // si el ingreso se hizo en la columna inasistencia
		: ($at_ArrayNames{$l_columna}="alSTR_InasistenciasPeriodo")
			$b_inasistenciaAceptada:=ASev2_RegistraInasistencia ($l_recNumCalificaciones;alSTR_InasistenciasPeriodo{$l_fila};$y_campoCalificaciones_real)
			If (Not:C34($b_inasistenciaAceptada))
				alSTR_InasistenciasPeriodo{$l_fila}:=alSTR_InasistenciasPeriodo{0}
				$b_edicionValida:=False:C215
				
				  //AL_GotoCell (xALP_ASNotas;$l_columna;$l_fila)
				  //AL_UpdateArrays (xALP_ASNotas;-1)
			End if 
			
			  // si el ingreso se hizo en la columna nota final y corresponde a un examen recuperatorio
		: (($at_ArrayNames{$l_columna}="aNtaF") & (vr_MinimoExRecuperatorio>=vrNTA_MinimoEscalaReferencia) & (AS_PromediosSonCalculados ))
			$t_valorEditadoLiteral:=aNtaF{$l_fila}
			$b_calificacionAceptada:=EV2_validaCalificacion ($t_valorEditadoLiteral;->$t_valorEditadoLiteral;->$r_valorEditadoReal)
			If ($b_calificacionAceptada)
				aNtaF{$l_fila}:=$t_valorEditadoLiteral
				aRealNtaF{$l_fila}:=$r_valorEditadoReal
				ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
				ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98)
				$l_periodoRecalculo:=0
				$b_calcularPromedios:=True:C214
			Else 
				aNtaF{$l_fila}:=$t_valorAnteriorLiteral
				aRealNtaF{$l_fila}:=$r_valorAnteriorReal
				$b_edicionValida:=False:C215
				  //AL_GotoCell (xALP_ASNotas;$l_columna;$l_fila)
			End if 
			AL_SetCellLongProperty ($l_area;$l_fila;$l_columna;ALP_Cell_StyleF;Underline:K14:4+Bold:K14:2)
			  //AL_SetCellStyle (xALP_ASNotas;$l_columna;$i;$l_columna;$i;$al_arregloD2Celdas;Underline+Bold)
			
		Else 
			
			  // si el ingreso se hizo en cualquier otra columna de calificaciones
			$t_valorEditadoLiteral:=$y_arregloColumnaActivaLiteral->{$l_fila}
			$b_calificacionAceptada:=EV2_validaCalificacion ($t_valorEditadoLiteral;->$t_valorEditadoLiteral;->$r_valorEditadoReal)
			If ($b_calificacionAceptada)
				$y_arregloColumnaActivaReal->{$l_fila}:=$r_valorEditadoReal
				
				  // si se editaron las notas de los examenes finales calculamos los promedios
				Case of 
					: (($at_ArrayNames{$l_columna}="aNtaEX") & ($y_arregloColumnaActivaReal->{$l_fila}#[Alumnos_Calificaciones:208]ExamenAnual_Real:16))
						ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo)
						EV2_Calculos_PromediosFinales ($l_recNumCalificaciones)
						aNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
						aRealNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
					: (($at_ArrayNames{$l_columna}="aNtaEXX") & ($y_arregloColumnaActivaReal->{$l_fila}#[Alumnos_Calificaciones:208]ExamenExtra_Real:21))
						ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo)
						EV2_Calculos_PromediosFinales ($l_recNumCalificaciones)
						aNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
						aRealNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
					Else 
						$b_GuardarRegistro:=[Asignaturas:18]Consolidacion_EsConsolidante:35 | [Asignaturas:18]Resultado_no_calculado:47
						ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
						$b_calcularPromedios:=True:C214
				End case 
				
				
				  //vi_lastGradeView
				Case of 
					: (iViewMode=iPrintMode)
						If (iViewMode=vi_lastGradeView)
							$y_arregloColumnaActivaLiteral->{$l_fila}:=$y_campoCalificaciones_literal->
							$y_arregloColumnaActivaReal->{$l_fila}:=$y_campoCalificaciones_real->
						Else 
							$y_arregloColumnaActivaLiteral->{$l_fila}:=EV2_Real_a_Literal ($y_arregloColumnaActivaReal->{$l_fila};vi_lastGradeView;vlNTA_DecimalesParciales)
							$y_arregloColumnaActivaReal->{$l_fila}:=$y_campoCalificaciones_real->
						End if 
					Else 
						$y_arregloColumnaActivaLiteral->{$l_fila}:=EV2_Real_a_Literal ($y_arregloColumnaActivaReal->{$l_fila};iViewMode;vlNTA_DecimalesParciales)
						$y_arregloColumnaActivaReal->{$l_fila}:=$y_campoCalificaciones_real->
				End case 
				
				
				  // si el ingreso es en la columna Nota Final y los resultados son no calculados se copian las calificaciones a la nota oficial
				If ([Asignaturas:18]Resultado_no_calculado:47 & ($at_ArrayNames{$l_columna}="aNtaF"))
					aNtaOF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
					aRealNtaOficial{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32
				End if 
				
				  // si había un valor ingresado para un examen recuperatorio y se deja vacio el examen normal o el examen extraordinario hay que borrar el examen recuperatorio
				  // (no puede haber examen recuperatorio si no hay examen normal y extraordinario)
				Case of 
					: (($at_ArrayNames{$l_columna}="aNtaEX") & (aNtaEX{$l_fila}="") & ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95>-10))
						ASev2_RegistraCalificacion ($l_recNumCalificaciones;-10;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98;[Asignaturas:18]Consolidacion_EsConsolidante:35)
					: (($at_ArrayNames{$l_columna}="aNtaEXX") & (aNtaEXX{$l_fila}="") & ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95>-10))
						ASev2_RegistraCalificacion ($l_recNumCalificaciones;-10;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98;[Asignaturas:18]Consolidacion_EsConsolidante:35)
				End case 
				
			Else 
				$y_arregloColumnaActivaLiteral->{$l_fila}:=$t_valorAnteriorLiteral
				$y_arregloColumnaActivaReal->{$l_fila}:=$r_valorAnteriorReal
				AL_GotoCell (xALP_ASNotas;$l_columna;$l_fila)
			End if 
	End case 
	
	If (($b_calcularPromedios) & (AS_PromediosSonCalculados ))
		If (vl_EV2_calculosEnServidor=1)
			vl_ExecOnServer_Count:=vl_ExecOnServer_Count+1
			$l_milisegundos:=Milliseconds:C459
			SAVE RECORD:C53([Alumnos_Calificaciones:208])
			UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
			EV2_Calculos_Server (aNtaRecNum{$l_fila};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
			KRL_GotoRecord (->[Alumnos_Calificaciones:208];aNtaRecNum{$l_fila};False:C215)
			vl_ExecOnServer_ms:=vl_ExecOnServer_ms+Milliseconds:C459-$l_milisegundos
			vl_ExecOnServer_average:=vl_ExecOnServer_ms/vl_ExecOnServer_Count
		Else 
			vl_ExecOnClient_Count:=vl_ExecOnClient_Count+1
			$l_milisegundos:=Milliseconds:C459
			$b_promediosModificados:=EV2_Calculos (aNtaRecNum{$l_fila};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
			KRL_GotoRecord (->[Alumnos_Calificaciones:208];aNtaRecNum{$l_fila};False:C215)
			vl_ExecOnClient_ms:=vl_ExecOnClient_ms+Milliseconds:C459-$l_milisegundos
			vl_ExecOnClient_average:=vl_ExecOnClient_ms/vl_ExecOnClient_Count
		End if 
	End if 
	
	If ((EV2_CalificacionesModificadas ) | ($b_promediosModificados=False:C215))
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
	End if 
	
	
	$l_itemEncontrado:=Find in array:C230(aIdAlumnos_a_Recalcular;aNtaIdAlumno{$l_fila})
	If ($l_itemEncontrado<0)
		APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;aNtaIdAlumno{$l_fila})  // agrego el id del alumno para la creación de tarea de calculo de promedio general del alumno en EV2_TareasPostEdicion
	End if 
	
	If ($b_calcularPromedios)
		AS_xALP_RefrescaPromedios ($l_fila)
		AS_xALP_EstiloCalificaciones ($l_fila)
	End if 
	  //AL_SetAreaLongProperty ($l_area;ALP_Area_ClearCache;-2)
End if 



$0:=$b_edicionValida