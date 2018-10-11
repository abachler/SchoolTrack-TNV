//%attributes = {}
  //MNU_Wizards

$configPref:=XS_GetBlobName ("wizard")
$blob:=PREF_fGetBlob (0;$configPref)
SORT ARRAY:C229(atXS_AssistantsItems;atXS_AssistantsMethods)
Case of 
	: (<>vtXS_CountryCode="co")
		$el:=Find in array:C230(atXS_AssistantsItems;"Registro Estudiantes de Chile")
		If ($el>0)
			AT_Delete ($el;1;->atXS_AssistantsItems;->atXS_AssistantsMethods)
		End if 
End case 


WDW_OpenFormWindow (->[xShell_Dialogs:114];"XS_Wizards";-1;5)
DIALOG:C40([xShell_Dialogs:114];"XS_Wizards")
CLOSE WINDOW:C154

If (OK=1)
	KRL_ExecuteMethod (atXS_AssistantsMethods{atXS_AssistantsItems})
End if 
HL_ClearList (hl_Assistants)
