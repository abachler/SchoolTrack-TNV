//%attributes = {}
  // MPAcfg_Comp_Eliminar(recordNumber{;verificacionPrevia{;mostrarAvance}})
  // - recordNumber: Longint
  // - verificaciónPrevia: Boolean (opcional, defecto TRUE)
  // - mostrarAvance: Boolean (opcional, defecto TRUE)
  // Elimina la competencia cuyo record number se recibió en $1
  //
  // Se solicita confirmación al usuario si el parametro verificacionPrevia está en TRUE
  // y la competencia es utilizada en matrices o tiene evaluaciones registradas
  // Las competencias en matrices y las evaluaciones registradas son eliminadas si el usuario confirma
  // Se crea un registro en el log de actividades si la eliminación se concreta
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 28/06/12, 11:35:13
  // ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_mostrarAvance;$b_verificacionPrevia)
C_LONGINT:C283($l_competenciasEvaluadas;$l_competenciasEvaluadas;$l_asignaturas;$l_competenciasEnAprendizajes;$l_competenciasEnMatrices;$l_IdCompetencia;$l_IdProcesoAvance;$l_matrices;$l_recNumCompetencia;$l_respuestaConfirmacion;$l_TransaccionOK)
C_TEXT:C284($t_enunciadoCompetencia;$t_enunciadoDimension;$t_eventoLog;$t_nombreArea;$t_textoConfirmacion2;$t_textoConfirmacion4;$t_textoConfirmacion5;$t_textoConfirmacion6)

If (False:C215)
	C_LONGINT:C283(MPAcfg_Comp_Eliminar ;$0)
	C_LONGINT:C283(MPAcfg_Comp_Eliminar ;$1)
	C_BOOLEAN:C305(MPAcfg_Comp_Eliminar ;$2)
	C_BOOLEAN:C305(MPAcfg_Comp_Eliminar ;$3)
End if 




  // CÓDIGO
$l_recNumCompetencia:=$1
$b_verificacionPrevia:=True:C214
$b_mostrarAvance:=True:C214
Case of 
	: (Count parameters:C259=2)
		$b_verificacionPrevia:=$2
	: (Count parameters:C259=3)
		$b_verificacionPrevia:=$2
		$b_mostrarAvance:=$3
End case 

KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia;True:C214)
  // creo un conjunto con las matrices que serán afectadas por la eliminación de la dimensión y eventualmente de
  // las competencias asociadas,
  // las asignaturas que utilizan estas matrices deberán ser objeto de recalculos de promedios
  // si tienen opciones de calculos activas y aprendizajes evaluados
  // este conjunto alimentará con el conjunto "$matrices_a_recalcular" declarado en EVLG_Configuracion
QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=[MPA_DefinicionCompetencias:187]ID:1)
KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")

  // reestablezco el registro a eliminar
KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia;True:C214)
If (OK=1)
	$l_IdCompetencia:=[MPA_DefinicionCompetencias:187]ID:1
	If ($l_IdCompetencia#0)
		$t_enunciadoCompetencia:=[MPA_DefinicionCompetencias:187]Competencia:6
		$t_nombreArea:=KRL_GetTextFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		
		If ($b_verificacionPrevia)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=$l_IdCompetencia)
			$l_competenciasEnMatrices:=Records in selection:C76([MPA_ObjetosMatriz:204])
			CREATE SET:C116([MPA_ObjetosMatriz:204];"objetos")
			
			$l_matrices:=KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
			$l_asignaturas:=KRL_RelateSelection (->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
			
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$l_IdCompetencia)
			$l_competenciasEnAprendizajes:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
			CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"CompetenciasEvaluación")
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			$l_competenciasEvaluadas:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
			
			Case of 
				: ($l_competenciasEvaluadas>0)
					  //la competencia está asignada a matrices y hay evaluaciones registradas para ella
					
					  // solicito confirmación al usuario
					$t_textoConfirmacion2:=__ ("- Esta Competencia es utilizada en ^0 matrices de evaluación asignadas a ^1 asignaturas.")
					$t_textoConfirmacion2:=Replace string:C233($t_textoConfirmacion2;"^0";String:C10($l_matrices))
					$t_textoConfirmacion2:=Replace string:C233($t_textoConfirmacion2;"^1";String:C10($l_asignaturas))
					$t_textoConfirmacion4:=__ ("- Se han registrado ^0 evaluaciones para esta Competencia en las asignaturas que la utilizan.")
					$t_textoConfirmacion4:=Replace string:C233($t_textoConfirmacion4;"^0";String:C10($l_competenciasEvaluadas))
					$t_textoConfirmacion5:=__ ("Si elimina Competencia que se eliminarán las evaluaciones y se eliminará en las matrices de evaluación que la utilizan.")
					$t_textoConfirmacion6:=__ ("¿Desea realmente eliminar esta Competencia? ")
					$l_respuestaConfirmacion:=CD_Dlog (0;$t_textoConfirmacion2+__ ("\r")+$t_textoConfirmacion4+__ ("\r\r")+$t_textoConfirmacion5+__ ("\r\r")+$t_textoConfirmacion6;__ ("");__ ("No");__ ("Si. Eliminar todo"))
					
					  // creo el texto para el registro en el log
					$t_eventoLog:=__ ("La Competencia ^0 fue eliminada del mapa de aprendizaje del área ^1 y de las ^2 matrices de evaluación que la utilizaban. Se eliminaron también todas las evaluaciones para esta competencia previa confirmación del usuario.")
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoCompetencia)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";String:C10($l_matrices))
					
				: ($l_CompetenciasEnMatrices>0)
					  // la competencia está asignada a matrices pero no hay evaluaciones registradas
					
					  // solicito confirmación al usuario
					$t_textoConfirmacion2:=__ ("- Esta Competencia es utilizada en ^0 matrices de evaluación asignadas a ^1 asignaturas.")
					$t_textoConfirmacion2:=Replace string:C233($t_textoConfirmacion2;"^0";String:C10($l_matrices))
					$t_textoConfirmacion2:=Replace string:C233($t_textoConfirmacion2;"^1";String:C10($l_asignaturas))
					$t_textoConfirmacion6:=__ ("¿Desea realmente eliminar esta Competencia?")
					$l_respuestaConfirmacion:=CD_Dlog (0;$t_textoConfirmacion2+__ ("\r\r")+$t_textoConfirmacion6;__ ("");__ ("No");__ ("Si. Eliminar todo"))
					
					  // creo el texto para el registro en el log
					$t_eventoLog:=__ ("La Competencia ^0 fue eliminada del mapa de aprendizaje del área ^1 y de las ^2 matrices de evaluación que la utilizaban previa confirmación del usuario.")
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoDimension)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^2";String:C10($l_matrices))
					
				Else 
					  // la competencia no tiene evaluaciones ni hace parte de ninguna matriz
					  // puede ser eliminada
					$t_eventoLog:=__ ("La Competencia ^0 fue eliminada del mapa de aprendizaje del área ^1 a solicitud del usuario.")
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoCompetencia)
					$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
					$l_respuestaConfirmacion:=2
			End case 
			
		Else 
			$t_eventoLog:=__ ("La Competencia ^0 fue eliminada del mapa de aprendizaje del área ^1 a solicitud del usuario.")
			$t_eventoLog:=Replace string:C233($t_eventoLog;"^0";$t_enunciadoCompetencia)
			$t_eventoLog:=Replace string:C233($t_eventoLog;"^1";$t_nombreArea)
			$l_respuestaConfirmacion:=2
		End if 
		
		$l_TransaccionOK:=0
		If ($l_respuestaConfirmacion=2)
			If ($b_mostrarAvance)
				$l_IdProcesoAvance:=IT_UThermometer (1;0;__ ("Eliminando Competencias. Un momento por favor..."))
			End if 
			
			  // creo un conjunto con las matrices que serán afectadas por la eliminación de la competencia
			  // las asignaturas que utilizan estas matrices deberan ser objeto de recalculos de promedios
			  // si tienen opciones de calculos activas y aprendizajes evaluados
			  // este conjunto alimentará con el conjunto "$matrices_a_recalcular" declarado en EVLG_Configuracion
			SET_UseSet ("Objetos")
			KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
			CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")
			
			START TRANSACTION:C239
			SET_UseSet ("CompetenciasEvaluación")
			$l_TransaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
			
			If ($l_TransaccionOK=1)
				SET_UseSet ("Objetos")
				$l_TransaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
			End if 
			
			If ($l_TransaccionOK=1)
				  // elimino la competencia y valido la transacción
				KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia;True:C214)
				DELETE RECORD:C58([MPA_DefinicionCompetencias:187])
				If (OK=1)
					LOG_RegisterEvt ($t_eventoLog)
					VALIDATE TRANSACTION:C240
					
					  // combino el conjunto de matrices modificadas por la eliminación del objeto
					  // con el conjunto "$matrices_a_recalcular" declarado en EVLG_Configuracion
					UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
					
				Else 
					$t_mensaje:=__ ("No fue posible completar la eliminación de la Competencia:")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("Registros asociados que debían ser modificados o eliminados se encuentran en uso en otros procesos.")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor intente nuevamente mas tarde.")
					CANCEL TRANSACTION:C241
				End if 
			End if 
			
			If ($b_mostrarAvance)
				$l_IdProcesoAvance:=IT_UThermometer (-2;$l_IdProcesoAvance)
			End if 
		End if 
		
	Else 
		  //solo para depuración. No debiera existir una comptencia si ID
		ALERT:C41("ERROR. La competencia no tiene ID")
		$l_TransaccionOK:=0
		
	End if 
	
Else 
	$t_mensaje:=__ ("No fue posible completar la eliminación de la Competencia:")
	$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
	CD_Dlog (0;$t_mensaje)
	$l_TransaccionOK:=0
End if 

SET_ClearSets ("Objetos";"CompetenciasEvaluación";"$matricesModificadas")
KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])
KRL_UnloadReadOnly (->[MPA_AsignaturasMatrices:189])
KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
KRL_UnloadReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])

$0:=$l_TransaccionOK

