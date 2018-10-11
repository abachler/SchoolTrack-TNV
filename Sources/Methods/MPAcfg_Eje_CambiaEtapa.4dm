//%attributes = {}
  // MPAcfg_Eje_CambiaEtapa()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 01/07/12, 12:31:51
  // ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)

C_BOOLEAN:C305($b_abortarCambioEtapa)
C_LONGINT:C283($i;$l_aplicaDesdeNivel;$l_aplicaHastaNivel;$l_asignada_a_Etapa;$l_competenciasEnMatrices;$l_competenciasEvaluadas;$l_ejesEnMatrices;$l_ejesEvaluados;$l_IdArea;$l_IdEje)
C_LONGINT:C283($l_indexNivel;$l_nivelesAplicacion;$l_recnumArea;$l_recNumEje;$l_respuestaConfirmacion;$l_TransaccionOK)
C_TEXT:C284($t_enunciadoEje;$t_eventoLog;$t_mensajeConfirmacion;$t_nombreArea;$t_nombreEtapa;$t_rangoAplicacion)

ARRAY LONGINT:C221($al_recNumCompetencias;0)
ARRAY LONGINT:C221($al_recNumDimensiones;0)
If (False:C215)
	C_LONGINT:C283(MPAcfg_Eje_CambiaEtapa ;$1)
	C_LONGINT:C283(MPAcfg_Eje_CambiaEtapa ;$2)
	C_LONGINT:C283(MPAcfg_Eje_CambiaEtapa ;$3)
	C_TEXT:C284(MPAcfg_Eje_CambiaEtapa ;$4)
End if 

  // CÓDIGO
$l_recNumEje:=$1
$l_aplicaDesdeNivel:=$2
$l_aplicaHastaNivel:=$3
$t_nombreEtapa:=$4

$0:=0

KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEje;True:C214)
If (OK=1)
	$t_enunciadoEje:=[MPA_DefinicionEjes:185]Nombre:3
	$l_IdEje:=[MPA_DefinicionEjes:185]ID:1
	$l_IdArea:=[MPA_DefinicionEjes:185]ID_Area:2
	
	  // asigno valores a variables que serán utilizadas para entradas en el log de actividades
	$t_enunciadoEje:=[MPA_DefinicionEjes:185]Nombre:3
	$t_nombreArea:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionEjes:185]ID_Area:2;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
	If (($l_aplicaDesdeNivel=-100) & ($l_aplicaHastaNivel=-100))
		$t_rangoAplicacion:=__ ("Todos los niveles")
	Else 
		$t_rangoAplicacion:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_aplicaDesdeNivel;->[xxSTR_Niveles:6]Nivel:1)+" - "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_aplicaDesdeNivel;->[xxSTR_Niveles:6]Nivel:1)
	End if 
Else 
	$b_abortarCambioEtapa:=True:C214
	CD_Dlog (0;__ ("No fue posible acceder en escritura al registro de definición del Eje de aprendizaje.\r\rNo es posible continuar con el cambio de etapa."))
	
End if 

