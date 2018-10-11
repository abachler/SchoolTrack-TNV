If (vl_indexLC>0)
	ACTcfg_LoadConfigData (8)
	alACT_Proxima{vl_indexLC}:=vlACT_LCFolio  //para cuando se saque la transacción
	ACTcfg_SaveConfig (8)
End if 
CANCEL TRANSACTION:C241