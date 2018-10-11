Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		XS_Settings ("SavePanelColumnSettings")
	: (Form event:C388=On Data Change:K2:15)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
		vtVS_FieldHeader:=$itemText
		XS_Settings ("SetBrowserFieldSettings")
	: (Form event:C388=On Clicked:K2:4)
		XS_Settings ("GetColumnProperties")
	: (Form event:C388=On Drop:K2:12)
		RESOLVE POINTER:C394(Self:C308;$varName;$tableNum;$FieldNum)
		XS_Settings ("HandleDrag";$varName)
		XS_Settings ("SavePanelColumnSettings")
End case 