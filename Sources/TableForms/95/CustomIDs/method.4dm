Case of 
	: (Form event:C388=On Load:K2:1)
		vtSTR_rut:=[ADT_Contactos:95]RUT:11
		vtSTR_IDNacional2:=[ADT_Contactos:95]IDNacional_2:14
		vtSTR_IDNacional3:=[ADT_Contactos:95]IDNacional_3:15
		vtSTR_Pasaporte:=[ADT_Contactos:95]Pasaporte:16
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
		[ADT_Contactos:95]RUT:11:=vtSTR_rut
		[ADT_Contactos:95]IDNacional_2:14:=vtSTR_IDNacional2
		[ADT_Contactos:95]IDNacional_3:15:=vtSTR_IDNacional3
		[ADT_Contactos:95]Pasaporte:16:=vtSTR_Pasaporte
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
	: (Form event:C388=On Deactivate:K2:10)
		CANCEL:C270
End case 