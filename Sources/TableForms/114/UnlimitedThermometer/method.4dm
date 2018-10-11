Case of 
	: (Form event:C388=On Outside Call:K2:11)
		If (Fl_Blink=False:C215)
			CANCEL:C270
			  //<>ClosedTher:=True
		End if 
	: (Form event:C388=On Close Box:K2:21)
		If (Not:C34(Is compiled mode:C492))
			CANCEL:C270
		End if 
End case 
