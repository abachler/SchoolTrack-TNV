$listElements:=Count list items:C380(hl_Modules)
$foundedAt:=HL_FindElement (hl_Modules;<>vtXS_AppName)
Case of 
	: ($listelements=0)
		APPEND TO LIST:C376(hl_Modules;<>vtXS_AppName;$listElements+1)
		SAVE LIST:C384(hl_Modules;"XS_Modules")
	: ($listelements=1)
		  //GET LIST ITEM(hl_Modules;1;$itemRef;$itemText)
		  //SET LIST ITEM(hl_Modules;$itemRef;◊vtXS_AppName;$itemRef)
		SAVE LIST:C384(hl_Modules;"XS_Modules")
	Else 
		  //  `SET LIST ITEM(hl_Modules;1;◊vtXS_AppName;1)
		  //SAVE LIST(hl_Modules;"XS_Modules")
End case 
_O_REDRAW LIST:C382(hl_Modules)


XS_SetApplicationInfo (1;<>vtXS_AppName)





