//%attributes = {}
  //`Método: XS_CopyPrefWizServiceItems


C_BLOB:C604($blob)
C_TEXT:C284($item;$1;$blobType;$moduleName;$fromCountry;$fromLang)
C_LONGINT:C283($action;$2)
C_LONGINT:C283($moduleRef;$countryRef;$langRef)

$item:=$1
$action:=$2

GET LIST ITEM:C378(hl_Modules;*;$moduleRef;$moduleName)
GET LIST ITEM:C378(hl_Paises;*;$countryRef;$fromCountry)
GET LIST ITEM:C378(hl_langages;*;$langRef;$fromLang)


$fromCountry:=ST_GetWord ($fromCountry;1;":")
$fromLang:=ST_GetWord ($fromLang;1;":")
Case of 
	: ($item="Paneles de configuración")
		$itemType:="config"
		$sourceBlobName:=XS_GetBlobName ("config";$moduleRef;$fromCountry;$fromLang)
		$blob:=PREF_fGetBlob (0;$sourceBlobName)
	: ($item="Asistentes")
		$itemType:="wizard"
		$sourceBlobName:=XS_GetBlobName ("wizard";$moduleRef;$fromCountry;$fromLang)
		$blob:=PREF_fGetBlob (0;$sourceBlobName)
	: ($item="Items para el menú Herramientas")
		$itemType:="service"
		$sourceBlobName:=XS_GetBlobName ("service";$moduleRef;$fromCountry;$fromLang)
		$blob:=PREF_fGetBlob (0;$sourceBlobName)
End case 



Case of 
	: ($action=1)  //todos los idiomas, todos los paises
		For ($i;1;Count list items:C380(hl_Paises))
			GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
			$toCountry:=ST_GetWord ($text;1;":")
			For ($j;1;Count list items:C380(hl_Langages))
				GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
				$toLang:=ST_GetWord ($text;1;":")
				If (($fromCountry#$toCountry) | ($fromLang#$toLang))
					$destinationBlobName:=XS_GetBlobName ($itemType;$moduleRef;$toCountry;$toLang)
					PREF_SetBlob (0;$destinationBlobName;$blob)
				End if 
			End for 
		End for 
		
	: ($action=2)  //país seleccionado, todos los idiomas
		ARRAY TEXT:C222($aLanguages;0)
		HL_ReferencedList2Array (hl_Langages;->$aLanguages)
		For ($i;1;Size of array:C274($aLanguages))
			$langage:=ST_GetWord ($aLanguages{$i};1;":")
			If ($fromLang#$langage)
				$destinationBlobName:=XS_GetBlobName ($itemType;$moduleRef;$fromCountry;$langage)
				PREF_SetBlob (0;$destinationBlobName;$blob)
			End if 
		End for 
		
		
	: ($action=3)  // idioma seleccionado, todos los países
		ARRAY TEXT:C222($aCountries;0)
		HL_ReferencedList2Array (hl_Paises;->$aCountries)
		For ($i;1;Size of array:C274($aCountries))
			$country:=ST_GetWord ($aCountries{$i};1;":")
			If ($fromCountry#$country)
				$destinationBlobName:=XS_GetBlobName ($itemType;$moduleRef;$country;$fromLang)
				PREF_SetBlob (0;$destinationBlobName;$blob)
			End if 
		End for 
		
End case 