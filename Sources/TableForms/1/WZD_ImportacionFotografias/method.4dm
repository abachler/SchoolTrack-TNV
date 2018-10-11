C_LONGINT:C283(hl_TablasFotos)
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vlTableNumber:=1
		vlFieldNumber:=1
		vi_PageNumber:=1
		hl_TablasFotos:=New list:C375
		APPEND TO LIST:C376(hl_TablasFotos;API Get Virtual Table Name (Table:C252(->[Alumnos:2]));Table:C252(->[Alumnos:2]))
		APPEND TO LIST:C376(hl_TablasFotos;API Get Virtual Table Name (Table:C252(->[Profesores:4]));Table:C252(->[Profesores:4]))
		APPEND TO LIST:C376(hl_TablasFotos;API Get Virtual Table Name (Table:C252(->[Personas:7]));Table:C252(->[Personas:7]))
		APPEND TO LIST:C376(hl_TablasFotos;API Get Virtual Table Name (Table:C252(->[Familia:78]));Table:C252(->[Familia:78]))
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If ((vlTableNumber>0) & (vlFieldNumber>0))
			_O_ENABLE BUTTON:C192(bImport)
		Else 
			_O_DISABLE BUTTON:C193(bImport)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_TablasFotos)
		HL_ClearList (hl_Fields)
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

