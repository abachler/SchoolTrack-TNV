Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		r2:=1
		If (sElements>0)  //releemos el arreglo para asegurarnos que otro usuario no haya creado el valor#0)
			If (Position:C15("[+]";sValue)>0)
				r1:=1
				r2:=0
				sValue:=Replace string:C233(sValue;", [+]";"")
			Else 
				r2:=1
				r1:=0
				sValue:=Replace string:C233(sValue;", [-]";"")
			End if 
			
		End if 
End case 
