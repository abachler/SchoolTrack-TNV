//%attributes = {}
  //XS_VerifyCommandsTranslation





$commandRN:=$1

If ((Record number:C243([xShell_ExecutableCommands:19])#$commandRN) | (Read only state:C362([xShell_ExecutableCommands:19])))
	READ WRITE:C146([xShell_ExecutableCommands:19])
	GOTO RECORD:C242([xShell_ExecutableCommands:19];$commandRN)
End if 
QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=;[xShell_ExecutableCommands:19]ID:10;*)
QUERY:C277([xShell_ExecCommands_Localized:232]; & [xShell_ExecCommands_Localized:232]Country_Code:1;=;"cl";*)
QUERY:C277([xShell_ExecCommands_Localized:232]; & [xShell_ExecCommands_Localized:232]Language_Code:2;=;"es")
$alias:=[xShell_ExecCommands_Localized:232]Alias:3
$description:=[xShell_ExecCommands_Localized:232]Description:4
ARRAY TEXT:C222($aCountryCodes;0)
ARRAY TEXT:C222($aLanguageCodes;0)
LIST TO ARRAY:C288("XS_CountryCodes";$aCountryCodes)
LIST TO ARRAY:C288("XS_LangageCodes";$aLanguageCodes)
For ($i;1;Size of array:C274($aCountryCodes))
	$country:=ST_GetWord ($aCountryCodes{$i};1;":")
	For ($j;1;Size of array:C274($aLanguageCodes))
		$langage:=ST_GetWord ($aLanguageCodes{$j};1;":")
		QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=;[xShell_ExecutableCommands:19]ID:10;*)
		QUERY:C277([xShell_ExecCommands_Localized:232]; & [xShell_ExecCommands_Localized:232]Country_Code:1;=;$country;*)
		QUERY:C277([xShell_ExecCommands_Localized:232]; & [xShell_ExecCommands_Localized:232]Language_Code:2;=;$langage)
		
		Case of 
			: (Records in selection:C76([xShell_ExecCommands_Localized:232])=0)
				CREATE RECORD:C68([xShell_ExecCommands_Localized:232])
				[xShell_ExecCommands_Localized:232]Country_Code:1:=$country
				[xShell_ExecCommands_Localized:232]Language_Code:2:=$langage
				[xShell_ExecCommands_Localized:232]Alias:3:=$alias
				[xShell_ExecCommands_Localized:232]Description:4:=$description
				[xShell_ExecCommands_Localized:232]ID_ExecCommand:6:=[xShell_ExecutableCommands:19]ID:10
			Else 
				If ([xShell_ExecCommands_Localized:232]Alias:3="")
					[xShell_ExecCommands_Localized:232]Alias:3:=$alias
				End if 
				If ([xShell_ExecCommands_Localized:232]Description:4="")
					[xShell_ExecCommands_Localized:232]Description:4:=$description
				End if 
		End case 
		SAVE RECORD:C53([xShell_ExecCommands_Localized:232])
	End for 
End for 

KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
KRL_UnloadReadOnly (->[xShell_ExecCommands_Localized:232])