C_BOOLEAN:C305($enterable)
C_LONGINT:C283($style;$icon)
$authIcon:=Use PicRef:K28:4+2078
$nonAuthIcon:=Use PicRef:K28:4+2077
Case of 
	: (Contextual click:C713)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
		GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$style;$icon)
		$result:=Pop up menu:C542("Prohibir;Autorizar")
		Case of 
			: ($result=1)
				SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;$itemRef;$enterable;$style;$nonAuthIcon)
				$element:=Find in array:C230(<>aAuthMethodsAlias;$itemText)
				If ($element>0)
					AT_Delete ($element;1;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
				End if 
			: ($result=2)
				SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;$itemRef;$enterable;$style;$authIcon)
				$element:=Find in array:C230(<>aAuthMethodsAlias;$itemText)
				If ($element<0)
					AT_Insert (0;1;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
					<>aAuthMethodsAlias{Size of array:C274(<>aAuthMethodsAlias)}:=$itemText
					READ ONLY:C145([xShell_ExecutableCommands:19])
					XS_SearchCommandAlias (<>vtXS_CountryCode;<>vtXS_Langage;$itemText)
					<>aAuthMethodsAlias{Size of array:C274(<>aAuthMethodsAlias)}:=$itemText
					<>aAuthMethodsNames{Size of array:C274(<>aAuthMethodsNames)}:=[xShell_ExecutableCommands:19]MethodName:2
				End if 
		End case 
		_O_REDRAW LIST:C382(hl_ExecPermissions)
		
	: (Form event:C388=On Double Clicked:K2:5)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
		GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$style;$icon)
		Case of 
			: ($icon=$nonAuthIcon)
				SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;$itemRef;$enterable;$style;$authIcon)
				$element:=Find in array:C230(<>aAuthMethodsAlias;$itemText)
				If ($element<0)
					AT_Insert (0;1;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
					<>aAuthMethodsAlias{Size of array:C274(<>aAuthMethodsAlias)}:=$itemText
					READ ONLY:C145([xShell_ExecutableCommands:19])
					XS_SearchCommandAlias (<>vtXS_CountryCode;<>vtXS_Langage;$itemText)
					<>aAuthMethodsAlias{Size of array:C274(<>aAuthMethodsAlias)}:=$itemText
					<>aAuthMethodsNames{Size of array:C274(<>aAuthMethodsNames)}:=[xShell_ExecutableCommands:19]MethodName:2
				End if 
			: ($icon=$authIcon)
				SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;$itemRef;$enterable;$style;$nonAuthIcon)
				$element:=Find in array:C230(<>aAuthMethodsAlias;$itemText)
				If ($element>0)
					AT_Delete ($element;1;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
				End if 
		End case 
		_O_REDRAW LIST:C382(hl_ExecPermissions)
End case 