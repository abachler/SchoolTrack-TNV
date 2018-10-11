//%attributes = {}
  // MPAcfg_Eje_Eliminar(recordNumber{;verificacionPrevia{;mostrarAvance}})
  // - recordNumber: Longint
  // - verificaciónPrevia: Boolean (opcional, defecto TRUE)
  // - mostrarAvance: Boolean (opcional, defecto TRUE)
  // Elimina el eje cuyo record number se recibió en recordNumber
  //
  // El usuario puede tiene la opción de desconectar las competencias relacionadas con la dimensión a eliminar
  // o eliminar las competencias y registros de aprendizajes (incluyendo evaluados) relacionados
  // Se solicita confirmación al usuario si el parametro verificacionPrevia está en TRUE
  // y la dimensión o sus competencias son utilizadas en matrices o tienen evaluaciones registradas.
  // Se crea un registro en el log de actividades si la eliminación se concreta
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 28/06/12, 16:42:45
  // ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_mostrarAvance;$b_verificacionPrevia)
C_LONGINT:C283($l_asignaturas;$l_DefinicionesCompetencias;$l_definicionesDimensiones;$l_dependenciasEnAprendizajes;$l_DependenciasEnMatrices;$l_dependenciasEvaluadas;$l_IdEje;$l_IdProcesoAvance;$l_matrices;$l_recNumEje)
C_LONGINT:C283($l_respuestaConfirmacion;$l_respuestaOpciones;$l_TransaccionOK)
C_TEXT:C284($t_enunciadoDimension;$t_enunciadoEje;$t_eventoLog;$t_mensajeConfirmacion1;$t_mensajeConfirmacion2;$t_mensajeConfirmacion3;$t_mensajeConfirmacion4;$t_mensajeConfirmacion5;$t_mensajeConfirmacion6;$t_nombreArea)

If (False:C215)
	C_LONGINT:C283(MPAcfg_Eje_Eliminar ;$0)
	C_LONGINT:C283(MPAcfg_Eje_Eliminar ;$1)
	C_BOOLEAN:C305(MPAcfg_Eje_Eliminar ;$2)
	C_BOOLEAN:C305(MPAcfg_Eje_Eliminar ;$3)
End if 

  // CÓDIGO
$l_recNumEje:=$1
$b_verificacionPrevia:=True:C214
$b_mostrarAvance:=True:C214
Case of 
	: (Count parameters:C259=2)
		$b_verificacionPrevia:=$2
	: (Count parameters:C259=3)
		$b_verificacionPrevia:=$2
		$b_mostrarAvance:=$3
End case 

KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEje;True:C214)

  // creo un conjunto con las matrices que serán afectadas por la eliminación de la del eje y eventualmente las dimensiones y competencias asociadas
  // las asignaturas que utilizan estas matrices deberán ser objeto de recalculos de promedios
  // si tienen opciones de calculos activas y aprendizajes evaluados
  // este conjunto alimentará con el conjunto "$matrices_a_recalcular" declarado en EVLG_Configuracion
QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=[MPA_DefinicionEjes:185]ID:1)
KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")

  // reestablezco el registro a eliminar
KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEje;True:C214)
If (OK=1)
	$l_IdEje:=[MPA_DefinicionEjes:185]ID:1
	If ($l_IdEje>0)
		$t_enunciadoEje:=[MPA_DefinicionEjes:185]Nombre:3
		$t_nombreArea:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionEjes:185]ID_Area:2;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		
		  // Buscamos eventuales dimensiones y competencias dependientes del eje a eliminar
		READ ONLY:C145([MPA_DefinicionCompetencias:187])
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=[MPA_DefinicionEjes:185]ID:1)
		READ ONLY:C145([MPA_DefinicionDimensiones:188])
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=[MPA_DefinicionEjes:185]ID:1)
		
		If ((Records in selection:C76([MPA_DefinicionCompetencias:187])>0) | (Records in selection:C76([MPA_DefinicionDimensiones:188])>0))
			
			Case of 
				: ((Records in selection:C76([MPA_DefinicionDimensiones:188])>0) & ((Records in selection:C76([MPA_DefinicionCompetencias:187])>0)))
					$t_mensajeConfirmacion:=__ ("Las dimensiones de aprendizaje asociadas a este eje serán eliminadas (deben estar necesariamente asociadas a un eje de aprendizaje).")
					$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("Las competencias asociadas pueden ser desconectadas de este eje de aprendizaje o eliminadas conjuntamente con el eje y sus dimensiones.")
					$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("¿Que desea usted hacer?")
					$l_respuestaOpciones:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("Desconectar");__ ("Eliminar");__ ("Cancelar"))
					
				: ((Records in selection:C76([MPA_DefinicionDimensiones:188])=0) & ((Records in selection:C76([MPA_DefinicionCompetencias:187])>0)))
					$t_mensajeConfirmacion:=__ ("Las competencias asociadas pueden ser desconectadas de este eje de aprendizaje o eliminadas conjuntamente con el eje.")
					$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("¿Que desea usted hacer?")
					$l_respuestaOpciones:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("Desconectar");__ ("Eliminar");__ ("Cancelar"))
					
				: ((Records in selection:C76([MPA_DefinicionDimensiones:188])>0) & ((Records in selection:C76([MPA_DefinicionCompetencias:187])=0)))
					$t_mensajeConfirmacion:=__ ("Las dimensiones de aprendizaje asociadas a este eje serán eliminadas (deben estar necesariamente asociadas a un eje de aprendizaje).")
					$t_mensajeConfirmacion:=$t_mensajeConfirmacion+"\r\r"+__ ("¿Que desea usted hacer?")
					$l_respuestaOpciones:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("Eliminar");__ ("Cancelar"))
					If ($l_respuestaOpciones=1)
						$l_respuestaOpciones:=2
					Else 
						$l_respuestaOpciones:=3
					End if 
			End case 
			
			Case of 
				: ($l_respuestaOpciones=3)  // el usuario cancela, no hacemos nada
					
				: ($l_respuestaOpciones=1)  // el usuario opta por desconexión de las competencias y dimensiones del eje, sin afectar las evaluaciones de competencias o dimensiones
					
					START TRANSACTION:C239
					
					  // desconexión de los registros de aprendizaje de tipo Dimensión o Competencia del eje al que estaban asignados
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje)
					QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje)
					ARRAY LONGINT:C221($aLong;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
					$l_TransaccionOK:=KRL_Array2Selection (->$aLong;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
					$l_TransaccionOK:=KRL_Array2Selection (->$aLong;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
					
					If ($l_TransaccionOK=1)
						  // elimina los registros de evaluación de aprendizajes correspondientes al eje que será eliminado
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$l_IdEje;*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
						$l_TransaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
					End if 
					
					If ($l_TransaccionOK=1)
						  // elimina los registros de evaluación de aprendizajes correspondientes al eje que será eliminado
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$l_IdEje;*)
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
						$l_TransaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
					End if 
					
					If ($l_TransaccionOK=1)
						  // desconexión de los objetos de matriz de tipo Competencia o dimensión del eje a la que estaban asignados
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=$l_IdEje)
						QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje;*)
						ARRAY LONGINT:C221($aLong;Records in selection:C76([MPA_ObjetosMatriz:204]))
						$l_TransaccionOK:=KRL_Array2Selection (->$aLong;->[MPA_ObjetosMatriz:204]ID_Eje:3)
						$l_TransaccionOK:=KRL_Array2Selection (->$aLong;->[MPA_ObjetosMatriz:204]ID_Dimension:4)
					End if 
					
					If ($l_TransaccionOK=1)
						  // elimina los objetos de matriz correspondientes al eje que será eliminado
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=$l_IdEje)
						QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
						$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
					End if 
					
					If ($l_TransaccionOK=1)
						  // eliminación de los registros de dimensiones dependientes del eje a eliminar
						  // (las dimensiones no pueden existir sin estar asociadas a un eje)
						QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$l_Ideje)
						$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionDimensiones:188])
						
						  // desconexión de los registros de definición y Competencias del eje que será eliminado
						QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_IdEje)
						ARRAY LONGINT:C221($aLong;Records in selection:C76([MPA_DefinicionCompetencias:187]))
						$l_TransaccionOK:=KRL_Array2Selection (->$aLong;->[MPA_DefinicionCompetencias:187]ID_Eje:2)
					End if 
					
					If ($l_TransaccionOK=1)
						  // todos los registros implicados en la eliminación del Eje pudieron
						  // ser modificados o eliminados, ahora es posible eliminar el Eje
						KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEje;True:C214)
						If (OK=1)
							$t_eventoLog:=__ ("Eje de aprendizaje \"^0\" eliminado. Dimensiones asociadas y competencias desconectadas previa confirmación del usuario.")
							$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";[MPA_DefinicionEjes:185]Nombre:3)
							LOG_RegisterEvt ($t_eventoLog)
							DELETE RECORD:C58([MPA_DefinicionEjes:185])
							VALIDATE TRANSACTION:C240
							
							  // combino el conjunto de matrices modificadas por la eliminación del objeto
							  // con el conjunto "$matrices_a_recalcular" declarado en EVLG_Configuracion
							UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
							SET_ClearSets ("$matricesModificadas")
							$l_TransaccionOK:=1
							
						Else 
							  // no se pudo acceder en escritura al registro de Definicion del eje a eliminar
							  // se cancela la transacción
							$l_TransaccionOK:=0
							CANCEL TRANSACTION:C241
						End if 
						
					Else 
						  // la transacción no pudo ser completada debido a que hubo registros a los que no se pudo acceder en escritura,
						  // se cancela la transacción
						$l_TransaccionOK:=0
						CANCEL TRANSACTION:C241
					End if 
					
				: ($l_respuestaOpciones=2)  // Eliminación de la dimensión, los objetos de matriz aociados y las evaluaciones de la dimensión y competencias asociadas
					
					If ($b_verificacionPrevia)
						READ ONLY:C145([MPA_DefinicionDimensiones:188])
						QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$l_IdEje)
						CREATE SET:C116([MPA_DefinicionDimensiones:188];"dimensiones_MPA")
						$l_definicionesDimensiones:=Records in set:C195("Dimensiones_MPA")
						
						READ ONLY:C145([MPA_DefinicionCompetencias:187])
						QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_IdEje)
						CREATE SET:C116([MPA_DefinicionCompetencias:187];"Competencias_MPA")
						$l_DefinicionesCompetencias:=Records in set:C195("Competencias_MPA")
						
						READ ONLY:C145([MPA_ObjetosMatriz:204])
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=$l_IdEje)
						QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Dimension_Aprendizaje;*)
						QUERY SELECTION:C341([MPA_ObjetosMatriz:204]; | ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Logro_Aprendizaje)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"objetos")
						$l_DependenciasEnMatrices:=Records in set:C195("objetos")
						
						$l_matrices:=KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
						$l_asignaturas:=KRL_RelateSelection (->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
						
						QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$l_IdEje)
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Dimension_Aprendizaje;*)
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; | ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje)
						CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"evaluaciones")
						$l_dependenciasEnAprendizajes:=Records in set:C195("evaluaciones")
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
						$l_dependenciasEvaluadas:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
						
						$l_respuestaConfirmacion:=0
						Case of 
							: ($l_dependenciasEvaluadas>0)
								  // el eje, las dimensiones y las competencias que de él dependen son utilizados en matrices
								  // y hay evaluaciones registradas para ellos.
								  // informamos al usuario que el eje, las dimensiones y sus competencias serán eliminados de las matrices
								  // conjuntamente con todas las evaluaciones registradas para ellos.
								  // pedimos confirmación al usuario para proceder a la eliminación
								$t_mensajeConfirmacion1:=__ ("- ^0 Dimensiones de aprendizaje dependen de este eje")
								$t_mensajeConfirmacion1:=Replace string:C233($t_mensajeConfirmacion1;"^0";String:C10($l_definicionesDimensiones))
								$t_mensajeConfirmacion2:=__ ("- ^0 Competencias dependen de este Eje.")
								$t_mensajeConfirmacion2:=Replace string:C233($t_mensajeConfirmacion2;"^0";String:C10($l_DefinicionesCompetencias))
								$t_mensajeConfirmacion3:=__ ("- El Eje de aprendizaje es utilizado en ^0 matrices de evaluación asignadas a ^1 asignaturas.")
								$t_mensajeConfirmacion3:=Replace string:C233($t_mensajeConfirmacion3;"^0";String:C10($l_matrices))
								$t_mensajeConfirmacion3:=Replace string:C233($t_mensajeConfirmacion3;"^1";String:C10($l_asignaturas))
								$t_mensajeConfirmacion4:=__ ("- Se han registrado ^0 evaluaciones en este Eje o las  Dimensiones o Competencias que de él dependen.")
								$t_mensajeConfirmacion4:=Replace string:C233($t_mensajeConfirmacion4;"^0";String:C10($l_dependenciasEvaluadas))
								$t_mensajeConfirmacion5:=__ ("Si elimina esta Eje, será eliminado de las matrices de evaluación que lo utilizan con las Dimensiones y Competencias que de el dependen.\rTambién se eliminarán las evaluaciones asociadas.")
								$t_mensajeConfirmacion6:=__ ("¿Desea realmente eliminar este Eje de aprendizaje con sus todas sus dependencias? ")
								$l_respuestaConfirmacion:=CD_Dlog (0;$t_mensajeConfirmacion1+__ ("\r")+$t_mensajeConfirmacion2+__ ("\r")+$t_mensajeConfirmacion3+__ ("\r")+$t_mensajeConfirmacion4+__ ("\r\r")+$t_mensajeConfirmacion5+__ ("\r\r")+$t_mensajeConfirmacion6;__ ("");__ ("No");__ ("Si. Eliminar todo"))
								  // creamos el texto para una entrada en el log indicando la eliminación en las matrices del eje, la dimensión, sus competencias
								  // y de las evaluaciones registradas para ellos, previa confirmación del usuario (la entrada en el log solo será creada si el usuario confirmó)
								$t_eventoLog:=__ ("El Eje de aprendizaje \"^0\" fue eliminado del mapa de aprendizaje del área \"^1\" y de las ^2 matrices de evaluación que lo utilizaban. Se eliminaron también todas las evaluaciones asociadas previa confirmación del usuario.")
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoEje)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_NombreArea)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";String:C10($l_matrices))
								
							: ($l_DependenciasEnMatrices>0)
								  // el eje, las dimensiones y las competencias que de él dependen son utilizados en matrices.
								  // informamos al usuario que la dimensión y sus competencias serán eliminadas de las matrices
								  // pedimos confirmación al usuario para proceder a la eliminación
								$t_mensajeConfirmacion1:=__ ("- ^0 Dimensiones de aprendizaje dependen de este eje")
								$t_mensajeConfirmacion1:=Replace string:C233($t_mensajeConfirmacion1;"^0";String:C10($l_definicionesDimensiones))
								$t_mensajeConfirmacion2:=__ ("- ^0 Competencias dependen de este Eje.")
								$t_mensajeConfirmacion2:=Replace string:C233($t_mensajeConfirmacion2;"^0";String:C10($l_DefinicionesCompetencias))
								$t_mensajeConfirmacion3:=__ ("- El Eje de aprendizaje es utilizado en ^0 matrices de evaluación asignadas a ^1 asignaturas.")
								$t_mensajeConfirmacion3:=Replace string:C233($t_mensajeConfirmacion3;"^0";String:C10($l_DependenciasEnMatrices))
								$t_mensajeConfirmacion3:=Replace string:C233($t_mensajeConfirmacion3;"^1";String:C10($l_asignaturas))
								$t_mensajeConfirmacion5:=__ ("Si elimina esta Eje, será eliminado de las matrices de evaluación que lo utilizan con las Dimensiones y Competencias que de el dependen.")
								$t_mensajeConfirmacion6:=__ ("¿Desea realmente eliminar este Eje de aprendizaje con sus todas sus dependencias? ")
								  // creamos el texto para una entrada en el log indicando la eliminación en las matrices del eje, las dimensiones y competencias,
								  // previa confirmación del usuario (la entrada en el log solo será creada si el usuario confirmó)
								$l_respuestaConfirmacion:=CD_Dlog (0;$t_mensajeConfirmacion1+__ ("\r")+$t_mensajeConfirmacion2+__ ("\r")+$t_mensajeConfirmacion3+__ ("\r\r")+$t_mensajeConfirmacion5+__ ("\r\r")+$t_mensajeConfirmacion6;__ ("");__ ("No");__ ("Si. Eliminar todo"))
								$t_eventoLog:=__ ("El Eje de aprendizaje \"^0\" fue eliminado del mapa de aprendizaje del área \"^1\" previa confirmación del usuario.")
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoEje)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_NombreArea)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";String:C10($l_matrices))
								
							: (($l_DefinicionesCompetencias>0) | ($l_definicionesDimensiones>0))
								  // hay dimensiones y competencias que dependen del eje
								  // informamos al usuario que el eje y las dimensiones y competencias asociadas serán eliminados.
								$t_mensajeConfirmacion1:=__ ("- ^0 Dimensiones de aprendizaje dependen de este eje")
								$t_mensajeConfirmacion1:=Replace string:C233($t_mensajeConfirmacion1;"^0";String:C10($l_definicionesDimensiones))
								$t_mensajeConfirmacion2:=__ ("- ^0 Competencias dependen de este Eje.")
								$t_mensajeConfirmacion2:=Replace string:C233($t_mensajeConfirmacion1;"^0";String:C10($l_DefinicionesCompetencias))
								$t_mensajeConfirmacion6:=__ ("¿Desea realmente eliminar esteEje de aprendizaje con todas sus dependencias? ")
								$l_respuestaConfirmacion:=CD_Dlog (0;$t_mensajeConfirmacion1+__ ("\r")+$t_mensajeConfirmacion2+__ ("\r\r")+$t_mensajeConfirmacion6;__ ("");__ ("No");__ ("Si. Eliminar todo"))
								$t_eventoLog:=__ ("El Eje de aprendizaje \"^0\" fue eliminado del mapa de aprendizaje del área \"^1\".")
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoEje)
								$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_NombreArea)
								
						End case 
					Else 
						  // No se hizo ninguna verificación previa (de acuerdo al parametro verificacionPrevia recibido por este método)
						  // se eliminan el eje, las dimensiones y competencias asociadas, en las matrices que los utilizaban y las evaluaciones registradas para ellas
						  // se crea un registro en el log
						$t_eventoLog:=__ ("El eje de aprendizaje ^0 fue eliminado del mapa de aprendizaje del área ^1  a solicitud del usuario, conjuntamente con todas sus dependencias y evaluaciones.")
						$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
						$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
						$l_respuestaConfirmacion:=2
					End if 
					
					If ($l_respuestaConfirmacion=2)
						START TRANSACTION:C239
						If ($b_mostrarAvance)
							$l_IdProcesoAvance:=IT_UThermometer (1;0;__ ("Eliminando Ejes de aprendizajes. Un momento por favor..."))
						End if 
						
						SET_UseSet ("CompetenciasEvaluación")
						$l_transaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
						
						If ($l_transaccionOK=1)
							SET_UseSet ("Objetos")
							$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
						End if 
						
						If ($l_transaccionOK=1)
							SET_UseSet ("Competencias_MPA")
							$l_transaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionCompetencias:187])
						End if 
						
						If ($l_transaccionOK=1)
							SET_UseSet ("dimensiones_MPA")
							$l_transaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionDimensiones:188])
						End if 
						
						If ($l_transaccionOK=1)
							  // todos los registros implicados en la eliminación de la Dimensión pudieron
							  // ser modificados o eliminados, ahora es posible eliminar la dimensión
							KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEje;True:C214)
							If (OK=1)
								If ($t_eventoLog#"")
									LOG_RegisterEvt ($t_eventoLog)
								End if 
								DELETE RECORD:C58([MPA_DefinicionEjes:185])
								VALIDATE TRANSACTION:C240
								
								  // combino el conjunto de matrices modificadas por la eliminación del objeto
								  // con el conjunto "$matrices_a_recalcular" declarado en EVLG_Configuracion
								UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
								SET_ClearSets ("$matricesModificadas")
								$l_TransaccionOK:=1
								
							Else 
								  // no se pudo acceder en escritura al registro de Definicion del eje a eliminar
								  // se cancela la transacción
								$t_mensaje:=__ ("No fue posible completar la eliminación del Eje de aprendizaje:")
								$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
								CD_Dlog (0;$t_mensaje)
								$l_transaccionOK:=0
								CANCEL TRANSACTION:C241
							End if 
						Else 
							  // la transacción no pudo ser completada debido a que habían registros a los que no se pudo acceder en escritura,
							  // se cancela la transacción
							$t_mensaje:=__ ("No fue posible completar la eliminación del Eje de aprendizaje:")
							$t_mensaje:=$t_mensaje+"\r\r"+__ ("Registros asociados que debían ser modificados o eliminados se encuentran en uso en otros procesos.")
							$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor intente nuevamente mas tarde.")
							CD_Dlog (0;$t_mensaje)
							$l_transaccionOK:=0
							CANCEL TRANSACTION:C241
						End if 
						
						If ($b_mostrarAvance)
							$l_IdProcesoAvance:=IT_UThermometer (-2;$l_IdProcesoAvance)
						End if 
						
					Else 
						
					End if 
			End case 
			
		Else 
			  // no hay competencias asociadas al eje, el eje no es utilizado en ninguna matriz y no existen evaluaciones asociadas
			  // se puede proceder a la eliminación de la dimensión
			$l_respuestaConfirmacion:=2
			$t_eventoLog:=__ ("El Eje de Aprendizaje ^0 fue eliminado del mapa de aprendizaje del área ^1  a solicitud del usuario.")
			$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoEje)
			$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
			KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNumEje;True:C214)
			DELETE RECORD:C58([MPA_DefinicionEjes:185])
			If (OK=1)
				$l_TransaccionOK:=1
			Else 
				$t_mensaje:=__ ("No fue posible completar la eliminación del Eje de aprendizaje:")
				$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
				CD_Dlog (0;$t_mensaje)
			End if 
			
		End if 
	Else 
		  //solo para depuración. No debiera existir una eje sin ID
		ALERT:C41("ERROR. El eje no tiene ID")
		$l_TransaccionOK:=0
	End if 
Else 
	CD_Dlog (0;__ ("No fue posible acceder en escritura al registro de definición del Eje de aprendizaje o el registro ya no existe.\r\rEl eje de Aprendizaje no pudo se eliminado."))
	$l_TransaccionOK:=0
End if 

$0:=$l_TransaccionOK

SET_ClearSets ("Dimensiones_MPA";"Competencias_MPA";"objetos";"evaluaciones";"CompetenciasEvaluacion";"$matricesModificadas")

KRL_UnloadReadOnly (->[MPA_DefinicionEjes:185])
KRL_UnloadReadOnly (->[MPA_DefinicionDimensiones:188])
KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])
KRL_UnloadReadOnly (->[MPA_AsignaturasMatrices:189])
KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
KRL_UnloadReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])

