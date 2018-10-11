//%attributes = {}
  //XS_InsertInAllConfigBlobs

$ModuleRef:=$1
$selected:=$2

ARRAY TEXT:C222($aCountryCodes;0)
ARRAY TEXT:C222($aLanguageCodes;0)
HL_List2Array ("XS_CountryCodes";->$aCountryCodes)
HL_List2Array ("XS_LangageCodes";->$aLanguageCodes)
C_BLOB:C604($blob)
For ($i;1;Size of array:C274($aCountryCodes))
	$country:=ST_GetWord ($aCountryCodes{$i};1;":")
	For ($j;1;Size of array:C274($aLanguageCodes))
		$langage:=ST_GetWord ($aLanguageCodes{$j};1;":")
		$configPref:=XS_GetBlobName ("config";$moduleRef;$country;$langage)
		$blob:=PREF_fGetBlob (0;$configPref)
		$tempConfig:=New list:C375
		$tempConfig:=BLOB to list:C557($blob)
		$listElements:=Count list items:C380($tempConfig)
		$ref:=HL_GetNextItemRefNumber ($tempConfig)
		If ($selected#0)
			SELECT LIST ITEMS BY POSITION:C381($tempConfig;$selected)
			INSERT IN LIST:C625($tempConfig;*;"Panel de Configuración "+String:C10($listElements+1)+";Método";$ref)
		Else 
			APPEND TO LIST:C376($tempConfig;"Panel de Configuración "+String:C10($listElements+1)+";Método";$ref)
		End if 
		LIST TO BLOB:C556($tempConfig;$blob)
		PREF_SetBlob (0;$configPref;$blob)
		CLEAR LIST:C377($tempConfig)
		SET BLOB SIZE:C606($blob;0)
	End for 
End for 

XS_Settings ("GetConfig&WizardsItems")

$0:=$ref