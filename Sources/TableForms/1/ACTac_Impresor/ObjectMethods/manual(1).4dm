If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
	$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
	If (Records in set:C195($set)>0)
		USE SET:C118($set)
		viACT_avisoss2:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection")
	Else 
		viACT_avisos2:=0
	End if 
Else 
	viACT_avisos2:=0
End if 
viACT_avisos:=viACT_avisos2