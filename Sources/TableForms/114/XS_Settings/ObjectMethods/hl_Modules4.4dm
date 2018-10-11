Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			
		Else 
			XS_Settings ("GetModuleTables")
			XS_Settings ("GetModulePanels")
			XS_Settings ("GetModuleExecutables")
			XS_Settings ("GetModuleRestrictedMethods")
			XS_Settings ("GetConfig&WizardsItems")
		End if 
	: (Form event:C388=On Losing Focus:K2:8)
		SAVE LIST:C384(Self:C308->;"XS_Modules")
End case 
