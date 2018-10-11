Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		IT_SetButtonState ((Count list items:C380(hl_OrderDefinition)>0);->bClean;->bOrder)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Activate:K2:9)
		SET WINDOW TITLE:C213(__ ("Ordenamientos"))
End case 
