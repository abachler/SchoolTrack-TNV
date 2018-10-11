Case of 
	: (Form event:C388=On Load:K2:1)
		BWR_NotificationMailboxStatus 
		
		
		<>vb_SetPlatForm:=False:C215
		XS_SetInterface 
		ALP_SetInterface (xALP_Browser)
		
		  //LOC_SetLanguage  
		dhBWR_LoadLists 
		WDW_AddRemoveWindow ("Add";Frontmost window:C447;"Explorador "+vsBWR_CurrentModule)
		BWR_InitArrays 
		ARRAY LONGINT:C221(abrSelect;0)
		idMenu:=0
		brLastDim:=0
		vLocation:="Browser"
		
		HL_ClearList (vlXS_BrowserTab)
		$modulePrefRef:=XS_GetBlobName ("browser";vlBWR_CurrentModuleRef;<>vtXS_CountryCode;<>vtXS_langage)
		$blob:=PREF_fGetBlob (0;$modulePrefRef;$blob)
		If (BLOB size:C605($blob)>0)
			vlXS_BrowserTab:=BLOB to list:C557($blob)
			SELECT LIST ITEMS BY POSITION:C381(vlXS_BrowserTab;1)
			GET LIST ITEM:C378(vlXS_BrowserTab;1;$itemRef;$itemText)
			BWR_GetPanelSettings (vlBWR_CurrentModuleRef;$itemRef)
		Else 
			vlXS_BrowserTab:=0
			<>vtDEV_ToDo:="Manejar Error"
		End if 
		
		vlBWR_SelectedTableRef:=0
		vsBWR_selectedTableName:=""
		$countListItems:=Count list items:C380(vlXS_BrowserTab)
		$tieneDerechos:=False:C215
		For ($i;1;$countListItems)
			GET LIST ITEM:C378(vlXS_BrowserTab;$i;$itemRef;$itemText)
			If (USR_checkRights ("L";Table:C252($itemRef)))
				If (vlBWR_SelectedTableRef=0)
					vlBWR_SelectedTableRef:=$itemRef
					vsBWR_selectedTableName:=$itemText
				End if 
				SET LIST ITEM PROPERTIES:C386(vlXS_BrowserTab;$itemRef;True:C214;0;0)
				$tieneDerechos:=True:C214
				  //$i:=$countListItems RCH 20100311 Si el alumno no tiene derechos en Familia y si en Alumnos se habilitaban todas las pestañas.
			Else 
				SET LIST ITEM PROPERTIES:C386(vlXS_BrowserTab;$itemRef;False:C215;0;0)
			End if 
		End for 
		
		
		If ($tieneDerechos)
			vb_RecordInInputForm:=False:C215
			yBWR_currentTable:=Table:C252(vlBWR_SelectedTableRef)
			REDUCE SELECTION:C351(yBWR_currentTable->;0)
			dhBWR_OnBrowserLoad 
			BWR_ClearSets   //clearing sets
			BWR_PanelSettings 
			BWR_SelectTableData 
			$iconCounter:=PLT_LoadIcons 
			PLT_AdjustBrowserSize ($iconCounter)
			<>vlXS_CurrentModuleRef:=vlBWR_CurrentModuleRef
			<>vsXS_CurrentModule:=vsBWR_CurrentModule
			GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)  //JHB por si se pierde el icono...
			GET PICTURE FROM LIBRARY:C565("Config_Back_"+vsBWR_CurrentModule;vp_ModuleIconBack)
			vlBWR_BrowsingMethod:=BWR Standard Browsing
		Else 
			$ignore:=CD_Dlog (0;__ ("Usted no tiene derechos para utilizar ninguna función de este módulo.\rPor favor consulte con el administrador."))
			$closeSesion:=True:C214
			For ($i;1;Size of array:C274(<>alXS_ModuleProcessID))
				If ((<>alXS_ModuleProcessID{$i}>0) & (<>alXS_ModuleProcessID{$i}#Current process:C322))
					$closeSesion:=False:C215
					$processNumber:=<>alXS_ModuleProcessID{$i}
				End if 
			End for 
			
			If ($closeSesion)
				XS_CloseSesion 
			Else 
				dhXS_CloseChildProcess 
				BRING TO FRONT:C326($processNumber)
				PCS_UnRegisterProcess (Current process:C322)
				$position:=Find in array:C230(<>alXS_ModuleRef;vlBWR_currentModuleRef)
				<>alXS_ModuleProcessID{$Position}:=0
				CANCEL:C270
			End if 
		End if 
		
		  //20140404 RCH Se lee lenguaje para setear el diccionario
		STR_SeteaDiccionario (<>vl_Langage)
		
	: ((Form event:C388=On Activate:K2:9) & (Not:C34(Form event:C388=On Load:K2:1)))
		If (Not:C34(Is a list:C621(vlXS_BrowserTab)))
			$modulePrefRef:=XS_GetBlobName ("browser";vlBWR_CurrentModuleRef;<>vtXS_CountryCode;<>vtXS_langage)
			$blob:=PREF_fGetBlob (0;$modulePrefRef;$blob)
			If (BLOB size:C605($blob)>0)
				vlXS_BrowserTab:=BLOB to list:C557($blob)
				BWR_GetPanelSettings (vlBWR_CurrentModuleRef;1)
			Else 
				vlXS_BrowserTab:=0
				<>vtDEV_ToDo:="Manejar Error"
			End if 
		End if 
		XS_SetInterface 
		ALP_SetInterface (xALP_Browser)
		
		
		PREF_Set (<>lUSR_CurrentUserID;"lastModule";String:C10(vlBWR_CurrentModuleRef))
		<>vlXS_CurrentModuleRef:=vlBWR_CurrentModuleRef
		<>vsXS_CurrentModule:=vsBWR_CurrentModule
		GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)  //JHB por si se pierde el icono... 
		GET PICTURE FROM LIBRARY:C565("Config_Back_"+vsBWR_CurrentModule;vp_ModuleIconBack)
		
		  //Selected list items(vlXS_BrowserTab) retornaba 0 y daba error porque la variable yBWR_currentTable quedaba indefinida
		If (Selected list items:C379(vlXS_BrowserTab)=0)
			$selectedItem:=1
		Else 
			$selectedItem:=Selected list items:C379(vlXS_BrowserTab)
		End if 
		GET LIST ITEM:C378(vlXS_BrowserTab;$selectedItem;vlBWR_SelectedTableRef;$tableName)
		
		yBWR_currentTable:=Table:C252(vlBWR_SelectedTableRef)
		vLocation:="Browser"
		BWR_SetWindowTitle 
		BWR_SetInterfaceObjects 
		
		BWR_SetMenuBar 
		dhBWR_OnActivate 
	: (Form event:C388=On Menu Selected:K2:14)
		C_TEXT:C284($subMenu)
		$refSubMenu:=Menu selected:C152($subMenu)
		$menu:=Menu selected:C152\65536
		$item:=Menu selected:C152%65536
		BWR_BrowserMenuHandler ($menu;$item;$subMenu)
		
	: (Form event:C388=On Outside Call:K2:11)
		  //ABK 20120616: retiro de llamados a cambios de interfaz ya que solo está disponible en el login
		  //XS_SetInterface 
		  //ALP_SetInterface (xALP_Browser)
		  //ALP_SetFontThemeAttr  
		Case of 
			: (<>vt_CloseSesion)
				dhXS_CloseChildProcess 
				AL_SetSort (xALP_Browser;0)
				AL_RemoveArrays (xALP_Browser;1;brLastDim)
				AL_RemoveFields (xALP_Browser;1;brLastDim)
				For ($i;1;Count tables)
					REDUCE SELECTION:C351(Table:C252($i)->;0)
					SET_ClearSets ("$RecordSet_Table"+String:C10($i))
				End for 
				$position:=Find in array:C230(<>alXS_ModuleRef;vlBWR_currentModuleRef)
				<>alXS_ModuleProcessID{$Position}:=0
				CANCEL:C270
				
				
			: ((<>vt_IPMsg_Message="ShowList") & (<>vl_IPMsg_Tab2Select>0) & (<>vlXS_CurrentModuleRef=1))
				yBWR_currentTable:=Table:C252(<>vl_IPMsg_Tab2Select)
				SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;Table:C252(yBWR_currentTable))
				GET LIST ITEM:C378(vlXS_BrowserTab;*;vlBWR_SelectedTableRef;vsBWR_selectedTableName)
				
				ARRAY TEXT:C222($at_Asignaturas;0)
				ARRAY LONGINT:C221($al_recNumAsignaturas;0)
				HL_CopyReferencedListToArray (<>hl_avgDiff_Asignaturas;->$at_Asignaturas;->$al_recNumAsignaturas)
				CREATE SET FROM ARRAY:C641(yBWR_currentTable->;$al_recNumAsignaturas;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
				BWR_PanelSettings 
				BWR_SelectTableData 
				<>vt_IPMsg_Message:=""
				<>vl_IPMsg_Tab2Select:=0
				
			: ((<>vt_IPMsg_Message="OpenRecord") & (<>vl_IPMsg_OpenRecNum>=0) & (<>vl_IPMsg_Tab2Select>0) & (<>vlXS_CurrentModuleRef=1))
				yBWR_currentTable:=Table:C252(<>vl_IPMsg_Tab2Select)
				SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;Table:C252(yBWR_currentTable))
				GET LIST ITEM:C378(vlXS_BrowserTab;*;vlBWR_SelectedTableRef;vsBWR_selectedTableName)
				$tableSet:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				If (Records in set:C195($tableSet)=0)
					CREATE EMPTY SET:C140(yBWR_currentTable->;$tableSet)
				End if 
				KRL_GotoRecord (yBWR_currentTable;<>vl_IPMsg_OpenRecNum)
				ADD TO SET:C119(yBWR_currentTable->;$tableSet)
				BWR_PanelSettings 
				BWR_SelectTableData 
				BWR_SetWindowTitle 
				$el:=Find in array:C230(alBWR_recordNumber;<>vl_IPMsg_OpenRecNum)
				If ($el>0)
					ARRAY LONGINT:C221(abrSelect;1)
					abrSelect{1}:=$el
					AL_SetSelect (xALP_Browser;abrSelect)
					vlSTR_PaginaFormAsignaturas:=3
					vb_ComparacionPromedios:=True:C214
					BWR_OpenRecord 
					vb_ComparacionPromedios:=False:C215
				End if 
				
				<>vl_IPMsg_OpenRecNum:=-1
				<>vl_IPMsg_Tab2Select:=0
				<>vt_IPMsg_Message:=""
				
			Else 
				BWR_ProcessIPmsg 
				
				
		End case 
		
	: (Form event:C388=On Unload:K2:2)
		AL_SetSort (xALP_Browser;0)
		AL_RemoveArrays (xALP_Browser;1;brLastDim)
		AL_RemoveFields (xALP_Browser;1;brLastDim)
		
	: (Form event:C388=On Close Box:K2:21)
		$closeSesion:=True:C214
		For ($i;1;Size of array:C274(<>alXS_ModuleProcessID))
			If ((<>alXS_ModuleProcessID{$i}>0) & (<>alXS_ModuleProcessID{$i}#Current process:C322))
				$closeSesion:=False:C215
				$processNumber:=<>alXS_ModuleProcessID{$i}
			End if 
		End for 
		
		If (Application version:C493>="11@")
			For ($i;1;vlMNU_ModuleReferencedMenus)
				RELEASE MENU:C978(atMNU_ModuleReferencesMenus{$i})
			End for 
		End if 
		
		If ($closeSesion)
			XS_CloseSesion 
		Else 
			dhXS_CloseChildProcess 
			BRING TO FRONT:C326($processNumber)
			PCS_UnRegisterProcess (Current process:C322)
			$position:=Find in array:C230(<>alXS_ModuleRef;vlBWR_currentModuleRef)
			<>alXS_ModuleProcessID{$Position}:=0
			
			  //20120827 RCH Se registra cierre de sesion de modulo
			LOG_RegisterEvt ("Cierre de sesión de módulo.")
			
			CANCEL:C270
		End if 
End case 