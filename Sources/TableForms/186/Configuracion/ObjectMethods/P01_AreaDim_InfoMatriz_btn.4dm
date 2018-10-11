Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		MPAcfg_MuestraTipUsoObjeto (Self:C308)
		
		
	: (Form event:C388=On Clicked:K2:4)
		Case of 
			: (vlMPA_recNumDimension>=0)
				KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];vlMPA_recNumDimension)
				MPA_InfoUsoObjeto (->[MPA_DefinicionDimensiones:188]ID:1;2)
			: (vlMPA_recNumCompetencia>=0)
				KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];vlMPA_recNumCompetencia)
				RELATE ONE:C42([MPA_DefinicionCompetencias:187]ID_Dimension:23)
				MPA_InfoUsoObjeto (->[MPA_DefinicionDimensiones:188]ID:1;2)
		End case 
		
End case 