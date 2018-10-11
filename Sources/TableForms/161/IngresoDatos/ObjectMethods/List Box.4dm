C_POINTER:C301($colPtr)
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		LISTBOX GET CELL POSITION:C971(Self:C308->;$col;$row;$colPtr)
		If ($col=2)
			EDIT ITEM:C870($colPtr->;$row)
		End if 
	: (Form event:C388=On Data Change:K2:15)
		ab_NivelModificado{aiADT_NivNo}:=True:C214
End case 