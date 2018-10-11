//%attributes = {}
  //MNU_APP_Configuration
  //abachler
  // 21/5/03
  // purpose: Trae el diálogo de preferencias que se configure para la aplicacion


If (False:C215)
	<>xShellModificationDate:=!1903-05-21!
	  // 
End if 

C_LONGINT:C283($styles;$pictureID;hl_configuration;$icon)
C_PICTURE:C286(vpXS_Config1;vpXS_Config2;vpXS_Config3;vpXS_Config4;vpXS_Config5;vpXS_Config6;vpXS_Config7;vpXS_Config8;vpXS_Config9;vpXS_Config10;vpXS_Config11;vpXS_Config12;vpXS_Config13;vpXS_Config14;vpXS_Config15;vpXS_Config16;vpXS_Config17;vpXS_Config18;vpXS_Config19;vpXS_Config20;vpXS_Config21;vpXS_Config22;vpXS_Config23;vpXS_Config24;vpXS_Config25;vpXS_Config26;vpXS_Config27;vpXS_Config28)
C_TEXT:C284(vtXS_Config1;vtXS_Config2;vtXS_Config3;vtXS_Config4;vtXS_Config5;vtXS_Config6;vtXS_Config7;vtXS_Config8;vtXS_Config9;vtXS_Config10;vtXS_Config11;vtXS_Config12;vtXS_Config13;vtXS_Config14;vtXS_Config15;vtXS_Config16;vtXS_Config17;vtXS_Config18;vtXS_Config19;vtXS_Config20;vtXS_Config21;vtXS_Config22;vtXS_Config23;vtXS_Config24;vtXS_Config25;vtXS_Config26;vtXS_Config27;vtXS_Config28)
C_LONGINT:C283(bCFG_Panel1;bCFG_Panel2;bCFG_Panel3;bCFG_Panel4;bCFG_Panel5;bCFG_Panel6;bCFG_Panel7;bCFG_Panel8;bCFG_Panel9;bCFG_Panel10;bCFG_Panel11;bCFG_Panel12;bCFG_Panel13;bCFG_Panel14;bCFG_Panel15;bCFG_Panel16;bCFG_Panel17;bCFG_Panel18;bCFG_Panel19;bCFG_Panel20;bCFG_Panel21;bCFG_Panel22;bCFG_Panel23;bCFG_Panel24;bCFG_Panel25;bCFG_Panel26;bCFG_Panel27;bCFG_Panel28)
ARRAY TEXT:C222(atXS_ConfigMethods;0)
C_BOOLEAN:C305($enterable)

If ((Macintosh option down:C545 | Windows Alt down:C563) & (Shift down:C543) & (Macintosh command down:C546 | Windows Ctrl down:C562))
	If ((<>lUSR_CurrentUserID<0) & (<>lUSR_CurrentUserID>-99))
		XS_Settings 
		UFLD_LoadFileTplt (yBWR_currentTable)
		BWR_PanelSettings 
		USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
	Else 
		CD_Dlog (0;__ ("disable button(bEnter)"))
	End if 
Else 
	
	
	dhCFG_OnOpenConfig 
	$title:=__ ("Configuración de ")+vsBWR_CurrentModule
	FORM GET PROPERTIES:C674([xShell_Dialogs:114];"XS_PreferencePanel";$width;$height)
	WDW_OpenFormWindow (->[xShell_Dialogs:114];"XS_PreferencePanel";-1;4;$title)
	DIALOG:C40([xShell_Dialogs:114];"XS_PreferencePanel")
	CLOSE WINDOW:C154
	CLEAR LIST:C377(hl_configuration)
	FLUSH CACHE:C297
	SET_UseSet ("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	BWR_SelectTableData 
	dhCFG_OnCloseConfig 
	BWR_SetMenuBar 
	vlSTR_Periodos_CurrentRef:=0
	
End if 

