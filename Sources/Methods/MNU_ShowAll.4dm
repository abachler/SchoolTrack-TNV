//%attributes = {}
  //MNU_ShowAll

CREATE SELECTION FROM ARRAY:C640(yBWR_currentTable->;alBWR_recordNumber)
CREATE SET:C116(yBWR_currentTable->;"losquehay")
READ ONLY:C145(yBWR_currentTable->)
ALL RECORDS:C47(yBWR_currentTable->)
dhQF_RefineQuery 
CREATE SET:C116(yBWR_currentTable->;"xx")
If (USR_LimitedSearch )
	dhBWR_SpecialSearch 
	CREATE SET:C116(yBWR_currentTable->;"temp2")
	INTERSECTION:C121("temp2";"xx";"xx")
	USE SET:C118("xx")
	SET_ClearSets ("xx";"temp2")
End if 
$rt:=Records in selection:C76(yBWR_currentTable->)
If ($rt>1000)
	$nf:=String:C10($rt)
	$r:=CD_Dlog (2;__ ("Hay ")+$nf+__ (" registros en la tabla\r¿Desea Ud. realmente cargarlos todos?");__ ("");__ ("Si");__ ("No"))
	If ($r=1)
		$found:=$rt
		CREATE SET:C116(yBWR_CurrentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
	Else 
		USE SET:C118("losquehay")
		$found:=$rt
	End if 
Else 
	CREATE SET:C116(yBWR_CurrentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	BWR_SelectTableData 
End if 
CLEAR SET:C117("losquehay")