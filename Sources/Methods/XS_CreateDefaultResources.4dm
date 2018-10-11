//%attributes = {}
  //XS_CreateDefaultResources

  //Ejecutar este método cada vez que se agregue un pais en XS_CountryCodes o un lenguage en XS_LangageCodes

_O_C_STRING:C293(80;$configPref;$wizardPref;$configPref;$modulePrefRef;$prefRef;$NewPanel;$NewConfig;$NewWizards;$NewServices;$NewBrowser;$alias)
C_TEXT:C284($description)

ARRAY TEXT:C222($aCountryCodes;0)
ARRAY TEXT:C222($aLanguageCodes;0)
ARRAY TEXT:C222($aModules;0)
ARRAY LONGINT:C221($aModuleRefs;0)

$l:=Load list:C383("XS_Modules")
HL_List2Array ("XS_CountryCodes";->$aCountryCodes)
HL_List2Array ("XS_LangageCodes";->$aLanguageCodes)
HL_CopyReferencedListToArray ($l;->$aModules;->$aModuleRefs)

If (Count parameters:C259=1)
	$what:=$1
Else 
	$what:="all"
End if 

Case of 
	: ($what="commands")
		$CreateBlobs:=False:C215
		$CreateFields:=False:C215
		$CreateCommands:=True:C214
	: ($what="blobs")
		$CreateBlobs:=True:C214
		$CreateFields:=False:C215
		$CreateCommands:=False:C215
	: ($what="fields")
		$CreateBlobs:=False:C215
		$CreateFields:=True:C214
		$CreateCommands:=False:C215
	: ($what="all")
		$CreateBlobs:=True:C214
		$CreateFields:=True:C214
		$CreateCommands:=True:C214
	Else 
		$CreateBlobs:=True:C214
		$CreateFields:=True:C214
		$CreateCommands:=True:C214
End case 

