$event:=Form event:C388
Case of 
	: ($event=On Load:K2:1)
		wref:=WDW_GetWindowID 
	: ($event=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
	: ($event=On Close Box:K2:21)
		CANCEL:C270
		ARRAY INTEGER:C220(aALPLines;0)
End case 
