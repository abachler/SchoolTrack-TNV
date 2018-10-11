
Case of 
	: ((Form event:C388=On Selection Change:K2:29))
		If (<>aNivel>0)
			$oldSelected:=[xxSTR_Niveles:6]NoNivel:5
			
			$selectedNivel:=<>aNivel
			[xxSTR_Niveles:6]NoNivel:5:=[xxSTR_Niveles:6]NoNivel:5
			CFG_STR_SaveConfiguration ("Niveles")
			$l_numeroNivel:=<>aNivNo{$selectedNivel}
			KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->$l_numeroNivel;True:C214)
			If (Not:C34(KRL_IsRecordLocked (->[xxSTR_Niveles:6])))
				If (OK=1)
					CFG_STR_LoadConfiguration ("Niveles")
					<>aNivel:=$selectedNivel
					SET WINDOW TITLE:C213(__ ("Niveles Académicos: ")+<>aNivel{<>aNivel})
				End if 
			Else 
				KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->$oldSelected;True:C214)
				LISTBOX SELECT ROW:C912(*;"lb_ListaNiveles";Find in array:C230(<>aNivNo;[xxSTR_Niveles:6]NoNivel:5))
				SET WINDOW TITLE:C213(__ ("Niveles Académicos: ")+<>aNivel{Find in array:C230(<>aNivNo;[xxSTR_Niveles:6]NoNivel:5)})
			End if 
		End if 
		
		  //157382
		ARRAY TEXT:C222(at_EvtCalTipo;0)
		ARRAY LONGINT:C221(al_EvtCalMaxDay;0)
		ARRAY LONGINT:C221(al_EvtCalMaxWeek;0)
		BLOB_Blob2Vars (->[xxSTR_Niveles:6]xEventoCalendario:53;0;->at_EvtCalTipo;->al_EvtCalMaxDay;->al_EvtCalMaxWeek)
		
		
End case 