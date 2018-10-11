//%attributes = {}
  //BWR_OnDeleteSelection

If (False:C215)
	  // Project method: BWR_OnDeleteSelection
	  // Module: 
	  // Purpose:
	  // Syntax: BWR_OnDeleteSelection()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 7/1/02  10:24, by Alberto Bachler
	  // 
	  // 
End if 

BWR_ReduceSelection 
$trapped:=dhBWR_OnDeleteSelection (yBWR_currentTable)

If (Not:C34($trapped))
	CREATE SET:C116(yBWR_currentTable->;"2Delete")
	KRL_DeleteSelection (yBWR_currentTable)
End if 
CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
BWR_LoadData 
BWR_SetSort 


