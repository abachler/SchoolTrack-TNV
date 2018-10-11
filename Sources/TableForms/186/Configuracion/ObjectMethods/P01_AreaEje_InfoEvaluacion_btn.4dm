Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		MPAcfg_MuestraTipUsoObjeto (Self:C308)
		
		
	: (Form event:C388=On Clicked:K2:4)
		If (vlMPA_recNumEje>=0)
			KRL_GotoRecord (->[MPA_DefinicionEjes:185];vlMPA_recNumEje)
			MPA_InfoUsoObjeto (->[MPA_DefinicionEjes:185]ID:1;1)
		End if 
End case 