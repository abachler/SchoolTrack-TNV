Case of 
	: (Form event:C388=On Load:K2:1)
		If (vsBWR_CurrentModule="AccountTrack")
			IT_SetEnterable (False:C215;0;->vtSTR_rut;->vtSTR_IDNacional2;->vtSTR_IDNacional3;->vtSTR_Pasaporte;->vtSTR_CodigoInterno)
		End if 
		vtSTR_rut:=[Alumnos:2]RUT:5
		vtSTR_IDNacional2:=[Alumnos:2]IDNacional_2:71
		vtSTR_IDNacional3:=[Alumnos:2]IDNacional_3:70
		vtSTR_Pasaporte:=[Alumnos:2]NoPasaporte:87
		vtSTR_CodigoInterno:=[Alumnos:2]Codigo_interno:6
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
		If (vsBWR_CurrentModule#"AccountTrack")
			[Alumnos:2]RUT:5:=vtSTR_rut
			[Alumnos:2]IDNacional_2:71:=vtSTR_IDNacional2
			[Alumnos:2]IDNacional_3:70:=vtSTR_IDNacional3
			[Alumnos:2]NoPasaporte:87:=vtSTR_Pasaporte
			[Alumnos:2]Codigo_interno:6:=vtSTR_CodigoInterno
		End if 
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
	: (Form event:C388=On Deactivate:K2:10)
		CANCEL:C270
End case 