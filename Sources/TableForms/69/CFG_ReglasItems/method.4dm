  // [xxBBL_ReglasParaItems].CFG_ReglasItems()
  // Por: Alberto Bachler K.: 12-05-15, 13:05:41
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		If (Size of array:C274(<>aPrefDoc)=0)
			CREATE RECORD:C68([xxBBL_ReglasParaItems:69])
			[xxBBL_ReglasParaItems:69]Codigo_regla:1:=__ ("GEN")
			[xxBBL_ReglasParaItems:69]Nombre Regla:2:=__ ("Genérica")
			[xxBBL_ReglasParaItems:69]Default:10:=True:C214
			SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
			APPEND TO ARRAY:C911(<>aPrefDoc;[xxBBL_ReglasParaItems:69]Codigo_regla:1)
			APPEND TO ARRAY:C911(<>aPrefDocName;[xxBBL_ReglasParaItems:69]Nombre Regla:2)
		End if 
		
		
		QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Default:10=True:C214)
		If (Records in selection:C76([xxBBL_ReglasParaItems:69])>0)
			$l_posicion:=Find in array:C230(<>aPrefDoc;[xxBBL_ReglasParaItems:69]Codigo_regla:1)
		Else 
			$l_posicion:=1
		End if 
		<>aPrefDoc:=$l_posicion
		<>aPrefDocName:=$l_posicion
		lb_reglas{$l_posicion}:=True:C214
		
		If (Record number:C243([xxBBL_ReglasParaItems:69])=-3)
			[xxBBL_ReglasParaItems:69]DiasPrestamo:3:=<>MTi_LnDay
			[xxBBL_ReglasParaItems:69]Dias_gracia:4:=<>MTi_GrDay
			[xxBBL_ReglasParaItems:69]Multa_diaria:5:=<>MTr_Fine
			[xxBBL_ReglasParaItems:69]Max_renovacione:6:=<>MTi_Renov
			[xxBBL_ReglasParaItems:69]Reserva_anticipación:7:=<>MTi_RsDays
		End if 
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([BBL_Items:61];[BBL_Items:61]Regla:20=[xxBBL_ReglasParaItems:69]Codigo_regla:1)
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		OBJECT SET ENABLED:C1123(*;"eliminaRegla";($l_registros=0) & Not:C34([xxBBL_ReglasParaItems:69]Default:10))
		
		QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1=<>aPrefDoc{$l_posicion})
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([BBL_Items:61];[BBL_Items:61]Regla:20=[xxBBL_ReglasParaItems:69]Codigo_regla:1)
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		OBJECT SET ENABLED:C1123(*;"eliminaRegla";($l_registros=0) & Not:C34([xxBBL_ReglasParaItems:69]Default:10))
		
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		  //SAVE RECORD([xxBBL_ReglasParaItems])
		  //UNLOAD RECORD([xxBBL_ReglasParaItems])
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
		
		
	: (Form event:C388=On Unload:K2:2)
		SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
		UNLOAD RECORD:C212([xxBBL_ReglasParaItems:69])
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
