$vl_ItemPos:=Selected list items:C379(aHL_CMT_Config)
If ($vl_ItemPos>0)
	vlCMT_SelOptsPage:=$vl_ItemPos
	FORM GOTO PAGE:C247($vl_ItemPos)
	If ($vl_ItemPos=3)
		SELECT LIST ITEMS BY POSITION:C381(aHL_CMT_ConfigLog;1)
		AL_UpdateArrays (xALP_CMT_LogList;0)
		CMT_LoadLog 
		AL_UpdateArrays (xALP_CMT_LogList;-2)
	End if 
End if 