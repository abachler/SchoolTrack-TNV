Case of 
	: (Form event:C388=On Data Change:K2:15)
		
		If (arACTcfg_PctMax{lb_desctoIndividual}>100)
			arACTcfg_PctMax{lb_desctoIndividual}:=100
		End if 
		
		If (arACTcfg_PctMax{lb_desctoIndividual}<0)
			arACTcfg_PctMax{lb_desctoIndividual}:=0
		End if 
		
End case 