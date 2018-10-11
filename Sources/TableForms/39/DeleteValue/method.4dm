Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		sValue:=sElements{aLines{1}}
		OBJECT SET VISIBLE:C603(*;"NoReemXVacio";[xShell_List:39]NoReemplazarXVacio:13)
		OBJECT SET VISIBLE:C603(*;"ReemXVacio";Not:C34([xShell_List:39]NoReemplazarXVacio:13))
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
	: (Form event:C388=On Resize:K2:27)
		
End case 