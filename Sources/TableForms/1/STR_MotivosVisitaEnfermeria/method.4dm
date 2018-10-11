Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		  //r2:=1
		  //If (sElements#0)
		  //If (Position("[+]";sValue)>0)
		  //r1:=1
		  //r2:=0
		  //sValue:=Replace string(sValue;", [+]";"")
		  //Else 
		  //r2:=1
		  //r1:=0
		  //sValue:=Replace string(sValue;", [-]";"")
		  //End if 
		  //End if 
		r1:=1
		Case of 
			: (Position:C15("[M]";sValue)>0)
				r1:=1
				r2:=0
				r3:=0
				sValue:=Replace string:C233(sValue;", [M]";"")
			: (Position:C15("[D]";sValue)>0)
				r1:=0
				r2:=1
				r3:=0
				sValue:=Replace string:C233(sValue;", [D]";"")
			: (Position:C15("[T]";sValue)>0)
				r1:=0
				r2:=0
				r3:=1
				sValue:=Replace string:C233(sValue;", [T]";"")
		End case 
		XS_SetInterface 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		ARRAY TEXT:C222(atXS_Choices;0)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 