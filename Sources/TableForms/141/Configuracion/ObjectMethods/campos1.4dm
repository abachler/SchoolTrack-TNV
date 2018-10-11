Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		SET LIST ITEM:C385(hl_campos;*;Get edited text:C655;Record number:C243([xxSTR_MetadatosLocales:141]))
		_O_REDRAW LIST:C382(hl_campos)
	: (Form event:C388=On Data Change:K2:15)
		SAVE RECORD:C53([xxSTR_MetadatosLocales:141])
		SET LIST ITEM:C385(hl_campos;*;[xxSTR_MetadatosLocales:141]Etiqueta:3;Record number:C243([xxSTR_MetadatosLocales:141]))
		_O_REDRAW LIST:C382(hl_campos)
End case 