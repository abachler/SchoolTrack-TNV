//%attributes = {}
  // MPAcfg_Area_EliminaEtapa()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 22/07/12, 11:44:29
  // ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_aprendizajesEvaluados;$l_columna;$l_competencias;$l_dimensiones;$l_ejes;$l_fila;$l_IdArea;$l_limiteInferiorEtapa;$l_limiteSuperiorEtapa;$l_objetos)
C_LONGINT:C283($l_respuestaUsuario;$l_transaccionOK)
C_POINTER:C301($y_variableColumna)
C_TEXT:C284($t_textoEventoLog)
If (False:C215)
	C_LONGINT:C283(MPAcfg_Area_EliminaEtapa ;$1)
End if 

  // CÓDIGO
$l_IdArea:=[MPA_DefinicionAreas:186]ID:1

LISTBOX GET CELL POSITION:C971(*;"lb_etapas";$l_columna;$l_fila;$y_variableColumna)
$l_limiteInferiorEtapa:=alMPA_NivelDesde{$l_fila}
$l_limiteSuperiorEtapa:=alMPA_NivelHasta{$l_fila}

If ($l_IdArea#0)
	
	QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_IdArea;*)
	QUERY:C277([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]DesdeGrado:4>=$l_limiteInferiorEtapa;*)
	QUERY:C277([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]HastaGrado:5<=$l_limiteSuperiorEtapa)
	KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Eje:3;->[MPA_DefinicionEjes:185]ID:1;"")
	KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[MPA_DefinicionEjes:185]ID:1;"")
	CREATE SET:C116([MPA_DefinicionEjes:185];"$Ejes")
	CREATE SET:C116([MPA_ObjetosMatriz:204];"$Objetos_Ejes")
	
	QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=$l_IdArea;*)
	QUERY:C277([MPA_DefinicionDimensiones:188]; & [MPA_DefinicionDimensiones:188]DesdeGrado:6>=$l_limiteInferiorEtapa;*)
	QUERY:C277([MPA_DefinicionDimensiones:188]; & [MPA_DefinicionDimensiones:188]HastaGrado:7<=$l_limiteSuperiorEtapa)
	KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[MPA_DefinicionDimensiones:188]ID:1;"")
	KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[MPA_DefinicionDimensiones:188]ID:1;"")
	CREATE SET:C116([MPA_DefinicionDimensiones:188];"$Dimensiones")
	CREATE SET:C116([MPA_ObjetosMatriz:204];"$Objetos_Dimensiones")
	
	QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea;*)
	QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]DesdeGrado:5>=$l_limiteInferiorEtapa;*)
	QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]HastaGrado:13<=$l_limiteSuperiorEtapa)
	CREATE SET:C116([MPA_DefinicionCompetencias:187];"$Competencias")
	KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Competencia:5;->[MPA_DefinicionCompetencias:187]ID:1;"")
	KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;->[MPA_DefinicionCompetencias:187]ID:1;"")
	CREATE SET:C116([MPA_ObjetosMatriz:204];"$Objetos_Competencias")
	
	UNION:C120("$Objetos_Ejes";"$Objetos_Dimensiones";"$Objetos")
	UNION:C120("$Objetos";"$Objetos_Competencias";"$Objetos")
	
	$l_ejes:=Records in set:C195("$Ejes")
	$l_dimensiones:=Records in set:C195("$Dimensiones")
	$l_competencias:=Records in set:C195("$Competencias")
	$l_objetos:=Records in set:C195("$Objetos")
	
	USE SET:C118("$Objetos")
	KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
	CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matrices")
	
	KRL_RelateSelection (->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	CREATE SET:C116([Asignaturas:18];"$asignaturasConMatricesEliminadas")
	
	USE SET:C118("$matrices")
	KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
	CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$evaluaciones")
	
	
	
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_aprendizajesEvaluados)
	QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	Case of 
		: ($l_aprendizajesEvaluados>0)
			$l_respuestaUsuario:=CD_Dlog (0;Replace string:C233(__ ("^0 Ejes, Dimensiones y/o competencias definidas en esta etapa han sido evaluadas. Si usted elimina esta etapa se eliminarán también las evaluaciones registradas.\r\r");__ ("^0");String:C10($l_aprendizajesEvaluados))+__ ("¿Que desea hacer?");__ ("");__ ("Cancelar");__ ("Eliminar Etapa"))
			
		: ($l_objetos>0)
			$l_respuestaUsuario:=CD_Dlog (0;Replace string:C233(__ ("^0 Ejes, Dimensiones y/o competencias definidas en esta etapa son utilizados en matrices de evaluación.\rSi elimina la etapa serán retirados de las matrices.\r\r");__ ("^0");String:C10($l_objetos))+__ ("¿Que desea hacer?");__ ("");__ ("Cancelar");__ ("Eliminar Etapa"))
			
		Else 
			$l_respuestaUsuario:=2
	End case 
	
	If ($l_respuestaUsuario=2)
		START TRANSACTION:C239
		USE SET:C118("$Evaluaciones")
		$l_transaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
		
		If ($l_transaccionOK=1)
			USE SET:C118("$Objetos")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
		End if 
		
		If ($l_transaccionOK=1)
			USE SET:C118("$matrices")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_AsignaturasMatrices:189])
		End if 
		
		If ($l_transaccionOK=1)
			USE SET:C118("$Ejes")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionEjes:185])
		End if 
		
		If ($l_transaccionOK=1)
			USE SET:C118("$Dimensiones")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionDimensiones:188])
		End if 
		
		If ($l_transaccionOK=1)
			USE SET:C118("$Competencias")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_DefinicionCompetencias:187])
		End if 
		
		If ($l_transaccionOK=1)
			$t_textoEventoLog:=__ ("Se eliminó la etapa comprendida entre los niveles o grados académicos ^0 y ^1 en el área ^2 previa confirmación del usuario")
			$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^2";[MPA_DefinicionAreas:186]AreaAsignatura:4)
			$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^1";String:C10($l_limiteSuperiorEtapa))
			$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^0";String:C10($l_limiteInferiorEtapa))
			AT_Delete ($l_fila;1;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta;->atMPA_NivelDesde;->atMPA_NivelHasta)
			LOG_RegisterEvt ($t_textoEventoLog)
			MPAcfg_Area_AlGuardar 
			SAVE RECORD:C53([MPA_DefinicionAreas:186])
			VALIDATE TRANSACTION:C240
			
			  // combino el conjunto de matrices modificadas por la eliminación del objeto
			  // con el conjunto "$matrices_a_recalcular" declarado en MPAcfg_Configuracion
			UNION:C120("$asignaturas_a_recalcular";"$asignaturasConMatricesEliminadas";"$asignaturas_a_recalcular")
			
		Else 
			CANCEL TRANSACTION:C241
		End if 
		
	End if 
End if 

$0:=$l_transaccionOK

SET_ClearSets ("$Ejes";"$Objetos_Ejes";"$Dimensiones";"$Objetos_Dimensiones";"$Competencias";"$Objetos_Competencias";"$objetos";"$evaluaciones")

