

Case of 
	: (Form event:C388=On Load:K2:1)
		sCode:=""
		sName:=""
		<>aPlaceCode:=0
		<>aPlace:=0
		OBJECT SET TITLE:C194(bAddPlace;__ ("Agregar"))
		XS_SetConfigInterface 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (<>aPlaceCode=0)
			<>aPlaceCode:=0
			<>aPlace:=0
			OBJECT SET TITLE:C194(bAddPlace;__ ("Agregar"))
			OBJECT SET ENTERABLE:C238(sCode;True:C214)
			_O_DISABLE BUTTON:C193(bDelPlace)
			_O_ENABLE BUTTON:C192(bAddPlace)
		Else 
			If (<>aPlaceCode>0)
				If (<>aPlaceCode{<>aPlaceCode}#"")
					OBJECT SET TITLE:C194(bAddPlace;__ ("Modificar"))
					QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Lugar:13=(<>aPlaceCode{<>aPLaceCode}+"@"))
					If (Records in selection:C76([BBL_Registros:66])>0)
						GOTO OBJECT:C206(sName)
						OBJECT SET ENTERABLE:C238(sCode;False:C215)
						_O_DISABLE BUTTON:C193(bDelPlace)
					Else 
						OBJECT SET ENTERABLE:C238(sCode;True:C214)
						_O_ENABLE BUTTON:C192(bDelPlace)
					End if 
				Else 
					OBJECT SET TITLE:C194(bAddPlace;__ ("Modificar"))
					OBJECT SET ENTERABLE:C238(sCode;True:C214)
					_O_ENABLE BUTTON:C192(bDelPlace)
				End if 
			End if 
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 