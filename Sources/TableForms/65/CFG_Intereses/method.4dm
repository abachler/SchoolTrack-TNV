Case of 
	: (Form event:C388=On Load:K2:1)
		$items:=Count list items:C380(<>hl_InterestList)
		If ($items<24)
			For ($i;$items+1;24)
				APPEND TO LIST:C376(<>hl_InterestList;"Interés #"+String:C10($i);$i)
			End for 
		End if 
		For ($i;1;Count list items:C380(<>hl_InterestList))
			SET LIST ITEM PROPERTIES:C386(<>hl_InterestList;$i;True:C214;0;0)
		End for 
		XS_SetConfigInterface 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 