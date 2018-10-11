$formEvent:=Form event:C388
Case of 
	: ($formevent=On Load:K2:1)
		XS_SetInterface 
		
		ARRAY TEXT:C222(atQR_Pais;0)
		LIST TO ARRAY:C288("XS_CountryCodes";atQR_Pais)
		ARRAY TEXT:C222(atQR_CountryCode;Size of array:C274(atQR_Pais))
		AT_Insert (0;1;->atQR_Pais)
		atQR_Pais{Size of array:C274(atQR_Pais)}:="Todos"
		If ([xShell_Queries:53]CodigoPais:11="")
			[xShell_Queries:53]CodigoPais:11:=""
			atQR_Pais:=Size of array:C274(atQR_Pais)
		Else 
			atQR_Pais:=Find in array:C230(atQR_Pais;[xShell_Queries:53]CodigoPais:11+"@")
		End if 
		
		bInstall:=1
		r2:=1
		If ((<>lUSR_CurrentUserID<0))
			OBJECT SET VISIBLE:C603(*;"dev@";True:C214)
			bSaveAsStandard:=1
		Else 
			OBJECT SET VISIBLE:C603(*;"dev@";False:C215)
			bSaveAsStandard:=0
		End if 
		WDW_SlideDrawer (Current form table:C627;"ToSave")
		
		
	: ($formevent=On Validate:K2:3)
		
	: ($formEvent=On Activate:K2:9)
		
	: ($formevent=On Deactivate:K2:10)
		
End case 

