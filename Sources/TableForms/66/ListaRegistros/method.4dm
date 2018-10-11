Case of 
	: (Form event:C388=On Load:K2:1)
		_O_DISABLE BUTTON:C193(bSubset)
		_O_DISABLE BUTTON:C193(bPrintSelection)
		_O_DISABLE BUTTON:C193(bRestore)
		CREATE SET:C116([BBL_Registros:66];"Original")
		
		  //agrego arreglos.
		ARRAY TEXT:C222(titulos;0)
		ARRAY TEXT:C222(titulos2;0)
		ARRAY LONGINT:C221(Color;0)
		
		
		  //vlWinRef:=WDW_GetWindowID 
	: (Form event:C388=On Header:K2:17)
		XS_SetInterface 
		
		  //SET RGB COLORS(*;"Lista";0x0000;vlBBL_LastBkgColor)
	: (Form event:C388=On Display Detail:K2:22)
		  // MOD Ticket Nª 195826 PA 20180614
		C_TEXT:C284($refValue)
		$refValue:=""
		  // Modificado por: Alexis Bustamante (01-08-2017)
		  //TICKET 186372
		If (Records in selection:C76([BBL_Registros:66])=1)
			vtBBL_Title:=[BBL_Items:61]Primer_título:4+"; por "+[BBL_Items:61]Primer_autor:6
			  // MOD Ticket Nª 195826 PA 20180614
			$refValue:=String:C10([BBL_Registros:66]Número_de_item:1)+[BBL_Items:61]Primer_título:4
		Else 
			$refValue:=String:C10([BBL_Registros:66]Número_de_item:1)+[BBL_Items:61]Primer_título:4
			If ($refValue#vtBBL_LastTitle)
				OBJECT SET COLOR:C271(*;"separaregistros1";-15)
				vtBBL_Title:=[BBL_Items:61]Primer_título:4+"; por "+[BBL_Items:61]Primer_autor:6
				vtBBL_LastTitle:=String:C10([BBL_Registros:66]Número_de_item:1)+[BBL_Items:61]Primer_título:4
				If (vlBBL_LastBkgColor=0x00FFFFFF)
					vlBBL_LastBkgColor:=0x00EDF3FE
					  //OBJECT SET RGB COLORS(*;"Lista@";0x0000;vlBBL_LastBkgColor)
				Else 
					vlBBL_LastBkgColor:=0x00FFFFFF
					  //OBJECT SET RGB COLORS(*;"Lista@";0x0000;vlBBL_LastBkgColor)
				End if 
			Else 
				  //If ([BBL_Registros]Número_de_item=0)
				  //SET RGB COLORS(*;"Lista@";0x0000;0x00FFFFFF)
				  //Else 
				  //vtBBL_Title:=""
				  //OBJECT SET RGB COLORS(*;"Lista@";0x0000;vlBBL_LastBkgColor)
			End if 
		End if 
		
		  //203787 //ABC
		$find:=Find in array:C230(Titulos;$refValue)
		If ($find=-1)
			APPEND TO ARRAY:C911(Titulos;$refValue)
			APPEND TO ARRAY:C911(Titulos2;vtBBL_Title)
			APPEND TO ARRAY:C911(Color;vlBBL_LastBkgColor)
			OBJECT SET RGB COLORS:C628(*;"Lista@";0x0000;vlBBL_LastBkgColor)
		Else 
			If ([BBL_Registros:66]Número_de_copia:2>1)
				vtBBL_Title:=""
			Else 
				If (Size of array:C274(Titulos2)>0)
					vtBBL_Title:=Titulos2{$find}
				Else 
					vtBBL_Title:=vtBBL_Title
				End if 
			End if 
			OBJECT SET RGB COLORS:C628(*;"Lista@";0x0000;Color{$find})
		End if 
		
		vtBBL_BarCode:=Replace string:C233([BBL_Registros:66]Código_de_barra:20;"*";"")
		  //20110822. se guardan los datos en variables para que se muestren correctamente.
		vl_BBl_NoCopia:=[BBL_Registros:66]Número_de_copia:2
		vd_BBL_FechaIngreso:=[BBL_Registros:66]Fecha_de_ingreso:5
		
		
		
	: (Form event:C388=On Unload:K2:2)
		vtBBL_LastTitle:=""
		CLEAR SET:C117("Original")
	: (Form event:C388=On Clicked:K2:4)
		If (Records in set:C195("Userset")>0)
			_O_ENABLE BUTTON:C192(bSubset)
			_O_ENABLE BUTTON:C192(bPrintSelection)
		Else 
			_O_DISABLE BUTTON:C193(bSubset)
			_O_DISABLE BUTTON:C193(bPrintSelection)
		End if 
		If (Records in selection:C76([BBL_Registros:66])#(Records in set:C195("Original")))
			_O_ENABLE BUTTON:C192(bRestore)
		Else 
			_O_DISABLE BUTTON:C193(bRestore)
		End if 
	: (Form event:C388=On Deactivate:K2:10)
		BRING TO FRONT:C326(Current process:C322)
		WDW_SetFrontmost (WDW_GetWindowID )
End case 
