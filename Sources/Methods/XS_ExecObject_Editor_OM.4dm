//%attributes = {}
  // Método: XS_ExecObject_Editor_OM
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 09/07/10, 21:08:22
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_TEXT:C284($method;$1;$parameters;$3)
C_POINTER:C301($objectPointer;$2;$noTable)
C_LONGINT:C283($tableNum;$fieldNum)
_O_C_STRING:C293(255;$varName)


  // Código principal
Case of 
	: (Count parameters:C259=1)
		$method:=$1
	: (Count parameters:C259=2)
		$method:=$1
		$ObjectPointer:=$2
	: (Count parameters:C259=3)
		$method:=$1
		$ObjectPointer:=$2
		$parameters:=$3
End case 

If (Not:C34(Is nil pointer:C315($objectPointer)))
	RESOLVE POINTER:C394($objectPointer;$varName;$tableNum;$fieldNum)
	If ($tableNum>0) & ($fieldNum>0)
		$fieldName:="["+Table name:C256($tableNum)+"]"+Field name:C257($tableNum;$fieldNum)
	End if 
End if 

$currentSelectedRow:=alXS_ExecObjects_RecNum
$currentRecNum:=alXS_ExecObjects_RecNum{alXS_ExecObjects_RecNum}
Case of 
	: ($method="")
		KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
		
		
		Case of 
			: (vtXS_CurrentObjectClass="ConfigPanel")
				$winTitle:="Panel de configuración"
			: (vtXS_CurrentObjectClass="Wizard")
				$winTitle:="Asistente"
			: (vtXS_CurrentObjectClass="ToolsMenuItem")
				$winTitle:="Item Menú Herramientas"
		End case 
		
		  //START TRANSACTION
		WDW_OpenFormWindow ($noTable;"XS_ExecObject_Editor";-1;8;$winTitle)
		DIALOG:C40("XS_ExecObject_Editor")
		CLOSE WINDOW:C154
		
		If (bAccept=1)
			  //VALIDATE TRANSACTION
			atXS_ExecObjects_RefName{$currentSelectedRow}:=[XShell_ExecutableObjects:280]Object_Name:2
			atXS_ExecObjects_Alias{$currentSelectedRow}:=[XShell_ExecutableObjects:280]Object_Alias:5
			atXS_ExecObjects_Method{$currentSelectedRow}:=[XShell_ExecutableObjects:280]Object_MethodName:3
			alXS_ExecObjects_IconRef{$currentSelectedRow}:=[XShell_ExecutableObjects:280]IconRef:10
			LISTBOX SELECT ROW:C912(lb_ExecObjects;$currentSelectedRow)
			
		Else 
			  //CANCEL TRANSACTION
			LISTBOX SELECT ROW:C912(lb_ExecObjects;$currentSelectedRow)
		End if 
		
		
	: ($method="FormMethod")
		Case of 
			: (Form event:C388=On Load:K2:1)
				ARRAY TEXT:C222($aCountries;0)
				$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
				$objectID:=[XShell_ExecutableObjects:280]Object_ID:13
				$currentCountryCode:=[XShell_ExecutableObjects:280]CountryCode:6
				$currentLangageCode:=[XShell_ExecutableObjects:280]LangageCode:7
				QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID)
				AT_DistinctsFieldValues (->[XShell_ExecutableObjects:280]CountryCode:6;->$aCountries)
				
				ARRAY TEXT:C222(atXS_PaisesDisponibles;0)
				ARRAY LONGINT:C221(al_ExecObjects_Styles;0)
				ARRAY LONGINT:C221(al_ExecObjects_Colors;0)
				ARRAY TEXT:C222(atXS_ExecObjects_Countries;Count list items:C380(hl_Paises))
				ARRAY LONGINT:C221(al_ExecObjects_Styles;Count list items:C380(hl_Paises))
				ARRAY LONGINT:C221(al_ExecObjects_Colors;Count list items:C380(hl_Paises))
				For ($i;1;Size of array:C274(atXS_ExecObjects_Countries))
					GET LIST ITEM:C378(hl_Paises;$i;$CountryRef;$country)
					$countryCode:=ST_ClearSpaces (ST_GetWord ($country;1;":"))
					$countryName:=ST_ClearSpaces (ST_GetWord ($country;2;":"))
					atXS_ExecObjects_Countries{$i}:=$country
					If (Find in array:C230($aCountries;$countryCode)>0)
						al_ExecObjects_Styles{$i}:=1
						APPEND TO ARRAY:C911(atXS_PaisesDisponibles;$country)
					Else 
						al_ExecObjects_Styles{$i}:=0
					End if 
					If ($countryCode=vtXS_CountryCode)
						al_ExecObjects_Colors{$i}:=0x00FF0000
					Else 
						al_ExecObjects_Colors{$i}:=0
					End if 
				End for 
				vtXS_ExecObject_AliasLabel:=vtXS_CountryCode+"-"+vtXS_LangageCode
				atXS_PaisesDisponibles:=Find in array:C230(atXS_PaisesDisponibles;($currentCountryCode+":@"))
				KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
				
				$iconRef:=[XShell_ExecutableObjects:280]IconRef:10
				If ($iconRef>0)
					vl_CurrentIconRef:=$iconRef
					OBJECT SET FORMAT:C236(*;"bPreviewButton";"1;4;?"+String:C10($iconRef)+";65;30")
					OBJECT SET VISIBLE:C603(*;"bPreviewButton";True:C214)
					OBJECT GET COORDINATES:C663(bPreviewButton;$left;$top;$right;$bottom)
					IT_SetObjectRect (->bPreviewButton;$left;$top;$left+32;$top+32)
				Else 
					vl_CurrentIconRef:=0
					OBJECT SET FORMAT:C236(*;"bPreviewButton";"1;4;?"+String:C10(0)+";65;30")
					  //SET VISIBLE(*;"bPreviewButton@";False)
				End if 
				
				$iconRef:=[XShell_ExecutableObjects:280]MenuIconRef:15
				If ($iconRef>0)
					GET PICTURE FROM LIBRARY:C565($iconRef;vp_menuIcon)
					OBJECT SET FORMAT:C236(*;"bPreviewMenuIcon";"1;1;?"+String:C10($iconRef)+";64;0")
					OBJECT SET VISIBLE:C603(*;"bPreviewMenuIcon";True:C214)
					OBJECT GET COORDINATES:C663(bPreviewMenuIcon;$left;$top;$right;$bottom)
					IT_SetObjectRect (->bPreviewMenuIcon;$left;$top;$left+20;$top+20)
				Else 
					OBJECT SET FORMAT:C236(*;"bPreviewMenuIcon";"1;1;?"+String:C10(0)+";64;0")
					  //SET VISIBLE(*;"bPreviewButton@";False)
				End if 
				
				
				XS_ExecObject_Editor_OM ("LoadLanguageAliases")
		End case 
		
	: ($method="HandleCountrySelection")
		$countryCode:=ST_ClearSpaces (ST_GetWord (atXS_ExecObjects_Countries{atXS_ExecObjects_Countries};1;":"))
		If (al_ExecObjects_Styles{atXS_ExecObjects_Countries}=1)
			If (al_ExecObjects_Colors{atXS_ExecObjects_Countries}=0x00FF0000)
				BEEP:C151
			Else 
				al_ExecObjects_Styles{atXS_ExecObjects_Countries}:=0
				$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
				QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13;*)
				QUERY:C277([XShell_ExecutableObjects:280]; & [XShell_ExecutableObjects:280]CountryCode:6=$countryCode)
				KRL_DeleteSelection (->[XShell_ExecutableObjects:280])
				KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
				
				$el:=Find in array:C230(atXS_PaisesDisponibles;atXS_ExecObjects_Countries{atXS_ExecObjects_Countries})
				If ($el>0)
					DELETE FROM ARRAY:C228(atXS_PaisesDisponibles;$el)
					If (Size of array:C274(atXS_PaisesDisponibles)>0)
						atXS_PaisesDisponibles:=1
					Else 
						atXS_PaisesDisponibles:=0
						ARRAY TEXT:C222(atXS_ExecObjects_LangageCodes;0)
						ARRAY TEXT:C222(atXS_ExecObjects_Aliases;0)
					End if 
				End if 
				XS_ExecObject_Editor_OM ("LoadLanguageAliases")
			End if 
			
			
		Else 
			$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
			al_ExecObjects_Styles{atXS_ExecObjects_Countries}:=1
			For ($i;1;Count list items:C380(hl_langages))
				GET LIST ITEM:C378(hl_langages;$i;$langageRef;$langage)
				$langageCode:=ST_ClearSpaces (ST_GetWord ($langage;1;":"))
				QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13;*)
				QUERY:C277([XShell_ExecutableObjects:280]; & [XShell_ExecutableObjects:280]CountryCode:6=$countryCode;*)
				QUERY:C277([XShell_ExecutableObjects:280]; & [XShell_ExecutableObjects:280]LangageCode:7=$langageCode)
				If (Records in selection:C76([XShell_ExecutableObjects:280])=0)
					KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
					DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
					[XShell_ExecutableObjects:280]CountryCode:6:=$countryCode
					[XShell_ExecutableObjects:280]LangageCode:7:=$langageCode
					[XShell_ExecutableObjects:280]Auto_UUID:16:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
					SAVE RECORD:C53([XShell_ExecutableObjects:280])
				End if 
			End for 
			KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
			APPEND TO ARRAY:C911(atXS_PaisesDisponibles;atXS_ExecObjects_Countries{atXS_ExecObjects_Countries})
			SORT ARRAY:C229(atXS_PaisesDisponibles;>)
		End if 
		
		
		
	: ($method="ReadLanguageAliases")
		If (atXS_PaisesDisponibles>0)
			$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
			$objectID:=[XShell_ExecutableObjects:280]Object_ID:13
			$currentCountryCode:=atXS_PaisesDisponibles{atXS_PaisesDisponibles}
			$currentCountryCode:=ST_ClearSpaces (ST_GetWord ($currentCountryCode;1;":"))
			
			ARRAY TEXT:C222(atXS_ExecObjects_LangageCodes;0)
			ARRAY TEXT:C222(atXS_ExecObjects_Aliases;0)
			ARRAY TEXT:C222(atXS_ExecObjects_LangageCodes;Count list items:C380(hl_langages))
			ARRAY TEXT:C222(atXS_ExecObjects_Aliases;Count list items:C380(hl_langages))
			For ($i;1;Size of array:C274(atXS_ExecObjects_LangageCodes))
				GET LIST ITEM:C378(hl_Langages;$i;$langageRef;$langageCode)
				$langageCode:=ST_ClearSpaces (ST_GetWord ($langageCode;1;":"))
				atXS_ExecObjects_LangageCodes{$i}:=$langageCode
				QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID;*)
				QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=;$currentCountryCode;*)
				QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=;$langageCode)
				atXS_ExecObjects_Aliases{$i}:=[XShell_ExecutableObjects:280]Object_Alias:5
			End for 
			KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
		End if 
		
	: ($method="SetLanguageAliases")
		Case of 
			: (Form event:C388=On Data Change:K2:15)
				$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
				$objectID:=[XShell_ExecutableObjects:280]Object_ID:13
				$countryCode:=ST_ClearSpaces (ST_GetWord (atXS_PaisesDisponibles{atXS_PaisesDisponibles};1;":"))
				$langageCode:=ST_ClearSpaces (ST_GetWord (atXS_ExecObjects_LangageCodes{atXS_ExecObjects_LangageCodes};1;":"))
				
				If (atXS_ExecObjects_Aliases{atXS_ExecObjects_Aliases}#"")
					READ WRITE:C146([XShell_ExecutableObjects:280])
					QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID;*)
					QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6=$countryCode;*)
					QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7=$langageCode)
					If (Records in selection:C76([XShell_ExecutableObjects:280])=0)
						KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
						DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
						[XShell_ExecutableObjects:280]CountryCode:6:=$countryCode
						[XShell_ExecutableObjects:280]LangageCode:7:=$langageCode
						[XShell_ExecutableObjects:280]Auto_UUID:16:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
					End if 
					[XShell_ExecutableObjects:280]Object_Alias:5:=atXS_ExecObjects_Aliases{atXS_ExecObjects_Aliases}
					SAVE RECORD:C53([XShell_ExecutableObjects:280])
					
				Else 
					
					READ WRITE:C146([XShell_ExecutableObjects:280])
					QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID;*)
					QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6=$countryCode;*)
					QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7=$langageCode)
					If (Records in selection:C76([XShell_ExecutableObjects:280])>0)
						DELETE RECORD:C58([XShell_ExecutableObjects:280])
					End if 
					
				End if 
				
				
				KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
				
			: (Form event:C388=On Double Clicked:K2:5)
				EDIT ITEM:C870(atXS_ExecObjects_Aliases)
				
		End case 
		
	: ($method="SetTips")
		Case of 
			: (Form event:C388=On Data Change:K2:15)
				$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
				$objectID:=[XShell_ExecutableObjects:280]Object_ID:13
				$countryCode:=ST_ClearSpaces (ST_GetWord (atXS_PaisesDisponibles{atXS_PaisesDisponibles};1;":"))
				$langageCode:=ST_ClearSpaces (ST_GetWord (atXS_ExecObjects_LangageCodes_T{atXS_ExecObjects_LangageCodes_T};1;":"))
				
				If (atXS_ExecObjects_Aliases{atXS_ExecObjects_Aliases}#"")
					READ WRITE:C146([XShell_ExecutableObjects:280])
					QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID;*)
					QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6=$countryCode;*)
					QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7=$langageCode)
					If (Records in selection:C76([XShell_ExecutableObjects:280])=0)
						KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
						DUPLICATE RECORD:C225([XShell_ExecutableObjects:280])
						[XShell_ExecutableObjects:280]CountryCode:6:=$countryCode
						[XShell_ExecutableObjects:280]LangageCode:7:=$langageCode
						[XShell_ExecutableObjects:280]Auto_UUID:16:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
					End if 
					[XShell_ExecutableObjects:280]Tip:14:=atXS_ExecObjects_Tip{atXS_ExecObjects_Tip}
					SAVE RECORD:C53([XShell_ExecutableObjects:280])
					
				Else 
					
					READ WRITE:C146([XShell_ExecutableObjects:280])
					QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID;*)
					QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6=$countryCode;*)
					QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7=$langageCode)
					If (Records in selection:C76([XShell_ExecutableObjects:280])>0)
						[XShell_ExecutableObjects:280]Tip:14:=atXS_ExecObjects_Tip{atXS_ExecObjects_Tip}
					End if 
				End if 
				
				
				KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
				
			: (Form event:C388=On Double Clicked:K2:5)
				EDIT ITEM:C870(atXS_ExecObjects_Tip)
				
		End case 
		
		
		
		
	: ($method="LoadLanguageAliases")
		$objectID:=[XShell_ExecutableObjects:280]Object_ID:13
		$currentCountryCode:=[XShell_ExecutableObjects:280]CountryCode:6
		ARRAY TEXT:C222(atXS_ExecObjects_LangageCodes;0)
		ARRAY TEXT:C222(atXS_ExecObjects_LangageCodes_T;0)
		ARRAY TEXT:C222(atXS_ExecObjects_Aliases;0)
		ARRAY TEXT:C222(atXS_ExecObjects_Tip;0)
		ARRAY TEXT:C222(atXS_ExecObjects_LangageCodes;Count list items:C380(hl_langages))
		ARRAY TEXT:C222(atXS_ExecObjects_LangageCodes_T;Count list items:C380(hl_langages))
		ARRAY TEXT:C222(atXS_ExecObjects_Aliases;Count list items:C380(hl_langages))
		ARRAY TEXT:C222(atXS_ExecObjects_Tip;Count list items:C380(hl_langages))
		For ($i;1;Size of array:C274(atXS_ExecObjects_LangageCodes))
			GET LIST ITEM:C378(hl_Langages;$i;$langageRef;$langageCode)
			$langageCode:=ST_ClearSpaces (ST_GetWord ($langageCode;1;":"))
			atXS_ExecObjects_LangageCodes{$i}:=$langageCode
			atXS_ExecObjects_LangageCodes_T{$i}:=$langageCode
			QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID;*)
			QUERY:C277([XShell_ExecutableObjects:280]; & [XShell_ExecutableObjects:280]CountryCode:6=$currentCountryCode;*)
			QUERY:C277([XShell_ExecutableObjects:280]; & [XShell_ExecutableObjects:280]LangageCode:7=$langageCode)
			atXS_ExecObjects_Aliases{$i}:=[XShell_ExecutableObjects:280]Object_Alias:5
			atXS_ExecObjects_Tip{$i}:=[XShell_ExecutableObjects:280]Tip:14
		End for 
		KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
		
		
		
		
	: ($method="AddObject")
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
		  //START TRANSACTION
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
			  //VALIDATE TRANSACTION
			atXS_ExecObjects_RefName{$addedToRow}:=[XShell_ExecutableObjects:280]Object_Name:2
			atXS_ExecObjects_Alias{$addedToRow}:=[XShell_ExecutableObjects:280]Object_Alias:5
			atXS_ExecObjects_Method{$addedToRow}:=[XShell_ExecutableObjects:280]Object_MethodName:3
			alXS_ExecObjects_IconRef{$addedToRow}:=[XShell_ExecutableObjects:280]IconRef:10
			LISTBOX SELECT ROW:C912(lb_ExecObjects;$addedToRow)
		Else 
			  //CANCEL TRANSACTION
			AT_Delete ($addedToRow;1;->atXS_ExecObjects_RefName;->atXS_ExecObjects_Alias;->atXS_ExecObjects_Method;->alXS_ExecObjects_RecNum;->alXS_ExecObjects_IconRef)
			LISTBOX SELECT ROW:C912(lb_ExecObjects;$currentSelectedRow)
		End if 
		
	: ($method="SaveRecord")
		Case of 
			: ($fieldName="[XShell_ExecutableObjects]Object_Alias")
				$langageFound:=Find in array:C230(atXS_ExecObjects_LangageCodes;vtXS_LangageCode)
				If ($langageFound>0)
					atXS_ExecObjects_Aliases{$langageFound}:=[XShell_ExecutableObjects:280]Object_Alias:5
				End if 
		End case 
		
		
		SAVE RECORD:C53([XShell_ExecutableObjects:280])
		
	: ($method="CopyObject")
		$choice:=Pop up menu:C542("Copiar a todos los países en "+vtXS_Langage+";Copiar a todos los idiomas para "+vtXS_Country+";Copiar a todos los paises e idiomas")
		
		If ($choice>0)
			$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
			Case of 
				: ($choice=1)
					$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
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
					
				: ($choice=2)
					$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
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
					
					
				: ($choice=3)
					$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
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
			End case 
			
			
			KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
			ARRAY TEXT:C222($aCountries;0)
			$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
			$objectID:=[XShell_ExecutableObjects:280]Object_ID:13
			$currentCountryCode:=[XShell_ExecutableObjects:280]CountryCode:6
			$currentLangageCode:=[XShell_ExecutableObjects:280]LangageCode:7
			QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=$objectID)
			AT_DistinctsFieldValues (->[XShell_ExecutableObjects:280]CountryCode:6;->$aCountries)
			KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
			
			
			ARRAY TEXT:C222(atXS_PaisesDisponibles;0)
			ARRAY LONGINT:C221(al_ExecObjects_Styles;0)
			ARRAY LONGINT:C221(al_ExecObjects_Colors;0)
			ARRAY TEXT:C222(atXS_ExecObjects_Countries;Count list items:C380(hl_Paises))
			ARRAY LONGINT:C221(al_ExecObjects_Styles;Count list items:C380(hl_Paises))
			ARRAY LONGINT:C221(al_ExecObjects_Colors;Count list items:C380(hl_Paises))
			For ($i;1;Size of array:C274(atXS_ExecObjects_Countries))
				GET LIST ITEM:C378(hl_Paises;$i;$CountryRef;$country)
				$countryCode:=ST_ClearSpaces (ST_GetWord ($country;1;":"))
				$countryName:=ST_ClearSpaces (ST_GetWord ($country;2;":"))
				atXS_ExecObjects_Countries{$i}:=$country
				If (Find in array:C230($aCountries;$countryCode)>0)
					al_ExecObjects_Styles{$i}:=1
					APPEND TO ARRAY:C911(atXS_PaisesDisponibles;$country)
				Else 
					al_ExecObjects_Styles{$i}:=0
				End if 
				If ($countryCode=vtXS_CountryCode)
					al_ExecObjects_Colors{$i}:=0x00FF0000
				Else 
					al_ExecObjects_Colors{$i}:=0
				End if 
			End for 
			vtXS_ExecObject_AliasLabel:=vtXS_CountryCode+"-"+vtXS_LangageCode
			atXS_PaisesDisponibles:=Find in array:C230(atXS_PaisesDisponibles;($currentCountryCode+":@"))
			KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum)
			
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
			
			
			XS_ExecObject_Editor_OM ("LoadLanguageAliases")
			
		End if 
		
	: ($method="AsignaIcono")
		If (Contextual click:C713)
			$choice:=Pop up menu:C542("Asignar ícono a "+vtXS_CountryCode+" - "+vtXS_LangageCode+"...;Asignar ícono a todas las combinaciones...;(-;Remover ícono para "+vtXS_CountryCode+" - "+vtXS_LangageCode+";Remover en todas las combinaciones...;(-;Reasignar este ícono a todas las combinaciones país-idioma")
		Else 
			$choice:=1
		End if 
		
		Case of 
			: ($choice=1)  //asignar icono
				C_POINTER:C301($nil)
				$iconRef:=XS_SelectPicture_FM ("";$nil;String:C10([XShell_ExecutableObjects:280]IconRef:10))
				If (OK=1)
					If ($iconRef#0)
						[XShell_ExecutableObjects:280]IconRef:10:=$iconRef
						SAVE RECORD:C53([XShell_ExecutableObjects:280])
					End if 
				End if 
				
			: ($choice=2)  //asignar icono en todas las combinaciones
				C_POINTER:C301($nil)
				$iconRef:=XS_SelectPicture_FM ("";$nil;String:C10([XShell_ExecutableObjects:280]IconRef:10))
				If (OK=1)
					If ($iconRef#0)
						$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
						[XShell_ExecutableObjects:280]IconRef:10:=$iconRef
						SAVE RECORD:C53([XShell_ExecutableObjects:280])
						READ WRITE:C146([XShell_ExecutableObjects:280])
						QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13)
						APPLY TO SELECTION:C70([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]IconRef:10:=$iconRef)
						KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
					End if 
				End if 
				
			: ($choice=4)  //remover icono
				[XShell_ExecutableObjects:280]IconRef:10:=0
				SAVE RECORD:C53([XShell_ExecutableObjects:280])
				
			: ($choice=5)  //remover icono en todas las combinaciones
				$r:=CD_Dlog (0;__ ("¿Estas seguro de eliminar  los iconos asociados a todas las combinaciones país/Idioma");__ ("");__ ("Si");__ ("Cancelar"))
				$iconRef:=0
				$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
				[XShell_ExecutableObjects:280]IconRef:10:=$iconRef
				SAVE RECORD:C53([XShell_ExecutableObjects:280])
				READ WRITE:C146([XShell_ExecutableObjects:280])
				QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13)
				APPLY TO SELECTION:C70([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]IconRef:10:=$iconRef)
				KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
				
			: ($choice=7)  //copiar icono a todas las combinaciones país/Idioma
				$iconRef:=[XShell_ExecutableObjects:280]IconRef:10
				$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
				[XShell_ExecutableObjects:280]IconRef:10:=$iconRef
				SAVE RECORD:C53([XShell_ExecutableObjects:280])
				READ WRITE:C146([XShell_ExecutableObjects:280])
				QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13)
				APPLY TO SELECTION:C70([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]IconRef:10:=$iconRef)
				KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
		End case 
		
		
		$iconRef:=[XShell_ExecutableObjects:280]IconRef:10
		If ($iconRef>0)
			vl_CurrentIconRef:=$iconRef
			OBJECT SET FORMAT:C236(*;"bPreviewButton";"1;4;?"+String:C10($iconRef)+";65;30")
			OBJECT SET VISIBLE:C603(*;"bPreviewButton@";True:C214)
			OBJECT GET COORDINATES:C663(bPreviewButton;$left;$top;$right;$bottom)
			IT_SetObjectRect (->bPreviewButton;$left;$top;$left+32;$top+32)
		Else 
			vl_CurrentIconRef:=0
			OBJECT SET FORMAT:C236(*;"bPreviewButton";"1;4;?"+String:C10(0)+";65;30")
			  //SET VISIBLE(*;"bPreviewButton@";False)
		End if 
		
		
	: ($method="AsignaIconoMenu")
		If (Contextual click:C713)
			$choice:=Pop up menu:C542("Asignar ícono a "+vtXS_CountryCode+" - "+vtXS_LangageCode+"...;Asignar ícono a todas las combinaciones...;(-;Remover ícono para "+vtXS_CountryCode+" - "+vtXS_LangageCode+";Remover en todas las combinaciones...;(-;Reasignar este ícono a todas las combinaciones país-idioma")
		Else 
			$choice:=1
		End if 
		
		Case of 
			: ($choice=1)  //asignar icono
				C_POINTER:C301($nil)
				$iconRef:=XS_SelectPicture_FM ("";$nil;String:C10([XShell_ExecutableObjects:280]MenuIconRef:15))
				If (OK=1)
					If ($iconRef#0)
						[XShell_ExecutableObjects:280]MenuIconRef:15:=$iconRef
						SAVE RECORD:C53([XShell_ExecutableObjects:280])
					End if 
				End if 
				
			: ($choice=2)  //asignar icono en todas las combinaciones
				C_POINTER:C301($nil)
				$iconRef:=XS_SelectPicture_FM ("";$nil;String:C10([XShell_ExecutableObjects:280]MenuIconRef:15))
				If (OK=1)
					If ($iconRef#0)
						$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
						[XShell_ExecutableObjects:280]IconRef:10:=$iconRef
						SAVE RECORD:C53([XShell_ExecutableObjects:280])
						READ WRITE:C146([XShell_ExecutableObjects:280])
						QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13)
						APPLY TO SELECTION:C70([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]MenuIconRef:15:=$iconRef)
						KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
					End if 
				End if 
				
			: ($choice=4)  //remover icono
				[XShell_ExecutableObjects:280]IconRef:10:=0
				SAVE RECORD:C53([XShell_ExecutableObjects:280])
				
			: ($choice=5)  //remover icono en todas las combinaciones
				$r:=CD_Dlog (0;__ ("¿Estas seguro de eliminar  los iconos asociados a todas las combinaciones país/Idioma");__ ("");__ ("Si");__ ("Cancelar"))
				$iconRef:=0
				$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
				[XShell_ExecutableObjects:280]IconRef:10:=$iconRef
				SAVE RECORD:C53([XShell_ExecutableObjects:280])
				READ WRITE:C146([XShell_ExecutableObjects:280])
				QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13)
				APPLY TO SELECTION:C70([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]MenuIconRef:15:=$iconRef)
				KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
				
			: ($choice=7)  //copiar icono a todas las combinaciones país/Idioma
				$iconRef:=[XShell_ExecutableObjects:280]MenuIconRef:15
				$currentRecNum:=Record number:C243([XShell_ExecutableObjects:280])
				[XShell_ExecutableObjects:280]IconRef:10:=$iconRef
				SAVE RECORD:C53([XShell_ExecutableObjects:280])
				READ WRITE:C146([XShell_ExecutableObjects:280])
				QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Object_ID:13=[XShell_ExecutableObjects:280]Object_ID:13)
				APPLY TO SELECTION:C70([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]MenuIconRef:15:=$iconRef)
				KRL_GotoRecord (->[XShell_ExecutableObjects:280];$currentRecNum;True:C214)
		End case 
		
		
		$iconRef:=[XShell_ExecutableObjects:280]MenuIconRef:15
		If ($iconRef>0)
			vl_CurrentIconRef:=$iconRef
			OBJECT SET FORMAT:C236(*;"bPreviewMenuIcon";"1;1;?"+String:C10($iconRef)+";64;0")
			OBJECT SET VISIBLE:C603(*;"bPreviewMenuIcon";True:C214)
			OBJECT GET COORDINATES:C663(bPreviewMenuIcon;$left;$top;$right;$bottom)
			IT_SetObjectRect (->bPreviewMenuIcon;$left;$top;$left+16;$top+16)
		Else 
			vl_CurrentIconRef:=0
			OBJECT SET FORMAT:C236(*;"bPreviewMenuIcon";"1;1;?"+String:C10(0)+";64;0")
			  //SET VISIBLE(*;"bPreviewButton@";False)
		End if 
		
End case 