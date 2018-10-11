//%attributes = {}
  //USR_SetExecMethodsList

C_LONGINT:C283($style;$icon;hl_ExecPermissions)
C_BOOLEAN:C305($enterable)



If (Is a list:C621(hl_ExecPermissions))
	CLEAR LIST:C377(hl_ExecPermissions)
End if 
hl_ExecPermissions:=New list:C375

$authIcon:=Use PicRef:K28:4+2078
$nonAuthIcon:=Use PicRef:K28:4+2077

READ ONLY:C145([xShell_ExecutableCommands:19])
QUERY:C277([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Method_ID:8#0;*)
QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]PermissionRequired:6;=;True:C214)
QUERY SELECTION:C341([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Module:3;=;"";*)
QUERY SELECTION:C341([xShell_ExecutableCommands:19]; | ;[xShell_ExecutableCommands:19]Module:3;=;"Todos los Módulos";*)
QUERY SELECTION:C341([xShell_ExecutableCommands:19]; | ;[xShell_ExecutableCommands:19]Module:3="All Modules")
MESSAGES OFF:C175
ORDER BY FORMULA:C300([xShell_ExecutableCommands:19];ST_GetWord (XS_GetCommandAliasDescription (Record number:C243([xShell_ExecutableCommands:19]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t");>)
MESSAGES ON:C181
While (Not:C34(End selection:C36([xShell_ExecutableCommands:19])))
	$alias:=ST_GetWord (XS_GetCommandAliasDescription (Record number:C243([xShell_ExecutableCommands:19]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t")
	LOAD RECORD:C52([xShell_ExecutableCommands:19])  //20150514 ASM Se descargaba el registro
	APPEND TO LIST:C376(hl_ExecPermissions;$alias;[xShell_ExecutableCommands:19]Method_ID:8)
	$el:=Find in array:C230(<>aAuthMethodsNames;[xShell_ExecutableCommands:19]MethodName:2)
	If ($el>0)
		SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;[xShell_ExecutableCommands:19]Method_ID:8;False:C215;1;$authIcon)
	Else 
		$el:=Find in array:C230(<>aAuthMethodsAlias;$alias)
		If ($el>0)
			SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;[xShell_ExecutableCommands:19]Method_ID:8;False:C215;1;$authIcon)
		Else 
			SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;[xShell_ExecutableCommands:19]Method_ID:8;False:C215;1;$nonAuthIcon)
		End if 
	End if 
	NEXT RECORD:C51([xShell_ExecutableCommands:19])
End while 

GET LIST ITEM:C378(hl_AuthModules;Selected list items:C379(hl_AuthModules);$moduleRef;$moduleName)
GET LIST ITEM PROPERTIES:C631(hl_AuthModules;$moduleRef;$enterable;$style;$icon)
If ($icon=$authIcon)
	QUERY:C277([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Method_ID:8#0;*)
	QUERY:C277([xShell_ExecutableCommands:19]; & ;[xShell_ExecutableCommands:19]PermissionRequired:6;=;True:C214)
	QUERY SELECTION:C341([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Module:3;=;$moduleName)
	While (Not:C34(End selection:C36([xShell_ExecutableCommands:19])))
		$alias:=ST_GetWord (XS_GetCommandAliasDescription (Record number:C243([xShell_ExecutableCommands:19]);<>vtXS_CountryCode;<>vtXS_Langage);1;"\t")
		LOAD RECORD:C52([xShell_ExecutableCommands:19])  //20150514 ASM Se descargaba el registro
		APPEND TO LIST:C376(hl_ExecPermissions;$alias;[xShell_ExecutableCommands:19]Method_ID:8)
		$el:=Find in array:C230(<>aAuthMethodsNames;[xShell_ExecutableCommands:19]MethodName:2)
		If ($el>0)
			SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;[xShell_ExecutableCommands:19]Method_ID:8;False:C215;0;$authIcon)
		Else 
			$el:=Find in array:C230(<>aAuthMethodsAlias;$alias)
			If ($el>0)
				SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;[xShell_ExecutableCommands:19]Method_ID:8;False:C215;0;$authIcon)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_ExecPermissions;[xShell_ExecutableCommands:19]Method_ID:8;False:C215;0;$nonAuthIcon)
			End if 
		End if 
		NEXT RECORD:C51([xShell_ExecutableCommands:19])
	End while 
End if 
SORT LIST:C391(hl_ExecPermissions)

SET LIST PROPERTIES:C387(hl_ExecPermissions;1;0;18)
_O_REDRAW LIST:C382(hl_ExecPermissions)