//%attributes = {}
C_LONGINT:C283($l_numeroRegistros;$l_metodoExiste)
C_POINTER:C301($y_relacionDesde;$y_relacionHacia;$y_campo)
C_TEXT:C284($t_delimitador;$t_literal)
C_LONGINT:C283($userID;$1;$profID;$2)

$userID:=$1
$profID:=$2

If (atVS_QFSourceFieldAlias>0)
	$y_campo:=Field:C253(alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias};alVS_QFSourcefieldNumber{atVS_QFSourceFieldAlias})
	USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	CREATE SET:C116(yBWR_currentTable->;"Selection")
	$t_literal:=vtQRY_ValorLiteral
	$t_delimitador:=QRY_GetOperator (aDelims{aDelims})
	$t_literal:=dhQF_PreProcessValue ($y_campo;$t_literal)
	$t_literal:=QRY_PrePocesoValores ($y_campo;$t_literal;aDelims{aDelims})
	$t_literal:=dhQF_PreProcessField (->$y_campo;$t_literal)  //ASM 20130118 Para busquedas
	Case of 
		: (alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias}=Table:C252(yBWR_currentTable))
			If (o2=1)
				QUERY SELECTION:C341(yBWR_currentTable->;$y_campo->;$t_delimitador;$t_literal)
			Else 
				QUERY:C277(yBWR_currentTable->;$y_campo->;$t_delimitador;$t_literal)
			End if 
			
			
			
		: (atVS_QFSpecialRelationMethod{atVS_QFSourceFieldAlias}#"")
			$l_metodoExiste:=API Does Method Exist (atVS_QFSpecialRelationMethod{atVS_QFSourceFieldAlias})
			If ($l_metodoExiste=1)
				QUERY:C277(Table:C252(Table:C252($y_campo))->;$y_campo->;QRY_GetOperator (aDelims{aDelims});$t_literal)
				KRL_ExecuteMethod (atVS_QFSpecialRelationMethod{atVS_QFSourceFieldAlias})
			End if 
			If (Records in selection:C76(Table:C252(Table:C252($y_campo))->)>0)
				If (o2=1)
					CREATE SET:C116(yBWR_currentTable->;"temp")
					INTERSECTION:C121("Selection";"temp";"temp")
					USE SET:C118("temp")
					CLEAR SET:C117("temp")
				End if 
			End if 
			
			
			
		: (alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias}#Table:C252(yBWR_currentTable))
			$y_relacionDesde:=Field:C253(alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias};alVS_QFRelateFromField{atVS_QFSourceFieldAlias})
			$y_relacionHacia:=Field:C253(Table:C252(yBWR_currentTable);alVS_QFRelateToFieldNumber{atVS_QFSourceFieldAlias})
			If ((Not:C34(Is nil pointer:C315($y_relacionDesde))) & (Not:C34(Is nil pointer:C315($y_relacionHacia))))
				  //searchValue:=tValue
				QUERY:C277(Table:C252(Table:C252($y_campo))->;$y_campo->;QRY_GetOperator (aDelims{aDelims});$t_literal)
				If (Records in selection:C76(Table:C252(Table:C252($y_campo))->)>0)
					$l_numeroRegistros:=KRL_RelateSelection ($y_relacionHacia;$y_relacionDesde;"")
					If ((o2=1) & ($l_numeroRegistros#0))
						CREATE SET:C116(yBWR_currentTable->;"temp")
						INTERSECTION:C121("Selection";"temp";"temp")
						USE SET:C118("temp")
						CLEAR SET:C117("temp")
					End if 
				Else 
					REDUCE SELECTION:C351(yBWR_currentTable->;0)
				End if 
			Else 
				REDUCE SELECTION:C351(yBWR_currentTable->;0)
				CD_Dlog (0;__ ("Error en la definición de relaciones."))
			End if 
	End case 
	
	If (Records in selection:C76(yBWR_currentTable->)>0)
		dhQF_RefineQuery 
		CREATE SET:C116(yBWR_currentTable->;"xx")
		If (USR_LimitedSearch ($userID))
			dhSTWA2_SpecialSearch ("SchoolTrack";yBWR_currentTable;$profID)
			CREATE SET:C116(yBWR_currentTable->;"temp2")
			INTERSECTION:C121("temp2";"xx";"xx")
			USE SET:C118("xx")
			SET_ClearSets ("xx";"temp2")
		End if 
	End if 
	
	Case of 
		: (o3=1)  // agregar a la selección
			CREATE SET:C116(yBWR_currentTable->;"temp")
			UNION:C120("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable));"temp";"temp")
			USE SET:C118("temp")
			CLEAR SET:C117("temp")
		: (o4=1)  // retirar de la selección
			CREATE SET:C116(yBWR_currentTable->;"temp")
			DIFFERENCE:C122("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable));"temp";"temp")
			USE SET:C118("temp")
			CLEAR SET:C117("temp")
	End case 
Else 
	
End if 