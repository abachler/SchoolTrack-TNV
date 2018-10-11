
$event:=Form event:C388
Case of 
	: ($event=On Load:K2:1)
		XS_SetInterface 
	: ($event=On Deactivate:K2:10)
		  //WDW_SetFrontmost (wref)
End case 
