Case of 
	: (Form event:C388=On Load:K2:1)
		vtSTR_rut:=[Profesores:4]RUT:27
		vtSTR_IDNacional2:=[Profesores:4]IDNacional_2:42
		vtSTR_IDNacional3:=[Profesores:4]IDNacional_3:43
		vtSTR_Pasaporte:=[Profesores:4]Pasaporte:60
		vtSTR_CodigoInterno:=[Profesores:4]Codigo_interno:30
		vMsg:=""
		
		  //FORMATOS SEGÚN PAISES
		Case of 
			: (<>vtXS_CountryCode="cl")
				OBJECT SET VISIBLE:C603(*;"infopais@";True:C214)
				ARRAY TEXT:C222(aRUN_Pasaporte;0)
				If (Num:C11(Substring:C12(vtSTR_rut;1;Length:C16(vtSTR_rut)-1))>0)
					OBJECT SET FORMAT:C236(vtSTR_rut;"###.###.###-#")
				Else 
					OBJECT SET FORMAT:C236(vtSTR_rut;"")
				End if 
		End case 
	: (Form event:C388=On After Keystroke:K2:26)
		vMsg:=""
		
	: (Form event:C388=On Unload:K2:2)
		[Profesores:4]RUT:27:=vtSTR_rut
		[Profesores:4]IDNacional_2:42:=vtSTR_IDNacional2
		[Profesores:4]IDNacional_3:43:=vtSTR_IDNacional3
		[Profesores:4]Pasaporte:60:=vtSTR_Pasaporte
		[Profesores:4]Codigo_interno:30:=vtSTR_CodigoInterno
End case 