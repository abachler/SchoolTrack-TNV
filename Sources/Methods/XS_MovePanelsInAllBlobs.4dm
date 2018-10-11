//%attributes = {}
  //XS_MovePanelsInAllBlobs

$ModuleRef:=$1
$origin:=$2
$destination:=$3

ARRAY TEXT:C222($aCountryCodes;0)
ARRAY TEXT:C222($aLanguageCodes;0)
HL_List2Array ("XS_CountryCodes";->$aCountryCodes)
HL_List2Array ("XS_LangageCodes";->$aLanguageCodes)

C_BLOB:C604($blob)

For ($i;1;Size of array:C274($aCountryCodes))
	$country:=ST_GetWord ($aCountryCodes{$i};1;":")
	For ($j;1;Size of array:C274($aLanguageCodes))
		$langage:=ST_GetWord ($aLanguageCodes{$j};1;":")
		$tempList:=New list:C375
		$modulePrefRef:=XS_GetBlobName ("browser";$moduleRef;$country;$langage)
		$blob:=PREF_fGetBlob (0;$modulePrefRef)
		$tempList:=BLOB to list:C557($blob)
		SET BLOB SIZE:C606($blob;0)
		$items:=Count list items:C380($tempList)
		GET LIST ITEM:C378($tempList;$origin;$tableRef2move;$tableName2Move)
		DELETE FROM LIST:C624($tempList;$tableRef2move)
		If ($destination>$items)
			APPEND TO LIST:C376($tempList;$tableName2Move;$tableRef2move)
		Else 
			If ($destination>Count list items:C380($tempList))
				APPEND TO LIST:C376($tempList;$tableName2Move;$tableRef2move)
			Else 
				GET LIST ITEM:C378($tempList;$destination;$insertBefore;$tableName)
				INSERT IN LIST:C625($tempList;$insertBefore;$tableName2Move;$tableRef2move)
			End if 
		End if 
		LIST TO BLOB:C556($tempList;$blob)
		PREF_SetBlob (0;$modulePrefRef;$blob)
		CLEAR LIST:C377($tempList)
	End for 
End for 

XS_Settings ("GetModulePanels")