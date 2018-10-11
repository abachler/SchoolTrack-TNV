C_LONGINT:C283($formPage)
C_TEXT:C284($itemText)

Case of 
	: (Form event:C388=On Load:K2:1)
		
		
	: (Form event:C388=On Clicked:K2:4)
		GET LIST ITEM:C378(Self:C308->;*;$formPage;$itemText)
		
		Case of 
			: ($formPage=3)
				If (<>vtXS_CountryCode="cl")
					FORM GOTO PAGE:C247($formPage)
					SELECT LIST ITEMS BY POSITION:C381(Self:C308->;$formPage)
				Else 
					SELECT LIST ITEMS BY POSITION:C381(Self:C308->;$formPage)
					$formPage:=4
					FORM GOTO PAGE:C247($formPage)
					
				End if 
			: ($formPage=4)
				SELECT LIST ITEMS BY POSITION:C381(Self:C308->;$formPage)
				$formPage:=5
				FORM GOTO PAGE:C247($formPage)
				
			Else 
				
				FORM GOTO PAGE:C247($formPage)
		End case 
		
		
End case 