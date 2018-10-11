Case of 
	: (Form event:C388=On Load:K2:1)
		LIST TO ARRAY:C288("STR_BUBuses";atTipoBus)
		If (Is new record:C668([Buses_escolares:57]))
			[Buses_escolares:57]Patente:1:=sMatBus
		End if 
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
