$Duplicados:=ACTdc_buscaDuplicados (5;String:C10(vlACT_LCFolio))
If ($Duplicados>0)
	ACTcfg_LoadConfigData (8)
	Self:C308->:=alACT_Proxima{vl_indexLC}
	CD_Dlog (0;__ ("Ya existe un documento con este número de serie."))
	GOTO OBJECT:C206(Self:C308->)
End if 
cambioLC:=True:C214