If ($CreateBlobs)
	C_BLOB:C604($OriginalconfigBlob;$OriginalWizardBlob;$OriginalServicesBlob;$OriginalBrowserBlob;$OriginalPanel;$OriginalTablesBlob)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando recursos idiomáticos..."))
	For ($r;1;Size of array:C274($aModules))
		$configPref:=XS_GetBlobName ("config";$aModuleRefs{$r};"cl";"es")
		$OriginalconfigBlob:=PREF_fGetBlob (0;$configPref)
		$wizardPref:=XS_GetBlobName ("wizard";$aModuleRefs{$r};"cl";"es")
		$OriginalWizardBlob:=PREF_fGetBlob (0;$wizardPref)
		$configPref:=XS_GetBlobName ("service";$aModuleRefs{$r};"cl";"es")
		$OriginalServicesBlob:=PREF_fGetBlob (0;$configPref)
		$modulePrefRef:=XS_GetBlobName ("browser";$aModuleRefs{$r};"cl";"es")
		$OriginalBrowserBlob:=PREF_fGetBlob (0;$modulePrefRef)
		$tablesPref:=XS_GetBlobName ("tables";$aModuleRefs{$r};"cl";"es")
		$OriginalTablesBlob:=PREF_fGetBlob (0;$tablesPref)
		$listRef:=BLOB to list:C557($OriginalBrowserBlob)
		For ($f;1;Count list items:C380($listRef))
			SELECT LIST ITEMS BY POSITION:C381($listRef;$f)
			GET LIST ITEM:C378($listRef;Selected list items:C379($listRef);$PanelRef;$tableName)
			$prefRef:=XS_GetBlobName ("panel";$aModuleRefs{$r};"cl";"es";$PanelRef)
			$OriginalPanel:=PREF_fGetBlob (0;$prefRef)
			For ($x;1;Size of array:C274($aCountryCodes))
				For ($y;1;Size of array:C274($aLanguageCodes))
					$NewPanel:=XS_GetBlobName ("panel";$aModuleRefs{$r};ST_GetWord ($aCountryCodes{$x};1;":");ST_GetWord ($aLanguageCodes{$y};1;":");$PanelRef)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$rec)
					SET QUERY LIMIT:C395(1)
					QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$NewPanel)
					SET QUERY LIMIT:C395(0)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($rec=0)
						PREF_SetBlob (0;$NewPanel;$OriginalPanel)
					End if 
				End for 
			End for 
			SET BLOB SIZE:C606($OriginalPanel;0)
		End for 
		For ($i;1;Size of array:C274($aCountryCodes))
			For ($j;1;Size of array:C274($aLanguageCodes))
				$NewConfig:=XS_GetBlobName ("config";$aModuleRefs{$r};ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":"))
				SET QUERY DESTINATION:C396(Into variable:K19:4;$rec)
				SET QUERY LIMIT:C395(1)
				QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$NewConfig)
				SET QUERY LIMIT:C395(0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($rec=0)
					PREF_SetBlob (0;$NewConfig;$OriginalconfigBlob)
				End if 
				$NewWizards:=XS_GetBlobName ("wizard";$aModuleRefs{$r};ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":"))
				SET QUERY DESTINATION:C396(Into variable:K19:4;$rec)
				SET QUERY LIMIT:C395(1)
				QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$NewWizards)
				SET QUERY LIMIT:C395(0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($rec=0)
					PREF_SetBlob (0;$NewWizards;$OriginalWizardBlob)
				End if 
				$NewServices:=XS_GetBlobName ("service";$aModuleRefs{$r};ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":"))
				SET QUERY DESTINATION:C396(Into variable:K19:4;$rec)
				SET QUERY LIMIT:C395(1)
				QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$NewServices)
				SET QUERY LIMIT:C395(0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($rec=0)
					PREF_SetBlob (0;$NewServices;$OriginalServicesBlob)
				End if 
				$NewBrowser:=XS_GetBlobName ("browser";$aModuleRefs{$r};ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":"))
				SET QUERY DESTINATION:C396(Into variable:K19:4;$rec)
				SET QUERY LIMIT:C395(1)
				QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$NewBrowser)
				SET QUERY LIMIT:C395(0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($rec=0)
					PREF_SetBlob (0;$NewBrowser;$OriginalBrowserBlob)
				End if 
				$NewTables:=XS_GetBlobName ("tables";$aModuleRefs{$r};ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":"))
				SET QUERY DESTINATION:C396(Into variable:K19:4;$rec)
				SET QUERY LIMIT:C395(1)
				QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$NewTables)
				SET QUERY LIMIT:C395(0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($rec=0)
					PREF_SetBlob (0;$NewTables;$OriginalTablesBlob)
				End if 
			End for 
		End for 
		SET BLOB SIZE:C606($OriginalconfigBlob;0)
		SET BLOB SIZE:C606($OriginalWizardBlob;0)
		SET BLOB SIZE:C606($OriginalServicesBlob;0)
		SET BLOB SIZE:C606($OriginalBrowserBlob;0)
		SET BLOB SIZE:C606($OriginalTablesBlob;0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r/Size of array:C274($aModules))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 



If ($CreateCommands)
	READ WRITE:C146([xShell_ExecutableCommands:19])
	ALL RECORDS:C47([xShell_ExecutableCommands:19])
	
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([xShell_ExecutableCommands:19];$aRecNums;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando comandos ejecutables a otros idiomas..."))
	For ($iRecords;1;Size of array:C274($aRecNums))
		
		GOTO RECORD:C242([xShell_ExecutableCommands:19];$aRecNums{$iRecords})
		$commandID:=[xShell_ExecutableCommands:19]ID:10
		QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=$commandID;*)
		QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Country_Code:1;=;"cl";*)
		QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Language_Code:2;=;"es")
		$alias:=[xShell_ExecCommands_Localized:232]Alias:3
		$description:=[xShell_ExecCommands_Localized:232]Description:4
		For ($i;1;Size of array:C274($aCountryCodes))
			For ($j;1;Size of array:C274($aLanguageCodes))
				$toCountry:=ST_GetWord ($aCountryCodes{$i};1;":")
				$toLang:=ST_GetWord ($aLanguageCodes{$j};1;":")
				READ WRITE:C146([xShell_ExecCommands_Localized:232])
				QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=$commandID;*)
				QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Country_Code:1;=;$toCountry;*)
				QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Language_Code:2;=;$toLang)
				If (Records in selection:C76([xShell_ExecCommands_Localized:232])=0)
					CREATE RECORD:C68([xShell_ExecCommands_Localized:232])
					[xShell_ExecCommands_Localized:232]ID_ExecCommand:6:=[xShell_ExecutableCommands:19]ID:10
					[xShell_ExecCommands_Localized:232]Country_Code:1:=$toCountry
					[xShell_ExecCommands_Localized:232]Language_Code:2:=$toLang
					[xShell_ExecCommands_Localized:232]Alias:3:=$alias
					[xShell_ExecCommands_Localized:232]Description:4:=$description
					SAVE RECORD:C53([xShell_ExecCommands_Localized:232])
				Else 
					[xShell_ExecCommands_Localized:232]Alias:3:=$alias
					[xShell_ExecCommands_Localized:232]Description:4:=$description
					SAVE RECORD:C53([xShell_ExecCommands_Localized:232])
				End if 
			End for 
		End for 
		READ WRITE:C146([xShell_ExecutableCommands:19])
		GOTO RECORD:C242([xShell_ExecutableCommands:19];$aRecNums{$iRecords})
		If ([xShell_ExecutableCommands:19]Module:3="All Modules")
			[xShell_ExecutableCommands:19]Module:3:="Todos los Módulos"
		End if 
		If ([xShell_ExecutableCommands:19]ID:10=0)
			[xShell_ExecutableCommands:19]ID:10:=SQ_SeqNumber (->[xShell_ExecutableCommands:19]ID:10)
		End if 
		SAVE RECORD:C53([xShell_ExecutableCommands:19])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iRecords/Size of array:C274($aRecNums))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
KRL_UnloadReadOnly (->[xShell_ExecCommands_Localized:232])
CFG_SaveDevelopperConfig 