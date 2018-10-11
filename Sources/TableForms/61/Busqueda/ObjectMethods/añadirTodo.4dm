  // [BBL_Items].Busqueda.Cerrar1()
  // Por: Alberto Bachler K.: 16-12-14, 18:15:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Records in selection:C76([BBL_Items:61])>0)
	CREATE SET:C116([BBL_Items:61];"$seleccion")
	UNION:C120("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable));"$seleccion";"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	CLEAR SET:C117("$seleccion")
	ACCEPT:C269
End if 

