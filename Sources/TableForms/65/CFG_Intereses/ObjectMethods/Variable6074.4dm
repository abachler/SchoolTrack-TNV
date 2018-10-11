Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;vtBBL_SelectedInterest)
	: (Form event:C388=On Clicked:K2:4)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;vtBBL_SelectedInterest)
	: (Form event:C388=On Data Change:K2:15)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
		If ($itemText#vtBBL_SelectedInterest)
			BBLdbu_SetInterestTextField ($itemRef)
		End if 
End case 
