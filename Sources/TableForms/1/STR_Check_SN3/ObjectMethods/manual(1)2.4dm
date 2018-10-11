If (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
	$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
	If (Records in set:C195($set)>0)
		USE SET:C118($set)
		viACT_avisos2:=Records in selection:C76([Asignaturas:18])
		CREATE SET:C116([Asignaturas:18];"Selection")
	Else 
		viACT_avisos2:=0
	End if 
Else 
	viACT_avisos2:=0
End if 
viACT_avisos:=viACT_avisos2