Case of 
	: (Form event:C388=On Load:K2:1)
		vtSTR_rut:=[Personas:7]RUT:6
		vtSTR_IDNacional2:=[Personas:7]IDNacional_2:37
		vtSTR_IDNacional3:=[Personas:7]IDNacional_3:38
		vtSTR_Pasaporte:=[Personas:7]Pasaporte:59
		vtSTR_CodigoInterno:=[Personas:7]Codigo_interno:22
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
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		[Personas:7]RUT:6:=vtSTR_rut
		[Personas:7]IDNacional_2:37:=vtSTR_IDNacional2
		[Personas:7]IDNacional_3:38:=vtSTR_IDNacional3
		[Personas:7]Pasaporte:59:=vtSTR_Pasaporte
		[Personas:7]Codigo_interno:22:=vtSTR_CodigoInterno
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
	: (Form event:C388=On Deactivate:K2:10)
		CANCEL:C270
End case 