Case of 
	: (Form event:C388=On Load:K2:1)
		Self:C308->:=Num:C11(PREF_fGet (0;"XS_FormatNames";"1"))
		<>gAutoFormat:=(Self:C308->=1)
	: (Form event:C388=On Clicked:K2:4)
		PREF_Set (0;"XS_FormatNames";String:C10(Self:C308->))
		<>gAutoFormat:=(Self:C308->=1)
End case 