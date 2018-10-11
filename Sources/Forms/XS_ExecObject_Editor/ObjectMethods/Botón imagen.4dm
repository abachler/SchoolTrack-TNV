  // Método: Método de Objeto: XS_ExecObject_Editor.Botón imagen
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 12/07/10, 09:54:39
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
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
