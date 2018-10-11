Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		
		ARRAY TEXT:C222(atADT_Entrevistadores;0)
		ARRAY LONGINT:C221(alADT_IDFuncEn;0)
		READ ONLY:C145([Profesores:4])
		QUERY:C277([Profesores:4];[Profesores:4]Es_Presentador_Admisiones:74=True:C214)
		ORDER BY:C49([Profesores:4];[Profesores:4]Apellidos_y_nombres:28)
		SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;atADT_Entrevistadores;[Profesores:4]Numero:1;alADT_IDFuncEn)
		
		xALP_Set_ADT_CFG_Jornadas 
		PST_ReadParameters 
		If (Size of array:C274(adPST_PresentDate)=0)
			_O_DISABLE BUTTON:C193(bDelPresentacion)
		Else 
			_O_ENABLE BUTTON:C192(bDelPresentacion)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
