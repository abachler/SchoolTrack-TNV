//%attributes = {}
  //ACTbol_BoletasUniverso

C_LONGINT:C283($procID)
READ WRITE:C146([Personas:7])
READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
If (Table:C252(yBWR_CurrentTable)#Table:C252(->[Personas:7]))
	If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		$procID:=IT_UThermometer (1;0;__ ("Verificando avisos a incluir en documentos tributarios...");-1)
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_CurrentTable))
		
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			$Found:=BWR_SearchRecords 
			If ($Found#-1)
				ACTbol_DeterminaSiBoleta 
				viACT_registros1:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection1")
			Else 
				viACT_registros1:=0
				_O_DISABLE BUTTON:C193(f1)
			End if 
			USE SET:C118($set)
			ACTbol_DeterminaSiBoleta 
			viACT_registros2:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection2")
		Else 
			viACT_registros1:=0
			viACT_registros2:=0
			_O_DISABLE BUTTON:C193(f1)
			_O_DISABLE BUTTON:C193(f2)
		End if 
	Else 
		If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
			$procID:=IT_UThermometer (1;0;__ ("Verificando pagos a incluir en documentos tributarios...");-1)
			$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_CurrentTable))
			If (Records in set:C195($set)>0)
				USE SET:C118($set)
				$Found:=BWR_SearchRecords 
				If ($Found#-1)
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=0)
					KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
					
					  //20150317 RCH quito personas a las que no se les emite
					ARRAY LONGINT:C221($al_idsResp;0)
					CREATE SET:C116([ACT_Pagos:172];"$pagosTodos")
					QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3#0)
					KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;"")
					QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_ReceptorDT_Tipo:112=4)
					SELECTION TO ARRAY:C260([Personas:7]No:1;$al_idsResp)
					QUERY SELECTION WITH ARRAY:C1050([ACT_Pagos:172]ID_Apoderado:3;$al_idsResp)
					CREATE SET:C116([ACT_Pagos:172];"$pagosAQuitar")
					DIFFERENCE:C122("$pagosTodos";"$pagosAQuitar";"$pagosTodos")
					USE SET:C118("$pagosTodos")
					SET_ClearSets ("$pagosTodos";"$pagosAQuitar")
					
					  //20150317 RCH quito terceros a los que no se les emite
					ARRAY LONGINT:C221($al_idsResp;0)
					CREATE SET:C116([ACT_Pagos:172];"$pagosTodos")
					QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26#0)
					KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Pagos:172]ID_Tercero:26;"")
					QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]ReceptorDT_tipo:76=4)
					SELECTION TO ARRAY:C260([ACT_Terceros:138]Id:1;$al_idsResp)
					QUERY SELECTION WITH ARRAY:C1050([ACT_Pagos:172]ID_Tercero:26;$al_idsResp)
					CREATE SET:C116([ACT_Pagos:172];"$pagosAQuitar")
					DIFFERENCE:C122("$pagosTodos";"$pagosAQuitar";"$pagosTodos")
					USE SET:C118("$pagosTodos")
					SET_ClearSets ("$pagosTodos";"$pagosAQuitar")
					
					viACT_registros1:=Records in selection:C76([ACT_Pagos:172])
					CREATE SET:C116([ACT_Pagos:172];"Selection1")
				Else 
					viACT_registros1:=0
					_O_DISABLE BUTTON:C193(f1)
				End if 
				USE SET:C118($set)
				KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=0)
				KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
				
				  //20150317 RCH quito personas a las que no se les emite
				ARRAY LONGINT:C221($al_idsResp;0)
				CREATE SET:C116([ACT_Pagos:172];"$pagosTodos")
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3#0)
				KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;"")
				QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_ReceptorDT_Tipo:112=4)
				SELECTION TO ARRAY:C260([Personas:7]No:1;$al_idsResp)
				QUERY SELECTION WITH ARRAY:C1050([ACT_Pagos:172]ID_Apoderado:3;$al_idsResp)
				CREATE SET:C116([ACT_Pagos:172];"$pagosAQuitar")
				DIFFERENCE:C122("$pagosTodos";"$pagosAQuitar";"$pagosTodos")
				USE SET:C118("$pagosTodos")
				SET_ClearSets ("$pagosTodos";"$pagosAQuitar")
				
				  //20150317 RCH quito terceros a los que no se les emite
				ARRAY LONGINT:C221($al_idsResp;0)
				CREATE SET:C116([ACT_Pagos:172];"$pagosTodos")
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26#0)
				KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Pagos:172]ID_Tercero:26;"")
				QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]ReceptorDT_tipo:76=4)
				SELECTION TO ARRAY:C260([ACT_Terceros:138]Id:1;$al_idsResp)
				QUERY SELECTION WITH ARRAY:C1050([ACT_Pagos:172]ID_Tercero:26;$al_idsResp)
				CREATE SET:C116([ACT_Pagos:172];"$pagosAQuitar")
				DIFFERENCE:C122("$pagosTodos";"$pagosAQuitar";"$pagosTodos")
				USE SET:C118("$pagosTodos")
				SET_ClearSets ("$pagosTodos";"$pagosAQuitar")
				
				viACT_registros2:=Records in selection:C76([ACT_Pagos:172])
				CREATE SET:C116([ACT_Pagos:172];"Selection2")
			Else 
				viACT_registros1:=0
				viACT_registros2:=0
				_O_DISABLE BUTTON:C193(f1)
				_O_DISABLE BUTTON:C193(f2)
			End if 
		Else 
			viACT_registros1:=0
			viACT_registros2:=0
			_O_DISABLE BUTTON:C193(f1)
			_O_DISABLE BUTTON:C193(f2)
		End if 
	End if 
Else 
	$procID:=IT_UThermometer (1;0;__ ("Verificando avisos a incluir en documentos tributarios...");-1)
	$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_CurrentTable))
	If (Records in set:C195($set)>0)
		USE SET:C118($set)
		$Found:=BWR_SearchRecords 
		If ($Found#-1)
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]No:1;"")
			ACTbol_DeterminaSiBoleta 
			viACT_registros1:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection1")
		Else 
			viACT_registros1:=0
			_O_DISABLE BUTTON:C193(f1)
		End if 
		USE SET:C118($set)
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]No:1;"")
		ACTbol_DeterminaSiBoleta 
		viACT_registros2:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection2")
	Else 
		viACT_registros1:=0
		viACT_registros2:=0
		_O_DISABLE BUTTON:C193(f1)
		_O_DISABLE BUTTON:C193(f2)
	End if 
End if 
Case of 
	: (viACT_registros1>0)
		COPY SET:C600("Selection1";"Selection")
		f1:=1
		f2:=0
		f3:=0
		vi_Selected:=viACT_registros1
	: (viACT_registros2>0)
		COPY SET:C600("Selection2";"Selection")
		f1:=0
		f2:=1
		f3:=0
		vi_Selected:=viACT_registros2
	: (viACT_registros3>0)
		COPY SET:C600("Selection3";"Selection")
		f1:=0
		f2:=0
		f3:=1
		vi_Selected:=viACT_registros3
	Else 
		vi_Selected:=0
		f1:=1
		f2:=0
		f3:=0
End case 
IT_SetButtonState ((viACT_registros1>0);->f1)
IT_SetButtonState ((viACT_registros2>0);->f2)
IT_SetButtonState ((viACT_registros3>0);->f3)
If ($procID#0)
	IT_UThermometer (-2;$procID)
End if 