


Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		USE SET:C118($set)
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
		QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		ACTcc_QuitarAdmision 
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
		viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
		Case of 
			: (r1=1)
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7#0)
				viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
			: (r2=1)
				If ((vsACT_AsignedMatrix2#"") & (vsACT_AsignedMatrix2#"Ninguna"))
					$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
					viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
				Else 
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
					viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
				End if 
			: (r3=1)
				viACT_cuentas:=viACT_cuentas2
		End case 
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		USE SET:C118($set)
		KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->[ACT_Terceros:138]Id:1;"")
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
		QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		ACTcc_QuitarAdmision 
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
		viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
		Case of 
			: (r1=1)
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7#0)
				viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
			: (r2=1)
				If ((vsACT_AsignedMatrix2#"") & (vsACT_AsignedMatrix2#"Ninguna"))
					$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
					viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
				Else 
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
					viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
				End if 
			: (r3=1)
				viACT_cuentas:=viACT_cuentas2
		End case 
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
		
	Else 
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		USE SET:C118($set)
		QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		ACTcc_QuitarAdmision 
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
		viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
		Case of 
			: (r1=1)
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7#0)
				viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
			: (r2=1)
				If ((vsACT_AsignedMatrix2#"") & (vsACT_AsignedMatrix2#"Ninguna"))
					$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
					viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
				Else 
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
					viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
				End if 
			: (r3=1)
				viACT_cuentas:=viACT_cuentas2
		End case 
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
End case 