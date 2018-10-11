
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vi_PageNumber:=1
		Chk_cal:=0
		Chk_pla:=0
		Chk_obs:=0
		Chk_apren:=0
		vt_publicacion:=""
		  // /VALIDACION DE BIT
		vl_publicacion:=0
		STR_Crea_universoAsignaturas 
		
		Case of 
			: (Table:C252(yBWR_currentTable)#Table:C252(->[Asignaturas:18]))
				f1:=0
				f2:=0
				f3:=1
				_O_DISABLE BUTTON:C193(f1)
				_O_DISABLE BUTTON:C193(f2)
				CREATE SET:C116([Asignaturas:18];"Selection")
				viACT_avisos3:=Records in selection:C76([Asignaturas:18])
			: (Size of array:C274(aBrSelect)>0)
				f1:=1
				f2:=0
				f3:=0
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				
				BWR_SearchRecords 
				CREATE SET:C116([Asignaturas:18];"Selection")
				viACT_avisos1:=Records in selection:C76([Asignaturas:18])
			: (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))>0)
				f1:=0
				f2:=1
				f3:=0
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				CREATE SET:C116([Asignaturas:18];"Selection")
				viACT_avisos2:=Records in selection:C76([Asignaturas:18])
			Else 
				f1:=0
				f2:=0
				f3:=1
				_O_DISABLE BUTTON:C193(f1)
				_O_DISABLE BUTTON:C193(f2)
				CREATE SET:C116([Asignaturas:18];"Selection")
				viACT_avisos3:=Records in table:C83([Asignaturas:18])
		End case 
		
		
End case 
