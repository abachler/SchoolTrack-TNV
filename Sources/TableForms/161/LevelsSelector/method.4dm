C_LONGINT:C283(vlSN3_CurrConfigLevel)
Case of 
	: (Form event:C388=On Load:K2:1)
		WDW_SlideDrawer (->[SN3_PublicationPrefs:161];"LevelsSelector")
		XS_SetInterface 
		ARRAY TEXT:C222(at_NivelesDestino;0)
		ARRAY LONGINT:C221(al_NivelesDestino;0)
		ARRAY TEXT:C222(at_NivelesOrigen;0)
		ARRAY LONGINT:C221(al_NivelesOrigen;0)
		COPY ARRAY:C226(at_IDNivel;at_NivelesOrigen)
		COPY ARRAY:C226(aiADT_NivNo;al_NivelesOrigen)
		$found:=Find in array:C230(aiADT_NivNo;vlSN3_CurrConfigLevel)
		AT_Delete ($found;1;->at_NivelesOrigen;->al_NivelesOrigen)
		SN3_CopiaIngreso:=""
		OBJECT SET VISIBLE:C603(SN3_CopiaIngreso;False:C215)
		If (vtSN3_CurrDataType#"")
			rDatosActuales:=1
			rTodos:=0
			If (vtSN3_CurrDataType#"ingreso")
				OBJECT SET TITLE:C194(rDatosActuales;__ ("Copiar la configuracion de ")+vtSN3_CurrDataType+__ (" de ")+vtSNT_ConfigLevel+__ (" a los niveles que seleccione"))
				OBJECT SET TITLE:C194(rTodos;__ ("Copiar la configuración completa de ")+vtSNT_ConfigLevel+__ (" a los niveles que seleccione"))
			Else 
				SN3_CopiaIngreso:=__ ("Copiar la configuración de ")+vtSNT_ConfigLevelRD+__ (" a los niveles que seleccione")
				OBJECT SET VISIBLE:C603(rTodos;False:C215)
				OBJECT SET VISIBLE:C603(rDatosActuales;False:C215)
				OBJECT SET VISIBLE:C603(SN3_CopiaIngreso;True:C214)
			End if 
		Else 
			OBJECT SET TITLE:C194(rDatosActuales;__ ("No hay un tipo de datos seleccionado para ")+vtSNT_ConfigLevel)
			OBJECT SET TITLE:C194(rTodos;__ ("Copiar la configuración completa de ")+vtSNT_ConfigLevel+__ (" a los niveles que seleccione"))
			rDatosActuales:=0
			rTodos:=1
			_O_DISABLE BUTTON:C193(rDatosActuales)
		End if 
		LISTBOX SELECT ROW:C912(lb_NivelesOrigen;0;lk remove from selection:K53:3)
		_O_DISABLE BUTTON:C193(bCopiar)
End case 