GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
If (vlSN3_CurrentTab#$ref)
	Case of 
		: (vlSN3_CurrentTab=1)
			SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
		: (vlSN3_CurrentTab=2)
			SN3_SaveDataReceptionSettings 
		: (vlSN3_CurrentTab=3)
			
	End case 
	Case of 
		: ($ref=1)
			FORM GOTO PAGE:C247(1)
			SN3_LoadDataReceptionSettings 
			SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)
		: ($ref=2)
			FORM GOTO PAGE:C247(2)
			SN3_LoadDataReceptionSettings 
		: ($ref=3)
			FORM GOTO PAGE:C247(3)
	End case 
	vlSN3_CurrentTab:=$ref
End if 