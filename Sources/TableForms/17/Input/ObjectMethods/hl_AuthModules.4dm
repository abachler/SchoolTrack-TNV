
C_BOOLEAN:C305($enterable)
C_LONGINT:C283($style;$icon)
$authIcon:=Use PicRef:K28:4+2078
$nonAuthIcon:=Use PicRef:K28:4+2077
Case of 
		
	: (Contextual click:C713)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$moduleName)
		GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$style;$icon)
		$result:=Pop up menu:C542("Prohibir;Autorizar")
		Case of 
			: ($result=1)
				SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;$enterable;$style;$nonAuthIcon)
				$element:=Find in array:C230(<>atUSR_AuthModules;$moduleName)
				If ($element>0)
					AT_Delete ($element;1;-><>atUSR_AuthModules)
					READ ONLY:C145([xShell_ExecutableCommands:19])
					QUERY:C277([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Method_ID:8#0;*)
					QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]PermissionRequired:6;=;True:C214)
					QUERY SELECTION:C341([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Module:3;=;$moduleName)
					MESSAGES OFF:C175
					ORDER BY FORMULA:C300([xShell_ExecutableCommands:19];ST_GetWord (XS_GetCommandAliasDescription (Record number:C243([xShell_ExecutableCommands:19]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");>)
					MESSAGES ON:C181
					While (Not:C34(End selection:C36([xShell_ExecutableCommands:19])))
						$el:=Find in array:C230(<>aAuthMethodsNames;[xShell_ExecutableCommands:19]MethodName:2)
						If ($el>0)
							AT_Delete ($el;1;-><>aAuthMethodsNames;-><>aAuthMethodsAlias)
						End if 
						NEXT RECORD:C51([xShell_ExecutableCommands:19])
					End while 
				End if 
			: ($result=2)
				SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;$enterable;$style;$authIcon)
				$element:=Find in array:C230(<>atUSR_AuthModules;$moduleName)
				If ($element<0)
					AT_Insert (0;1;-><>atUSR_AuthModules)
					<>atUSR_AuthModules{Size of array:C274(<>atUSR_AuthModules)}:=$moduleName
				End if 
		End case 
		_O_REDRAW LIST:C382(Self:C308->)
		USR_SetExecMethodsList 
		
	: (Form event:C388=On Clicked:K2:4)
		USR_SetExecMethodsList 
		
	: (Form event:C388=On Double Clicked:K2:5)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$moduleName)
		GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$style;$icon)
		Case of 
			: ($icon=$nonAuthIcon)
				SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;$enterable;$style;$authIcon)
				$element:=Find in array:C230(<>atUSR_AuthModules;$moduleName)
				If ($element<0)
					AT_Insert (0;1;-><>atUSR_AuthModules)
					<>atUSR_AuthModules{Size of array:C274(<>atUSR_AuthModules)}:=$moduleName
				End if 
			: ($icon=$authIcon)
				SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;$enterable;$style;$nonAuthIcon)
				$element:=Find in array:C230(<>atUSR_AuthModules;$moduleName)
				If ($element>0)
					AT_Delete ($element;1;-><>atUSR_AuthModules)
					READ ONLY:C145([xShell_ExecutableCommands:19])
					QUERY:C277([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Method_ID:8#0;*)
					QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]PermissionRequired:6;=;True:C214)
					QUERY SELECTION:C341([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Module:3;=;$moduleName)
					MESSAGES OFF:C175
					ORDER BY FORMULA:C300([xShell_ExecutableCommands:19];ST_GetWord (XS_GetCommandAliasDescription (Record number:C243([xShell_ExecutableCommands:19]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");>)
					MESSAGES ON:C181
					While (Not:C34(End selection:C36([xShell_ExecutableCommands:19])))
						$el:=Find in array:C230(<>aAuthMethodsNames;[xShell_ExecutableCommands:19]MethodName:2)
						If ($el>0)
							AT_Delete ($el;1;-><>aAuthMethodsNames;-><>aAuthMethodsAlias)
						End if 
						NEXT RECORD:C51([xShell_ExecutableCommands:19])
					End while 
				End if 
		End case 
		
		_O_REDRAW LIST:C382(Self:C308->)
		USR_SetExecMethodsList 
End case 