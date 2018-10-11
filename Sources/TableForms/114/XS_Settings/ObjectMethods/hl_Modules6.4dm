C_BLOB:C604($blob)
Case of 
	: (Form event:C388=On Drop:K2:12)
		RESOLVE POINTER:C394(Self:C308;$varName;$tableNum;$FieldNum)
		XS_Settings ("HandleDrag";$varName)
		
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			
		Else 
			XS_Settings ("GetPanelColumns")
		End if 
	: ((Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Data Change:K2:15))
		LIST TO BLOB:C556(hl_ModulePanels;$blob)
		GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$moduleRef;$moduleName)
		$modulePrefRef:=XS_GetBlobName ("browser";$moduleRef;vtXS_CountryCode;vtXS_LangageCode)
		PREF_SetBlob (0;$modulePrefRef;$blob)
		XS_Settings ("SavePanelColumnSettings")
End case 
