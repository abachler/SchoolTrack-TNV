If (aYearsACT=1)
	Case of 
		: (alProEvt=1)
			$line:=AL_GetLine (xALP_DocsTributarios)
			IT_SetButtonState (($line#0);->bAnular)
		: (alProEvt=2)
			$line:=AL_GetLine (xALP_DocsTributarios)
			
			  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
			$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
			$yBWR_currentTable:=yBWR_currentTable
			$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
			$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
			$rnPersona:=Record number:C243([ACT_Terceros:138])
			$readState:=Read only state:C362([ACT_Terceros:138])
			AL_UpdateArrays (xALP_DocsTributarios;0)
			
			  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
			yBWR_currentTable:=->[ACT_Boletas:181]
			vyBWR_CustomArrayPointer:=->alACT_ApdosDTID
			alACT_ApdosDTID:=$line
			vyBWR_CustonFieldRefPointer:=->[ACT_Boletas:181]ID:1
			vlBWR_BrowsingMethod:=BWR Array Browsing
			
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=alACT_ApdosDTID{$line})
			
			WDW_OpenFormWindow (->[ACT_Boletas:181];"Input";0;4;__ ("Detalle del Documento Tributario"))
			DIALOG:C40([ACT_Boletas:181];"Input")
			CLOSE WINDOW:C154
			UNLOAD RECORD:C212([ACT_Boletas:181])
			
			  //reestablecemos el metodo de navegación previo
			vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
			yBWR_currentTable:=$yBWR_currentTable
			vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
			vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
			GOTO RECORD:C242([ACT_Terceros:138];$rnPersona)
			If ($readState)
				KRL_ReloadAsReadOnly (->[ACT_Terceros:138])
			Else 
				KRL_ReloadInReadWriteMode (->[ACT_Terceros:138])
			End if 
			ACTpp_FormArraysDeclarations 
			ACTter_OnRecordLoad 
			  //PP_OnRecordLoad 
			BWR_SetInputFormButtons 
	End case 
Else 
	IT_SetButtonState (False:C215;->bAnular)
End if 