Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		[BU_Viajes:109]ID:1:=SQ_SeqNumber (->[BU_Viajes:109]ID:1)
		vlBU_IDViaje:=[BU_Viajes:109]ID:1
		READ ONLY:C145([BU_Rutas:26])
		ALL RECORDS:C47([BU_Rutas:26])
		SELECTION TO ARRAY:C260([BU_Rutas:26]Nombre:9;atRuta;[BU_Rutas:26]ID:12;alIDRuta)
		vtNombreRuta:=""
		vtNombreRec:=""
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 