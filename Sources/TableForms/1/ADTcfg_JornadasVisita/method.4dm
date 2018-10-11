Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		
		PST_ReadParameters 
		READ ONLY:C145([ADT_JornadasVisita:144])
		ALL RECORDS:C47([ADT_JornadasVisita:144])
		ORDER BY:C49([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Section:5;>)
		SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]Section:5;atPST_SeccionJornada;[ADT_JornadasVisita:144]Date_Jornada:2;adPST_DateJornada;[ADT_JornadasVisita:144]Hora_Jornada:3;aiPST_HoraJornada)
		SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]Total:8;aiPST_AsistentesJornada;[ADT_JornadasVisita:144]Place:4;atPST_LugarJornada;[ADT_JornadasVisita:144]ID:1;aiPST_IDJornada)
		
		xALP_Set_ADT_CFG_JornadasVisita 
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
