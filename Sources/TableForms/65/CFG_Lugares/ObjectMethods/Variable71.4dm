If ((scode#"") & (sName#""))
	If (<>aPlace=0)
		If (Find in array:C230(<>aPlaceCode;scode)=-1)
			AT_Insert (1;1;-><>aPlace;-><>aPlaceCode)
			<>aPlaceCode{1}:=scode
			<>aPlace{1}:=sName
			<>aPlace:=0
			<>aPlaceCode:=0
			OBJECT SET TITLE:C194(Self:C308->;__ ("Modificar"))
		Else 
			BEEP:C151
		End if 
	Else 
		<>aPlaceCode{<>aPlace}:=scode
		<>aPlace{<>aPlace}:=sName
	End if 
End if 
