//%attributes = {}
  //ACTcc_AsignacionUniverso

Case of 
	: (Table:C252(yBWR_currentTable)#Table:C252(->[ACT_CuentasCorrientes:175]))
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
						CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
						viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
						_O_ENABLE BUTTON:C192(f1)
						f1:=1
						f2:=0
						f3:=0
					Else 
						viACT_cuentas1:=0
						_O_DISABLE BUTTON:C193(f1)
						f1:=0
						f2:=1
						f3:=0
					End if 
				Else 
					viACT_cuentas1:=0
					_O_DISABLE BUTTON:C193(f1)
					f1:=0
					f2:=1
					f3:=0
				End if 
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				If (Records in set:C195($set)>0)
					USE SET:C118($set)
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					ACTcc_QuitarAdmision 
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
				Else 
					viACT_cuentas2:=0
					_O_DISABLE BUTTON:C193(f2)
					f1:=0
					f2:=0
					f3:=1
				End if 
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
				
				
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))  //20171201 ASM Ticket 188856 
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				If (Records in set:C195($set)>0)
					USE SET:C118($set)
					$encontrados:=BWR_SearchRecords 
					If ($encontrados#-1)
						KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->[ACT_Terceros:138]Id:1;"")
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
						ACTcc_QuitarAdmision 
						CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
						viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
						_O_ENABLE BUTTON:C192(f1)
						f1:=1
						f2:=0
						f3:=0
					Else 
						viACT_cuentas1:=0
						_O_DISABLE BUTTON:C193(f1)
						f1:=0
						f2:=1
						f3:=0
					End if 
				Else 
					viACT_cuentas1:=0
					_O_DISABLE BUTTON:C193(f1)
					f1:=0
					f2:=1
					f3:=0
				End if 
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				If (Records in set:C195($set)>0)
					USE SET:C118($set)
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					ACTcc_QuitarAdmision 
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
				Else 
					viACT_cuentas2:=0
					_O_DISABLE BUTTON:C193(f2)
					f1:=0
					f2:=0
					f3:=1
				End if 
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
				
				
			Else 
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
				viACT_cuentas1:=0
				viACT_cuentas2:=0
				_O_DISABLE BUTTON:C193(f1)
				_O_DISABLE BUTTON:C193(f2)
				f1:=0
				f2:=0
				f3:=1
		End case 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			$encontrados:=BWR_SearchRecords 
			If ($encontrados#-1)
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
				_O_ENABLE BUTTON:C192(f1)
			Else 
				viACT_cuentas1:=0
				_O_DISABLE BUTTON:C193(f1)
			End if 
		Else 
			viACT_cuentas1:=0
			_O_DISABLE BUTTON:C193(f1)
		End if 
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ACTcc_QuitarAdmision 
			viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
		Else 
			viACT_cuentas2:=0
			_O_DISABLE BUTTON:C193(f2)
		End if 
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		ACTcc_QuitarAdmision 
		viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
End case 