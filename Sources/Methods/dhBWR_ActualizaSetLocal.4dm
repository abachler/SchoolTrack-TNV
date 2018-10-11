//%attributes = {}
  //dhBWR_ActualizaSetLocal 
  //20170731 RCH Workaround de problema con set.
If (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))>0)  //MONO TICKET 196502
	USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	CREATE SET:C116(yBWR_currentTable->;"setEliminacion")
	USE SET:C118("setEliminacion")
	CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	CLEAR SET:C117("setEliminacion")
End if 
