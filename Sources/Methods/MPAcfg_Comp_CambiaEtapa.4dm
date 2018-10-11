//%attributes = {}
  // MPAcfg_Comp_CambiaEtapa(recNumCompetencia:L; aplicaDesdeNivel:L, aplicaHastaNivel:L; nombreEtapa:T)
  // modifica el rango de niveles de aplicación de una competencia
  // - recNumCompetencia: record number de la competencia
  // - aplicaDesdeNivel: limite inferior del rango de niveles de aplicacion de la competencia
  // - aplicaHastaNivel: limite superior del rango de niveles de aplicacion de la competencia
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
C_LONGINT:C283($i;$indexNivel;$l_aplicaDesdeNivel;$l_aplicaHastaNivel;$l_competenciasEnMatrices;$l_competenciasEvaluadas;$l_IdCompetencia;$l_recNumArea;$l_recNumCompetencia;$l_respuestaConfirmacion)
C_LONGINT:C283($l_TransaccionOK)
C_TEXT:C284($t_enunciadoCompetencia;$t_eventoLog;$t_nombreArea;$t_nombreEtapa)
If (False:C215)
	C_LONGINT:C283(MPAcfg_Comp_CambiaEtapa ;$1)
	C_LONGINT:C283(MPAcfg_Comp_CambiaEtapa ;$2)
	C_LONGINT:C283(MPAcfg_Comp_CambiaEtapa ;$3)
	C_TEXT:C284(MPAcfg_Comp_CambiaEtapa ;$4)
End if 



  // CÓDIGO
$l_recNumCompetencia:=$1
$l_aplicaDesdeNivel:=$2
$l_aplicaHastaNivel:=$3
$t_nombreEtapa:=$4


KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia;True:C214)
If (OK=1)
	[MPA_DefinicionCompetencias:187]DesdeGrado:5:=$l_aplicaDesdeNivel
	[MPA_DefinicionCompetencias:187]HastaGrado:13:=$l_aplicaHastaNivel
	[MPA_DefinicionCompetencias:187]BitNiveles:28:=0
	For ($i;$l_aplicaDesdeNivel;$l_aplicaHastaNivel)
		$l_bitToSet:=Find in array:C230(<>aNivNo;$i)
		[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_bitToSet
	End for 
	
	If (Not:C34(MPAcfg_Comp_EsUnica ))
		CD_Dlog (0;__ ("Existe una competencia con el mismo nombre en el mismo contenedor (Area, Eje o Dimensión) que aplica en las mismas etapas o niveles académicos.\r\rNo es posible desplazar la competencia a ")+$t_nombreEtapa)
		OK:=0
		$b_abortarCambioEtapa:=True:C214
		
		
	Else 
		$l_IdCompetencia:=[MPA_DefinicionCompetencias:187]ID:1
		$l_IdArea:=[MPA_DefinicionCompetencias:187]ID_Area:11
		
		  // asigno valores a variables que serán utilizadas para entradas en el log de actividades 
		$t_enunciadoCompetencia:=[MPA_DefinicionCompetencias:187]Competencia:6
		$t_nombreArea:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		If (($l_aplicaDesdeNivel=-100) & ($l_aplicaHastaNivel=-100))
			$t_rangoAplicacion:=__ ("Todos los niveles")
		Else 
			$t_rangoAplicacion:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_aplicaDesdeNivel;->[xxSTR_Niveles:6]Nivel:1)+" - "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_aplicaHastaNivel;->[xxSTR_Niveles:6]Nivel:1)
		End if 
		
		
		$b_abortarCambioEtapa:=False:C215
		Case of 
			: ([MPA_DefinicionCompetencias:187]ID_Dimension:23#0)
				  // si la competencia depende de una dimensión verificamos que sus etapas/niveles de aplicación sean compatibles
				  // (la competencia no puede ser utilizada en niveles en los que la dimensión no aplica)
				RELATE ONE:C42([MPA_DefinicionCompetencias:187]ID_Dimension:23)
				$b_abortarCambioEtapa:=False:C215
				For ($i;1;24)
					If (([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $i) & (Not:C34([MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $i)))
						$b_abortarCambioEtapa:=True:C214
						CD_Dlog (0;__ ("Esta Competencia depende de una Dimensión de aprendizaje con rangos de aplicación no compatibles."))
						$i:=24
					End if 
				End for 
				
				
			: ([MPA_DefinicionCompetencias:187]ID_Eje:2#0)
				  // si la competencia depende de un eje verificamos que sus etapas/niveles de aplicación sean compatibles
				  // (la competencia no puede ser utilizada en niveles en los que que el eje no aplica)
				RELATE ONE:C42([MPA_DefinicionCompetencias:187]ID_Eje:2)
				$b_abortarCambioEtapa:=False:C215
				For ($i;1;24)
					If (([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $i) & (Not:C34([MPA_DefinicionEjes:185]BitsNiveles:20 ?? $i)))
						$b_abortarCambioEtapa:=True:C214
						CD_Dlog (0;__ ("Esta Competencia depende de un Eje de aprendizaje con rangos de aplicación no compatibles."))
						$i:=24
					End if 
				End for 
				
		End case 
	End if 
Else 
	$t_mensaje:=__ ("No fue posible completar el cambio de etapa de aplicación:")
	$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
	CD_Dlog (0;$t_mensaje)
	$b_abortarCambioEtapa:=True:C214
End if 

If (Not:C34($b_abortarCambioEtapa))
	If (($l_aplicaDesdeNivel=-100) & ($l_aplicaHastaNivel=-100))
		  // la competencia debe aplicar a todos los niveles 
		  // en que son impartidas las asignaturas pertenecientes al área,
		[MPA_DefinicionCompetencias:187]BitNiveles:28:=0
		For ($indexNivel;1;Size of array:C274(<>al_NumeroNivelesActivos))
			$l_bitToSet:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{$indexNivel})
			[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_bitToSet  // enciendo los bits de aplicación de todos los niveles
		End for 
		[MPA_DefinicionCompetencias:187]DesdeGrado:5:=-100
		[MPA_DefinicionCompetencias:187]HastaGrado:13:=-100
		[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=0
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		$l_TransaccionOK:=1
		$t_eventoLog:=__ ("El rango de aplicación de la competencia \"^0\" fue extendido a todos los niveles en los que se imparten las asignaturas del área ^1.")
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoCompetencia)
		$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
		LOG_RegisterEvt ($t_eventoLog)
		
		
	Else 
		  // los objetos y evaluaciones que queden fuera de la nuevas etapas de aplicación de la competencia
		  // deben ser eliminados previa confirmación del usuario
		
		  // Creo un conjunto con las matrices en las que las competencias dejarán de ser utilizadas después del cambio de etapa
		  // Esto permitirá recalcular los promedios de estas matrices una vez que salgamos del formulario de configuración de mapas.
		QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ID_Area:22;=;$l_IdArea)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]NumeroNivel:4<$l_aplicaDesdeNivel;*)
		QUERY SELECTION:C341([MPA_AsignaturasMatrices:189]; | ;[MPA_AsignaturasMatrices:189]NumeroNivel:4>$l_aplicaHastaNivel)
		CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")
		
		  // busco las asignaciones de la competencia que deberán ser retiradas de las matrices en las que quedan fuera de aplicación
		KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
		QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=$l_IdCompetencia)
		CREATE SET:C116([MPA_ObjetosMatriz:204];"objetos")
		$l_competenciasEnMatrices:=Records in selection:C76([MPA_ObjetosMatriz:204])
		
		  // busco los registros de Evaluación de aprendizaje para la competencia en las matrices de las que será retirada
		KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$l_IdCompetencia)
		CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"enunciadosEvaluación")
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		$l_competenciasEvaluadas:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
		
		Case of 
			: ($l_competenciasEvaluadas>0)
				  // Si hay competencias evaluadas en niveles que quedan fuera del rango de aplicación de la nueva etapa,
				  // las competencias evaluadas y sus asignaciones a matrices deben ser eliminadas.
				  // Informamos al usuario y solicitamos su confirmación para el cambio de etapa
				$t_mensajeConfirmacion:=__ ("Se han registrado ^0 evaluaciones para esta Competencia.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("Si confirma el cambio la Competencia  será retirada de las matrices y se eliminarán las evaluaciones correspondientes en los niveles que quedarán fuera del rango de aplicación.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("¿Desea realmente limitar la aplicación de esta competencia asociadas a los niveles del rango ^1?")
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";String:C10($l_competenciasEvaluadas))
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_rangoAplicacion)
				$l_respuestaConfirmacion:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("No");__ ("Confirmo"))
				  // creamos el texto para la enrada en el log de actividades
				$t_eventoLog:=__ ("El rango de aplicación de la Competencia \"^0\" en el área ^1 fue modificado utilizando los rangos definidos en la etapa \"^2\": ^3. Las asignaciones a matrices y las evaluaciones asociadas en los niveles fuera de ese rango fueron eliminadas previa co"+"mación del usuario.")
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoCompetencia)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_nombreEtapa)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^3";$t_rangoAplicacion)
				
			: ($l_competenciasEnMatrices>0)
				  // Si hay competencias asignadas a matrices en niveles que quedan fuera del rango de aplicación de la nueva etapa,
				  // las asignaciones a matrices deben ser eliminadas.
				  // Informamos al usuario y solicitamos su confirmación para el cambio de etapa
				$t_mensajeConfirmacion:=__ ("Esta Competencia es utilizada en matrices de evaluación pero no se han registrado evaluaciones.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("Si confirma el cambio de etapa la Competencia será retirada de las matrices en los niveles que quedarán fuera del rango de aplicación.")
				$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("¿Desea realmente limitar la aplicación de esta Competencias  a los niveles del rango ^1?")
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_rangoAplicacion)
				$l_respuestaConfirmacion:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("No");__ ("Confirmo"))
				  // creamos el texto para la enrada en el log de actividades
				$t_eventoLog:=__ ("El rango de aplicación de la Competencia \"^0\" en el área ^1 fue modificado utilizando los rangos definidos en la etapa \"^2\": ^3. Las asignaciones a matrices en los niveles fuera de ese rango fueron eliminadas previa confirmación del usuario")
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoCompetencia)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_nombreEtapa)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^3";$t_rangoAplicacion)
				
			Else 
				  // no hay evaluaciones ni asignaciones a matrices.
				  // se puede proceder al cambio de etapa
				$l_respuestaConfirmacion:=2
				$t_eventoLog:=__ ("La Competencia \"^0\" del área ^1 fue modificada para aplicar sólo a los niveles del rango ")+$t_rangoAplicacion
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoCompetencia)
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
			
			  // eliminación de las asignaciones a matrices que quedaron fuera de rango de aplicación de la competencia
			If (($l_TransaccionOK=1) & ($l_competenciasEnMatrices>0))
				SET_UseSet ("Objetos")
				$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
			End if 
			
			If ($l_TransaccionOK=1)
				KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia;True:C214)
				If (OK=1)
					  // asigno los nuevos limites del rango de aplicación
					[MPA_DefinicionCompetencias:187]DesdeGrado:5:=$l_aplicaDesdeNivel
					[MPA_DefinicionCompetencias:187]HastaGrado:13:=$l_aplicaHastaNivel
					[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=1
					[MPA_DefinicionCompetencias:187]BitNiveles:28:=0
					  // enciendo los bits correspondientes a los niveles del rango en el campo [MPA_DefinicionCompetencias]BitNiveles 
					For ($i;$l_aplicaDesdeNivel;$l_aplicaHastaNivel)
						$l_bitToSet:=Find in array:C230(<>aNivNo;$i)
						[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_bitToSet
					End for 
					  // almaceno el registro, valido la transacción y registro la entrada en el log de actividades
					SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
					KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])
					VALIDATE TRANSACTION:C240
					LOG_RegisterEvt ($t_eventoLog)
					
					  // combino el conjunto de matrices modificadas por la eliminación del objeto
					  // con el conjunto "$matrices_a_recalcular" declarado en MPAcfg_Configuracion
					UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
					SET_ClearSets ("$matricesModificadas")
					
				Else 
					$t_mensaje:=__ ("No fue posible completar el cambio de etapa de aplicación de la Competencia:")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
					CD_Dlog (0;$t_mensaje)
					CANCEL TRANSACTION:C241
					KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])
				End if 
			Else 
				$t_mensaje:=__ ("No fue posible completar el cambio de etapa de la Competencia:")
				$t_mensaje:=$t_mensaje+"\r\r"+__ ("Registros asociados que debían ser modificados o eliminados se encuentran en uso en otros procesos.")
				$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor intente nuevamente mas tarde.")
				CD_Dlog (0;$t_mensaje)
				CANCEL TRANSACTION:C241
			End if 
		End if 
	End if 
	
	If ($l_TransaccionOK=1)
		If (cb_AutoActualizaMatricesMPA=1)
			$l_recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]ID:1;$l_IdArea)
			
			  // si la transacción fue validada y la opción de actualización de matrices de evaluación por defecto esta activa
			  // asignamos la competencia a las matrices por defecto en los niveles que están en el rango de la nueva etapa
			MPAcfg_ActualizaMatrices ($l_recNumArea;Logro_Aprendizaje;$l_aplicaDesdeNivel;$l_aplicaHastaNivel;Record number:C243([MPA_DefinicionCompetencias:187]))
			$t_eventoLog:=__ ("Matrices de evaluación del área \"^0\" actualizadas en los niveles del rango ^3 después del cambio de etapa de la Competencia \"^1\"")
			$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreArea)
			$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_enunciadoCompetencia)
			$t_eventoLog:=Replace string:C233($t_eventoLog;"^3";$t_rangoAplicacion)
			LOG_RegisterEvt ($t_eventoLog)
		End if 
	End if 
End if 


If ($l_TransaccionOK=0)
	$l_recNumCompetencia:=-1
End if 

$0:=$l_recNumCompetencia

KRL_ReloadAsReadOnly (->[MPA_DefinicionEjes:185])
KRL_ReloadAsReadOnly (->[MPA_DefinicionDimensiones:188])
KRL_ReloadAsReadOnly (->[MPA_DefinicionCompetencias:187])
KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
KRL_ReloadAsReadOnly (->[MPA_ObjetosMatriz:204])
KRL_ReloadAsReadOnly (->[Asignaturas:18])
KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
