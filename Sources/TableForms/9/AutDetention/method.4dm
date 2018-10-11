$fEvent:=Form event:C388

Spell_CheckSpelling 

Case of 
	: ($fEvent=On Load:K2:1)
		XS_SetInterface 
		ddDate:=Current date:C33
		iHrs:=2
		sprof:=<>tUSR_CurrentUserName
		iProfID:=<>lUSR_RelatedTableUserID
		If ((iHrs>0) & (iprofId>0))
			_O_ENABLE BUTTON:C192(b_Gen)
		Else 
			_O_DISABLE BUTTON:C193(b_Gen)
		End if 
		WDW_SlideDrawer (->[Alumnos_Castigos:9];"AutDetention")
	: ($fEvent=On Data Change:K2:15)
		If ((iHrs>0) & (iprofId>0))
			_O_ENABLE BUTTON:C192(b_Gen)
		Else 
			_O_DISABLE BUTTON:C193(b_Gen)
		End if 
		
		
	: ($fEvent=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
End case 
