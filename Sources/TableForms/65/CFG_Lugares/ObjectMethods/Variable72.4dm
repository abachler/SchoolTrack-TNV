If (<>aPlace>0)
	If (<>aPlaceCode{<>aPlaceCode}#"")
		OBJECT SET TITLE:C194(bAddPlace;__ ("Modificar"))
		QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Lugar:13=(<>aPlaceCode{<>aPLaceCode}+"@"))
		If (Records in selection:C76([BBL_Registros:66])>0)
			CD_Dlog (0;__ ("Hay items registrados en este lugar. No es posible eliminarlo"))
		Else 
			AT_Delete (<>aPLace;1;-><>aPlace;-><>aPlaceCode)
			<>aPlace:=0
			<>aPlaceCode:=0
			sCode:=""
			sName:=""
			_O_DISABLE BUTTON:C193(bDelPlace)
		End if 
	Else 
		AT_Delete (<>aPLace;1;-><>aPlace;-><>aPlaceCode)
		<>aPlace:=0
		<>aPlaceCode:=0
		sCode:=""
		sName:=""
		_O_DISABLE BUTTON:C193(bDelPlace)
	End if 
End if 