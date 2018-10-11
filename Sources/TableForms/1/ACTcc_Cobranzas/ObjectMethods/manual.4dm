Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		USE SET:C118($set)
		$encontrados:=BWR_SearchRecords 
		If ($encontrados#-1)
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
			viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
		End if 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))  //20171201 ASM Ticket 188856 
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		USE SET:C118($set)
		$encontrados:=BWR_SearchRecords 
		If ($encontrados#-1)
			KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->[ACT_Terceros:138]Id:1;"")
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
			viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
		End if 
		
	Else 
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		USE SET:C118($set)
		TRACE:C157
		BWR_SearchRecords 
		QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
		viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
End case 

