//%attributes = {}
  // MPAcfg_Dim_Eliminar(recordNumber{;verificacionPrevia{;mostrarAvance}})
  // - recordNumber: Longint
  // - verificaciónPrevia: Boolean (opcional, defecto TRUE)
  // - mostrarAvance: Boolean (opcional, defecto TRUE)
  // Elimina la dimensión cuyo record number se recibió en recordNumber
  //
  // El usuario puede tiene la opción de desconectar las competencias relacionadas con la dimensión a eliminar
  // o eliminar las competencias y registros de aprendizajes (incluyendo evaluados) relacionados
  // Se solicita confirmación al usuario si el parametro verificacionPrevia está en TRUE
  // y la dimensión o sus competencias son utilizadas en matrices o tienen evaluaciones registradas.
  // Se crea un registro en el log de actividades si la eliminación se concreta
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 28/06/12, 11:20:43
  // ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_mostrarAvance;$b_verificacionPrevia)
C_LONGINT:C283($l_AprendizajesEvaluados;$l_asignaturas;$l_CompetenciasEnAprendizajes;$l_CompetenciasEnMatrices;$l_CompetenciasEvaluadas;$l_DefinicionesCompetencias;$l_DimensionEnAprendizajes;$l_DimensionesEnMatrices;$l_dimensionesEvaluadas;$l_IdDimension)
C_LONGINT:C283($l_matrices;$l_recNumDimension;$l_respuestaConfirmacion;$l_respuestaOpciones;$l_TransaccionOK;$l_IdProcesoAvance)
C_TEXT:C284($t_enunciadoDimension;$t_eventoLog;$t_nombreArea;$t_textoConfirmacion1;$t_textoConfirmacion2;$t_textoConfirmacion4;$t_textoConfirmacion5;$t_textoConfirmacion6)

If (False:C215)
	C_LONGINT:C283(MPAcfg_Dim_Eliminar ;$0)
	C_LONGINT:C283(MPAcfg_Dim_Eliminar ;$1)
	C_BOOLEAN:C305(MPAcfg_Dim_Eliminar ;$2)
	C_BOOLEAN:C305(MPAcfg_Dim_Eliminar ;$3)
End if 





  // CÓDIGO
$l_recNumDimension:=$1
$b_verificacionPrevia:=True:C214
$b_mostrarAvance:=True:C214
Case of 
	: (Count parameters:C259=2)
		$b_verificacionPrevia:=$2
	: (Count parameters:C259=3)
		$b_verificacionPrevia:=$2
		$b_mostrarAvance:=$3
End case 

KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension;True:C214)

  // creo un conjunto con las matrices que serán afectadas por la eliminación de la dimensión y eventualmente de 
  // las competencias asociadas,
  // las asignaturas que utilizan estas matrices deberán ser objeto de recalculos de promedios
  // si tienen opciones de calculos activas y aprendizajes evaluados
  // este conjunto alimentará con el conjunto "$matrices_a_recalcular" declarado en EVLG_Configuracion
QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=[MPA_DefinicionDimensiones:188]ID:1)
KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")

  // reestablezco el registro a eliminar
KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension;True:C214)
If (OK=1)
	$l_IdDimension:=[MPA_DefinicionDimensiones:188]ID:1
	If ($l_IdDimension#0)
		
		$t_enunciadoDimension:=[MPA_DefinicionDimensiones:188]Dimensión:4
		$t_nombreArea:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionDimensiones:188]ID_Area:2;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		
		
		  // Buscamos eventuales competencias dependientes de la dimensión a eliminar 
		READ ONLY:C145([MPA_DefinicionCompetencias:187])
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=[MPA_DefinicionDimensiones:188]ID:1)
		If (Records in selection:C76([MPA_DefinicionCompetencias:187])>0)
			  // Existen competencias dependientes de la dimension a eliminar
			  // el usuario debe decidir si las desconecta de la dimensión o las elimina conjuntamente con la dimensión
			$l_respuestaOpciones:=CD_Dlog (0;__ ("Hay Competencias conectadas a esta Dimensión.\rPuede desconectar las Competencias de esta Dimensión o eliminarlas junto con la Dimensión.\r\r¿Que desea usted hacer?");__ ("");__ ("Desconectar");__ ("Eliminar");__ ("Cancelar"))
			Case of 
				: ($l_respuestaOpciones=3)  // el usuario cancela, no hacemos nada
					
				: ($l_respuestaOpciones=1)  // el usuario opta por desconexión de las competencias de la dimensión, sin afectar las evaluaciones de Competencias
					
					START TRANSACTION:C239
					
					  // desconexión de los registros de aprendizaje de la dimension a la que estaban asignados
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$l_IdDimension;*)
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
					ARRAY LONGINT:C221($aLong;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
					$l_TransaccionOK:=KRL_Array2Selection (->$aLong;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
					
					If ($l_TransaccionOK=1)
						  // elimina los registros de evaluación de aprendizajes correspondientes a la dimensión que será eliminada
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$l_IdDimension;*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
						$l_TransaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
					End if 
					
					If ($l_TransaccionOK=1)
						  // desconección de los objetos de matriz de tipo Comptencia de la dimension a la que estaban asignados
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$l_IdDimension;*)
						QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
						ARRAY LONGINT:C221($aLong;Records in selection:C76([MPA_ObjetosMatriz:204]))
						$l_TransaccionOK:=KRL_Array2Selection (->$aLong;->[MPA_ObjetosMatriz:204]ID_Dimension:4)
					End if 
					
					If ($l_TransaccionOK=1)
						  // elimina los objetos de matriz correspondientes a la dimensión que será eliminada
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$l_IdDimension;*)
						QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
						$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
					End if 
					
					If ($l_TransaccionOK=1)
						  // desconexión de los registros de definición de Competencias de la dimensión que será eliminada
						QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$l_IdDimension)
						ARRAY LONGINT:C221($aLong;Records in selection:C76([MPA_DefinicionCompetencias:187]))
						$l_TransaccionOK:=KRL_Array2Selection (->$aLong;->[MPA_DefinicionCompetencias:187]ID_Dimension:23)
					End if 
					
					If ($l_TransaccionOK=1)
						  // todos los registros implicados en la eliminación de la Dimensión pudieron
						  // ser modificados o eliminados, ahora es posible eliminar la dimensión
						KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension;True:C214)
						If (OK=1)
							$t_eventoLog:=__ ("Dimensión de aprendizaje \"^0\" eliminada. Competencias desconectadas previa confirmación del usuario.")
							$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";[MPA_DefinicionDimensiones:188]Dimensión:4)
							LOG_RegisterEvt ($t_eventoLog)
							$l_IdDimension:=[MPA_DefinicionDimensiones:188]ID:1
							DELETE RECORD:C58([MPA_DefinicionDimensiones:188])
							VALIDATE TRANSACTION:C240
							
							  // combino el conjunto de matrices modificadas por la eliminación del objeto
							  // con el conjunto "$matrices_a_recalcular" declarado en EVLG_Configuracion
							UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
							$l_TransaccionOK:=1
							
						Else 
							  // no se pudo acceder en escritura al registro de definición de la Dimensión a eliminar
							  // se cancela la transacción
							$l_TransaccionOK:=0
							CANCEL TRANSACTION:C241
							
						End if 
						
					Else 
						  // la transacción no pudo ser completada debido a que habían registros a los que no se pudo acceder en escritura,
						  // se cancela la transacción
						$l_TransaccionOK:=0
						CANCEL TRANSACTION:C241
						
					End if 
					
				: ($l_respuestaOpciones=2)  // Eliminación de la dimensión, los objetos de matriz aociados y las evaluaciones de la dimensión y competencias asociadas
					
					If ($b_verificacionPrevia)
						  //si se utiliza una verificación previa a la eliminación
						  // (puede desactivarse si se llama este método con FALSE en el 2do parametro)
						
						READ ONLY:C145([MPA_DefinicionCompetencias:187])
						QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$l_IdDimension)
						CREATE SET:C116([MPA_DefinicionCompetencias:187];"Competencias_MPA")
						$l_DefinicionesCompetencias:=Records in set:C195("Competencias_MPA")
						
						READ ONLY:C145([MPA_ObjetosMatriz:204])
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$l_IdDimension;*)
						QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"CompetenciasMatrices")
						$l_CompetenciasEnMatrices:=Records in set:C195("CompetenciasMatrices")
						
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$l_IdDimension;*)
						QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"dimensionesMatrices")
						$l_DimensionesEnMatrices:=Records in set:C195("dimensionesMatrices")
						UNION:C120("CompetenciasMatrices";"dimensionesMatrices";"objetos")
						
						$l_matrices:=KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
						$l_asignaturas:=KRL_RelateSelection (->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
						
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$l_IdDimension;*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
						CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"dimensionesEvaluacion")
						$l_DimensionEnAprendizajes:=Records in set:C195("dimensionesEvaluacion")
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
						CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"dimensionesEvaluadas")
						$l_dimensionesEvaluadas:=Records in set:C195("dimensionesEvaluadas")
						
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$l_IdDimension;*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
						CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"CompetenciasEvaluacion")
						$l_CompetenciasEnAprendizajes:=Records in set:C195("CompetenciasEvaluacion")
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
						CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"CompetenciasEvaluados")
						$l_CompetenciasEvaluadas:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
						INTERSECTION:C121("dimensionesEvaluadas";"CompetenciasEvaluados";"evaluaciones")
						$l_AprendizajesEvaluados:=Records in set:C195("evaluaciones")
						
						$l_respuestaConfirmacion:=0
						Case of 
							: ($l_AprendizajesEvaluados>0)
								  // la dimensión y las competencias que de ella dependen son utilizadas en matrices
								  // y hay evaluaciones registradas para ellas
								  // informamos al usuario que  la dimensión y sus competencias serán eliminadas de las matrices 
								  // conjuntamente con todas las evaluaciones registradas para ellas
								  // pedimos confirmación al usuario para proceder a la eliminación
								$t_textoConfirmacion1:=__ ("- ^0 Competencias dependen de esta dimensión.")
								$t_textoConfirmacion1:=Replace string:C233($t_textoConfirmacion1;"^0";String:C10($l_DefinicionesCompetencias))
								$t_textoConfirmacion2:=__ ("- Esta Dimensión de aprendizaje es utilizada en ^0 matrices de evaluación asignadas a ^1 asignaturas.")
								$t_textoConfirmacion2:=Replace string:C233($t_textoConfirmacion2;"^0";String:C10($l_matrices))
								$t_textoConfirmacion2:=Replace string:C233($t_textoConfirmacion2;"^1";String:C10($l_asignaturas))
								$t_textoConfirmacion4:=__ ("- Se han registrado ^0 evaluaciones en esta Dimensión o en las Competencias que de ella dependen.")
								$t_textoConfirmacion4:=Replace string:C233($t_textoConfirmacion4;"^0";String:C10($l_AprendizajesEvaluados))
								$t_textoConfirmacion5:=__ ("Si elimina esta Dimensión, ella y las Competencias que dependen serán eliminadas de las matrices de evaluación que los utilizan. También se eliminarán las evaluaciones asociadas.")
								$t_textoConfirmacion6:=__ ("¿Desea realmente eliminar esta Dimensión de aprendizaje con todas sus dependencias? ")
								$l_respuestaConfirmacion:=CD_Dlog (0;$t_textoConfirmacion1+__ ("\r")+$t_textoConfirmacion2+__ ("\r")+$t_textoConfirmacion4+__ ("\r\r")+$t_textoConfirmacion5+__ ("\r\r")+$t_textoConfirmacion6;__ ("");__ ("No");__ ("Si. Eliminar todo"))
								  // creamos el texto para una entrada en el log indicando la eliminación en las matrices de la dimensión, sus competencias 
								  // y de las evaluaciones registradas, previa confirmación del usuario (la entrada en el log solo será creada si el usuario confirmó)
								$t_eventoLog:=__ ("La Dimensión de aprendizaje ^0 fue eliminada del mapa de aprendizaje del área ^1 y de las ^2 matrices de evaluación que la utilizaban. Se eliminaron también todas las evaluaciones asociadas previa confirmación del usuario.")
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";String:C10($l_matrices))
								
								
								
							: (($l_CompetenciasEnMatrices>0) | ($l_DimensionesEnMatrices>0))
								  // la dimensión y las competencias que de ella dependen son utilizadas en matrices
								  // informamos al usuario que la dimensión y sus competencias serán eliminadas de las matrices 
								  // pedimos confirmación al usuario para proceder a la eliminación
								$t_textoConfirmacion1:=__ ("- ^0 Competencias dependen de esta dimensión.")
								$t_textoConfirmacion1:=Replace string:C233($t_textoConfirmacion1;"^0";String:C10($l_DefinicionesCompetencias))
								$t_textoConfirmacion2:=__ ("- Esta Dimensión de aprendizaje es utilizada en ^0 matrices de evaluación asignadas a ^1 asignaturas.")
								$t_textoConfirmacion2:=Replace string:C233($t_textoConfirmacion2;"^0";String:C10($l_matrices))
								$t_textoConfirmacion2:=Replace string:C233($t_textoConfirmacion2;"^1";String:C10($l_asignaturas))
								$t_textoConfirmacion6:=__ ("¿Desea realmente eliminar esta Dimensión de aprendizaje con todas sus dependencias? ")
								$l_respuestaConfirmacion:=CD_Dlog (0;$t_textoConfirmacion1+__ ("\r")+$t_textoConfirmacion2+__ ("\r\r")+$t_textoConfirmacion6;__ ("");__ ("No");__ ("Si. Eliminar todo"))
								  // creamos el texto para una entrada en el log indicando la eliminación en las matrices de la dimensión, y sus competencias
								  // previa confirmación del usuario (la entrada en el log solo será creada si el usuario confirmó)
								$t_eventoLog:=__ ("La Dimensión de aprendizaje ^0 fue eliminada del mapa de aprendizaje del área ^1 y de las ^2 matrices de evaluación que la utilizaban previa confirmación del usuario.")
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";String:C10($l_matrices))
								
								
								
							: ($l_DefinicionesCompetencias>0)
								  // hay competencias que dependen de la dimensión
								  // informamos al usuario que las competencias asociadas a la dikmensión serán eliminadas.
								$t_textoConfirmacion1:=__ ("- ^0 Competencias dependen de esta dimensión.")
								$t_textoConfirmacion1:=Replace string:C233($t_textoConfirmacion1;"^0";String:C10($l_DefinicionesCompetencias))
								$t_textoConfirmacion6:=__ ("¿Desea realmente eliminar esta Dimensión de aprendizaje con todas sus dependencias? ")
								$l_respuestaConfirmacion:=CD_Dlog (0;$t_textoConfirmacion1+__ ("\r\r")+$t_textoConfirmacion6;__ ("");__ ("No");__ ("Si. Eliminar todo"))
								  // creamos el texto para una entrada en el log indicando la eliminación de la dimensión y sus competencias
								  // previa confirmación del usuario (la entrada en el log solo será creada si el usuario confirmó)
								$t_eventoLog:=__ ("La Dimensión de aprendizaje ^0 fue eliminada del mapa de aprendizaje del área ^1.")
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
								
								
								
							Else 
								  // no hay competencias asociadas a la dimension, la dimension no es utilizada en ninguna matriz y no existen evaluaciones asociadas
								  // se puede proceder a la eliminación de la dimensión
								$l_respuestaConfirmacion:=2
								$t_eventoLog:=__ ("La Dimensión ^0 fue eliminada del mapa de aprendizaje del área ^1  a solicitud del usuario.")
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
						End case 
						
						
					Else 
						  // No se hizo ninguna verificación previa (de acuerdo al parametro verificacionPrevia recibido por este método)
						  // se eliminan la dimensión y sus competencias, en las matrices que las utilizaba y las evaluaciones registradas para ellas
						  // se crea un registro en el log
						$t_eventoLog:=__ ("La Dimensión ^0 fue eliminada del mapa de aprendizaje del área ^1  a solicitud del usuario, conjuntamente con todas dependencias y evaluaciones.")
						$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
						$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
						$l_respuestaConfirmacion:=2
					End if 
					
					
					
					
					
					If ($l_respuestaConfirmacion=2)
						START TRANSACTION:C239
						
						If ($b_mostrarAvance)
							$l_IdProcesoAvance:=IT_UThermometer (1;0;__ ("Eliminando Dimensiones de aprendizajes. Un momento por favor..."))
						End if 
						
						SET_UseSet ("CompetenciasEvaluación")
						$l_TransaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
						
						If ($l_TransaccionOK=1)
							SET_UseSet ("Objetos")
							$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
						End if 
						
						If ($l_TransaccionOK=1)
							SET_UseSet ("Competencias_MPA")
							$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionCompetencias:187])
						End if 
						
						If ($l_TransaccionOK=1)
							  // todos los registros implicados en la eliminación de la dimensión pudieron
							  // ser modificados o eliminados, ahora es posible eliminar la dimensión
							KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension;True:C214)
							DELETE RECORD:C58([MPA_DefinicionDimensiones:188])
							If (OK=1)
								If ($t_eventoLog#"")
									LOG_RegisterEvt ($t_eventoLog)
								End if 
								VALIDATE TRANSACTION:C240
								
								  // combino el conjunto de matrices modificadas por la eliminación del objeto
								  // con el conjunto "$matrices_a_recalcular" declarado en EVLG_Configuracion
								UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
								SET_ClearSets ("$matricesModificadas")
								
							Else 
								  // no se pudo acceder en escritura al registro de definicion de la Dimensión a eliminar
								  // se cancela la transacción
								$t_mensaje:=__ ("No fue posible completar la eliminación de la Dimensión de aprendizaje:")
								$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
								CD_Dlog (0;$t_mensaje)
								$l_TransaccionOK:=0
								CANCEL TRANSACTION:C241
							End if 
							
						Else 
							  // la transacción no pudo ser completada debido a que hubo registros a los que no se pudo acceder en escritura,
							  // se cancela la transacción
							$t_mensaje:=__ ("No fue posible completar la eliminación de la Dimensión de aprendizaje:")
							$t_mensaje:=$t_mensaje+"\r\r"+__ ("Registros asociados que debían ser modificados o eliminados se encuentran en uso en otros procesos.")
							$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor intente nuevamente mas tarde.")
							CD_Dlog (0;$t_mensaje)
							$l_TransaccionOK:=0
							CANCEL TRANSACTION:C241
						End if 
						
						If ($b_mostrarAvance)
							$l_IdProcesoAvance:=IT_UThermometer (-2;$l_IdProcesoAvance)
						End if 
						
					Else 
						$l_TransaccionOK:=1
					End if 
					
			End case 
		Else 
			
			  // no hay competencias asociadas a la dimension, la dimension no es utilizada en ninguna matriz y no existen evaluaciones asociadas
			  // se puede proceder a la eliminación de la dimensión
			KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension;True:C214)
			DELETE RECORD:C58([MPA_DefinicionDimensiones:188])
			If (OK=1)
				$t_eventoLog:=__ ("La Dimensión de Aprendizaje ^0 fue eliminada del mapa de aprendizaje del área ^1  a solicitud del usuario.")
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
				$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
				$l_TransaccionOK:=1
			Else 
				$l_TransaccionOK:=0
			End if 
		End if 
	Else 
		  //solo para depuración. No debiera existir una dimension si ID
		ALERT:C41("ERROR. La dimensión no tiene ID")
		$l_TransaccionOK:=0
		
	End if 
Else 
	$t_mensaje:=__ ("No fue posible completar la eliminación de la Dimensión de aprendizaje:")
	$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
	CD_Dlog (0;$t_mensaje)
	$l_TransaccionOK:=0
End if 

$0:=$l_TransaccionOK

SET_ClearSets ("dimensionesEvaluadas";"CompetenciasEvaluados";"evaluaciones";"dimensionesEvaluacion";"$matricesModificadas")
KRL_UnloadReadOnly (->[MPA_DefinicionEjes:185])
KRL_UnloadReadOnly (->[MPA_DefinicionDimensiones:188])
KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])
KRL_UnloadReadOnly (->[MPA_AsignaturasMatrices:189])
KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
KRL_UnloadReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])




