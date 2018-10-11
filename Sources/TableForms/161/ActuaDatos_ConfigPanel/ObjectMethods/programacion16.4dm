$page:=FORM Get current page:C276
Case of 
	: ($page=1)
		SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
	: ($page=2)
		SN3_SaveDataReceptionSettings 
	: ($page=3)
		
End case 
SN3_SendDataReceptionConfigs (3)
If (vb_Gral_CFG_Mod)
	SN3_SendDataReceptionConfigs (0)
End if 
CANCEL:C270