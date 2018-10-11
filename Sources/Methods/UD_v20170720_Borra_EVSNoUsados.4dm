//%attributes = {}
  // [-- DETERMINO EL USO DEL ESTILO PARA NOTIFICAR CORRECCIONES EN EL ESTILO
  // determino el uso en niveles como estilo oficial
C_LONGINT:C283($i_registros;$l_uso;$l_uso;$l_uso;$l_uso;$l_usoEstilo;$l_uso;$l_uso)
C_POINTER:C301($y_tabla)

ARRAY LONGINT:C221($al_recNums;0)

ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
$y_tabla:=->[xxSTR_EstilosEvaluacion:44]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
READ WRITE:C146($y_tabla->)


For ($i_registros;1;Records in selection:C76($y_tabla->))
	$l_usoEstilo:=0
	
	GOTO RECORD:C242($y_tabla->;$al_recNums{$i_registros})
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_uso)
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EvStyle_oficial:23;=;[xxSTR_EstilosEvaluacion:44]ID:1)
	$l_usoEstilo:=$l_usoEstilo+$l_uso
	
	  // determino el uso en niveles como estilo interno
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_uso)
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EvStyle_interno:33;=;[xxSTR_EstilosEvaluacion:44]ID:1)
	$l_usoEstilo:=$l_usoEstilo+$l_uso
	
	  // determino el uso en asignaturas
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_uso)
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39;=;[xxSTR_EstilosEvaluacion:44]ID:1)
	$l_usoEstilo:=$l_usoEstilo+$l_uso
	
	  // determino el uso en ejes
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_uso)
	QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]EstiloEvaluación:13;=;[xxSTR_EstilosEvaluacion:44]ID:1)
	$l_usoEstilo:=$l_usoEstilo+$l_uso
	
	  // determino el uso en dimensiones
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_uso)
	QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;=;[xxSTR_EstilosEvaluacion:44]ID:1)
	$l_usoEstilo:=$l_usoEstilo+$l_uso
	
	  // determino el uso en competencias
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_uso)
	QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;=;[xxSTR_EstilosEvaluacion:44]ID:1)
	$l_usoEstilo:=$l_usoEstilo+$l_uso
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If (($l_usoEstilo=0) & ([xxSTR_EstilosEvaluacion:44]ID:1>0))
		  // si el estilo de evaluación no un estilo por defecto y no es utilizado en ninguna parte lo elimino.
		KRL_DeleteRecord (->[xxSTR_EstilosEvaluacion:44])
	End if 
End for 




