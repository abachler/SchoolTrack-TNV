Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		hl_Modules:=Load list:C383("XS_Modules")
		hl_Paises:=Load list:C383("XS_CountryCodes")
		hl_Langages:=Load list:C383("XS_LangageCodes")
		GET LIST ITEM:C378(hl_Paises;1;$ref;vtXS_Country)
		GET LIST ITEM:C378(hl_Langages;1;$ref;vtXS_Langage)
		vtXS_CountryCode:="cl"
		vtXS_LangageCode:="es"
		xALSet_XS_FieldSettings 
		xALSet_XS_MethodProperties 
		XS_Settings ("GetModuleExecutables")
		
		  // setting default application name and modules list
		If (<>vtXS_AppName="")
			<>vtXS_AppName:="Application Name"
		End if 
		$listElements:=Count list items:C380(hl_Modules)
		Case of 
			: ($listelements=0)
				APPEND TO LIST:C376(hl_Modules;<>vtXS_AppName;1)
				SAVE LIST:C384(hl_Modules;"XS_Modules")
			: ($listelements=1)
				SET LIST ITEM:C385(hl_Modules;1;<>vtXS_AppName;1)
				SAVE LIST:C384(hl_Modules;"XS_Modules")
			Else 
				SAVE LIST:C384(hl_Modules;"XS_Modules")
		End case 
		XS_SetApplicationInfo (1;<>vtXS_AppName)
		SET LIST PROPERTIES:C387(hl_Modules;1;0;64)
		_O_REDRAW LIST:C382(hl_Modules)
		ARRAY TEXT:C222(aChoiceObjects;3)
		aChoiceObjects{1}:="Paneles de Configuración"
		aChoiceObjects{2}:="Asistentes"
		aChoiceObjects{3}:="Items para el Menu Herramientas"
		aChoiceObjects:=1
		OBJECT SET VISIBLE:C603(*;"hl_wizards";False:C215)
		OBJECT SET VISIBLE:C603(*;"hl_ServicesMenu";False:C215)
		
		ARRAY TEXT:C222(atXS_JumpMenu;5)  //No olvide agregar aqui si agrega pàginas al form...
		atXS_JumpMenu{1}:="Aplicación"
		atXS_JumpMenu{2}:="Tablas y Módulos"
		atXS_JumpMenu{3}:="Configuración del Explorador"
		atXS_JumpMenu{4}:="Parámetros de Tablas y Campos"
		atXS_JumpMenu{5}:="Comandos"
		vtXS_JumpMenu:=AT_array2text (->atXS_JumpMenu)
		vsXS_SettingsPage:=atXS_JumpMenu{1}
		_O_DISABLE BUTTON:C193(bPreviousPage)
		
		hl_PaisesSistema:=Load list:C383("XS_CountryCodes")
		hl_LangSistema:=Load list:C383("XS_LangageCodes")
		SET LIST PROPERTIES:C387(hl_PaisesSistema;_o_Ala Macintosh:K28:1;0;18)
		SET LIST PROPERTIES:C387(hl_LangSistema;_o_Ala Macintosh:K28:1;0;18)
		For ($i;1;Count list items:C380(hl_PaisesSistema))
			GET LIST ITEM:C378(hl_PaisesSistema;$i;$ref;$text)
			SET LIST ITEM PROPERTIES:C386(hl_PaisesSistema;$ref;False:C215;0;Use PicRef:K28:4+2077)
		End for 
		For ($i;1;Count list items:C380(hl_LangSistema))
			GET LIST ITEM:C378(hl_LangSistema;$i;$ref;$text)
			SET LIST ITEM PROPERTIES:C386(hl_LangSistema;$ref;False:C215;0;Use PicRef:K28:4+2077)
		End for 
		$pos:=HL_FindElement (hl_PaisesSistema;"cl: Chile")
		GET LIST ITEM:C378(hl_PaisesSistema;$pos;$ref;$text)
		SET LIST ITEM PROPERTIES:C386(hl_PaisesSistema;$ref;False:C215;0;Use PicRef:K28:4+2077)
		$pos:=HL_FindElement (hl_LangSistema;"es: Español")
		GET LIST ITEM:C378(hl_LangSistema;$pos;$ref;$text)
		SET LIST ITEM PROPERTIES:C386(hl_LangSistema;$ref;False:C215;0;Use PicRef:K28:4+2077)
		SELECT LIST ITEMS BY POSITION:C381(hl_PaisesSistema;0)
		SELECT LIST ITEMS BY POSITION:C381(hl_LangSistema;0)
		IT_SetButtonState (False:C215;->bDelPaisSistema;->bDelLangSistema)
		
		_O_ARRAY STRING:C218(31;aMethodNames;0)
		ARRAY INTEGER:C220(aMethodIDs;0)
		4D_GetMethodList (->aMethodNames;->aMethodIDs)
		
		hl_source:=Load list:C383("XS_Tables")
		HL_ExpandAll (hl_source)
		For ($i;Count list items:C380(hl_source);1;-1)
			GET LIST ITEM:C378(hl_source;$i;$itemRef;$itemText)
			If ($itemRef<=0)
				SELECT LIST ITEMS BY POSITION:C381(hl_source;$i)
				DELETE FROM LIST:C624(hl_source;*)
			End if 
		End for 
		HL_CollapseAll (hl_source)
		
		hl_Destination:=Copy list:C626(hl_source)
		For ($i;Count list items:C380(hl_Destination);1;-1)
			GET LIST ITEM:C378(hl_Destination;$i;$itemRef;$itemText)
			If ($itemRef<=0)
				DELETE FROM LIST:C624(hl_Destination;$itemRef)
			End if 
		End for 
		
		SET LIST PROPERTIES:C387(hl_wizards;0;0;36)
		SET LIST PROPERTIES:C387(hl_configuration;0;0;36)
		SET LIST PROPERTIES:C387(hl_ServicesMenu;0;0;36)
		
		_O_REDRAW LIST:C382(hl_wizards)
		_O_REDRAW LIST:C382(hl_configuration)
		_O_REDRAW LIST:C382(hl_ServicesMenu)
		
		
	: (Form event:C388=On Clicked:K2:4)
		
	: (Form event:C388=On Activate:K2:9)
		
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (xALP_Fields)
		ALP_SetInterface (xALP_RelatedFields)
		
	: (Form event:C388=On Unload:K2:2)
		_O_ARRAY STRING:C218(31;aMethodNames;0)
		ARRAY INTEGER:C220(aMethodIDs;0)
		
		
		
End case 