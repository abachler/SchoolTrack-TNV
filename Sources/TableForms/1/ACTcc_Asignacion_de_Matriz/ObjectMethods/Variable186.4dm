Case of 
	: (f1=1)
		
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				If (Records in set:C195($set)>0)
					USE SET:C118($set)
					$encontrados:=BWR_SearchRecords 
					If ($encontrados#-1)
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
						ACTcc_QuitarAdmision 
						CREATE SET:C116([ACT_CuentasCorrientes:175];"¨Selection")
						viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
					End if 
				End if 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				If (Records in set:C195($set)>0)
					USE SET:C118($set)
					$encontrados:=BWR_SearchRecords 
					If ($encontrados#-1)
						KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->[ACT_Terceros:138]Id:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
						ACTcc_QuitarAdmision 
						CREATE SET:C116([ACT_CuentasCorrientes:175];"¨Selection")
						viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
					End if 
				End if 
				
			Else 
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				BWR_SearchRecords 
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
		End case 
		
	: (f2=1)
		
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				If (Records in set:C195($set)>0)
					USE SET:C118($set)
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					ACTcc_QuitarAdmision 
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
				End if 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
				
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				If (Records in set:C195($set)>0)
					USE SET:C118($set)
					KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->[ACT_Terceros:138]Id:1;"")
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					ACTcc_QuitarAdmision 
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
				End if 
				
			Else 
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
		End case 
		
	: (f3=1)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		ACTcc_QuitarAdmision 
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
		viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
End case 
QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
If (viACT_cuentas=0)
	_O_DISABLE BUTTON:C193(bNext)
Else 
	_O_ENABLE BUTTON:C192(bNext)
End if 
_O_DISABLE BUTTON:C193(bMatrizaReemplazar)
OBJECT SET COLOR:C271(*;"Reemplazo@";-61966)