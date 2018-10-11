
Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(at_tableNames;Size of array:C274(al_TableNums))
		For ($i;1;Size of array:C274(al_TableNums))
			at_tableNames{$i}:=API Get Virtual Table Name ($i)
			If (at_tableNames{$i}="")
				at_tableNames{$i}:=Table name:C256($i)
			End if 
		End for 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
