Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		_O_DISABLE BUTTON:C193(bAsign)
		
		If ([MPA_DefinicionAreas:186]AreaAsignatura:4#"")
			QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4;=;[MPA_DefinicionAreas:186]AreaAsignatura:4)
			SELECTION TO ARRAY:C260([xxSTR_Materias:20]Materia:2;atMPA_AsignaturasArea)
		End if 
		OBJECT SET RGB COLORS:C628(*;"lb_AsignaturasArea";0x0000;0x00FFFFFF;0x00F3F6FA)
		LISTBOX SELECT ROW:C912(lb_AsignaturasArea;0;lk remove from selection:K53:3)
		atMPA_AsignaturasArea:=0
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If ((Find in array:C230(lb_AsignaturasArea;True:C214)>0) & ((r1_SoloSinAsignaciones*1)+(r2_CompletarAsignaciones*2)+(r3_ReemplazarNoEvaluadas*3)+(r4_ReemplazarEvaluadas*4)>0))
			_O_ENABLE BUTTON:C192(bAsign)
		Else 
			_O_DISABLE BUTTON:C193(bAsign)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 