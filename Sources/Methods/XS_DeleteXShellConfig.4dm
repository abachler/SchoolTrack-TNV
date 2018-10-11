//%attributes = {}
  //XS_DeleteXShellConfig

C_BLOB:C604($OriginalBrowserBlob)
_O_C_STRING:C293(80;$configPref;$wizardPref;$configPref;$modulePrefRef;$prefRef;$NewPanel;$NewConfig;$NewWizards;$NewServices;$NewBrowser;$alias)

ARRAY TEXT:C222($aModules;0)
ARRAY LONGINT:C221($aModuleRefs;0)
LIST TO ARRAY:C288("XS_Modules";$aModules;$aModuleRefs)

$country:=$1
$langage:=$2

For ($r;1;Size of array:C274($aModules))
	$configPref:=XS_GetBlobName ("config";$aModuleRefs{$r};$country;$langage)
	READ WRITE:C146([xShell_Prefs:46])
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$configPref)
	DELETE SELECTION:C66([xShell_Prefs:46])
	READ ONLY:C145([xShell_Prefs:46])
	$wizardPref:=XS_GetBlobName ("wizard";$aModuleRefs{$r};$country;$langage)
	READ WRITE:C146([xShell_Prefs:46])
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$wizardPref)
	DELETE SELECTION:C66([xShell_Prefs:46])
	READ ONLY:C145([xShell_Prefs:46])
	$configPref:=XS_GetBlobName ("service";$aModuleRefs{$r};$country;$langage)
	READ WRITE:C146([xShell_Prefs:46])
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$configPref)
	DELETE SELECTION:C66([xShell_Prefs:46])
	READ ONLY:C145([xShell_Prefs:46])
	$tablesPref:=XS_GetBlobName ("tables";$aModuleRefs{$r};$country;$langage)
	READ WRITE:C146([xShell_Prefs:46])
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$tablesPref)
	DELETE SELECTION:C66([xShell_Prefs:46])
	READ ONLY:C145([xShell_Prefs:46])
	$modulePrefRef:=XS_GetBlobName ("browser";$aModuleRefs{$r};$country;$langage)
	$OriginalBrowserBlob:=PREF_fGetBlob (0;$modulePrefRef)
	$listRef:=BLOB to list:C557($OriginalBrowserBlob)
	For ($f;1;Count list items:C380($listRef))
		SELECT LIST ITEMS BY POSITION:C381($listRef;$f)
		GET LIST ITEM:C378($listRef;Selected list items:C379($listRef);$PanelRef;$tableName)
		$prefRef:=XS_GetBlobName ("panel";$aModuleRefs{$r};$country;$langage;$PanelRef)
		READ WRITE:C146([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$prefRef)
		DELETE SELECTION:C66([xShell_Prefs:46])
		READ ONLY:C145([xShell_Prefs:46])
	End for 
	READ WRITE:C146([xShell_Prefs:46])
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$modulePrefRef)
	DELETE SELECTION:C66([xShell_Prefs:46])
	READ ONLY:C145([xShell_Prefs:46])
End for 

READ ONLY:C145([xShell_Tables:51])
READ WRITE:C146([xShell_TableAlias:199])
ALL RECORDS:C47([xShell_Tables:51])
While (Not:C34(End selection:C36([xShell_Tables:51])))
	$FromtableRef:=String:C10([xShell_Tables:51]NumeroDeTabla:5)+"."+$country+"."+$langage
	$FromRN:=Find in field:C653([xShell_TableAlias:199]TableRef:1;$FromtableRef)
	If ($FromRN#-1)
		GOTO RECORD:C242([xShell_TableAlias:199];$FromRN)
		DELETE RECORD:C58([xShell_TableAlias:199])
	End if 
	NEXT RECORD:C51([xShell_Tables:51])
End while 
KRL_UnloadReadOnly (->[xShell_TableAlias:199])

READ ONLY:C145([xShell_Fields:52])
READ WRITE:C146([xShell_FieldAlias:198])
ALL RECORDS:C47([xShell_Fields:52])
While (Not:C34(End selection:C36([xShell_Fields:52])))
	QUERY:C277([xShell_FieldAlias:198];[xShell_FieldAlias:198]Referencia_tablaCampo:1=[xShell_Fields:52]ReferenciaTablaCampo:7;*)
	QUERY:C277([xShell_FieldAlias:198]; & ;[xShell_FieldAlias:198]PaisLenguaje:6;=;$country+"."+$langage)
	DELETE RECORD:C58([xShell_FieldAlias:198])
	NEXT RECORD:C51([xShell_Fields:52])
End while 
KRL_UnloadReadOnly (->[xShell_Fields:52])

READ WRITE:C146([xShell_ExecutableCommands:19])
ALL RECORDS:C47([xShell_ExecutableCommands:19])

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([xShell_ExecutableCommands:19];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([xShell_ExecutableCommands:19];$aRecNums{$i})
	QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=[xShell_ExecutableCommands:19]ID:10;*)
	QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Country_Code:1;=;$country;*)
	QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Language_Code:2;=;$langage)
	DELETE RECORD:C58([xShell_ExecCommands_Localized:232])
End for 

KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
KRL_UnloadReadOnly (->[xShell_ExecCommands_Localized:232])