//%attributes = {}
  //MNU_ReduceSel

C_LONGINT:C283($err)
READ ONLY:C145(yBWR_currentTable->)

If (Size of array:C274(abrSelect)>0)
	
	BWR_ReduceSelection 
	CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	BWR_SelectTableData 
End if 
