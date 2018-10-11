Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		vt_Lunes:=""
		vt_Martes:=""
		vt_Miercoles:=""
		vt_Jueves:=""
		vt_Viernes:=""
		vt_Sabado:=""
		vt_Domingo:=""
		vt_NombreRuta:=""
		
		READ ONLY:C145([BU_Rutas:26])
		ALL RECORDS:C47([BU_Rutas:26])
		SELECTION TO ARRAY:C260([BU_Rutas:26]Nombre:9;at_RutaName;[BU_Rutas:26]ID:12;al_RutaNumber)
End case 
