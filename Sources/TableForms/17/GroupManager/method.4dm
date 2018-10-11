Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		AT_Initialize (-><>aMembers)
		MNU_SetMenuItemState (False:C215;2;1;2;3)
		MNU_SetMenuItemState (False:C215;2;4)
		
		  //Se cargan las listas de usuario y para las busquedas.
		USR_GetUserLists 
		
		OBJECT SET HELP TIP:C1181(*;"Buscador";"La búsqueda se efectúa por nombre registrado y/o nombre de usuario")
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		MNU_SetMenuItemState (<>atUSR_UserNames>0;2;1;2;3)
		MNU_SetMenuItemState (<>atUSR_GroupNames>0;2;4)
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
