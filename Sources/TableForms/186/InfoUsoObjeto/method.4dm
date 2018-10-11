Case of 
	: (Form event:C388=On Load:K2:1)
		
		
		Case of 
			: (vlMPA_PaginaInfoUsoObjeto=1)
				FORM GOTO PAGE:C247(1)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_InfoObjetos;vlMPA_PaginaInfoUsoObjeto)
			: (vlMPA_PaginaInfoUsoObjeto=2)
				FORM GOTO PAGE:C247(2)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_InfoObjetos;2)
		End case 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 