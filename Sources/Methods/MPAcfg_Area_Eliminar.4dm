//%attributes = {}
  // // MPAcfg_Area_Eliminar
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/07/12, 16:06:56
  // ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_aprendizajes;$l_aprendizajesEvaluados;$l_asignaturas;$l_competencias;$l_dimensiones;$l_ejes;$l_enunciados;$l_IdArea;$l_matrices;$l_objetos)
C_LONGINT:C283($l_recNumArea;$l_respuestaUsuario;$l_subsectoresAsignados;$l_transaccionOK)
C_TEXT:C284($t_mensaje;$t_nombreArea;$t_textoConfirmacion;$t_textoEventoLog)

If (False:C215)
	C_LONGINT:C283(MPAcfg_Area_Eliminar ;$1)
End if 




  // CÓDIGO
$l_recNumArea:=$1
READ ONLY:C145([MPA_DefinicionAreas:186])
KRL_GotoRecord (->[MPA_DefinicionAreas:186];$l_recNumArea;True:C214)
If (OK=1)
	$t_nombreArea:=[MPA_DefinicionAreas:186]AreaAsignatura:4
	$l_IdArea:=[MPA_DefinicionAreas:186]ID:1
	
	QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4=[MPA_DefinicionAreas:186]AreaAsignatura:4)
	CREATE SET:C116([xxSTR_Materias:20];"materias")
	$l_subsectoresAsignados:=Records in set:C195("materias")
	
	QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_IdArea)
	CREATE SET:C116([MPA_DefinicionEjes:185];"Ejes")
	$l_ejes:=Records in set:C195("ejes")
	
	QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=$l_IdArea)
	CREATE SET:C116([MPA_DefinicionDimensiones:188];"Dimensiones")
	$l_dimensiones:=Records in set:C195("Dimensiones")
	
	QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea)
	CREATE SET:C116([MPA_DefinicionCompetencias:187];"Competencias")
	$l_competencias:=Records in set:C195("Competencias")
	
	QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ID_Area:22=$l_IdArea)
	CREATE SET:C116([MPA_AsignaturasMatrices:189];"matrices")
	$l_matrices:=Records in set:C195("matrices")
	
	$l_asignaturas:=KRL_RelateSelection (->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	CREATE SET:C116([Asignaturas:18];"asignaturas")
	
	$l_objetos:=KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
	CREATE SET:C116([MPA_ObjetosMatriz:204];"objetos")
	
	$l_aprendizajes:=KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
	QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
	CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"Evaluados")
	$l_aprendizajesEvaluados:=Records in set:C195("evaluados")
	
	  // busco las asignaturas que tenían matrices con opciones de cálculos activadas
	  // y obtengo la selección de asignatruras que usan esas matrices
	  // deberán ser calculados al salir de la configuración de mapas
	SET_UseSet ("matrices")
	QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9=True:C214)
	KRL_RelateSelection (->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
	CREATE SET:C116([Asignaturas:18];"$asignaturasConMatricesEliminadas")
	
	Case of 
		: ($l_aprendizajesEvaluados>0)
			  // Existen registros de evaluación de aprendizajes evaluados. Deben ser eliminados si se elimina el area.
			  // Construyo el texto del mensaje de confirmación en el evento en que existan evaluaciones registradas
			$t_textoConfirmacion:=__ ("Se han registrado ^0 evaluacion(es) en los enunciados definidos en esta área de aprendizaje y configurado ^1 matrice(s) de evaluación utilizadas en ^2 asignatura(s).";String:C10($l_aprendizajesEvaluados);String:C10($l_matrices);String:C10($l_subsectoresAsignados))
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si elimina el área se eliminarán todos sus enunciados, las matrices de evaluación asociadas a las asignaturas y todas las evaluaciones registradas.")
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea usted realmente eliminar el área ^0 y toda la información asociada?.";$t_nombreArea)
			
			  // construyo el texto de la entrada en el registro de actividades
			$t_textoEventoLog:=__ ("El área ^0 fue eliminada con toda su información asociada (enunciados, matrices y evaluaciones de aprendizajes) previa confirmación del usuario.";$t_nombreArea)
			
			
		: ($l_objetos>0)
			  // Existen matrices de evaluación configuradas para las asignaturas del área. Deben ser eliminadas si se elimina el área.
			  // Construyo el texto del mensaje de confirmación en el evento en que existan matrices configuradas para las asignaturas del área
			$t_textoConfirmacion:=__ ("Se han configurado ^0 matrice(s) de evaluación utilizadas en ^1 asignatura(s).";String:C10($l_matrices);String:C10($l_subsectoresAsignados))
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si elimina el área se eliminarán todos sus enunciados y las matrices de evaluación asociadas a las asignaturas")
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea usted realmente eliminar el área ^0 y toda la información asociada?.";$t_nombreArea)
			
			  // Construyo el texto de la entrada en el registro de actividades
			$t_textoEventoLog:=__ ("El área ^0 fue eliminada con toda su información asociada (enunciados y matrices de evaluación) previa confirmación del usuario.";$t_nombreArea)
			
			
		: (($l_ejes+$l_dimensiones+$l_competencias)>0)
			$l_enunciados:=$l_ejes+$l_dimensiones+$l_competencias
			  // Existen matrices de evaluación configuradas para las asignaturas del área. Deben ser eliminadas si se elimina el área.
			  // Construyo el texto del mensaje de confirmación en el evento en que existan matrices configuradas para las asignaturas del área
			$t_textoConfirmacion:=__ ("Se han definido ^0 enunciados en esta área.";String:C10($l_enunciados))
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si elimina el área se eliminarán todos sus enunciados y las matrices de evaluación asociadas a las asignaturas")
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea usted realmente eliminar el área ^0 y toda la información asociada?.";$t_nombreArea)
			
			  // Construyo el texto de la entrada en el registro de actividades
			$t_textoEventoLog:=__ ("El área ^0 y todos sus enunciados fueron eliminados previa confirmación del usuario.";$t_nombreArea)
			
			
		: ($l_subsectoresAsignados>0)
			  // Hay subsectores asignados al área. Si el área es eliminada los subsectores quedan no asignados a ningún área
			  // Construyo el texto del mensaje de confirmación en el evento en que existan subsectores asignados al área
			$t_textoConfirmacion:=__ ("Hay ^0 asignatura(s) asignados al área.";String:C10($l_subsectoresAsignados))
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si elimina el área las asignaturas quedarán sin asignación a ningún área")
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea usted realmente eliminar el área ^0 y dejar las asignaturas sin asignación a ningún area?.";$t_nombreArea)
			
			  // Construyo el texto de la entrada en el registro de actividades
			$t_textoEventoLog:=__ ("El área ^0 fue eliminada previa confirmación del usuario. Las asignaturas previamente asociadas a esta área quedaron sin asignación a ningún área.";$t_nombreArea)
			
		Else 
			
			$t_textoConfirmacion:=__ ("¿Desea usted realmente eliminar el área ^0 ?";$t_nombreArea)
			$t_textoEventoLog:=__ ("El área ^0 fue eliminada previa confirmación del usuario.";$t_nombreArea)
			
	End case 
	
	$l_respuestaUsuario:=CD_Dlog (0;$t_textoConfirmacion;"";__ ("Cancelar");__ ("Eliminar área"))
	
	If ($l_respuestaUsuario=2)
		START TRANSACTION:C239
		SET_UseSet ("Evaluados")
		$l_transaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203];True:C214;__ ("Eliminando evaluaciones registradas..."))
		If ($l_transaccionOK=1)
			SET_UseSet ("Evaluados")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204];True:C214;__ ("Eliminando enunciados en matrices..."))
		End if 
		If ($l_transaccionOK=1)
			SET_UseSet ("matrices")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_AsignaturasMatrices:189];True:C214;__ ("Eliminando matrices de evaluación..."))
		End if 
		If ($l_transaccionOK=1)
			SET_UseSet ("Competencias")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionCompetencias:187];True:C214;__ ("Eliminando Competencias..."))
		End if 
		If ($l_transaccionOK=1)
			SET_UseSet ("Dimensiones")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionDimensiones:188];True:C214;__ ("Eliminando Dimensiones de Aprendizaje..."))
		End if 
		If ($l_transaccionOK=1)
			SET_UseSet ("Ejes")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionEjes:185];True:C214;__ ("Eliminando Ejes de Aprendizaje..."))
		End if 
		If ($l_transaccionOK=1)
			SET_UseSet ("Asignaturas")
			ARRAY LONGINT:C221($aLong;Records in selection:C76([Asignaturas:18]))
			$l_transaccionOK:=KRL_Array2Selection (->$aLong;->[Asignaturas:18]EVAPR_IdMatriz:91)
		End if 
		
		If ($l_transaccionOK=1)
			SET_UseSet ("Materias")
			ARRAY TEXT:C222($aText;Records in selection:C76([xxSTR_Materias:20]))
			$l_transaccionOK:=KRL_Array2Selection (->$aText;->[xxSTR_Materias:20]AreaMPA:4)
		End if 
		
		If ($l_transaccionOK=1)
			KRL_GotoRecord (->[MPA_DefinicionAreas:186];$l_recNumArea;True:C214)
			DELETE RECORD:C58([MPA_DefinicionAreas:186])
			If (OK=1)
				LOG_RegisterEvt ($t_textoEventoLog)
				VALIDATE TRANSACTION:C240
				
				  // Agrego al conjunto "$asignaturas_a_recalcular" las asignaturas cuyas matrices contemplaban la conversión
				  // de aprendizajes a notas y que fueron eliminadas conjuntamente con el área de aprendizaje
				UNION:C120("$asignaturas_a_recalcular";"$asignaturasConMatricesEliminadas";"$asignaturas_a_recalcular")
				SET_ClearSets ("$asignaturasConMatricesEliminadas")
				
			Else 
				$t_mensaje:=__ ("No fue posible completar la eliminación del Área de aprendizaje:")
				$t_mensaje:=$t_mensaje+"\r\r"+__ ("No fue posible acceder en escritura al registro.")
				CD_Dlog (0;$t_mensaje)
				CANCEL TRANSACTION:C241
			End if 
		Else 
			$t_mensaje:=__ ("No fue posible completar la eliminación del Área de aprendizaje:")
			$t_mensaje:=$t_mensaje+"\r\r"+__ ("Registros asociados que debían ser modificados o eliminados se encuentran en uso en otros procesos.")
			$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor intente nuevamente mas tarde.")
			CD_Dlog (0;$t_mensaje)
		End if 
		SET_ClearSets ("evaluados";"objetos";"asignaturas";"matrices";"Competencias";"Dimensiones";"Ejes";"materias")
	End if 
	
Else 
	CD_Dlog (0;__ ("No fue posible completar la eliminación del Área de aprendizaje:\r\rNo fue posible acceder en escritura al registro del Área de aprendizaje."))
End if 

KRL_UnloadReadOnly (->[MPA_DefinicionEjes:185])
KRL_UnloadReadOnly (->[MPA_DefinicionDimensiones:188])
KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])
KRL_UnloadReadOnly (->[MPA_AsignaturasMatrices:189])
KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
KRL_UnloadReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])

$0:=$l_transaccionOK