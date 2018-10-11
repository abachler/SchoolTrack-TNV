Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		PST_ReadParameters 
		ARRAY TEXT:C222(atADT_Examinadores;0)
		ARRAY LONGINT:C221(alADT_IDFuncEx;0)
		READ ONLY:C145([Profesores:4])
		QUERY:C277([Profesores:4];[Profesores:4]Es_Examinador_Admisiones:63=True:C214)
		SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;atADT_Examinadores;[Profesores:4]Numero:1;alADT_IDFuncEx)
		xALP_Set_ADT_CFG_SesionesEX 
		If (viPST_VariableExSesions=1)
			OBJECT SET VISIBLE:C603(*;"Fixed@";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"Fixed@";True:C214)
		End if 
		AL_SetLine (xALP_Exams;0)
		_O_DISABLE BUTTON:C193(bDeleteSesion)
		IT_SetButtonState ((viPST_AutoAsigExam=1);->viPST_DontAsigExamJF)
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
