Case of 
	: (Form event:C388=On Load:K2:1)
		READ ONLY:C145([MPA_DefinicionCompetencias:187])
		RELATE ONE:C42([MPA_ObjetosMatriz:204]ID_Competencia:5)
		If ([MPA_ObjetosMatriz:204]FechaEstimadaLogro:26=!00-00-00!)
			[MPA_ObjetosMatriz:204]FechaEstimadaLogro:26:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
		End if 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 