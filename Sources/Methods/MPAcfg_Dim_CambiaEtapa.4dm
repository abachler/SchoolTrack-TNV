//%attributes = {}
  // MPAcfg_Dim_CambiaEtapa(recNumDimension:L; aplicaDesdeNivel:L, aplicaHastaNivel:L; nombreEtapa:T)
  // modifica el rango de niveles de aplicación de una dimensión
  // - recNumDimension: record number de la dimension
  // - aplicaDesdeNivel: limite inferior del rango de niveles de aplicacion de la dimension
  // - aplicaHastaNivel: limite superior del rango de niveles de aplicacion de la dimension
  // - nombreEtapa: nombre de la estapa de destino
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 30/06/12, 11:29:19
  // ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)

C_BOOLEAN:C305($b_abortarCambioEtapa)
C_LONGINT:C283($i;$l_aplicaDesdeNivel;$l_aplicaHastaNivel;$l_asignada_a_Etapa;$l_competenciasEnMatrices;$l_competenciasEvaluadas;$l_dimensionesEnMatrices;$l_dimensionesEvaluadas;$l_IdArea;$l_IdDimension)
C_LONGINT:C283($l_indexNivel;$l_nivelesAplicacion;$l_recNumArea;$l_recNumCompetencia;$l_recNumDimension;$l_respuestaConfirmacion;$l_TransaccionOK)
C_TEXT:C284($t_enunciadoDimension;$t_eventoLog;$t_mensajeConfirmacion;$t_nombreArea;$t_nombreEtapa;$t_rangoAplicacion)

ARRAY LONGINT:C221($al_recNumCompetencias;0)
If (False:C215)
	C_LONGINT:C283(MPAcfg_Dim_CambiaEtapa ;$1)
	C_LONGINT:C283(MPAcfg_Dim_CambiaEtapa ;$2)
	C_LONGINT:C283(MPAcfg_Dim_CambiaEtapa ;$3)
	C_TEXT:C284(MPAcfg_Dim_CambiaEtapa ;$4)
End if 

  // CÓDIGO
$l_recNumDimension:=$1
$l_aplicaDesdeNivel:=$2
$l_aplicaHastaNivel:=$3
$t_nombreEtapa:=$4

KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension;True:C214)
If (OK=1)
	$l_IdDimension:=[MPA_DefinicionDimensiones:188]ID:1
	$l_IdArea:=[MPA_DefinicionDimensiones:188]ID_Area:2
	
	[MPA_DefinicionDimensiones:188]DesdeGrado:6:=$l_aplicaDesdeNivel
	[MPA_DefinicionDimensiones:188]HastaGrado:7:=$l_aplicaHastaNivel
	[MPA_DefinicionDimensiones:188]BitsNiveles:21:=0
	For ($i;$l_aplicaDesdeNivel;$l_aplicaHastaNivel)
		$l_bitToSet:=Find in array:C230(<>aNivNo;$i)
		[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?+ $l_bitToSet
	End for 
	
	If (Not:C34(MPAcfg_Dim_EsUnica ))
		CD_Dlog (0;__ ("Existe una competencia con el mismo nombre en el mismo Eje que aplica en las mismas etapas o niveles académicos.\r\rNo es posible desplazar la competencia a ")+$t_nombreEtapa)
		OK:=0
		$b_abortarCambioEtapa:=True:C214
		
	Else 
		
		  // asigno valores a variables que serán utilizadas para entradas en el log de actividades
		$t_enunciadoDimension:=[MPA_DefinicionDimensiones:188]Dimensión:4
		$t_nombreArea:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionDimensiones:188]ID_Area:2;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		If (($l_aplicaDesdeNivel=-100) & ($l_aplicaHastaNivel=-100))
			$t_rangoAplicacion:=__ ("Todos los niveles")
		Else 
			$t_rangoAplicacion:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_aplicaDesdeNivel;->[xxSTR_Niveles:6]Nivel:1)+" - "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_aplicaDesdeNivel;->[xxSTR_Niveles:6]Nivel:1)
		End if 
		
		$b_abortarCambioEtapa:=False:C215
		If ([MPA_DefinicionDimensiones:188]ID_Eje:3#0)
			  // La dimension depende de un eje, verificamos que sus etapas/niveles de aplicación sean compatibles
			  // (la dimensión no puede ser utilizada en niveles en los que que el eje no aplica)
			RELATE ONE:C42([MPA_DefinicionDimensiones:188]ID_Eje:3)
			$b_abortarCambioEtapa:=False:C215
			For ($i;1;24)
				If (([MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $i) & (Not:C34([MPA_DefinicionEjes:185]BitsNiveles:20 ?? $i)))
					$b_abortarCambioEtapa:=True:C214
					CD_Dlog (0;__ ("Esta Dimensión depende de un Eje de aprendizaje con rangos de aplicación no compatibles."))
					$i:=24
				End if 
			End for 
			
			  //If ([MPA_DefinicionEjes]DesdeGrado#-100)
			  //If (([MPA_DefinicionEjes]DesdeGrado#$l_aplicaDesdeNivel) | ([MPA_DefinicionEjes]HastaGrado#$l_aplicaHastaNivel))
			  //  // si los niveles de aplicación no son compatibles advertimos al usuario y abortamos el cambio de etapa
			  //$b_abortarCambioEtapa:=True
			  //CD_Dlog (0;__ ("Esta Dimensión de Aprendizaje depende de un Eje de aprendizaje con rango de aplicación entre ")+$t_rangoAplicacion+".\r\r"+__ ("La Dimensión no puede utilizada en niveles en los que el Eje de aprendizaje no es aplicable."))
			  //End if 
			  //End if 
		End if 
	End if 
Else 
	$b_abortarCambioEtapa:=True:C214
	CD_Dlog (0;__ ("No fue posible acceder en escritura al registro de definición de la Dimensión de aprendizaje.\r\rNo es posible continuar con el cambio de etapa."))
End if 



If (Not:C34($b_abortarCambioEtapa))
	If (($l_aplicaDesdeNivel=-100) & ($l_aplicaHastaNivel=-100))
		  // la competencia debe aplicar a todos los niveles
		  // en que son impartidas las asignaturas pertenecientes al área
		[MPA_DefinicionDimensiones:188]BitsNiveles:21:=0
		For ($l_niveles;1;Size of array:C274(<>al_NumeroNivelesActivos))
			$l_bitToSet:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{$l_niveles})
			[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?+ $l_bitToSet  // enciendo los bits de aplicación de los niveles activos
		End for 
		[MPA_DefinicionDimensiones:188]DesdeGrado:6:=-100
		[MPA_DefinicionDimensiones:188]HastaGrado:7:=-100
		[MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5:=0
		SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
		$l_TransaccionOK:=1
		$t_eventoLog:=__ ("El rango de aplicación de la dimensión \"^0\" fue extendido a todos los niveles en los que se imparten las asignaturas del área ^1.")
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
		LOG_RegisterEvt ($t_eventoLog)
		$0:=1
	Else 
		
		  // los objetos y evaluaciones que queden fuera de la nuevas etapas de aplicación de la dimensión
		  // deben ser eliminados previa confirmación del usuario
		
		  // Creo un conjunto con las matrices en las que la dimension dejará de ser utilizada después del cambio de etapa
		  // Esto permitirá recalcular los promedios de estas matrices una vez que salgamos del formulario de configuración de mapas.
		QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ID_Area:22;=;$l_IdArea)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]NumeroNivel:4<$l_aplicaDesdeNivel;*)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189]; | ;[MPA_AsignaturasMatrices:189]NumeroNivel:4>$l_aplicaHastaNivel)
		CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")
		
		  // busco las asignaciones de la dimensión y de las competencias asociadas que deberán ser retiradas de las matrices en las que quedan fuera de aplicación
		KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
		QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$l_IdDimension)
		CREATE SET:C116([MPA_ObjetosMatriz:204];"objetos")
		$l_dimensionesEnMatrices:=Records in selection:C76([MPA_ObjetosMatriz:204])
		
		  // busco los registros de Evaluación de aprendizaje para la dimensión y las competencias asociadas en las matrices de las que será retirada
		KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$l_IdDimension)
		CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"enunciadosEvaluación")
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		$l_dimensionesEvaluadas:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
		
		Case of 
			: ($l_dimensionesEvaluadas>0)
				  // Si hay dimensiones o competencias asociadas evaluadas en niveles que quedan fuera del rango de aplicación de la nueva etapa,
				  // las dimensiones y competencias evaluadas y sus asignaciones a matrices deben ser eliminadas.
				  // Informamos al usuario y solicitamos su confirmación para el cambio de etapa
				$t_mensajeConfirmacion:=__ ("Se han registrado ^0 evaluaciones para esta Dimensión y sus competencias asociadas.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("Si confirma el cambio la Dimensión y sus competencias asociadas serán serán retiradas de las matrices y se eliminarán las evaluaciones correspondientes en los niveles que quedarán fuera del rango de aplicación.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("¿Desea realmente limitar la aplicación de esta dimension y las competencias asociadas a los niveles del rango ^1?")
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";String:C10($l_dimensionesEvaluadas))
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_rangoAplicacion)
				$l_respuestaConfirmacion:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("No");__ ("Confirmo"))
				  // creamos el texto para la enrada en el log de actividades
				$t_eventoLog:=__ ("El rango de aplicación de la Dimensión de aprendizaje \"^0\" en el área ^1 fue modificado utilizando los rangos definidos en la etapa \"^2\": ^3. Las asignaciones a matrices y las evaluaciones asociadas en los niveles fuera de ese rango fueron elimina"+"previa co"+"mación del usuario.")
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_nombreEtapa)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^3";$t_rangoAplicacion)
				
			: ($l_dimensionesEnMatrices>0)
				  // Si hay dimensiones y competencias asociadas asignadas a matrices en niveles que quedan fuera del rango de aplicación de la nueva etapa,
				  // las asignaciones a matrices deben ser eliminadas.
				  // Informamos al usuario y solicitamos su confirmación para el cambio de etapa
				$t_mensajeConfirmacion:=__ ("Esta Dimensión de aprendizaje y sus competencias asociadas son utilizadas en matrices de evaluación pero no se han registrado evaluaciones.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("Si confirma el cambio de etapa las dimensiones serán retiradas de las matrices en los niveles que quedarán fuera del rango de aplicación.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("¿Desea realmente limitar la aplicación de esta dimension y las competencias asociadas a los niveles del  rango ^1?")
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_rangoAplicacion)
				$l_respuestaConfirmacion:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("No");__ ("Confirmo"))
				  // creamos el texto para la enrada en el log de actividades
				$t_eventoLog:=__ ("El rango de aplicación de la Dimension \"^0\" en el área ^1 fue modificado utilizando los rangos definidos en la etapa \"^2\": ^3. Las asignaciones a matrices en los niveles fuera de ese rango fueron eliminadas previa confirmación del usuario")
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimensión)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_nombreEtapa)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^3";$t_rangoAplicacion)
				
			Else 
				  // no hay evaluaciones ni asignaciones a matrices.
				  // se puede proceder al cambio de etapa
				$l_respuestaConfirmacion:=2
				$t_eventoLog:=__ ("La Dimensión \"^0\" del área ^1 y sus competencias asociadas fueron modificadas para aplicar sólo a los niveles del rango ")+$t_rangoAplicacion
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
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
			
			  // eliminación de las asignaciones a matrices que quedaron fuera de rango de aplicación de la dimension
			If (($l_TransaccionOK=1) & ($l_competenciasEnMatrices>0))
				SET_UseSet ("Objetos")
				$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
			End if 
			
			  // modificación de los rangos de aplicación de las competencias que dependen de la dimensión de acuerdo a los rangos de la dimensión
			If ($l_transaccionOK=1)
				QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$l_IdDimension)
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
				KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension;True:C214)
				If (OK=1)
					  // asigno los nuevos limites del rango de aplicación
					[MPA_DefinicionDimensiones:188]DesdeGrado:6:=$l_aplicaDesdeNivel
					[MPA_DefinicionDimensiones:188]HastaGrado:7:=$l_aplicaHastaNivel
					[MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5:=1
					
					  // enciendo los bits correspondientes a los niveles del rango en el campo [MPA_DefinicionCompetencias]BitNiveles
					For ($i;$l_aplicaDesdeNivel;$l_aplicaHastaNivel)
						$l_bitToSet:=Find in array:C230(<>aNivNo;$i)
						[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?+ $l_bitToSet
					End for 
					
					  // almaceno el registro, valido la transacción y registro la entrada en el log de actividades
					SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
					KRL_ReloadAsReadOnly (->[MPA_DefinicionDimensiones:188])
					VALIDATE TRANSACTION:C240
					LOG_RegisterEvt ($t_eventoLog)
					
					  // combino el conjunto de matrices modificadas por la eliminación del objeto
					  // con el conjunto "$matrices_a_recalcular" declarado en MPAcfg_Configuracion
					UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
					SET_ClearSets ("$matricesModificadas")
				Else 
					$t_mensaje:=__ ("No fue posible completar el cambio de etapa de aplicación de la Dimensión de aprendizaje:")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
					CD_Dlog (0;$t_mensaje)
					CANCEL TRANSACTION:C241
				End if 
			Else 
				$t_mensaje:=__ ("No fue posible completar el cambio de etapa de la Dimensión de aprendizaje:")
				$t_mensaje:=$t_mensaje+"\r\r"+__ ("Registros asociados que debían ser modificados o eliminados se encuentran en uso en otros procesos.")
				$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor intente nuevamente mas tarde.")
				CANCEL TRANSACTION:C241
				KRL_ReloadAsReadOnly (->[MPA_DefinicionDimensiones:188])
			End if 
		End if 
	End if 
End if 



If ($l_transaccionOK=1)
	If (cb_AutoActualizaMatricesMPA=1)
		$l_recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]ID:1;$l_IdArea)
		
		  // si la transacción fue validada y la opción de actualización de matrices de evaluación por defecto esta activa
		  // asignamos la dimensión a las matrices por defecto en los niveles que están en el rango de la nueva etapa
		MPAcfg_ActualizaMatrices ($l_recNumArea;Dimension_Aprendizaje;$l_aplicaDesdeNivel;$l_aplicaHastaNivel;Record number:C243([MPA_DefinicionDimensiones:188]))
		
		  // asignamos las competencias asociadas a la dimensión a las matrices por defecto en los niveles que están en el rango de la nueva etapa
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$l_IdDimension)
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNumCompetencias)
		For ($i;1;Size of array:C274($al_recNumCompetencias))
			MPAcfg_ActualizaMatrices ($l_recNumArea;Logro_Aprendizaje;$l_aplicaDesdeNivel;$l_aplicaHastaNivel;$al_recNumCompetencias{$i})
		End for 
		
		  // creamos un registro en el log de actividades para anotar la actualización de matrices después del cambio de etapa
		$t_eventoLog:=__ ("Matrices de evaluación del área \"^0\" actualizadas en los niveles del rango ^3 después del cambio de etapa de la Dimensión \"^1\"")
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreArea)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_enunciadoDimension)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^3";$t_rangoAplicacion)
		LOG_RegisterEvt ($t_eventoLog)
	End if 
End if 

$0:=$l_TransaccionOK
KRL_ReloadAsReadOnly (->[MPA_DefinicionDimensiones:188])
KRL_ReloadAsReadOnly (->[MPA_DefinicionEjes:185])
KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])
KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
KRL_ReloadAsReadOnly (->[MPA_ObjetosMatriz:204])
KRL_ReloadAsReadOnly (->[Asignaturas:18])
KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionAprendizajes:203])