//%attributes = {}
  // MPAcfg_Area_AsignaAsignatura()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/07/12, 18:26:33
  // ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_alumnos;$l_aprendizajes;$l_aprendizajesEvaluados;$l_asignaturas;$l_matrices;$l_objetos;$l_respuestaUsuario;$l_transaccionOK)
C_TEXT:C284($t_eventoLog;$t_nombreArea;$t_nombreAreaAsignada;$t_nombreAsignatura;$t_textoConfirmacion)
If (False:C215)
	C_TEXT:C284(MPAcfg_Area_AsignaAsignatura ;$1)
	C_TEXT:C284(MPAcfg_Area_AsignaAsignatura ;$2)
End if 

  // CÓDIGO
$t_nombreAsignatura:=$1
$t_nombreArea:=$2



  // accedo en escritura al registro del subsector a asignar o re-asignar
KRL_FindAndLoadRecordByIndex (->[xxSTR_Materias:20]Materia:2;->$t_nombreAsignatura;True:C214)
If (OK=1)
	$t_nombreAreaAsignada:=[xxSTR_Materias:20]AreaMPA:4
	
	Case of 
		: (($t_nombreAreaAsignada="") & ($t_nombreArea#""))
			  // El subsector no está asignado a ningún area.
			  // La asigno inmediatamente y pongo la variable $l_transaccionOK en 1
			  // para actualizar las matrices al final de este método
			  // si la opción de actualización automática está activada
			[xxSTR_Materias:20]AreaMPA:4:=$t_nombreArea
			SAVE RECORD:C53([xxSTR_Materias:20])
			KRL_UnloadReadOnly (->[xxSTR_Materias:20])
			$t_eventoLog:=__ ("Subsector de aprendizaje \"^0\" asignado al área \"^1\".")
			$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreAsignatura)
			$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreAreaAsignada)
			LOG_RegisterEvt ($t_eventoLog)
			$l_transaccionOK:=1
			
		: ($t_nombreAreaAsignada#$t_nombreArea)
			  // el subsector está asignado a un area, el usuario quiere cambiar la asignación o retirarlo
			  // del area al que está asignado
			
			  // creo un conjunto con todas las asignaturas correspondientes al subsector asignado a otra area anteriormente
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3;=;$t_nombreAreaAsignada)
			CREATE SET:C116([Asignaturas:18];"asignaturas")
			
			  // creo un conjunto con todas las matrices utilizadas por esas asignaturas
			$l_matrices:=KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91)
			CREATE SET:C116([MPA_AsignaturasMatrices:189];"matrices")
			
			
			  // busco las asignaturas que tenían matrices con opciones de cálculos activadas
			  // y obtengo la selección de asignatruras que usan esas matrices
			  // deberán ser calculados al salir de la configuración de mapas
			QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9=True:C214)
			KRL_RelateSelection (->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
			CREATE SET:C116([Asignaturas:18];"$asignaturasConMatricesEliminadas")
			
			  // creo un conjunto con los enunciados asignados a esas matrices
			$l_objetos:=KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
			CREATE SET:C116([MPA_ObjetosMatriz:204];"objetos")
			
			  // creo un conjunto con los registros de evaluacion de aprendizajes asociados a esas matrices
			$l_aprendizajes:=KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
			CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"aprendizajes")
			$l_alumnos:=KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
			
			  // cuento los registros de evaluación de aprendizajes asociados a las matrices y efectivamente evaluados
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			$l_aprendizajesEvaluados:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
			
			  // construyo el mensaje que mostramos al usuario para confirmar la re-asignación de un subsector
			  // a otra área o el retiro del subsector desde el área asignada
			$t_textoConfirmacion:=""
			$t_textoConfirmacion:=__ ("\"^0\" está asignado al área \"^1\"")
			$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^0";$t_nombreAsignatura)
			$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^1";$t_nombreAreaAsignada)
			
			If ($l_asignaturas>0)
				$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("- ^0 asignaturas utilizan ^1 matrices de evaluación de aprendizajes definidas para esta área.")
				$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^0";String:C10($l_asignaturas))
				$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^1";String:C10($l_matrices))
			End if 
			
			If ($l_aprendizajesEvaluados>0)
				$t_textoConfirmacion:=$t_textoConfirmacion+"\r"+__ ("- Se han registrado ^0 evaluaciones de aprendizajes en esas asignaturas.")
				$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^0";String:C10($l_aprendizajesEvaluados))
			End if 
			
			Case of 
				: (($t_nombreAreaAsignada#"") & ($t_nombreArea#"") & ($l_aprendizajesEvaluados>0))
					  // el subsector estaba asignado a otra área, el usuario quiere reasignarlo al área actual:
					  // hay evaluaciones registradas en los enunciados definidos en las matrices configuradas
					  // construimos el texto del mensaje para solicitar confirmación al usuario
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si asigna \"^0\" al área \"^1\" se eliminarán las matrices de evaluación de aprendizajes y las evaluaciones registradas en las asignaturas.")
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea realmente asignar \"^0\" al área \"^1\" eliminando matrices de evaluación y evaluaciones registradas?")
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^0";$t_nombreAsignatura)
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^1";$t_nombreArea)
					  // construyo el texto para el registro en el registro de actividades
					$t_eventoLog:=__ ("\"^0\" fue retirado del area \"^1\" y asignado al área \"^2\". Se eliminaron las evaluaciones de aprendizajes existentes y las matrices de evaluación anteriormente configuradas, previa confirmación del usuario.")
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreAsignatura)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreAreaAsignada)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_nombreArea)
					
				: (($l_aprendizajesEvaluados>0) & ($t_nombreArea=""))
					  // el subsector está asignado al area actual, el usuario quiere retirarlo:
					  // hay evaluaciones registradas en los enunciados definidos en las matrices configuradas
					  // construimos el texto del mensaje para solicitar confirmación al usuario
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si retira \"^0\" del área \"^1\" se eliminarán las matrices de evaluación de aprendizajes y las evaluaciones registradas en las asignaturas.")
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea realmente retirar \"^0\" del área \"^1\"  eliminando matrices de evaluación y evaluaciones registradas?")
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^0";$t_nombreAsignatura)
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^1";$t_nombreAreaAsignada)
					  // construyo el texto para el registro en el registro de actividades
					$t_eventoLog:=__ ("\"^0\" fue retirado del area \"^1\". Se eliminaron las evaluaciones de aprendizajes existentes y las matrices de evaluación anteriormente configuradas, previa confirmación del usuario.")
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreAsignatura)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreAreaAsignada)
					
				: (($l_objetos>0) & ($t_nombreArea#"") & ($t_nombreAreaAsignada#""))
					  // el subsector estaba asignado a otra área, el usuario quiere reasignarlo al área actual:
					  // NO hay evaluaciones pero hay enunciados asignados a las matrices configuradas para el subsector
					  // construimos el texto del mensaje para solicitar confirmación al usuario
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si asigna \"^0\" al área \"^1\" se eliminarán las matrices de evaluación asociadas.")
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea realmente asignar \"^0\" al área \"^1\" eliminando matrices de evaluación?")
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^0";$t_nombreAsignatura)
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^1";$t_nombreArea)
					  // construyo el texto para el registro en el registro de actividades
					$t_eventoLog:=__ ("\"^0\" fue retirado del area \"^1\" y asignado al área \"^2\".Se eliminaron las matrices de evaluación anteriormente configuradas, previa confirmación del usuario.")
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreAsignatura)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreAreaAsignada)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_nombreArea)
					
				: (($l_objetos>0) & ($t_nombreArea="") & ($t_nombreAreaAsignada#""))
					  // el subsector está asignado al area actual, el usuario quiere retirarlo:
					  // NO hay evaluaciones pero hay enunciados asignados a las matrices configuradas para el subsector
					  // construimos el texto del mensaje para solicitar confirmación al usuario
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si retira \"^0\" del área \"^1\" se eliminarán las matrices de evaluación asociadas.")
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea realmente retirar \"^0\" del área \"^1\" eliminando matrices de evaluación?")
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^0";$t_nombreAsignatura)
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^1";$t_nombreAreaAsignada)
					$t_eventoLog:=__ ("\"^0\" fue retirado del area \"^1\". Se eliminaron las matrices de evaluación anteriormente configuradas, previa confirmación del usuario.")
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreAsignatura)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreAreaAsignada)
					
				: (($t_nombreArea#"") & ($t_nombreAreaAsignada#""))
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea usted asignarlo al área \"^0\"?")
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^0";$t_nombreArea)
					  // construyo el texto para el registro en el registro de actividades
					$t_eventoLog:=__ ("\"^0\" fue retirado del area \"^1\" y asignado al área \"^2\".")
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreAsignatura)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreAreaAsignada)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";$t_nombreArea)
					
				: ($t_nombreArea="")
					$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea usted retirarlo del área \"^0\"?")
					$t_textoConfirmacion:=Replace string:C233($t_textoConfirmacion;"^0";$t_nombreAreaAsignada)
					$t_eventoLog:=__ ("\"^0\" fue retirado del area \"^1\".")
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_nombreAsignatura)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreAreaAsignada)
					
				Else 
					  // solo para debugging. Este caso no está contemplado en el código
					ALERT:C41("Error. Caso no contemplado. ")
					$t_textoConfirmacion:=""
					$l_respuestaUsuario:=0
					$l_transaccionOK:=0
			End case 
			
			  // solicitamos confirmación al usuario
			If ($t_textoConfirmacion#"")
				If ($t_nombreArea#"")
					$l_respuestaUsuario:=CD_Dlog (0;$t_textoConfirmacion;__ ("");__ ("No");__ ("Asignar"))
				Else 
					$l_respuestaUsuario:=CD_Dlog (0;$t_textoConfirmacion;__ ("");__ ("No");__ ("Retirar"))
				End if 
			End if 
			
			If ($l_respuestaUsuario=2)
				  //El usuario confirma la transferencia o retiro del subsector sede el area
				  // Iniciamos la transacción
				START TRANSACTION:C239
				
				  //eliminamos los registros de evaluación de aprendizajes en las asignaturas correspondientes al subsector retirado o transferido de area
				SET_UseSet ("Aprendizajes")
				$l_transaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
				
				  // eliminamos los enunciados de aprendizaje correspondientes en las matrices configuradas para el subsector retirado o transferido de area
				If ($l_transaccionOK=1)
					SET_UseSet ("objetos")
					$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
				End if 
				
				  // eliminamos las matrices de evaluación existentes correspondientes al subsector retirado o transferido de area
				If ($l_transaccionOK=1)
					SET_UseSet ("matrices")
					$l_transaccionOK:=KRL_DeleteSelection (->[MPA_AsignaturasMatrices:189])
				End if 
				
				  // inicializamos la referencia a matrices de evaluacion en las asignaturas correspondientes al subsector retirado o transferido de area
				If ($l_transaccionOK=1)
					SET_UseSet ("Asignaturas")
					ARRAY LONGINT:C221($aLong;Records in selection:C76([Asignaturas:18]))
					$l_transaccionOK:=KRL_Array2Selection (->$aLong;->[Asignaturas:18]EVAPR_IdMatriz:91)
				End if 
				
				If ($l_transaccionOK=1)
					  //actualizamos el registro del subsector con el nombre del area al que es asignada, o lo inicializamos si se trata de un retrio del area ($t_nombreArea="")
					  //y validamos la transacción
					KRL_LoadRecord (->[xxSTR_Materias:20])
					[xxSTR_Materias:20]AreaMPA:4:=$t_nombreArea
					SAVE RECORD:C53([xxSTR_Materias:20])
					KRL_UnloadReadOnly (->[xxSTR_Materias:20])
					VALIDATE TRANSACTION:C240
					LOG_RegisterEvt ($t_eventoLog)
					$l_transaccionOK:=1
					
					  // Agrego al conjunto "$asignaturas_a_recalcular" las asignaturas cuyas matrices contemplaban la conversión
					  // de aprendizajes a notas y que fueron eliminadas durante la transferencia o retiro de área
					UNION:C120("$asignaturas_a_recalcular";"$asignaturasConMatricesEliminadas";"$asignaturas_a_recalcular")
				Else 
					$t_mensaje:=__ ("No fue posible completar asignación o remoción de la asignatura:")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("Registros asociados que debían ser modificados o eliminados se encuentran en uso en otros procesos.")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor intente nuevamente mas tarde.")
					CD_Dlog (0;$t_mensaje)
					CANCEL TRANSACTION:C241
					$l_transaccionOK:=0
				End if 
				
			Else 
				  // el usuario cancelo la asignación o remoción del subsector
				$l_transaccionOK:=0
			End if 
			
			SET_ClearSets ("objetos";"asignaturas";"matrices";"aprendizajes")
			
	End case 
Else 
	CD_Dlog (0;__ ("No fue posible acceder en escritura al subsector de aprendizaje. No puede ser reasignado ahora."))
	$l_transaccionOK:=0
End if 

$0:=$l_transaccionOK