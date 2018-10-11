Case of 
	: (Form event:C388=On Load:K2:1)
		vtSTR_NombreOficial:=[Alumnos:2]Nombre_oficial:48
		vtSTR_NombreComun:=[Alumnos:2]Nombre_Común:30
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		[Alumnos:2]Nombre_oficial:48:=vtSTR_NombreOficial
		[Alumnos:2]Nombre_Común:30:=vtSTR_NombreComun
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
	: (Form event:C388=On Deactivate:K2:10)
		[Alumnos:2]Nombre_oficial:48:=vtSTR_NombreOficial
		[Alumnos:2]Nombre_Común:30:=vtSTR_NombreComun
		CANCEL:C270
End case 