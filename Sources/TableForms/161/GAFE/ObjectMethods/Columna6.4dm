C_BOOLEAN:C305($bool)
GAFESettingsModificados:=True:C214 & Not:C34(GAFEDisableModifications)
If ((Macintosh command down:C546) | (Windows Ctrl down:C562))
	$bool:=Self:C308->{Self:C308->}
	AT_Populate (Self:C308;->$bool)
End if 