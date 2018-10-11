//%attributes = {}
  //XS_Settings

C_TEXT:C284($1;$message;$Title;$2)
C_BOOLEAN:C305($fwidth;$fheight;$indexed;$invisible;$unique)
C_LONGINT:C283($tableNumbers;$relatedTableNumber;$pages;$length;$oneTable;$oneField;$choiceField;hl_RelatedFields;hl_moduleTables;hl_AllTables;hl_Modules;hl_Wizards;$iconRef)
C_BLOB:C604($blob)
C_TEXT:C284(vtBWR_OnLoadMethod;vtBWR_OnClickMethod;vtBWR_OnDClickMethod;vtBWR_OnRClickMethod;vtVS_FieldFormat;vtBWR_sortOrder;vtBWR_OnEClickMethod;vtBWR_OnEDClickMethod;vtBWR_OnERClickMethod;vtBWR_OnHRClickMethod)
C_LONGINT:C283(viBWR_LockColumns;viBWR_HiddenColumns)


If (Count parameters:C259>0)
	$message:=$1
Else 
	$message:=""
End if 
Case of 
	: ($message="")
		VS_buildTableList 
		MNU_SetMenuBar ("XS_Settings")
		MNU_SetMenuItemState (False:C215;2;11;2;12;2;13;2;14;2;16;2;17)
		XS_Settings ("Initialize")
		
		<>vt_ApplicationSignature:=XS_GetApplicationInfo (1)
		<>vtXS_AppName:=XS_GetApplicationInfo (1)
		
		START TRANSACTION:C239
		$wRef:=WDW_OpenFormWindow (->[xShell_Dialogs:114];"XS_Settings";0;8)
		FORM SET INPUT:C55([xShell_Dialogs:114];"XS_Settings")
		If (Records in table:C83([xShell_Dialogs:114])=0)
			ADD RECORD:C56([xShell_Dialogs:114];*)
		Else 
			READ WRITE:C146([xShell_Dialogs:114])
			ALL RECORDS:C47([xShell_Dialogs:114])
			FIRST RECORD:C50([xShell_Dialogs:114])
			MODIFY RECORD:C57([xShell_Dialogs:114];*)
			KRL_UnloadReadOnly (->[xShell_Dialogs:114])
		End if 
		CLOSE WINDOW:C154
		
		If (ok=1)
			VALIDATE TRANSACTION:C240
			SAVE LIST:C384(hl_Paises;"XS_CountryCodes")
			SAVE LIST:C384(hl_langages;"XS_LangageCodes")
			FLUSH CACHE:C297
			XS_Settings ("SaveModuleExecutables")
			CFG_SaveDevelopperConfig 
			
			PREF_Set (0;"VirtualStructureDefined";"1")
		Else 
			CANCEL TRANSACTION:C241
			SAVE LIST:C384(hl_DesignersBackup;"XS_Designers")
		End if 
		
		READ ONLY:C145([xShell_Tables:51])
		READ ONLY:C145([xShell_Fields:52])
		XS_Settings ("ClearMemory")
		
		If (vlBWR_CurrentModuleRef#0)
			MNU_LoadModuleMenus 
		End if 
		
	: ($message="Initialize")
		vtVS_FieldHeader:=""
		vtVS_FieldFormat:=""
		viVS_QFPosition:=0
		viBWR_LockColumns:=0
		vtBWR_sortOrder:=""
		
		ARRAY INTEGER:C220(alVS_TableNumber;0)
		ARRAY INTEGER:C220(alVS_FieldNumber;0)
		ARRAY INTEGER:C220(alVS_BrowserPosition;0)
		ARRAY TEXT:C222(atVS_Header;0)
		ARRAY TEXT:C222(atVS_FieldNames;0)
		ARRAY TEXT:C222(atVS_BrowserFormat;0)
		ARRAY INTEGER:C220(alVS_ColumnWidth;0)
		
		ARRAY LONGINT:C221(alVS_QFSourceTableNumber;0)
		ARRAY LONGINT:C221(alVS_QFSourceFieldNumber;0)
		ARRAY LONGINT:C221(alVS_QFRelateFromField;0)
		ARRAY LONGINT:C221(alVS_QFRelateToFieldNumber;0)
		ARRAY TEXT:C222(atVS_QFSourceFieldAlias;0)
		ARRAY TEXT:C222(atVS_QFSpecialRelationMethod;0)
		ARRAY INTEGER:C220(aiVS_QFSourceFieldOrder;0)
		
		ARRAY TEXT:C222(atXS_Methods_Module;0)
		ARRAY TEXT:C222(atXS_Methods_Alias;0)
		ARRAY TEXT:C222(atXS_Methods_Name;0)
		ARRAY BOOLEAN:C223(abXS_Methods_Executable;0)
		ARRAY BOOLEAN:C223(abXS_Methods_AuthRequired;0)
		ARRAY BOOLEAN:C223(abXS_Methods_ExecOnClient;0)
		ARRAY LONGINT:C221(alXS_Methods_ID;0)
		ARRAY LONGINT:C221(alXS_Methods_RecNum;0)
		ARRAY TEXT:C222(atXS_Methods_Description;0)
		ARRAY LONGINT:C221(alXS_MethodsRecID;0)
		
		
		ARRAY TEXT:C222(atVS_TableRelations;4)
		atVS_TableRelations{1}:="Sólo Campos de la Tabla"
		atVS_TableRelations{2}:="Campos Relacionados Uno a Uno"
		atVS_TableRelations{3}:="Campos Relacionados Muchos a Uno"
		atVS_TableRelations{4}:="Todos los Campos (Relaciones Suaves)"
		atVS_TableRelations:=1
		
		hl_moduleTables:=New list:C375
		hl_PanelColumns:=New list:C375
		hl_QuickFindFields:=New list:C375
		hl_ModulePanels:=New list:C375
		hl_AllTables:=New list:C375
		hl_RelatedFields:=New list:C375
		hl_RestrictedMethods:=New list:C375
		hl_Designers:=Load list:C383("XS_Designers")
		hl_DesignersBackup:=Load list:C383("XS_Designers")
		
		  // setting xALP_MethodProperties area 
		
		
		  // loading all tables
		QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NombreDeTabla:1#"xShell_@";*)
		QUERY:C277([xShell_Tables:51]; & ;[xShell_Tables:51]NombreDeTabla:1#"xx@";*)
		QUERY:C277([xShell_Tables:51]; & ;[xShell_Tables:51]NombreDeTabla:1#"REGEX@";*)
		QUERY:C277([xShell_Tables:51]; & ;[xShell_Tables:51]NombreDeTabla:1#"zz@")
		SELECTION TO ARRAY:C260([xShell_Tables:51]NombreDeTabla:1;$at_tableName;[xShell_Tables:51]NumeroDeTabla:5;$al_tableNumbers;[xShell_Tables:51]ReferenciaModulo:36;$al_moduleRef)
		For ($i;1;Size of array:C274($at_tableName))
			APPEND TO LIST:C376(hl_AllTables;$at_tableName{$i};$al_tableNumbers{$i})
			If ($al_moduleRef{$i}>0)
				SET LIST ITEM PROPERTIES:C386(hl_AllTables;$al_tableNumbers{$i};False:C215;2;0)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_AllTables;$al_tableNumbers{$i};False:C215;0;0)
			End if 
		End for 
		SORT LIST:C391(hl_AllTables;>)
		
		SET LIST PROPERTIES:C387(hl_moduleTables;1;0;16)
		SET LIST PROPERTIES:C387(hl_AllTables;1;0;16)
		
	: ($message="HandleDrag")
		$dropDestination:=$2
		DRAG AND DROP PROPERTIES:C607($srcObject;$srcElement;$srcProcess)
		RESOLVE POINTER:C394($srcObject;$varName;$tableNum;$fieldNum)
		RESOLVE POINTER:C394(Focus object:C278;$dragSource;$tableNum;$fieldNum)
		$position:=Drop position:C608
		If ($position=-1)
			$position:=Size of array:C274(alvs_TableNumber)+1
		End if 
		Case of 
			: (($varName="hl_ModuleTables") & ($dropDestination="hl_modulePanels"))
				GET LIST ITEM:C378(hl_ModuleTables;$srcElement;$tableRef;$tableName)
				If (List item position:C629(hl_modulePanels;$tableRef)=0)
					$items:=Count list items:C380(hl_modulePanels)
					If ($position>$items)
						APPEND TO LIST:C376(hl_modulePanels;$tableName;$tableRef)
					Else 
						SELECT LIST ITEMS BY POSITION:C381(hl_modulePanels;$position)
						INSERT IN LIST:C625(hl_modulePanels;*;$tableName;$tableRef)
					End if 
					_O_REDRAW LIST:C382(hl_modulePanels)
					SELECT LIST ITEMS BY REFERENCE:C630(hl_modulePanels;$tableRef)
					GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$itemText)
					GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$PanelRef;$tableName)
					XS_VerifyPanelTranslations ($ModuleRef;$PanelRef)
					XS_Settings ("GetPanelColumns")
				End if 
				
			: (($varName="hl_modulePanels") & ($dropDestination="hl_modulePanels"))
				
				GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$itemText)
				XS_MovePanelsInAllBlobs ($ModuleRef;$srcElement;$position)
				_O_REDRAW LIST:C382(hl_modulePanels)
				
			: (($varName="hl_QuickFindFields") & ($dropDestination="hl_QuickFindFields"))
				$items:=Count list items:C380(hl_QuickFindFields)
				GET LIST ITEM:C378(hl_QuickFindFields;$srcElement;$Ref2move;$fieldName2Move)
				DELETE FROM LIST:C624(hl_QuickFindFields;$Ref2move)
				If ($position>$items)
					APPEND TO LIST:C376(hl_QuickFindFields;$fieldName2Move;$Ref2move)
					$position:=Count list items:C380(hl_QuickFindFields)
				Else 
					If ($position>Count list items:C380(hl_QuickFindFields))
						APPEND TO LIST:C376(hl_QuickFindFields;$fieldName2Move;$Ref2move)
						$position:=Count list items:C380(hl_QuickFindFields)
					Else 
						If ($position>Count list items:C380(hl_QuickFindFields))
							APPEND TO LIST:C376(hl_QuickFindFields;$fieldName2Move;$Ref2move)
							$position:=Count list items:C380(hl_QuickFindFields)
						Else 
							GET LIST ITEM:C378(hl_QuickFindFields;$position;$insertBefore;$tableName)
							INSERT IN LIST:C625(hl_QuickFindFields;$insertBefore;$fieldName2Move;$Ref2move)
						End if 
					End if 
				End if 
				_O_REDRAW LIST:C382(hl_QuickFindFields)
				GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$ModuleText)
				GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$mainTableRef;$mainTableName)
				XS_MoveInAllPanelBlobsQF ($ModuleRef;$mainTableRef;$srcElement;$position)
			: ($varName="hl_AllTables")
				GET LIST ITEM:C378(hl_AllTables;$srcElement;$tableNum;$tableName)
				Case of 
					: ($dropDestination="hl_Modules")
						GET LIST ITEM:C378(hl_Modules;$Position;$moduleRef;$moduleName)
					: ($dropDestination="hl_ModuleTables")
						GET LIST ITEM:C378(hl_Modules;Selected list items:C379(hl_Modules);$moduleRef;$moduleName)
				End case 
				$count:=Count list items:C380(hl_ModuleTables)
				APPEND TO LIST:C376(hl_ModuleTables;$tableName;$tableNum)
				XS_Settings ("SaveModuleTables")
				READ WRITE:C146([xShell_Tables:51])
				QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$tableNum)
				[xShell_Tables:51]ReferenciaModulo:36:=$moduleRef
				SAVE RECORD:C53([xShell_Tables:51])
				UNLOAD RECORD:C212([xShell_Tables:51])
				READ ONLY:C145([xShell_Tables:51])
				SET LIST ITEM PROPERTIES:C386(hl_AllTables;$tableNum;False:C215;2;0)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Modules;$moduleRef)
				
				XS_Settings ("GetModuleTables")
				SELECT LIST ITEMS BY REFERENCE:C630(hl_ModuleTables;$tableNum)
				_O_REDRAW LIST:C382(hl_AllTables)
				
			: ($varName="hl_ModuleTables")
				GET LIST ITEM:C378(hl_AllTables;$srcElement;$tableNum;$tableName)
				Case of 
					: ($dropDestination="hl_Modules")
						GET LIST ITEM:C378(hl_Modules;$Position;$moduleRef;$moduleName)
						READ WRITE:C146([xShell_Tables:51])
						QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$tableNum)
						[xShell_Tables:51]ReferenciaModulo:36:=$moduleRef
						SAVE RECORD:C53([xShell_Tables:51])
						SELECT LIST ITEMS BY REFERENCE:C630(hl_Modules;$moduleRef)
						SET LIST ITEM PROPERTIES:C386(hl_AllTables;$tableNum;False:C215;2;0)
						XS_Settings ("SaveModuleTables")
						XS_Settings ("GetModuleTables")
						
					: ($dropDestination="hl_AllTables")
						READ WRITE:C146([xShell_Tables:51])
						QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$tableNum)
						[xShell_Tables:51]ReferenciaModulo:36:=0
						SAVE RECORD:C53([xShell_Tables:51])
						SET LIST ITEM PROPERTIES:C386(hl_AllTables;$tableNum;False:C215;0;0)
				End case 
				_O_REDRAW LIST:C382(hl_AllTables)
				
			: (($varName="hl_RelatedFields") & ($dropDestination="hl_PanelColumns"))
				GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$mainTableRef;$mainTableName)
				GET LIST ITEM:C378(hl_RelatedFields;$srcElement;$tableFieldRef;$itemText)
				$tableNum:=Num:C11(Substring:C12(String:C10($tableFieldRef);1;5))-10000
				$fieldNum:=Num:C11(Substring:C12(String:C10($tableFieldRef);6;5))-10000
				
				If ($fieldNum>0)
					$format:=VS_GetFieldDefaultFormat ($tableNum;$fieldNum)
					If ((KRL_IsTableRelated ($tableNum;$mainTableRef)) | ($tableNum=$mainTableRef))
						$itemPosition:=List item position:C629(hl_PanelColumns;$tableFieldRef)
						If ($itemPosition=0)
							$items:=Count list items:C380(hl_PanelColumns)
							If ($position>$items)
								APPEND TO LIST:C376(hl_PanelColumns;$itemText;$tableFieldRef)
							Else 
								SELECT LIST ITEMS BY POSITION:C381(hl_PanelColumns;$position)
								INSERT IN LIST:C625(hl_PanelColumns;*;$itemText;$tableFieldRef)
							End if 
							GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$ModuleText)
							XS_InsertInAllPanelBlobs ($ModuleRef;$mainTableRef;$tableNum;$fieldNum;$itemText;$position;$format)
							_O_REDRAW LIST:C382(hl_PanelColumns)
						Else 
							BEEP:C151
						End if 
					Else 
						$ignore:=CD_Dlog (0;__ ("El campo seleccionado pertenece a una tabla no relacionada.\r\rNo puede ser desplegada en el explorador del módulo."))
					End if 
				Else 
					$ignore:=CD_Dlog (0;__ ("Debe seleccionar un campo, no una tabla."))
				End if 
			: (($varName="hl_PanelColumns") & ($dropDestination="hl_PanelColumns"))
				$items:=Count list items:C380(hl_PanelColumns)
				GET LIST ITEM:C378(hl_PanelColumns;$srcElement;$tableRef2move;$tableName2Move)
				DELETE FROM LIST:C624(hl_PanelColumns;$tableRef2move)
				If ($position>$items)
					APPEND TO LIST:C376(hl_PanelColumns;$tableName2Move;$tableRef2move)
					$position:=Count list items:C380(hl_PanelColumns)
				Else 
					If ($position>Count list items:C380(hl_PanelColumns))
						APPEND TO LIST:C376(hl_PanelColumns;$tableName2Move;$tableRef2move)
						$position:=Count list items:C380(hl_PanelColumns)
					Else 
						GET LIST ITEM:C378(hl_PanelColumns;$position;$insertBefore;$tableName)
						INSERT IN LIST:C625(hl_PanelColumns;$insertBefore;$tableName2Move;$tableRef2move)
					End if 
				End if 
				_O_REDRAW LIST:C382(hl_PanelColumns)
				GET LIST ITEM:C378(hl_modulePanels;Selected list items:C379(hl_modulePanels);$TableRef;$itemText)
				GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$itemText)
				XS_MoveInAllPanelBlobs ($ModuleRef;$TableRef;$srcElement;$position)
				XS_Settings ("GetPanelColumns")
			: (($varName="hl_RelatedFields") & ($dropDestination="hl_QuickFindFields"))
				GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$mainTableRef;$mainTableName)
				GET LIST ITEM:C378(hl_RelatedFields;$srcElement;$tableFieldRef;$itemText)
				$tableNum:=Num:C11(Substring:C12(String:C10($tableFieldRef);1;5))-10000
				$fieldNum:=Num:C11(Substring:C12(String:C10($tableFieldRef);6;5))-10000
				
				If ($fieldNum>0)
					$itemPosition:=List item position:C629(hl_QuickFindFields;$tableFieldRef)
					If (($itemPosition=0) | (Macintosh option down:C545 | Windows Alt down:C563))
						$items:=Count list items:C380(hl_QuickFindFields)
						If ($position>$items)
							If ($position>(Size of array:C274(aiVS_QFSourceFieldOrder)+1))
								$position:=Size of array:C274(aiVS_QFSourceFieldOrder)+1
							End if 
							APPEND TO LIST:C376(hl_QuickFindFields;$itemText;$tableFieldRef)
						Else 
							SELECT LIST ITEMS BY POSITION:C381(hl_QuickFindFields;$position)
							INSERT IN LIST:C625(hl_QuickFindFields;*;$itemText;$tableFieldRef)
						End if 
						_O_REDRAW LIST:C382(hl_QuickFindFields)
						GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;ModuleText)
						XS_InsertInAllPanelBlobsQF ($ModuleRef;$mainTableRef;$tableNum;$fieldNum;$itemText;$position;$mainTableRef)
						SELECT LIST ITEMS BY REFERENCE:C630(hl_QuickFindFields;$tableFieldRef)
						XS_Settings ("GetQFRelationsProperties")
					Else 
						BEEP:C151
					End if 
				Else 
					$ignore:=CD_Dlog (0;__ ("Debe seleccionar un campo, no una tabla."))
				End if 
		End case 
	: ($message="GetQFRelationsProperties")
		$selectedQFField:=Selected list items:C379(hl_QuickFindFields)
		If ($selectedQFField>0)
			GET LIST ITEM:C378(hl_QuickFindFields;$selectedQFField;$manyTable;$manyTableName)
			$manyTable:=Num:C11(Substring:C12(String:C10($manyTable);1;5))-10000
			GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$mainTableRef;$mainTableName)
			If ($manyTable#$mainTableRef)
				
				$hlList:=New list:C375
				For ($i;1;Get last field number:C255($mainTableRef))
					  //20130321 RCH
					If (Is field number valid:C1000($mainTableRef;$i))
						GET FIELD PROPERTIES:C258($mainTableRef;$i;$type;$length;$indexed;$unique;$invisible)
						If (($type#Is BLOB:K8:12) & ($type#Is picture:K8:10) & ($type#Is subtable:K8:11) & (Not:C34($invisible)))
							$fieldName:=API Get Virtual Field Name ($mainTableRef;$i)
							APPEND TO LIST:C376($hlList;$fieldName;$i)
						End if 
					End if 
				End for 
				HL_ClearList (hl_RelateTo)
				hl_RelateTo:=New list:C375
				
				APPEND TO LIST:C376(hl_RelateTo;API Get Virtual Table Name ($mainTableRef);-$mainTableRef;$hlList;True:C214)
				_O_REDRAW LIST:C382(hl_RelateTo)
				
				$hlList:=New list:C375
				For ($i;1;Get last field number:C255($manyTable))
					  //20130321 RCH
					If (Is field number valid:C1000($manyTable;$i))
						GET FIELD PROPERTIES:C258($manyTable;$i;$type;$length;$indexed;$unique;$invisible)
						If (($type#Is BLOB:K8:12) & ($type#Is picture:K8:10) & ($type#Is subtable:K8:11) & (Not:C34($invisible)))
							$fieldName:=API Get Virtual Field Name ($manyTable;$i)
							APPEND TO LIST:C376($hlList;$fieldName;$i)
						End if 
					End if 
				End for 
				$fromItems:=Count list items:C380($hlList)
				HL_ClearList (hl_RelateFrom)
				hl_RelateFrom:=New list:C375
				APPEND TO LIST:C376(hl_RelateFrom;API Get Virtual Table Name ($manyTable);-$manyTable;$hlList;True:C214)
				_O_REDRAW LIST:C382(hl_RelateFrom)
				
				If (alVS_QFRelateToFieldNumber{$selectedQFField}>0)
					SELECT LIST ITEMS BY REFERENCE:C630(hl_RelateTo;alVS_QFRelateToFieldNumber{$selectedQFField})
				Else 
					SELECT LIST ITEMS BY POSITION:C381(hl_RelateTo;1)
				End if 
				If (alVS_QFRelateFromField{$selectedQFField}>0)
					SELECT LIST ITEMS BY REFERENCE:C630(hl_RelateFrom;alVS_QFRelateFromField{$selectedQFField})
				Else 
					SELECT LIST ITEMS BY POSITION:C381(hl_RelateFrom;1)
				End if 
				vtVS_QFSpecialRelationMethod:=atVS_QFSpecialRelationMethod{$selectedQFField}
				OBJECT SET VISIBLE:C603(*;"QFRelations@";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"QFRelations@";False:C215)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*;"QFRelations@";False:C215)
		End if 
	: ($message="SavePanelColumnSettings")
		GET LIST ITEM:C378(hl_modulePanels;Selected list items:C379(hl_modulePanels);$TableRef;$itemText)
		SET BLOB SIZE:C606($blob;0)
		BLOB_Variables2Blob (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
		COMPRESS BLOB:C534($blob)
		GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$itemText)
		GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$PanelRef;$tableName)
		$prefRef:=XS_GetBlobName ("panel";$ModuleRef;vtXS_CountryCode;vtXS_LangageCode;$PanelRef)
		PREF_SetBlob (0;$prefRef;$blob)
		XS_SaveInAllPanelBlobs ($ModuleRef;$PanelRef)
		
	: ($message="GetConfig&WizardsItems")
		Case of 
			: (aChoiceObjects=1)
				vtXS_CurrentObjectClass:="ConfigPanel"
				
			: (aChoiceObjects=2)
				vtXS_CurrentObjectClass:="Wizard"
				
			: (aChoiceObjects=3)
				vtXS_CurrentObjectClass:="ToolsMenuItem"
				
		End case 
		
		GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$moduleRef;$itemText)
		QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;vtXS_CurrentObjectClass;*)
		QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8;=$moduleRef;*)
		QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=vtXS_CountryCode;*)
		QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=vtXS_LangageCode)
		ORDER BY:C49([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Order:11;>;[XShell_ExecutableObjects:280]Object_Alias:5)
		
		SELECTION TO ARRAY:C260([XShell_ExecutableObjects:280];alXS_ExecObjects_RecNum;[XShell_ExecutableObjects:280]Object_Alias:5;atXS_ExecObjects_Alias;[XShell_ExecutableObjects:280]Object_Name:2;atXS_ExecObjects_RefName;[XShell_ExecutableObjects:280]Object_MethodName:3;atXS_ExecObjects_Method;[XShell_ExecutableObjects:280]IconRef:10;alXS_ExecObjects_IconRef)
		
		If (Size of array:C274(alXS_ExecObjects_RecNum)>0)
			LISTBOX SELECT ROW:C912(lb_ExecObjects;1)
			XS_Settings ("ShowExecObjectIcon")
		Else 
			OBJECT SET VISIBLE:C603(*;"bPreviewButton@";False:C215)
		End if 
		
		
	: ($message="CopyExecObject")
		Case of 
			: (aChoiceObjects=1)
				vtXS_CurrentObjectClass:="ConfigPanel"
				$tipo:="Paneles de Configuración"
			: (aChoiceObjects=2)
				vtXS_CurrentObjectClass:="Wizard"
				$tipo:="Asistentes"
			: (aChoiceObjects=3)
				vtXS_CurrentObjectClass:="ToolsMenuItem"
				$tipo:="Items Menu Herramientas"
		End case 
		
		$aTodos:=False:C215
		If (IT_AltKeyIsDown )
			$choice:=Pop up menu:C542("Copiar todo a todos los países en "+vtXS_Langage+";Copiar todo a todos los idiomas para "+vtXS_Country+";Copiar todo a todos los paises e idiomas")
			$aTodos:=True:C214
		Else 
			$choice:=Pop up menu:C542("Copiar a todos los países en "+vtXS_Langage+";Copiar a todos los idiomas para "+vtXS_Country+";Copiar a todos los paises e idiomas")
		End if 
		
		If ($choice>0)
			$currentRecNum:=alXS_ExecObjects_RecNum{alXS_ExecObjects_RecNum}
			KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
			Case of 
				: ($choice=1)
					$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
					If ($aTodos)
						$r:=CD_Dlog (0;"Se dispone a copiar TODOS los "+$tipo+" "+vtXS_Langage+"-"+vtXS_Country+" a todos los paises en "+vtXS_Langage+". ¿Esta seguro?";"";"No";"Si")
						If ($r=2)
							$p:=IT_UThermometer (1;0;"Copiando "+$tipo+"...")
							GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$moduleRef;$itemText)
							QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;vtXS_CurrentObjectClass;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8;=$moduleRef;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=vtXS_CountryCode;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=vtXS_LangageCode)
							CREATE SET:C116([XShell_ExecutableObjects:280];"Selection")
							QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;vtXS_CurrentObjectClass;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8;=$moduleRef;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=vtXS_LangageCode)
							CREATE SET:C116([XShell_ExecutableObjects:280];"Selection2")
							DIFFERENCE:C122("Selection2";"Selection";"Selection2")
							USE SET:C118("Selection2")
							KRL_DeleteSelection (->[XShell_ExecutableObjects:280])
							USE SET:C118("Selection")
							ARRAY LONGINT:C221($aRecNums;0)
							LONGINT ARRAY FROM SELECTION:C647([XShell_ExecutableObjects:280];$aRecNums;"")
							For ($i;1;Size of array:C274($aRecNums))
								For ($iCountry;1;Count list items:C380(hl_Paises))
									GET LIST ITEM:C378(hl_Paises;$iCountry;$itemRef;$country)
									$countryCode:=ST_GetWord ($country;1;":")
									If ($countryCode#vtXS_CountryCode)
										KRL_GotoRecord (->[XShell_ExecutableObjects:280];$aRecNums{$i})
										DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
										[XShell_ExecutableObjects:280]CountryCode:6:=$countryCode
										[XShell_ExecutableObjects:280]Auto_UUID:16:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
										SAVE RECORD:C53([XShell_ExecutableObjects:280])
									End if 
								End for 
							End for 
							SET_ClearSets ("Selection";"Selection2")
							IT_UThermometer (-2;$p)
						End if 
					Else 
						QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13;*)
						QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7=vtXS_LangageCode)
						CREATE SET:C116([XShell_ExecutableObjects:280];"Selection")
						KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
						REMOVE FROM SET:C561([XShell_ExecutableObjects:280];"Selection")
						USE SET:C118("Selection")
						KRL_DeleteSelection (->[XShell_ExecutableObjects:280])
						KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
						
						For ($iCountry;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$iCountry;$itemRef;$country)
							$countryCode:=ST_GetWord ($country;1;":")
							If ($countryCode#vtXS_CountryCode)
								KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
								DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
								[XShell_ExecutableObjects:280]CountryCode:6:=$countryCode
								[XShell_ExecutableObjects:280]Auto_UUID:16:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
								SAVE RECORD:C53([XShell_ExecutableObjects:280])
							End if 
						End for 
					End if 
				: ($choice=2)
					$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
					If ($aTodos)
						$r:=CD_Dlog (0;"Se dispone a copiar TODOS los "+$tipo+" "+vtXS_Langage+"-"+vtXS_Country+" a todos los idiomas para "+vtXS_Country+". ¿Esta seguro?";"";"No";"Si")
						If ($r=2)
							$p:=IT_UThermometer (1;0;"Copiando "+$tipo+"...")
							GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$moduleRef;$itemText)
							QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;vtXS_CurrentObjectClass;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8;=$moduleRef;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=vtXS_CountryCode;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=vtXS_LangageCode)
							CREATE SET:C116([XShell_ExecutableObjects:280];"Selection")
							QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;vtXS_CurrentObjectClass;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8;=$moduleRef;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=vtXS_Country)
							CREATE SET:C116([XShell_ExecutableObjects:280];"Selection2")
							DIFFERENCE:C122("Selection2";"Selection";"Selection2")
							USE SET:C118("Selection2")
							KRL_DeleteSelection (->[XShell_ExecutableObjects:280])
							USE SET:C118("Selection")
							ARRAY LONGINT:C221($aRecNums;0)
							LONGINT ARRAY FROM SELECTION:C647([XShell_ExecutableObjects:280];$aRecNums;"")
							For ($i;1;Size of array:C274($aRecNums))
								For ($iLangage;1;Count list items:C380(hl_langages))
									GET LIST ITEM:C378(hl_langages;$iLangage;$itemRef;$langage)
									$langageCode:=ST_GetWord ($langage;1;":")
									If ($langageCode#vtXS_LangageCode)
										KRL_GotoRecord (->[XShell_ExecutableObjects:280];$aRecNums{$i})
										DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
										[XShell_ExecutableObjects:280]LangageCode:7:=$langageCode
										[XShell_ExecutableObjects:280]Auto_UUID:16:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
										SAVE RECORD:C53([XShell_ExecutableObjects:280])
									End if 
								End for 
							End for 
							SET_ClearSets ("Selection";"Selection2")
							IT_UThermometer (-2;$p)
						End if 
					Else 
						QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13;*)
						QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6=vtXS_CountryCode)
						CREATE SET:C116([XShell_ExecutableObjects:280];"Selection")
						KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
						REMOVE FROM SET:C561([XShell_ExecutableObjects:280];"Selection")
						USE SET:C118("Selection")
						KRL_DeleteSelection (->[XShell_ExecutableObjects:280])
						KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
						
						
						For ($iLangage;1;Count list items:C380(hl_langages))
							GET LIST ITEM:C378(hl_langages;$iLangage;$itemRef;$langage)
							$langageCode:=ST_GetWord ($langage;1;":")
							If ($langageCode#vtXS_LangageCode)
								KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
								DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
								[XShell_ExecutableObjects:280]LangageCode:7:=$langageCode
								[XShell_ExecutableObjects:280]Auto_UUID:16:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
								SAVE RECORD:C53([XShell_ExecutableObjects:280])
							End if 
						End for 
					End if 
				: ($choice=3)
					$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
					If ($aTodos)
						$r:=CD_Dlog (0;"Se dispone a copiar TODOS los "+$tipo+" "+vtXS_Langage+"-"+vtXS_Country+" a todos los paises e idiomas. ¿Esta seguro?";"";"No";"Si")
						If ($r=2)
							$p:=IT_UThermometer (1;0;"Copiando "+$tipo+"...")
							GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$moduleRef;$itemText)
							QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;vtXS_CurrentObjectClass;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8;=$moduleRef;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=vtXS_CountryCode;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=vtXS_LangageCode)
							CREATE SET:C116([XShell_ExecutableObjects:280];"Selection")
							QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;vtXS_CurrentObjectClass)
							CREATE SET:C116([XShell_ExecutableObjects:280];"Selection2")
							DIFFERENCE:C122("Selection2";"Selection";"Selection2")
							USE SET:C118("Selection2")
							KRL_DeleteSelection (->[XShell_ExecutableObjects:280])
							USE SET:C118("Selection")
							ARRAY LONGINT:C221($aRecNums;0)
							LONGINT ARRAY FROM SELECTION:C647([XShell_ExecutableObjects:280];$aRecNums;"")
							For ($i;1;Size of array:C274($aRecNums))
								For ($iCountry;1;Count list items:C380(hl_Paises))
									GET LIST ITEM:C378(hl_Paises;$iCountry;$itemRef;$country)
									$countryCode:=ST_GetWord ($country;1;":")
									For ($iLangage;1;Count list items:C380(hl_langages))
										GET LIST ITEM:C378(hl_langages;$iLangage;$itemRef;$langage)
										$langageCode:=ST_GetWord ($langage;1;":")
										If (($countryCode#vtXS_CountryCode) | ($langageCode#vtXS_LangageCode))
											KRL_GotoRecord (->[XShell_ExecutableObjects:280];$aRecNums{$i})
											DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
											[XShell_ExecutableObjects:280]CountryCode:6:=$countryCode
											[XShell_ExecutableObjects:280]LangageCode:7:=$langageCode
											[XShell_ExecutableObjects:280]Auto_UUID:16:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
											SAVE RECORD:C53([XShell_ExecutableObjects:280])
										End if 
									End for 
								End for 
							End for 
							SET_ClearSets ("Selection";"Selection2")
							IT_UThermometer (-2;$p)
						End if 
					Else 
						QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13)
						CREATE SET:C116([XShell_ExecutableObjects:280];"Selection")
						KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
						REMOVE FROM SET:C561([XShell_ExecutableObjects:280];"Selection")
						USE SET:C118("Selection")
						KRL_DeleteSelection (->[XShell_ExecutableObjects:280])
						For ($iCountry;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$iCountry;$itemRef;$country)
							$countryCode:=ST_GetWord ($country;1;":")
							For ($iLangage;1;Count list items:C380(hl_langages))
								GET LIST ITEM:C378(hl_langages;$iLangage;$itemRef;$langage)
								$langageCode:=ST_GetWord ($langage;1;":")
								If (($countryCode#vtXS_CountryCode) | ($langageCode#vtXS_LangageCode))
									KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
									DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
									[XShell_ExecutableObjects:280]CountryCode:6:=$countryCode
									[XShell_ExecutableObjects:280]LangageCode:7:=$langageCode
									[XShell_ExecutableObjects:280]Auto_UUID:16:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
									SAVE RECORD:C53([XShell_ExecutableObjects:280])
								End if 
							End for 
						End for 
					End if 
			End case 
			KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
		End if 
		
		
		
	: ($message="AddExecObject")
		Case of 
			: (aChoiceObjects=1)
				vtXS_CurrentObjectClass:="ConfigPanel"
				
			: (aChoiceObjects=2)
				vtXS_CurrentObjectClass:="Wizard"
				
			: (aChoiceObjects=3)
				vtXS_CurrentObjectClass:="ToolsMenuItem"
				
		End case 
		
		$currentSelectedRow:=atXS_ExecObjects_RefName
		$addedToRow:=Size of array:C274(atXS_ExecObjects_RefName)+1
		GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$moduleRef;$moduleName)
		START TRANSACTION:C239
		CREATE RECORD:C68([XShell_ExecutableObjects:280])
		[XShell_ExecutableObjects:280]Object_ID:13:=SQ_SeqNumber (->[XShell_ExecutableObjects:280]Object_ID:13)
		[XShell_ExecutableObjects:280]Object_Name:2:=vtXS_CurrentObjectClass+" #"+String:C10([XShell_ExecutableObjects:280]Object_ID:13)
		[XShell_ExecutableObjects:280]Object_Alias:5:=[XShell_ExecutableObjects:280]Object_Name:2
		[XShell_ExecutableObjects:280]Object_MethodName:3:=""
		[XShell_ExecutableObjects:280]Object_Script:4:=""
		[XShell_ExecutableObjects:280]Class:1:=vtXS_CurrentObjectClass
		[XShell_ExecutableObjects:280]CountryCode:6:=vtXS_CountryCode
		[XShell_ExecutableObjects:280]LangageCode:7:=vtXS_LangageCode
		[XShell_ExecutableObjects:280]IconRef:10:=0
		[XShell_ExecutableObjects:280]ModuleRef:8:=$moduleRef
		[XShell_ExecutableObjects:280]ModuleName:9:=$moduleName
		[XShell_ExecutableObjects:280]Order:11:=$addedToRow
		[XShell_ExecutableObjects:280]xLiff_ID:12:=""
		SAVE RECORD:C53([XShell_ExecutableObjects:280])
		
		APPEND TO ARRAY:C911(atXS_ExecObjects_RefName;[XShell_ExecutableObjects:280]Object_Name:2)
		APPEND TO ARRAY:C911(atXS_ExecObjects_Alias;[XShell_ExecutableObjects:280]Object_Alias:5)
		APPEND TO ARRAY:C911(atXS_ExecObjects_Method;[XShell_ExecutableObjects:280]Object_MethodName:3)
		APPEND TO ARRAY:C911(alXS_ExecObjects_RecNum;Record number:C243([XShell_ExecutableObjects:280]))
		APPEND TO ARRAY:C911(alXS_ExecObjects_IconRef;[XShell_ExecutableObjects:280]IconRef:10)
		LISTBOX SELECT ROW:C912(lb_ExecObjects;$addedToRow)
		
		XS_ExecObject_Editor_OM 
		
		If (bAccept=1)
			LISTBOX SELECT ROW:C912(lb_ExecObjects;$addedToRow)
			  //$iconRef:=alXS_ExecObjects_IconRef{alXS_ExecObjects_IconRef}
			  //If ($iconRef>0)
			  //SET FORMAT(*;"bPreviewButton";"1;4;?"+String($iconRef)+";65;30")
			  //SET VISIBLE(*;"bPreviewButton@";True)
			  //GET OBJECT RECT(bPreviewButton;$left;$top;$right;$bottom)
			  //IT_SetObjectRect (->bPreviewButton;$left;$top;$left+32;$top+32)
			  //Else 
			  //SET VISIBLE(*;"bPreviewButton@";False)
			  //End if 
			
		Else 
			AT_Delete ($addedToRow;1;->atXS_ExecObjects_RefName;->atXS_ExecObjects_Alias;->atXS_ExecObjects_Method;->alXS_ExecObjects_RecNum;->alXS_ExecObjects_IconRef)
			LISTBOX SELECT ROW:C912(lb_ExecObjects;$currentSelectedRow)
		End if 
		XS_Settings ("ShowExecObjectIcon")
		
	: ($message="EditExecObject")
		Case of 
			: (Form event:C388=On Row Moved:K2:32)
				$result:=CD_Dlog (0;__ ("Modificaste el orden de los items.\r\rDeseas aplicar este ordenamiento... \r- sólo para ")+vtXS_Country+__ ("/")+vtXS_Langage+__ ("\r- para todos los idiomas en ")+vtXS_Country+__ ("\r- para todos los países/idiomas?");__ ("");__ ("Solo en ")+vtXS_CountryCode+__ ("/")+vtXS_LangageCode;__ ("Todo ")+vtXS_CountryCode;__ ("Todo país/idioma"))
				For ($i;1;Size of array:C274(alXS_ExecObjects_RecNum))
					KRL_GotoRecord (->[XShell_ExecutableObjects:280];alXS_ExecObjects_RecNum{$i};True:C214)
					$objectID:=[XShell_ExecutableObjects:280]Object_ID:13
					[XShell_ExecutableObjects:280]Order:11:=$i
					SAVE RECORD:C53([XShell_ExecutableObjects:280])
					Case of 
						: ($result=2)
							READ WRITE:C146([XShell_ExecutableObjects:280])
							QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID;*)
							QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6=vtXS_CountryCode)
							APPLY TO SELECTION:C70([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Order:11:=$i)
							
						: ($result=3)
							READ WRITE:C146([XShell_ExecutableObjects:280])
							QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID)
							APPLY TO SELECTION:C70([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Order:11:=$i)
							
					End case 
				End for 
				
			: (Form event:C388=On Double Clicked:K2:5)
				XS_ExecObject_Editor_OM 
				XS_Settings ("ShowExecObjectIcon")
				  //$iconRef:=alXS_ExecObjects_IconRef{alXS_ExecObjects_IconRef}
				  //If ($iconRef>0)
				  //vl_CurrentIconRef:=$iconRef
				  //SET FORMAT(*;"bPreviewButton";"1;4;?"+String($iconRef)+";65;30")
				  //SET VISIBLE(*;"bPreviewButton@";True)
				  //GET OBJECT RECT(bPreviewButton;$left;$top;$right;$bottom)
				  //IT_SetObjectRect (->bPreviewButton;$left;$top;$left+32;$top+32)
				  //Else 
				  //vl_CurrentIconRef:=0
				  //SET FORMAT(*;"bPreviewButton";"1;4;?"+String(0)+";65;30")
				  //End if 
				
			: (Form event:C388=On Clicked:K2:4)
				  //$currentSelectedRow:=alXS_ExecObjects_RecNum
				
				$selected:=Find in array:C230(lb_ExecObjects;True:C214)
				If ($selected>0)
					_O_ENABLE BUTTON:C192(bCopyExecOptions)
					_O_ENABLE BUTTON:C192(bDeleteExecObject)
				Else 
					_O_DISABLE BUTTON:C193(bCopyExecOptions)
					_O_DISABLE BUTTON:C193(bDeleteExecObject)
					
				End if 
				XS_Settings ("ShowExecObjectIcon")
		End case 
		
	: ($message="DeleteExecObject")
		$result:=CD_Dlog (0;__ ("Este objeto será eliminado para todos la países y todos los idiomas\r\rSi quieres inhabilitarlo para algún país/idioma en particular edítalo para establecer su disponibilidad.\r\r");__ ("");__ ("Editar");__ ("Eliminar todo");__ ("Cancelar"))
		Case of 
			: ($result=1)
				XS_ExecObject_Editor_OM 
				
			: ($result=2)
				$currentSelectedRow:=alXS_ExecObjects_RecNum
				$currentRecNum:=alXS_ExecObjects_RecNum{alXS_ExecObjects_RecNum}
				KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
				QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13)
				OK:=KRL_DeleteSelection (->[XShell_ExecutableObjects:280])
				AT_Delete ($currentSelectedRow;1;->atXS_ExecObjects_RefName;->atXS_ExecObjects_Alias;->atXS_ExecObjects_Method;->alXS_ExecObjects_RecNum;->alXS_ExecObjects_IconRef)
				LISTBOX SELECT ROW:C912(lb_ExecObjects;0;lk remove from selection:K53:3)
				
			: ($result=3)
				  //
		End case 
		XS_Settings ("ShowExecObjectIcon")
		
		
	: ($message="ShowExecObjectIcon")
		If (alXS_ExecObjects_IconRef>0)
			$iconRef:=alXS_ExecObjects_IconRef{alXS_ExecObjects_IconRef}
			If ($iconRef>0)
				vl_CurrentIconRef:=$iconRef
				OBJECT SET FORMAT:C236(*;"bPreviewButton";"1;4;?"+String:C10($iconRef)+";65;30")
				OBJECT SET VISIBLE:C603(*;"bPreviewButton@";True:C214)
				OBJECT GET COORDINATES:C663(bPreviewButton;$left;$top;$right;$bottom)
				IT_SetObjectRect (->bPreviewButton;$left;$top;$left+32;$top+32)
			Else 
				vl_CurrentIconRef:=0
				OBJECT SET FORMAT:C236(*;"bPreviewButton";"1;4;?"+String:C10(0)+";65;30")
			End if 
		Else 
			OBJECT SET FORMAT:C236(*;"bPreviewButton";"1;4;?"+String:C10(0)+";65;30")
		End if 
		
		
	: ($message="GetModuleTables")
		HL_ClearList (hl_ModuleTables)
		hl_ModuleTables:=New list:C375
		SET BLOB SIZE:C606($blob;0)
		GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$moduleRef;$itemText)
		$PrefReference:=XS_GetBlobName ("tables";$moduleRef;vtXS_CountryCode;vtXS_LangageCode)
		$blob:=PREF_fGetBlob (0;$PrefReference)
		If (BLOB size:C605($blob)>0)
			hl_moduleTables:=BLOB to list:C557($blob)
			SORT LIST:C391(hl_ModuleTables;>)
			SET LIST PROPERTIES:C387(hl_moduleTables;1;0;16)
			_O_REDRAW LIST:C382(hl_ModuleTables)
		End if 
		XS_Settings ("GetConfig&WizardsItems")
		
		
	: ($message="SaveModuleTables")
		GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$moduleRef;$itemText)
		C_BLOB:C604($blob;0)
		LIST TO BLOB:C556(hl_moduleTables;$blob)
		ARRAY TEXT:C222($aCountryCodes;0)
		ARRAY TEXT:C222($aLanguageCodes;0)
		HL_List2Array ("XS_CountryCodes";->$aCountryCodes)
		HL_List2Array ("XS_LangageCodes";->$aLanguageCodes)
		For ($x;1;Size of array:C274($aCountryCodes))
			For ($y;1;Size of array:C274($aLanguageCodes))
				$PrefReference:=XS_GetBlobName ("tables";$moduleRef;ST_GetWord ($aCountryCodes{$x};1;":");ST_GetWord ($aLanguageCodes{$y};1;":"))
				PREF_SetBlob (0;$PrefReference;$blob)
			End for 
		End for 
		
		
	: ($message="SetBrowserFieldSettings")
		$element:=Selected list items:C379(hl_PanelColumns)
		If ($element#0)
			GET LIST ITEM:C378(hl_PanelColumns;$element;$itemRef;$itemText)
			If ($element>0)
				atVS_Header{$element}:=vtVS_FieldHeader
				atVS_BrowserFormat{$element}:=vtVS_FieldFormat
				alVS_ColumnWidth{$element}:=viVS_ColumnWidth
				atVS_FieldNames{$element}:=vtVS_FieldAlias
				SET LIST ITEM:C385(hl_PanelColumns;$itemRef;vtVS_FieldHeader;$itemRef)
				_O_REDRAW LIST:C382(hl_PanelColumns)
				XS_Settings ("SavePanelColumnSettings")
			End if 
		End if 
	: ($message="GetBrowserFieldSettings")
		$element:=Num:C11($2)
		If ($element>0)
			OBJECT SET ENTERABLE:C238(*;"FieldSettings@";True:C214)
			vtVS_FieldHeader:=atVS_Header{$element}
			vtVS_FieldFormat:=atVS_BrowserFormat{$element}
			viVS_ColumnWidth:=alVS_ColumnWidth{$element}
			vtVS_FieldAlias:=atVS_FieldNames{$element}
		Else 
			OBJECT SET ENTERABLE:C238(*;"FieldSettings@";False:C215)
		End if 
		
	: ($message="GetModulePanels")
		If (Is a list:C621(hl_ModulePanels))
			CLEAR LIST:C377(hl_ModulePanels)
		End if 
		hl_ModulePanels:=New list:C375
		SET BLOB SIZE:C606($blob;0)
		GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$moduleRef;$moduleName)
		$modulePrefRef:=XS_GetBlobName ("browser";$moduleRef;vtXS_CountryCode;vtXS_LangageCode)
		$blob:=PREF_fGetBlob (0;$modulePrefRef;$blob)
		If (BLOB size:C605($blob)>0)
			hl_ModulePanels:=BLOB to list:C557($blob)
		Else 
			QUERY:C277([xShell_Tables:51];[xShell_Tables:51]ReferenciaModulo:36=$moduleRef)
			ORDER BY:C49([xShell_Tables:51];[xShell_Tables:51]PosicionEnExplorador:16;>)
			While (Not:C34(End selection:C36([xShell_Tables:51])))
				APPEND TO LIST:C376(hl_ModulePanels;XSvs_nombreTablaLocal_Numero ([xShell_Tables:51]NumeroDeTabla:5;vtXS_CountryCode;vtXS_LangageCode);[xShell_Tables:51]NumeroDeTabla:5)
				NEXT RECORD:C51([xShell_Tables:51])
			End while 
		End if 
		SET LIST PROPERTIES:C387(hl_ModulePanels;1;0;16)
		If (Count list items:C380(hl_ModulePanels)>0)
			For ($i;1;Count list items:C380(hl_ModulePanels))
				GET LIST ITEM:C378(hl_ModulePanels;$i;$itemRef;$itemText)
				SET LIST ITEM PROPERTIES:C386(hl_ModulePanels;$itemRef;True:C214;0;0)
			End for 
		End if 
		If (Count list items:C380(hl_ModulePanels)>0)
			SELECT LIST ITEMS BY POSITION:C381(hl_ModulePanels;1)
			XS_Settings ("GetPanelColumns")
		End if 
		
		
	: ($message="GetPanelColumns")
		AT_Initialize (->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod)
		atVS_TableRelations:=1
		HL_ClearList (hl_QuickFindFields;hl_panelColumns)
		hl_QuickFindFields:=New list:C375
		hl_panelColumns:=New list:C375
		GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$itemText)
		GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$PanelRef;$tableName)
		$prefRef:=XS_GetBlobName ("panel";$ModuleRef;vtXS_CountryCode;vtXS_LangageCode;$PanelRef)
		SET BLOB SIZE:C606($blob;0)
		$blob:=PREF_fGetBlob (0;$prefRef;$blob)
		viBWR_HiddenColumns:=0
		If (BLOB size:C605($blob)>0)
			BLOB_Blob2Vars (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
		Else 
			QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$PanelRef;*)
			QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]ColumnaEnExplorador:18>0)
			SELECTION TO ARRAY:C260([xShell_Fields:52]ColumnaEnExplorador:18;alVS_BrowserPosition;[xShell_Fields:52]NumeroTabla:1;alVS_TableNumber;[xShell_Fields:52]NumeroCampo:2;alVS_FieldNumber;[xShell_Fields:52]FormatoExplorador:22;atVS_BrowserFormat)
			ARRAY TEXT:C222(atVS_Header;Size of array:C274(alVS_BrowserPosition))
			For ($i;1;Size of array:C274(alVS_BrowserPosition))
				atVS_Header{$i}:=XSvs_nombreCampoLocal_Numero ($PanelRef;alVS_FieldNumber{$i};vtXS_CountryCode;vtXS_LangageCode)
			End for 
			ARRAY INTEGER:C220(alVS_ColumnWidth;Size of array:C274(alVS_BrowserPosition))
		End if 
		ARRAY TEXT:C222(atVS_QFSpecialRelationMethod;Size of array:C274(alVS_QFSourceTableNumber))
		ARRAY INTEGER:C220(alVS_ColumnWidth;Size of array:C274(alVS_BrowserPosition))
		SORT ARRAY:C229(alVS_BrowserPosition;alVS_TableNumber;alVS_FieldNumber;atVS_Header;alVS_ColumnWidth;atVS_BrowserFormat;atVS_FieldNames;>)
		For ($i;1;Size of array:C274(alVS_TableNumber))
			If (atVS_BrowserFormat{$i}="")
				atVS_BrowserFormat{$i}:=VS_GetFieldDefaultFormat (alVS_TableNumber{$i};alVS_FieldNumber{$i})
			End if 
			$tableFieldRef:=Num:C11(String:C10(10000+alVS_TableNumber{$i})+String:C10(10000+alVS_FieldNumber{$i}))
			APPEND TO LIST:C376(hl_panelColumns;atVS_Header{$i};$tableFieldRef)
		End for 
		_O_REDRAW LIST:C382(hl_panelColumns)
		XS_Settings ("GetPanelAvailableFields")
		If (Count list items:C380(hl_panelColumns)>0)
			SELECT LIST ITEMS BY POSITION:C381(hl_panelColumns;1)
		Else 
			SELECT LIST ITEMS BY POSITION:C381(hl_panelColumns;0)
		End if 
		_O_REDRAW LIST:C382(hl_panelColumns)
		XS_Settings ("GetColumnProperties")
		XS_Settings ("GetQF_Settings")
		
		
		
	: ($message="GetColumnProperties")
		If (Selected list items:C379(hl_panelColumns)>0)
			GET LIST ITEM:C378(hl_panelColumns;Selected list items:C379(hl_panelColumns);$tableFieldRef;$tableName)
			alVS_TableNumber{0}:=Num:C11(Substring:C12(String:C10($tableFieldRef);1;5))-10000
			alVS_FieldNumber{0}:=Num:C11(Substring:C12(String:C10($tableFieldRef);6;5))-10000
			ARRAY LONGINT:C221($DA_Return;0)
			$foundAt:=AT_MultiArraySearch (False:C215;->$DA_Return;->alvs_TableNumber;->alvs_FieldNumber)
			If ($foundAt>0)
				vtVS_FieldHeader:=atVS_Header{$DA_Return{1}}
				vtVS_FieldFormat:=atVS_BrowserFormat{$DA_Return{1}}
				viVS_ColumnWidth:=alVS_ColumnWidth{$DA_Return{1}}
				vtVS_FieldAlias:="["+Table name:C256(alvs_TableNumber{$DA_Return{1}})+"]"+Field name:C257(alvs_TableNumber{$DA_Return{1}};alVS_FieldNumber{$DA_Return{1}})  //atVS_FieldNames{DA_Return{1}}
			End if 
		End if 
		
		
	: ($message="GetPanelAvailableFields")
		HL_ClearList (hl_RelatedFields)
		hl_RelatedFields:=New list:C375
		If (Selected list items:C379(hl_ModulePanels)>0)
			GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$tableRef;$tableName)
			Case of 
				: (atVS_TableRelations=1)  // only table fields
					QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$tableRef)
					QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$tableRef)
					If (Is a list:C621(hl_relatedFields))
						CLEAR LIST:C377(hl_RelatedFields;*)
					End if 
					hl_RelatedFields:=New list:C375
					$tableRef:=[xShell_Tables:51]NumeroDeTabla:5
					$hl_Fields:=New list:C375
					SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNum;[xShell_Fields:52]ID:24;$aFieldID)
					For ($k;1;Size of array:C274($aFieldNum))
						GET FIELD PROPERTIES:C258([xShell_Tables:51]NumeroDeTabla:5;$aFieldNum{$k};$type;$length;$indexed;$unique;$invisible)
						If (($invisible=False:C215) & ($type#Is BLOB:K8:12) & ($type#Is picture:K8:10) & ($type#Is subtable:K8:11))
							  //APPEND TO LIST($hl_Fields;XSvs_nombreCampoLocal_Numero ($tableRef;$aFieldID{$k};vtXS_CountryCode;vtXS_LangageCode);Num(String(10000+$tableRef)+String(10000+$aFieldNum{$k})))
							APPEND TO LIST:C376($hl_Fields;XSvs_nombreCampoLocal_Numero ($tableRef;$aFieldNum{$k};vtXS_CountryCode;vtXS_LangageCode);Num:C11(String:C10(10000+$tableRef)+String:C10(10000+$aFieldNum{$k})))
						End if 
					End for 
					SORT LIST:C391($hl_Fields;>)
					_O_REDRAW LIST:C382($hl_Fields)
					APPEND TO LIST:C376(hl_RelatedFields;XSvs_nombreTablaLocal_Numero ([xShell_Tables:51]NumeroDeTabla:5;vtXS_CountryCode;vtXS_LangageCode);$tableRef+10000;$hl_Fields;True:C214)
					
				: (atVS_TableRelations=2)  // one to one related
					For ($i;1;Get last field number:C255($tableRef))
						  //20130321 RCH
						If (Is field number valid:C1000($tableRef;$i))
							GET RELATION PROPERTIES:C686($tableRef;$i;$oneTable;$oneField;$choiceField)
							If (($oneTable>0) & ($oneTable<=255))
								QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$oneTable)
								$relatedtableRef:=[xShell_Tables:51]NumeroDeTabla:5
								$hl_Fields:=New list:C375
								QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$oneTable)
								SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNum;[xShell_Fields:52]ID:24;$aFieldID)
								  //SORT ARRAY($aFieldName;$aFieldNum;>)
								For ($k;1;Size of array:C274($aFieldNum))
									GET FIELD PROPERTIES:C258($oneTable;$aFieldNum{$k};$type;$length;$indexed;$unique;$invisible)
									If (($invisible=False:C215) & ($type#Is BLOB:K8:12) & ($type#Is picture:K8:10) & ($type#Is subtable:K8:11))
										  //APPEND TO LIST($hl_Fields;XSvs_nombreCampoLocal_Numero ($oneTable;$aFieldID{$k};vtXS_CountryCode;vtXS_LangageCode);Num(String(10000+$relatedtableRef)+String(10000+$aFieldNum{$k})))
										APPEND TO LIST:C376($hl_Fields;XSvs_nombreCampoLocal_Numero ($tableRef;$aFieldNum{$k};vtXS_CountryCode;vtXS_LangageCode);Num:C11(String:C10(10000+$tableRef)+String:C10(10000+$aFieldNum{$k})))
									End if 
								End for 
								SORT LIST:C391($hl_Fields;>)
								_O_REDRAW LIST:C382($hl_Fields)
								APPEND TO LIST:C376(hl_RelatedFields;XSvs_nombreTablaLocal_Numero ([xShell_Tables:51]NumeroDeTabla:5;vtXS_CountryCode;vtXS_LangageCode);$relatedtableRef+10000;$hl_Fields;False:C215)
							End if 
						End if 
					End for 
					
				: (atVS_TableRelations=3)  // many to one related
					READ ONLY:C145([xShell_Tables_RelatedFiles:243])
					QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11=$tableRef)
					ARRAY INTEGER:C220($ai_tablasRelacionadas;0)
					SELECTION TO ARRAY:C260([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;$ai_tablasRelacionadas)
					For ($i;1;Size of array:C274($ai_tablasRelacionadas))
						$relatedTableNumber:=$ai_tablasRelacionadas{$i}
						QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$relatedTableNumber)
						$tableRef:=[xShell_Tables:51]NumeroDeTabla:5
						$hl_Fields:=New list:C375
						QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$relatedTableNumber)
						SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNum;[xShell_Fields:52]ID:24;$aFieldID)
						For ($k;1;Size of array:C274($aFieldNum))
							GET FIELD PROPERTIES:C258($relatedTableNumber;$aFieldNum{$k};$type;$length;$indexed;$unique;$invisible)
							If (($invisible=False:C215) & ($type#Is BLOB:K8:12) & ($type#Is picture:K8:10) & ($type#Is subtable:K8:11))
								  //APPEND TO LIST($hl_Fields;XSvs_nombreCampoLocal_Numero ($relatedTableNumber;$aFieldID{$k};vtXS_CountryCode;vtXS_LangageCode);Num(String(10000+$relatedTableNumber)+String(10000+$aFieldNum{$k})))
								APPEND TO LIST:C376($hl_Fields;XSvs_nombreCampoLocal_Numero ($tableRef;$aFieldNum{$k};vtXS_CountryCode;vtXS_LangageCode);Num:C11(String:C10(10000+$tableRef)+String:C10(10000+$aFieldNum{$k})))
							End if 
						End for 
						SORT LIST:C391($hl_Fields;>)
						_O_REDRAW LIST:C382($hl_Fields)
						APPEND TO LIST:C376(hl_RelatedFields;XSvs_nombreTablaLocal_Numero ([xShell_Tables:51]NumeroDeTabla:5;vtXS_CountryCode;vtXS_LangageCode);$tableRef+10000;$hl_Fields;False:C215)
					End for 
					
					
				: (atVS_TableRelations=4)  //all tables (soft Relations)
					GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$itemRef;$itemText)
					QUERY:C277([xShell_Tables:51];[xShell_Tables:51]ReferenciaModulo:36=$itemRef)
					ALL RECORDS:C47([xShell_Tables:51])
					ARRAY INTEGER:C220($tempIntArray;0)
					SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;$tempIntArray)
					For ($i;1;Size of array:C274($tempIntArray))
						If (Is table number valid:C999($tempIntArray{$i}))
							$relatedTableNumber:=$tempIntArray{$i}
							QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$relatedTableNumber)
							$tableRef:=[xShell_Tables:51]NumeroDeTabla:5
							$hl_Fields:=New list:C375
							QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$relatedTableNumber)
							SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNum;[xShell_Fields:52]ID:24;$aFieldID)
							  //SORT ARRAY($aFieldName;$aFieldNum;>)
							For ($k;1;Size of array:C274($aFieldNum))
								GET FIELD PROPERTIES:C258($relatedTableNumber;$aFieldNum{$k};$type;$length;$indexed;$unique;$invisible)
								If (($invisible=False:C215) & ($type#Is BLOB:K8:12) & ($type#Is picture:K8:10) & ($type#Is subtable:K8:11))
									  //APPEND TO LIST($hl_Fields;XSvs_nombreCampoLocal_Numero ($relatedTableNumber;$aFieldID{$k};vtXS_CountryCode;vtXS_LangageCode);Num(String(10000+$relatedTableNumber)+String(10000+$aFieldNum{$k}));0;False)
									APPEND TO LIST:C376($hl_Fields;XSvs_nombreCampoLocal_Numero ($tableRef;$aFieldNum{$k};vtXS_CountryCode;vtXS_LangageCode);Num:C11(String:C10(10000+$tableRef)+String:C10(10000+$aFieldNum{$k})))
								End if 
							End for 
							SORT LIST:C391($hl_Fields;>)
							_O_REDRAW LIST:C382($hl_Fields)
							APPEND TO LIST:C376(hl_RelatedFields;XSvs_nombreTablaLocal_Numero ([xShell_Tables:51]NumeroDeTabla:5;vtXS_CountryCode;vtXS_LangageCode);$tableRef+10000;$hl_Fields;False:C215)
						End if 
					End for 
			End case 
			_O_REDRAW LIST:C382(hl_RelatedFields)
			SET LIST PROPERTIES:C387(hl_RelatedFields;1;0;14)
			SORT LIST:C391(hl_RelatedFields)
		End if 
		
		
		
	: ($message="Clearmemory")
		HL_ClearList (hl_RelatedFields;hl_AllTables;hl_ModuleTables;hl_RestrictedMethods;hl_PanelColumns;hl_QuickFindFields;hl_ModulePanels;hl_Designers;hl_DesignersBackup)
		UNLOAD RECORD:C212([xShell_Fields:52])
		UNLOAD RECORD:C212([xShell_Tables:51])
		READ ONLY:C145([xShell_Fields:52])
		READ ONLY:C145([xShell_Tables:51])
	: ($message="GetQF_Settings")
		HL_ClearList (hl_QuickFindFields)
		hl_QuickFindFields:=New list:C375
		SORT ARRAY:C229(aiVS_QFSourceFieldOrder;alVS_QFSourceTableNumber;alVS_QFSourceFieldNumber;atVS_QFSourceFieldAlias;alVS_QFRelateToFieldNumber;alVS_QFRelateFromField;atVS_QFSpecialRelationMethod;>)
		For ($i;1;Size of array:C274(alVS_QFSourceTableNumber))
			$itemRef:=Num:C11(String:C10(alVS_QFSourceTableNumber{$i}+10000)+String:C10(alVS_QFSourceFieldNumber{$i}+10000))
			$itemText:=atVS_QFSourceFieldAlias{$i}
			APPEND TO LIST:C376(hl_QuickFindFields;$itemText;$itemRef)
		End for 
		_O_REDRAW LIST:C382(hl_QuickFindFields)
		XS_Settings ("GetQFRelationsProperties")
		
		
		
	: ($message="GetModuleExecutables")
		AL_UpdateArrays (xALP_MethodProperties;0)
		ARRAY TEXT:C222(atXS_Methods_Module;0)
		ARRAY TEXT:C222(atXS_Methods_Alias;0)
		ARRAY TEXT:C222(atXS_Methods_Name;0)
		ARRAY BOOLEAN:C223(abXS_Methods_Executable;0)
		ARRAY BOOLEAN:C223(abXS_Methods_AuthRequired;0)
		ARRAY BOOLEAN:C223(abXS_Methods_ExecOnClient;0)
		ARRAY LONGINT:C221(alXS_Methods_ID;0)
		ARRAY LONGINT:C221(alXS_Methods_RecNum;0)
		ARRAY TEXT:C222(atXS_Methods_Description;0)
		ARRAY LONGINT:C221(alXS_MethodsRecID;0)
		READ ONLY:C145([xShell_ExecutableCommands:19])
		ALL RECORDS:C47([xShell_ExecutableCommands:19])
		SELECTION TO ARRAY:C260([xShell_ExecutableCommands:19];alXS_Methods_RecNum;[xShell_ExecutableCommands:19]Module:3;atXS_Methods_Module;[xShell_ExecutableCommands:19]MethodName:2;atXS_Methods_Name;[xShell_ExecutableCommands:19]Method_ID:8;alXS_Methods_ID;[xShell_ExecutableCommands:19]ExecutableByUsers:7;abXS_Methods_Executable;[xShell_ExecutableCommands:19]PermissionRequired:6;abXS_Methods_AuthRequired;[xShell_ExecutableCommands:19]ExecutableOnClient:5;abXS_Methods_ExecOnClient;[xShell_ExecutableCommands:19]ID:10;alXS_MethodsRecID)
		ARRAY TEXT:C222(atXS_Methods_Alias;Size of array:C274(alXS_Methods_RecNum))
		ARRAY TEXT:C222(atXS_Methods_Description;Size of array:C274(alXS_Methods_RecNum))
		For ($x;1;Size of array:C274(alXS_Methods_RecNum))
			$aliasDesc:=XS_GetCommandAliasDescription (alXS_Methods_RecNum{$x};vtXS_CountryCode;vtXS_LangageCode)
			atXS_Methods_Alias{$x}:=ST_GetWord ($aliasDesc;1;"\t")
			atXS_Methods_Description{$x}:=ST_GetWord ($aliasDesc;2;"\t")
		End for 
		AL_UpdateArrays (xALP_MethodProperties;-2)
		AL_SetSort (xALP_MethodProperties;1;2)
		For ($I;1;Size of array:C274(alXS_Methods_RecNum))
			If (abXS_Methods_AuthRequired{$i})
				AL_SetRowColor (xALP_MethodProperties;$i;"Red")
			Else 
				AL_SetRowColor (xALP_MethodProperties;$i;"Green")
			End if 
		End for 
		AL_SetLine (xALP_MethodProperties;0)
		_O_DISABLE BUTTON:C193(bDelLine)
		vt_NumComandos:="Hay "+String:C10(Size of array:C274(atXS_Methods_Alias))+" comandos definidos."
		
		
		
	: ($message="SaveModuleExecutables")
		For ($i;Size of array:C274(alXS_Methods_RecNum);1;-1)
			If ((atXS_Methods_Alias{$i}#"") & (atXS_Methods_Name{$i}#""))
				If (alXS_Methods_RecNum{$i}=-1)
					CREATE RECORD:C68([xShell_ExecutableCommands:19])
					[xShell_ExecutableCommands:19]Module:3:=atXS_Methods_Module{$i}
					[xShell_ExecutableCommands:19]MethodName:2:=atXS_Methods_Name{$i}
					[xShell_ExecutableCommands:19]Method_ID:8:=alXS_Methods_ID{$i}
					[xShell_ExecutableCommands:19]ExecutableByUsers:7:=abXS_Methods_Executable{$i}
					[xShell_ExecutableCommands:19]PermissionRequired:6:=abXS_Methods_AuthRequired{$i}
					[xShell_ExecutableCommands:19]ExecutableOnClient:5:=abXS_Methods_ExecOnClient{$i}
					SAVE RECORD:C53([xShell_ExecutableCommands:19])
					CREATE RECORD:C68([xShell_ExecCommands_Localized:232])
					[xShell_ExecCommands_Localized:232]ID_ExecCommand:6:=[xShell_ExecutableCommands:19]ID:10
					[xShell_ExecCommands_Localized:232]Country_Code:1:="cl"
					[xShell_ExecCommands_Localized:232]Language_Code:2:="es"
					[xShell_ExecCommands_Localized:232]Alias:3:=atXS_Methods_Alias{$i}
					[xShell_ExecCommands_Localized:232]Description:4:=atXS_Methods_Description{$i}
					SAVE RECORD:C53([xShell_ExecCommands_Localized:232])
					alXS_Methods_RecNum{$i}:=Record number:C243([xShell_ExecutableCommands:19])
				End if 
				XS_VerifyCommandsTranslation (alXS_Methods_RecNum{$i})
				READ WRITE:C146([xShell_ExecutableCommands:19])
				GOTO RECORD:C242([xShell_ExecutableCommands:19];alXS_Methods_RecNum{$i})
				[xShell_ExecutableCommands:19]Module:3:=atXS_Methods_Module{$i}
				[xShell_ExecutableCommands:19]MethodName:2:=atXS_Methods_Name{$i}
				[xShell_ExecutableCommands:19]Method_ID:8:=alXS_Methods_ID{$i}
				[xShell_ExecutableCommands:19]ExecutableByUsers:7:=abXS_Methods_Executable{$i}
				[xShell_ExecutableCommands:19]PermissionRequired:6:=abXS_Methods_AuthRequired{$i}
				[xShell_ExecutableCommands:19]ExecutableOnClient:5:=abXS_Methods_ExecOnClient{$i}
				
				  //20130128 RCH No se estaban guardando los cambios en las propiedades.
				SAVE RECORD:C53([xShell_ExecutableCommands:19])
				
				READ WRITE:C146([xShell_ExecCommands_Localized:232])
				QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=;[xShell_ExecutableCommands:19]ID:10;*)
				QUERY:C277([xShell_ExecCommands_Localized:232]; & [xShell_ExecCommands_Localized:232]Country_Code:1;=;vtXS_CountryCode;*)
				QUERY:C277([xShell_ExecCommands_Localized:232]; & [xShell_ExecCommands_Localized:232]Language_Code:2;=;vtXS_LangageCode)
				[xShell_ExecCommands_Localized:232]Alias:3:=atXS_Methods_Alias{$i}
				[xShell_ExecCommands_Localized:232]Description:4:=atXS_Methods_Description{$i}
				SAVE RECORD:C53([xShell_ExecCommands_Localized:232])
			Else 
				If (alXS_Methods_RecNum{$i}=-1)
					AT_Delete ($i;1;->alXS_Methods_RecNum;->atXS_Methods_Module;->atXS_Methods_Alias;->atXS_Methods_Name;->alXS_Methods_ID;->abXS_Methods_Executable;->abXS_Methods_AuthRequired;->abXS_Methods_ExecOnClient;->atXS_Methods_Description)
				Else 
					READ WRITE:C146([xShell_ExecutableCommands:19])
					GOTO RECORD:C242([xShell_ExecutableCommands:19];alXS_Methods_RecNum{$i})
					DELETE RECORD:C58([xShell_ExecutableCommands:19])
					KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
				End if 
			End if 
		End for 
		KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
		KRL_UnloadReadOnly (->[xShell_ExecCommands_Localized:232])
		
		
		
	: ($message="CopyPanelSettings")
		C_TEXT:C284($vt_country;$vt_language;$itemText;$tableName;$prefRef;$PanelPref)
		C_LONGINT:C283($ModuleRef;$PanelRef;$i;$j;$resp)
		$vt_country:=ST_GetWord (vtXS_Country;1;":")
		$vt_language:=ST_GetWord (vtXS_Langage;1;":")
		
		$resp:=CD_Dlog (0;__ ("Se copiarán las propiedades del panel seleccionado desde el país: ")+$vt_country+__ (", idioma: ")+$vt_language+__ (" a todos los países, todos los idiomas.\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
		If ($resp=1)
			ARRAY INTEGER:C220($alVS_BrowserPosition;0)
			ARRAY INTEGER:C220($alVS_TableNumber;0)
			ARRAY INTEGER:C220($alVS_FieldNumber;0)
			ARRAY TEXT:C222($atVS_Header;0)
			ARRAY INTEGER:C220($alVS_ColumnWidth;0)
			ARRAY TEXT:C222($atVS_BrowserFormat;0)
			ARRAY TEXT:C222($atVS_FieldNames;0)
			
			GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$itemText)
			GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$PanelRef;$tableName)
			$prefRef:=XS_GetBlobName ("panel";$ModuleRef;$vt_country;$vt_language;$PanelRef)
			C_BLOB:C604($xBlob)
			$xBlob:=PREF_fGetBlob (0;$prefRef;$xBlob)
			BLOB_Blob2Vars (->$xBlob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
			
			COPY ARRAY:C226(alVS_BrowserPosition;$alVS_BrowserPosition)
			COPY ARRAY:C226(alVS_TableNumber;$alVS_TableNumber)
			COPY ARRAY:C226(alVS_FieldNumber;$alVS_FieldNumber)
			COPY ARRAY:C226(atVS_Header;$atVS_Header)
			COPY ARRAY:C226(alVS_ColumnWidth;$alVS_ColumnWidth)
			COPY ARRAY:C226(atVS_BrowserFormat;$atVS_BrowserFormat)
			COPY ARRAY:C226(atVS_FieldNames;$atVS_FieldNames)
			
			ARRAY TEXT:C222($aCountryCodes;0)
			ARRAY TEXT:C222($aLanguageCodes;0)
			HL_List2Array ("XS_CountryCodes";->$aCountryCodes)
			HL_List2Array ("XS_LangageCodes";->$aLanguageCodes)
			
			For ($i;1;Size of array:C274($aCountryCodes))
				For ($j;1;Size of array:C274($aLanguageCodes))
					$PanelPref:=XS_GetBlobName ("panel";$ModuleRef;ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":");$PanelRef)
					$xBlob:=PREF_fGetBlob (0;$PanelPref;$xBlob)
					BLOB_Blob2Vars (->$xBlob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
					
					COPY ARRAY:C226($alVS_BrowserPosition;alVS_BrowserPosition)
					COPY ARRAY:C226($alVS_TableNumber;alVS_TableNumber)
					COPY ARRAY:C226($alVS_FieldNumber;alVS_FieldNumber)
					COPY ARRAY:C226($atVS_Header;atVS_Header)
					COPY ARRAY:C226($alVS_ColumnWidth;alVS_ColumnWidth)
					COPY ARRAY:C226($atVS_BrowserFormat;atVS_BrowserFormat)
					COPY ARRAY:C226($atVS_FieldNames;atVS_FieldNames)
					
					SET BLOB SIZE:C606($xBlob;0)
					BLOB_Variables2Blob (->$xBlob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
					PREF_SetBlob (0;$PanelPref;$xBlob)
				End for 
			End for 
			SET BLOB SIZE:C606($xBlob;0)
			XS_Settings ("GetPanelColumn")
		End if 
End case 