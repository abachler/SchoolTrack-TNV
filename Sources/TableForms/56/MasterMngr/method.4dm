Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (<>lUSR_RelatedTableUserID#-1)
			_O_DISABLE BUTTON:C193(bAddArea)
			_O_DISABLE BUTTON:C193(bAddItem)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
