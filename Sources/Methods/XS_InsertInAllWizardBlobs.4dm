//%attributes = {}
  //XS_InsertInAllWizardBlobs

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
		$wizardPref:=XS_GetBlobName ("wizard";$moduleRef;$country;$langage)
		$blob:=PREF_fGetBlob (0;$wizardPref)
		$tempWizard:=New list:C375
		$tempWizard:=BLOB to list:C557($blob)
		$listElements:=Count list items:C380($tempWizard)
		$ref:=HL_GetNextItemRefNumber ($tempWizard)
		If ($selected#0)
			SELECT LIST ITEMS BY POSITION:C381($tempWizard;$selected)
			INSERT IN LIST:C625($tempWizard;*;"Asistente "+String:C10($listElements+1)+";Método";$ref)
		Else 
			APPEND TO LIST:C376($tempWizard;"Asistente "+String:C10($listElements+1)+";Método";$ref)
		End if 
		LIST TO BLOB:C556($tempWizard;$blob)
		PREF_SetBlob (0;$wizardPref;$blob)
		SET BLOB SIZE:C606($blob;0)
		CLEAR LIST:C377($tempWizard)
	End for 
End for 

XS_Settings ("GetConfig&WizardsItems")

$0:=$ref