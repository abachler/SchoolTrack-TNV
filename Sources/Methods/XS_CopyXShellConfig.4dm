//%attributes = {"executedOnServer":true}
  //XS_CopyXShellConfig

SET QUERY DESTINATION:C396(Into current selection:K19:1)

C_TEXT:C284($configPref;$wizardPref;$configPref;$modulePrefRef;$prefRef;$NewPanel;$NewConfig;$NewWizards;$NewServices;$NewBrowser;$alias)

ARRAY TEXT:C222($aModules;0)
ARRAY LONGINT:C221($aModuleRefs;0)
LIST TO ARRAY:C288("XS_Modules";$aModules;$aModuleRefs)

$go:=True:C214

Case of 
	: (Count parameters:C259=5)
		$t_lenguajeOrigen:=$5
		$t_paisOrigen:=$4
		$t_lenguajeDestino:=$3
		$t_paisDestino:=$2
		$what:=$1
	: (Count parameters:C259=3)
		$t_lenguajeOrigen:="es"
		$t_paisOrigen:="cl"
		$t_lenguajeDestino:=$3
		$t_paisDestino:=$2
		$what:=$1
	Else 
		$go:=False:C215
End case 

If ($go)
	Case of 
		: ($what="lists")
			$CopyBlobs:=False:C215
			$CopyFields:=False:C215
			$CopyCommands:=False:C215
			$CopyRSRList:=True:C214
			$CopyRSRSTR:=False:C215
			$CopyRSRText:=False:C215
		: ($what="strs")
			$CopyBlobs:=False:C215
			$CopyFields:=False:C215
			$CopyCommands:=False:C215
			$CopyRSRList:=False:C215
			$CopyRSRSTR:=True:C214
			$CopyRSRText:=False:C215
		: ($what="texts")
			$CopyBlobs:=False:C215
			$CopyFields:=False:C215
			$CopyCommands:=False:C215
			$CopyRSRList:=False:C215
			$CopyRSRSTR:=False:C215
			$CopyRSRText:=True:C214
		: ($what="commands")
			$CopyBlobs:=False:C215
			$CopyFields:=False:C215
			$CopyCommands:=True:C214
			$CopyRSRList:=False:C215
			$CopyRSRSTR:=False:C215
			$CopyRSRText:=False:C215
		: ($what="blobs")
			$CopyBlobs:=True:C214
			$CopyFields:=False:C215
			$CopyCommands:=False:C215
			$CopyRSRList:=False:C215
			$CopyRSRSTR:=False:C215
			$CopyRSRText:=False:C215
		: ($what="fields")
			$CopyBlobs:=False:C215
			$CopyFields:=True:C214
			$CopyCommands:=False:C215
			$CopyRSRList:=False:C215
			$CopyRSRSTR:=False:C215
			$CopyRSRText:=False:C215
		: ($what="all")
			$CopyBlobs:=True:C214
			$CopyFields:=True:C214
			$CopyCommands:=True:C214
			$CopyRSRList:=True:C214
			$CopyRSRSTR:=True:C214
			$CopyRSRText:=True:C214
		Else 
			$CopyBlobs:=True:C214
			$CopyFields:=True:C214
			$CopyCommands:=True:C214
			$CopyRSRList:=True:C214
			$CopyRSRSTR:=True:C214
			$CopyRSRText:=True:C214
	End case 
	
	$p:=IT_UThermometer (1;0;"Copiando configuración local ("+$what+") "+$t_paisOrigen+"-"+$t_lenguajeOrigen+" a "+$t_paisDestino+"-"+$t_lenguajeDestino)
	If ($CopyBlobs)
		C_BLOB:C604($OriginalconfigBlob;$OriginalWizardBlob;$OriginalServicesBlob;$OriginalBrowserBlob;$OriginalPanel;$OriginalTablesBlob)
		
		For ($r;1;Size of array:C274($aModules))
			$configPref:=XS_GetBlobName ("config";$aModuleRefs{$r};$t_paisOrigen;$t_lenguajeOrigen)
			$OriginalconfigBlob:=PREF_fGetBlob (0;$configPref)
			$wizardPref:=XS_GetBlobName ("wizard";$aModuleRefs{$r};$t_paisOrigen;$t_lenguajeOrigen)
			$OriginalWizardBlob:=PREF_fGetBlob (0;$wizardPref)
			$configPref:=XS_GetBlobName ("service";$aModuleRefs{$r};$t_paisOrigen;$t_lenguajeOrigen)
			$OriginalServicesBlob:=PREF_fGetBlob (0;$configPref)
			$modulePrefRef:=XS_GetBlobName ("browser";$aModuleRefs{$r};$t_paisOrigen;$t_lenguajeOrigen)
			$OriginalBrowserBlob:=PREF_fGetBlob (0;$modulePrefRef)
			$tablesPref:=XS_GetBlobName ("tables";$aModuleRefs{$r};$t_paisOrigen;$t_lenguajeOrigen)
			$OriginalTablesBlob:=PREF_fGetBlob (0;$tablesPref)
			$listRef:=BLOB to list:C557($OriginalBrowserBlob)
			For ($f;1;Count list items:C380($listRef))
				SELECT LIST ITEMS BY POSITION:C381($listRef;$f)
				GET LIST ITEM:C378($listRef;Selected list items:C379($listRef);$PanelRef;$tableName)
				$prefRef:=XS_GetBlobName ("panel";$aModuleRefs{$r};$t_paisOrigen;$t_lenguajeOrigen;$PanelRef)
				$OriginalPanel:=PREF_fGetBlob (0;$prefRef)
				$NewPanel:=XS_GetBlobName ("panel";$aModuleRefs{$r};$t_paisDestino;$t_lenguajeDestino;$PanelRef)
				PREF_SetBlob (0;$NewPanel;$OriginalPanel)
				SET BLOB SIZE:C606($OriginalPanel;0)
			End for 
			$NewConfig:=XS_GetBlobName ("config";$aModuleRefs{$r};$t_paisDestino;$t_lenguajeDestino)
			PREF_SetBlob (0;$NewConfig;$OriginalconfigBlob)
			
			$NewWizards:=XS_GetBlobName ("wizard";$aModuleRefs{$r};$t_paisDestino;$t_lenguajeDestino)
			PREF_SetBlob (0;$NewWizards;$OriginalWizardBlob)
			
			$NewServices:=XS_GetBlobName ("service";$aModuleRefs{$r};$t_paisDestino;$t_lenguajeDestino)
			PREF_SetBlob (0;$NewServices;$OriginalServicesBlob)
			
			$NewBrowser:=XS_GetBlobName ("browser";$aModuleRefs{$r};$t_paisDestino;$t_lenguajeDestino)
			PREF_SetBlob (0;$NewBrowser;$OriginalBrowserBlob)
			
			$NewTables:=XS_GetBlobName ("tables";$aModuleRefs{$r};$t_paisDestino;$t_lenguajeDestino)
			PREF_SetBlob (0;$NewTables;$OriginalTablesBlob)
			
			SET BLOB SIZE:C606($OriginalconfigBlob;0)
			SET BLOB SIZE:C606($OriginalWizardBlob;0)
			SET BLOB SIZE:C606($OriginalServicesBlob;0)
			SET BLOB SIZE:C606($OriginalBrowserBlob;0)
			SET BLOB SIZE:C606($OriginalTablesBlob;0)
		End for 
	End if 
	
	
	
	If ($CopyFields)
		READ ONLY:C145([xShell_Tables:51])
		READ WRITE:C146([xShell_TableAlias:199])
		ALL RECORDS:C47([xShell_Tables:51])
		ARRAY LONGINT:C221($al_RecNumsTables;0)
		LONGINT ARRAY FROM SELECTION:C647([xShell_Tables:51];$al_RecNumsTables;"")
		For ($i_tables;1;Size of array:C274($al_RecNumsTables))
			GOTO RECORD:C242([xShell_Tables:51];$al_RecNumsTables{$i_tables})
			$t_referenciaTableOrigen:=String:C10([xShell_Tables:51]NumeroDeTabla:5)+"."+$t_paisOrigen+"."+$t_lenguajeOrigen
			$l_recNumAlias:=KRL_FindAndLoadRecordByIndex (->[xShell_TableAlias:199]TableRef:1;->$t_referenciaTableOrigen;False:C215)
			If ($l_recNumAlias>=0)
				XSvs_ActualizaLocalizacionTabla ($al_RecNumsTables{$i_tables};$t_paisDestino;$t_lenguajeDestino;[xShell_Tables:51]Alias:7)
			End if 
		End for 
		
		
		
		
		READ ONLY:C145([xShell_Fields:52])
		ALL RECORDS:C47([xShell_Fields:52])
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([xShell_Fields:52];$aRecNumFields;"")
		For ($i_Fields;1;Size of array:C274($aRecNumFields))
			GOTO RECORD:C242([xShell_Fields:52];$aRecNumFields{$i_Fields})
			$t_referenciaCampoOrigen:=String:C10([xShell_Fields:52]NumeroTabla:1)+"."+String:C10([xShell_Fields:52]NumeroCampo:2)+"."+$t_paisOrigen+"."+$t_lenguajeOrigen
			$l_recNumAlias:=KRL_FindAndLoadRecordByIndex (->[xShell_FieldAlias:198]FieldRef:5;->$t_referenciaCampoOrigen;False:C215)
			If ($l_recNumAlias>=0)
				XSvs_ActualizaLocalizacionCampo ($aRecNumFields{$i_Fields};$t_paisDestino;$t_lenguajeDestino;[xShell_FieldAlias:198]Alias:3)
			End if 
		End for 
	End if 
	
	
	
	
	If ($CopyCommands)
		ALL RECORDS:C47([xShell_ExecutableCommands:19])
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([xShell_ExecutableCommands:19];$aRecNums;"")
		For ($i;1;Size of array:C274($aRecNums))
			READ ONLY:C145([xShell_ExecutableCommands:19])
			GOTO RECORD:C242([xShell_ExecutableCommands:19];$aRecNums{$i})
			
			READ ONLY:C145([xShell_ExecCommands_Localized:232])
			QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=[xShell_ExecutableCommands:19]ID:10;*)
			QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Country_Code:1;=;$t_paisOrigen;*)
			QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Language_Code:2;=;$t_lenguajeOrigen)
			$alias:=[xShell_ExecCommands_Localized:232]Alias:3
			$description:=[xShell_ExecCommands_Localized:232]Description:4
			
			READ WRITE:C146([xShell_ExecCommands_Localized:232])
			QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=[xShell_ExecutableCommands:19]ID:10;*)
			QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Country_Code:1;=;$t_paisDestino;*)
			QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Language_Code:2;=;$t_lenguajeDestino)
			If (Records in selection:C76([xShell_ExecCommands_Localized:232])=0)
				CREATE RECORD:C68([xShell_ExecCommands_Localized:232])
				[xShell_ExecCommands_Localized:232]ID_ExecCommand:6:=[xShell_ExecutableCommands:19]ID:10
				[xShell_ExecCommands_Localized:232]Country_Code:1:=$t_paisDestino
				[xShell_ExecCommands_Localized:232]Language_Code:2:=$t_lenguajeDestino
				[xShell_ExecCommands_Localized:232]Alias:3:=$alias
				[xShell_ExecCommands_Localized:232]Description:4:=$description
				SAVE RECORD:C53([xShell_ExecCommands_Localized:232])
			Else 
				[xShell_ExecCommands_Localized:232]Alias:3:=$alias
				[xShell_ExecCommands_Localized:232]Description:4:=$description
				SAVE RECORD:C53([xShell_ExecCommands_Localized:232])
			End if 
		End for 
		
		QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]CountryCode:6;=;$t_paisOrigen;*)
		QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=;$t_lenguajeOrigen)
		LONGINT ARRAY FROM SELECTION:C647([XShell_ExecutableObjects:280];$aRecNums;"")
		For ($i;1;Size of array:C274($aRecNums))
			READ ONLY:C145([XShell_ExecutableObjects:280])
			GOTO RECORD:C242([XShell_ExecutableObjects:280];$aRecNums{$i})
			QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13;=[XShell_ExecutableObjects:280]Object_ID:13;*)
			QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=;$t_paisDestino;*)
			QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=;$t_lenguajeDestino)
			If (Records in selection:C76([XShell_ExecutableObjects:280])=0)
				GOTO RECORD:C242([XShell_ExecutableObjects:280];$aRecNums{$i})
				READ WRITE:C146([XShell_ExecutableObjects:280])
				DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
				[XShell_ExecutableObjects:280]CountryCode:6:=$t_paisDestino
				[XShell_ExecutableObjects:280]LangageCode:7:=$t_lenguajeDestino
				SAVE RECORD:C53([XShell_ExecutableObjects:280])
			End if 
		End for 
	End if 
	
	IT_UThermometer (-2;$p)
End if 