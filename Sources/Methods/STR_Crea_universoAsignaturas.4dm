//%attributes = {}
  //STR_Crea_universoAsignaturas

READ ONLY:C145([Asignaturas:18])
Case of 
	: (Table:C252(yBWR_currentTable)#Table:C252(->[Asignaturas:18]))
		ALL RECORDS:C47([Asignaturas:18])
		viACT_avisos3:=Records in table:C83([Asignaturas:18])
		viACT_avisos1:=0
		viACT_avisos2:=0
		_O_DISABLE BUTTON:C193(f1)
		_O_DISABLE BUTTON:C193(f2)
		f1:=0
		f2:=0
		f3:=1
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			$encontrados:=BWR_SearchRecords 
			If ($encontrados#-1)
				viACT_avisos1:=Records in selection:C76([Asignaturas:18])
				_O_ENABLE BUTTON:C192(f1)
			Else 
				viACT_avisos1:=0
				_O_DISABLE BUTTON:C193(f1)
				
			End if 
		Else 
			viACT_avisos1:=0
			_O_DISABLE BUTTON:C193(f1)
		End if 
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			viACT_avisos2:=Records in selection:C76([Asignaturas:18])
		Else 
			viACT_avisos2:=0
			_O_DISABLE BUTTON:C193(f2)
		End if 
		viACT_avisos3:=Records in table:C83([Asignaturas:18])
End case 