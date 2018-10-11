Case of 
	: (Form event:C388=On Load:K2:1)
		DEFAULT TABLE:C46([xxSTR_Niveles:6])  // ASM 20160404 ticket  158246
		XS_SetInterface 
		If (Table:C252(Current default table:C363)=Table:C252(->[xxSTR_Niveles:6]))
			OBJECT SET VISIBLE:C603(bApplyToClasses;True:C214)
			bApplyToClasses:=1
		Else 
			OBJECT SET VISIBLE:C603(bApplyToClasses;False:C215)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
