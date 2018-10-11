//%attributes = {}
  //QF2_RunQuery


If (atVS_QFSourceFieldAlias>0)
	$fieldPointer:=Field:C253(alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias};alVS_QFSourcefieldNumber{atVS_QFSourceFieldAlias})
	USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	CREATE SET:C116(yBWR_currentTable->;"Selection")
	searchValue:=dhQF2_PreProcessValue (vtQRY_ValorLiteral)
	If (searchValue="")
		searchValue:=vtQRY_ValorLiteral
	End if 
	Case of 
		: (alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias}=Table:C252(yBWR_currentTable))
			  //searchValue:=tValue
			If (o2=1)
				QUERY SELECTION:C341(yBWR_currentTable->;$fieldPointer->;QRY_GetOperator (aDelims{aDelims};searchValue);searchValue)
			Else 
				  //If (searchValue#"")
				QUERY:C277(yBWR_currentTable->;$fieldPointer->;QRY_GetOperator (aDelims{aDelims};searchValue);searchValue)
				  //Else 
				  //ALL RECORDS(yBWR_currentTable->)
				  //End if 
			End if 
		: (atVS_QFSpecialRelationMethod{atVS_QFSourceFieldAlias}#"")
			$result:=API Does Method Exist (atVS_QFSpecialRelationMethod{atVS_QFSourceFieldAlias})
			If ($result=1)
				  //searchValue:=tValue
				QUERY:C277(Table:C252(Table:C252($fieldPointer))->;$fieldPointer->;QRY_GetOperator (aDelims{aDelims};searchValue);searchValue)
				KRL_ExecuteMethod (atVS_QFSpecialRelationMethod{atVS_QFSourceFieldAlias})
			End if 
			If (Records in selection:C76(Table:C252(Table:C252($fieldPointer))->)>0)
				  //If ((o2=1) & ($founded#0))
				If (o2=1)
					CREATE SET:C116(yBWR_currentTable->;"temp")
					INTERSECTION:C121("Selection";"temp";"temp")
					USE SET:C118("temp")
					CLEAR SET:C117("temp")
				End if 
			End if 
		: (alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias}#Table:C252(yBWR_currentTable))
			$baseKey:=Field:C253(alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias};alVS_QFRelateFromField{atVS_QFSourceFieldAlias})
			$SearchKey:=Field:C253(Table:C252(yBWR_currentTable);alVS_QFRelateToFieldNumber{atVS_QFSourceFieldAlias})
			If ((Not:C34(Is nil pointer:C315($baseKey))) & (Not:C34(Is nil pointer:C315($searchKey))))
				  //searchValue:=tValue
				QUERY:C277(Table:C252(Table:C252($fieldPointer))->;$fieldPointer->;QRY_GetOperator (aDelims{aDelims};searchValue);searchValue)
				If (Records in selection:C76(Table:C252(Table:C252($fieldPointer))->)>0)
					$founded:=KRL_RelateSelection ($searchKey;$baseKey;"")
					If ((o2=1) & ($founded#0))
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

If (Records in selection:C76(yBWR_currentTable->)>0)
	ACCEPT:C269
Else 
	BEEP:C151
End if 
