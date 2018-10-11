Case of 
	: (Form event:C388=On Load:K2:1)
		hl_DeselectAllElements (hl_popupList)
		vtitle:=Get window title:C450  //rescatamos el titulo para reponerlo si desactivamos con boton derecho (no considerado como deactivate
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
	: (Form event:C388=On Deactivate:K2:10)
		CANCEL:C270
	: (Form event:C388=On Activate:K2:9)
		SET WINDOW TITLE:C213(vtitle)
End case 