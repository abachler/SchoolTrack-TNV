Case of 
	: (f1=1)
		If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
			$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
			USE SET:C118($set)
			$encontrados:=BWR_SearchRecords 
			If ($encontrados#-1)
				KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
				If (r2=1)
					If (vsACT_AsignedMatrix2#"")
						$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
						CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
						viACT_cuentas5:=Records in selection:C76([ACT_CuentasCorrientes:175])
					Else 
						viACT_cuentas5:=0
					End if 
					OBJECT SET COLOR:C271(viACT_cuentas4;-12)
					OBJECT SET COLOR:C271(viACT_cuentas5;-3)
				Else 
					viACT_cuentas4:=viACT_cuentas1
					OBJECT SET COLOR:C271(viACT_cuentas4;-3)
					OBJECT SET COLOR:C271(viACT_cuentas5;-12)
				End if 
			End if 
		Else 
			$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
			USE SET:C118($set)
			BWR_SearchRecords 
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
			viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
			If (r2=1)
				If (vsACT_AsignedMatrix2#"")
					$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas5:=Records in selection:C76([ACT_CuentasCorrientes:175])
				Else 
					viACT_cuentas5:=0
				End if 
				OBJECT SET COLOR:C271(viACT_cuentas4;-12)
				OBJECT SET COLOR:C271(viACT_cuentas5;-3)
			Else 
				viACT_cuentas4:=viACT_cuentas1
				OBJECT SET COLOR:C271(viACT_cuentas4;-3)
				OBJECT SET COLOR:C271(viACT_cuentas5;-12)
			End if 
		End if 
	: (f2=1)
		If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
			$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
			USE SET:C118($set)
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
			viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
			If (r2=1)
				If (vsACT_AsignedMatrix2#"")
					$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas5:=Records in selection:C76([ACT_CuentasCorrientes:175])
				Else 
					viACT_cuentas5:=0
				End if 
				OBJECT SET COLOR:C271(viACT_cuentas4;-12)
				OBJECT SET COLOR:C271(viACT_cuentas5;-3)
			Else 
				viACT_cuentas4:=viACT_cuentas2
				OBJECT SET COLOR:C271(viACT_cuentas4;-3)
				OBJECT SET COLOR:C271(viACT_cuentas5;-12)
			End if 
		Else 
			$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
			USE SET:C118($set)
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
			viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
			If (r2=1)
				If (vsACT_AsignedMatrix2#"")
					$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas5:=Records in selection:C76([ACT_CuentasCorrientes:175])
				Else 
					viACT_cuentas5:=0
				End if 
				OBJECT SET COLOR:C271(viACT_cuentas4;-12)
				OBJECT SET COLOR:C271(viACT_cuentas5;-3)
			Else 
				viACT_cuentas4:=viACT_cuentas2
				OBJECT SET COLOR:C271(viACT_cuentas4;-3)
				OBJECT SET COLOR:C271(viACT_cuentas5;-12)
			End if 
		End if 
	: (f3=1)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
		viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
		If (r2=1)
			If (vsACT_AsignedMatrix2#"")
				$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas5:=Records in selection:C76([ACT_CuentasCorrientes:175])
			Else 
				viACT_cuentas5:=0
			End if 
			OBJECT SET COLOR:C271(viACT_cuentas4;-12)
			OBJECT SET COLOR:C271(viACT_cuentas5;-3)
		Else 
			viACT_cuentas4:=viACT_cuentas3
			OBJECT SET COLOR:C271(viACT_cuentas4;-3)
			OBJECT SET COLOR:C271(viACT_cuentas5;-12)
		End if 
End case 
_O_ENABLE BUTTON:C192(bMatrizaReemplazar)
OBJECT SET COLOR:C271(*;"Reemplazo@";-15)
If ((viACT_cuentas5=0) & (r2=1))
	_O_DISABLE BUTTON:C193(bNext)
Else 
	_O_ENABLE BUTTON:C192(bNext)
End if 