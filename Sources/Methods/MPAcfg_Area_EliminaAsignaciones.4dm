//%attributes = {}
  // // MPAcfg_Area_EliminaAsignaciones()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 16/07/12, 09:53:38
  // ---------------------------------------------





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
			  // Existen registros de evaluación de aprendizajes evaluados. Deben ser eliminados si se eliminan las asignaciones.
			  // Construyo el texto del mensaje de confirmación en el evento en que existan evaluaciones registradas
			$t_textoConfirmacion:=__ ("Se han registrado ^0 evaluacion(es) en los enunciados actualmente asignados a ^1 matrice(s) de evaluación utilizadas en ^2 asignatura(s).";String:C10($l_aprendizajesEvaluados);String:C10($l_matrices);String:C10($l_subsectoresAsignados))
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si elimina las asignaciones se eliminarán las matrices de evaluación asociadas a las asignaturas, los enunciados asignados y las evaluaciones registradas.")
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea usted realmente las matrices, sus enunciados y las evaluaciones de aprendizaje registradas en las asignaturas del área ^0 ?";$t_nombreArea)
			  // construyo el texto de la entrada en el registro de actividades
			$t_textoEventoLog:=__ ("La matrices definidas para el área ^0 fueron eliminadas con toda su información asociada (enunciados y evaluaciones de aprendizajes) previa confirmación del usuario.";$t_nombreArea)
			
		: ($l_objetos>0)
			  // Existen matrices de evaluación configuradas para las asignaturas del área. Deben ser eliminadas si se eliminan  las asignaciones.
			  // Construyo el texto del mensaje de confirmación en el evento en que existan matrices configuradas para las asignaturas del área
			$t_textoConfirmacion:=__ ("Existen ^0 matrice(s) de evaluación utilizadas en ^1 asignatura(s).";String:C10($l_matrices);String:C10($l_subsectoresAsignados))
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("Si elimina las asignaciones se eliminarán las matrices definidas para el área ^0 y todos sus enunciados asociados a ellas.";$t_nombreArea)
			$t_textoConfirmacion:=$t_textoConfirmacion+"\r\r"+__ ("¿Desea usted realmente eliminar las matrices y sus enunciados en las asignaturas del área ^0 ?";$t_nombreArea)
			  // Construyo el texto de la entrada en el registro de actividades
			$t_textoEventoLog:=__ ("La matrices definidas para el área ^0 fueron eliminadas previa confirmación del usuario.";$t_nombreArea)
			
		Else 
			
			$t_textoConfirmacion:=__ ("¿Desea usted realmente eliminar las matrices existente para las asignaturas del área ^0 ?";$t_nombreArea)
			$t_textoEventoLog:=__ ("El área ^0 fue eliminada previa confirmación del usuario.";$t_nombreArea)
			
	End case 
	
	
	$l_respuestaUsuario:=CD_Dlog (0;$t_textoConfirmacion;"";__ ("Cancelar");__ ("Eliminar asignaciones"))
	
	If ($l_respuestaUsuario=2)
		START TRANSACTION:C239
		SET_UseSet ("Evaluados")
		$l_transaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
		If ($l_transaccionOK=1)
			SET_UseSet ("Evaluados")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
		End if 
		If ($l_transaccionOK=1)
			SET_UseSet ("matrices")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_AsignaturasMatrices:189])
		End if 
		If ($l_transaccionOK=1)
			SET_UseSet ("Asignaturas")
			ARRAY LONGINT:C221($aLong;Records in selection:C76([Asignaturas:18]))
			$l_transaccionOK:=KRL_Array2Selection (->$aLong;->[Asignaturas:18]EVAPR_IdMatriz:91)
		End if 
		VALIDATE TRANSACTION:C240
		
		
		  // si hay registros con evaluaciones de aprendizajes...
		If (Records in set:C195("$asignaturasConEvaluaciones")>0)
			  // los pongo en el conjunto de asignaturas a recalcular ("$asignaturas_a_recalcular", creado en EVLG_Configuracion)
			UNION:C120("$asignaturas_a_recalcular";"$asignaturasConMatricesEliminadas";"$asignaturas_a_recalcular")
			SET_ClearSets ("$asignaturasConMatricesEliminadas")
		End if 
		
		
	Else 
		CANCEL TRANSACTION:C241
	End if 
	
End if 

SET_ClearSets ("evaluados";"aprendizajes";"objetos";"asignaturas";"matrices";"Competencias";"Dimensiones";"Ejes";"materias")
