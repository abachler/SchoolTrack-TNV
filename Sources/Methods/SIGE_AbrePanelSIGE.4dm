//%attributes = {}
If (<>gCountryCode="cl")
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"SIGE_panel_de_control";0;4;"SIGE")
	DIALOG:C40([xxSTR_Constants:1];"SIGE_panel_de_control")
	CLOSE WINDOW:C154
Else 
	CD_Dlog (0;"Esta funcionalidad es exclusiva para colegios en Chile debido que opera en conjunto con el Ministerio de Edución")
End if 
