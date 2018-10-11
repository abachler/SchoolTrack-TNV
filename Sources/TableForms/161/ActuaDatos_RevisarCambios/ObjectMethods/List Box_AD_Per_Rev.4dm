C_POINTER:C301($colPtr)
Case of 
	: (Form event:C388=On Data Change:K2:15)
		C_REAL:C285($col;$row)
		LISTBOX GET CELL POSITION:C971(List Box_AD_Per_Rev;$col;$row;$colPtr)
		
End case 