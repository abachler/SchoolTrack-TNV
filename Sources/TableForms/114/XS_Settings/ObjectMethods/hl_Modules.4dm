C_LONGINT:C283($styles;$icon)
Case of 
	: (Form event:C388=On Drop:K2:12)
		RESOLVE POINTER:C394(Self:C308;$varName;$tableNum;$FieldNum)
		XS_Settings ("HandleDrag";$varName)
	: (Form event:C388=On Clicked:K2:4)
		XS_Settings ("GetModuleTables")
		XS_Settings ("GetModuleExecutables")
		XS_Settings ("GetModuleRestrictedMethods")
		XS_Settings ("GetConfig&WizardsItems")
	: (Form event:C388=On Losing Focus:K2:8)
		SAVE LIST:C384(Self:C308->;"XS_Modules")
End case 
