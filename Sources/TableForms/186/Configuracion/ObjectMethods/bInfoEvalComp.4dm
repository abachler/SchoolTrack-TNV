Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		MPAcfg_MuestraTipUsoObjeto (Self:C308)
		
		
	: (Form event:C388=On Clicked:K2:4)
		KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];vlMPA_recNumCompetencia)
		MPA_InfoUsoObjeto (->[MPA_DefinicionCompetencias:187]ID:1;1)
End case 