If (Not:C34($b_abortarCambioEtapa))
	If (($l_aplicaDesdeNivel=-100) & ($l_aplicaHastaNivel=-100))
		  // el eje debe aplicar a todos los niveles
		  // en que son impartidas las asignaturas pertenecientes al área
		[MPA_DefinicionEjes:185]BitsNiveles:20:=0
		For ($l_indexNivel;1;Size of array:C274(<>al_NumeroNivelesActivos))
			$l_bitToSet:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{$l_indexNivel})
			[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $l_bitToSet  // enciendo los bits de aplicación de todos los niveles
		End for 
		[MPA_DefinicionEjes:185]DesdeGrado:4:=-100
		[MPA_DefinicionEjes:185]HastaGrado:5:=-100
		[MPA_DefinicionEjes:185]Asignado_a_Etapa:19:=0
		SAVE RECORD:C53([MPA_DefinicionEjes:185])
		$l_TransaccionOK:=1
		$t_eventoLog:=__ ("El rango de aplicación del eje\"^0\" fue extendido a todos los niveles en los que se imparten las asignaturas del área ^1.")
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoEje)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
		LOG_RegisterEvt ($t_eventoLog)
		$0:=1
	Else 
		
		  // los objetos y evaluaciones que queden fuera de la nuevas etapas de aplicación de la competencia
		  // deben ser eliminados previa confirmación del usuario
		
		  // Creo un conjunto con las matrices en las que el eje dejará de ser utilizado después del cambio de etapa
		  // Esto permitirá recalcular los promedios de estas matrices una vez que salgamos del formulario de configuración de mapas.
		QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ID_Area:22;=;$l_IdArea)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]NumeroNivel:4<$l_aplicaDesdeNivel;*)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189]; | ;[MPA_AsignaturasMatrices:189]NumeroNivel:4>$l_aplicaHastaNivel)
		CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")
		
		  // busco las asignaciones del eje, sus dimensiones y competencias asociadas que deberán ser retiradas de las matrices en las que quedan fuera de aplicación
		KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
		QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=$l_IdEje)
		CREATE SET:C116([MPA_ObjetosMatriz:204];"objetos")
		$l_ejesEnMatrices:=Records in selection:C76([MPA_ObjetosMatriz:204])
		
		  // busco los registros de Evaluación de aprendizaje para el eje, las dimensiones y las competencias asociadas en las matrices de las que será retirada
		KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$l_IdEje)
		CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"enunciadosEvaluación")
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		$l_ejesEvaluados:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
		
		Case of 
			: ($l_ejesEvaluados>0)
				  // Si hay ejes, dimensiones o competencias asociadas evaluadas en niveles que quedan fuera del rango de aplicación de la nueva etapa,
				  // los ejes, dimensiones y competencias evaluadas y sus asignaciones a matrices deben ser eliminadas.
				  // Informamos al usuario y solicitamos su confirmación para el cambio de etapa
				$t_mensajeConfirmacion:=__ ("Se han registrado ^0 evaluaciones para este Eje de aprendizaje, sus dimensiones y sus competencias asociadas.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("Si confirma el cambio el Eje, las dimensiones y las competencias asociadas serán serán retiradas de las matrices y se eliminarán las evaluaciones correspondientes en los niveles que quedarán fuera del rango de aplicación.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("¿Desea realmente limitar la aplicación de este Eje de aprendizaje, sus dimensiones y sus competencias asociadas a los niveles del rango ^1?")
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";String:C10($l_ejesEvaluados))
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_rangoAplicacion)
				$l_respuestaConfirmacion:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("No");__ ("Confirmo"))
				  // creamos el texto para la enrada en el log de actividades
				$t_eventoLog:=__ ("El rango de aplicación del Eje de aprendizaje \"^0\" en el área ^1 fue modificado utilizando los rangos definidos en la etapa \"^2\": ^3. Las asignaciones a matrices y las evaluaciones asociadas en los niveles fuera de ese rango fueron elimina"+"previa co"+"mación del usuario.")
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoEje)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_nombreEtapa)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^3";$t_rangoAplicacion)
				
			: ($l_ejesEnMatrices>0)
				  // Si hay ejes, dimensiones o competencias asociadas asignados a matrices en niveles que quedan fuera del rango de aplicación de la nueva etapa,
				  // las asignaciones a matrices deben ser eliminadas.
				  // Informamos al usuario y solicitamos su confirmación para el cambio de etapa
				$t_mensajeConfirmacion:=__ ("Este Eje de aprendizaje y sus Dimensiones y Competencias asociadas son utilizadas en matrices de evaluación pero no se han registrado evaluaciones.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("Si confirma el cambio de etapa el Eje de aprendizaje y sus Dimensiones y Competencias asociadas serán retiradas de las matrices en los niveles que quedarán fuera del rango de aplicación.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("¿Desea realmente limitar la aplicación de este Eje de aprendizaje, sus dimensiones y sus competencias asociadas a los niveles del rango ^1?")
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_rangoAplicacion)
				$l_respuestaConfirmacion:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("No");__ ("Confirmo"))
				  // creamos el texto para la enrada en el log de actividades
				$t_eventoLog:=__ ("El rango de aplicación del Eje de aprendizaje \"^0\" en el área ^1 fue modificado utilizando los rangos definidos en la etapa \"^2\": ^3. Las asignaciones a matrices en los niveles fuera de ese rango fueron eliminadas previa confirmación del usuario")
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoEje)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_nombreEtapa)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^3";$t_rangoAplicacion)
				
			Else 
				  // no hay evaluaciones ni asignaciones a matrices.
				  // se puede proceder al cambio de etapa
				$l_respuestaConfirmacion:=2
				$t_eventoLog:=__ ("El Eje de aprendizaje \"^0\" del área ^1 y sus competencias asociadas fueron modificadas para aplicar sólo a los niveles del rango ")+$t_rangoAplicacion
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoEje)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
		End case 
		
		If ($l_respuestaConfirmacion=2)
			START TRANSACTION:C239
			$l_TransaccionOK:=1
			
			  // eliminación de evaluaciones que quedaron fuera del rango de aplicación de la competencia
			If (($l_TransaccionOK=1) & ($l_competenciasEvaluadas>0))
				SET_UseSet ("enunciadosEvaluación")
				$l_TransaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
			End if 
			
			  // eliminación de las asignaciones a matrices que quedaron fuera de rango de aplicación del eje
			If (($l_TransaccionOK=1) & ($l_competenciasEnMatrices>0))
				SET_UseSet ("Objetos")
				$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
			End if 
			
			  // modificación de los rangos de aplicación de las dimensiones que dependen del eje de acuerdo a los rangos del eje
			If ($l_transaccionOK=1)
				QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$l_IdEje)
				ARRAY LONGINT:C221($aLong1;Records in selection:C76([MPA_DefinicionDimensiones:188]))
				ARRAY LONGINT:C221($aLong2;Records in selection:C76([MPA_DefinicionDimensiones:188]))
				ARRAY LONGINT:C221($aLong3;Records in selection:C76([MPA_DefinicionDimensiones:188]))
				ARRAY LONGINT:C221($aLong4;Records in selection:C76([MPA_DefinicionDimensiones:188]))
				$l_asignada_a_Etapa:=1
				$l_nivelesAplicacion:=0
				For ($i;$l_aplicaDesdeNivel;$l_aplicaHastaNivel)
					$l_indexNivel:=Find in array:C230(<>aNivNo;$i)
					$l_nivelesAplicacion:=$l_nivelesAplicacion ?+ $l_indexNivel
				End for 
				AT_Populate (->$aLong1;->$l_asignada_a_Etapa)
				AT_Populate (->$aLong2;->$l_aplicaDesdeNivel)
				AT_Populate (->$aLong3;->$l_aplicaHastaNivel)
				AT_Populate (->$aLong4;->$l_nivelesAplicacion)
				$l_transaccionOK:=KRL_Array2Selection (->$aLong1;->[MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5;->$aLong2;->[MPA_DefinicionDimensiones:188]DesdeGrado:6;->$aLong3;->[MPA_DefinicionDimensiones:188]HastaGrado:7;->$aLong4;->[MPA_DefinicionDimensiones:188]BitsNiveles:21)
			End if 
			
			  // modificación de los rangos de aplicación de las competencias que dependen de la dimensión de acuerdo a los rangos de la dimensión
			If ($l_transaccionOK=1)
				QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_IdEje)
				ARRAY LONGINT:C221($aLong1;Records in selection:C76([MPA_DefinicionCompetencias:187]))
				ARRAY LONGINT:C221($aLong2;Records in selection:C76([MPA_DefinicionCompetencias:187]))
				ARRAY LONGINT:C221($aLong3;Records in selection:C76([MPA_DefinicionCompetencias:187]))
				ARRAY LONGINT:C221($aLong4;Records in selection:C76([MPA_DefinicionCompetencias:187]))
				$l_asignada_a_Etapa:=1
				$l_nivelesAplicacion:=0
				For ($i;$l_aplicaDesdeNivel;$l_aplicaHastaNivel)
					$l_indexNivel:=Find in array:C230(<>aNivNo;$i)
					$l_nivelesAplicacion:=$l_nivelesAplicacion ?+ $l_indexNivel
				End for 
				AT_Populate (->$aLong1;->$l_asignada_a_Etapa)
				AT_Populate (->$aLong2;->$l_aplicaDesdeNivel)
				AT_Populate (->$aLong3;->$l_aplicaHastaNivel)
				AT_Populate (->$aLong4;->$l_nivelesAplicacion)
				$l_transaccionOK:=KRL_Array2Selection (->$aLong1;->[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4;->$aLong2;->[MPA_DefinicionCompetencias:187]DesdeGrado:5;->$aLong3;->[MPA_DefinicionCompetencias:187]HastaGrado:13;->$aLong4;->[MPA_DefinicionCompetencias:187]BitNiveles:28)
			End if 
			
			If ($l_transaccionOK=1)
				KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEje;True:C214)
				If (OK=1)
					  // asigno los nuevos limites del rango de aplicación
					[MPA_DefinicionEjes:185]DesdeGrado:4:=$l_aplicaDesdeNivel
					[MPA_DefinicionEjes:185]HastaGrado:5:=$l_aplicaHastaNivel
					[MPA_DefinicionEjes:185]Asignado_a_Etapa:19:=1
					
					  // enciendo los bits correspondientes a los niveles del rango en el campo [MPA_DefinicionEjes]BitNiveles
					[MPA_DefinicionEjes:185]BitsNiveles:20:=0
					For ($i;$l_aplicaDesdeNivel;$l_aplicaHastaNivel)
						$l_bitToSet:=Find in array:C230(<>aNivNo;$i)
						[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $l_bitToSet
					End for 
					
					  // almaceno el registro, valido la transacción y registro la entrada en el log de actividades
					SAVE RECORD:C53([MPA_DefinicionEjes:185])
					KRL_ReloadAsReadOnly (->[MPA_DefinicionEjes:185])
					VALIDATE TRANSACTION:C240
					LOG_RegisterEvt ($t_eventoLog)
					
					  // combino el conjunto de matrices modificadas por la eliminación del objeto
					  // con el conjunto "$matrices_a_recalcular" declarado en MPAcfg_Configuracion
					UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
					SET_ClearSets ("$matricesModificadas")
					
					
				Else 
					$t_mensaje:=__ ("No fue posible completar el cambio de etapa de aplicación del Eje de aprendizaje:")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
					CD_Dlog (0;$t_mensaje)
					CANCEL TRANSACTION:C241
				End if 
				
				
			Else 
				$t_mensaje:=__ ("No fue posible completar el cambio de etapa de la Eje de aprendizaje:")
				$t_mensaje:=$t_mensaje+"\r\r"+__ ("Registros asociados que debían ser modificados o eliminados se encuentran en uso en otros procesos.")
				$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor intente nuevamente mas tarde.")
				CANCEL TRANSACTION:C241
				KRL_ReloadAsReadOnly (->[MPA_DefinicionEjes:185])
			End if 
		End if 
	End if 
End if 

If ($l_transaccionOK=1)
	If (cb_AutoActualizaMatricesMPA=1)
		  // si la transacción fue validada y la opción de actualización de matrices de evaluación por defecto esta activa
		  // asignamos la dimensión a las matrices por defecto en los niveles que están en el rango de la nueva etapa
		$l_recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]ID:1;$l_IdArea)
		
		MPAcfg_ActualizaMatrices ($l_recnumArea;Eje_Aprendizaje;$l_aplicaDesdeNivel;$l_aplicaHastaNivel;Record number:C243([MPA_DefinicionEjes:185]))
		
		  // asignamos las competencias asociadas a la dimensión a las matrices por defecto en los niveles que están en el rango de la nueva etapa
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$l_IdEje)
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$al_recNumDimensiones)
		For ($i;1;Size of array:C274($al_recNumDimensiones))
			MPAcfg_ActualizaMatrices ($l_recnumArea;Dimension_Aprendizaje;$l_aplicaDesdeNivel;$l_aplicaHastaNivel;$al_recNumDimensiones{$i})
		End for 
		
		  // asignamos las competencias asociadas a la dimensión a las matrices por defecto en los niveles que están en el rango de la nueva etapa
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_IdEje)
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNumCompetencias)
		For ($i;1;Size of array:C274($al_recNumCompetencias))
			MPAcfg_ActualizaMatrices ($l_recnumArea;Logro_Aprendizaje;$l_aplicaDesdeNivel;$l_aplicaHastaNivel;$al_recNumCompetencias{$i})
		End for 
		
		  // creamos un registro en el log de actividades para anotar la actualización de matrices después del cambio de etapa
		$t_eventoLog:=__ ("Matrices de evaluación del área \"^0\" actualizadas en los niveles del rango ^3 después del cambio de etapa del Eje \"^1\"")
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreArea)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_enunciadoEje)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^3";$t_rangoAplicacion)
		LOG_RegisterEvt ($t_eventoLog)
	End if 
End if 

$0:=$l_TransaccionOK

KRL_ReloadAsReadOnly (->[MPA_DefinicionDimensiones:188])
KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])
KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
KRL_ReloadAsReadOnly (->[MPA_ObjetosMatriz:204])
KRL_ReloadAsReadOnly (->[Asignaturas:18])
KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionAprendizajes:203])

