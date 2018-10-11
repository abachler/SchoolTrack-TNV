SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
Case of 
	: ((Macintosh option down:C545 | Windows Alt down:C563) & (Shift down:C543))
		SN3_SendDataReceptionConfigs (3)
	: (Macintosh option down:C545 | Windows Alt down:C563)
		SN3_SendDataReceptionConfigs (2)
	Else 
		SN3_SendDataReceptionConfigs (1;vlSN3_CurrConfigLevel)
End case 
SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)