If (Form event:C388=On Display Detail:K2:22)
	If ([MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19)
		OBJECT SET FONT STYLE:C166(*;"S4@";1)
	Else 
		OBJECT SET FONT STYLE:C166(*;"S4@";0)
	End if 
End if 
