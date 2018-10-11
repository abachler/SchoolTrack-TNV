Case of 
	: (Form event:C388=On Load:K2:1)
		ACTpp_OpcionesCambioTipoDoc ("OnLoad")
		OBJECT SET ENABLED:C1123(*;"atACT_tipoDocAModif";(cs_particularCTD=1))
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET ENABLED:C1123(*;"atACT_tipoDocAModif";(cs_particularCTD=1))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 