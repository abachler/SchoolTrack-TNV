//%attributes = {}
  //XS_RemovePanelInAllBlobs

$ModuleRef:=$1
$delete:=$2

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
		GET LIST ITEM:C378($tempList;$delete;$tableRef2move;$tableName2Move)
		DELETE FROM LIST:C624($tempList;$tableRef2move)
		LIST TO BLOB:C556($tempList;$blob)
		PREF_SetBlob (0;$modulePrefRef;$blob)
		SET BLOB SIZE:C606($blob;0)
		CLEAR LIST:C377($tempList)
		READ WRITE:C146([xShell_Prefs:46])
		$panel:=XS_GetBlobName ("panel";$moduleRef;$country;$langage;$tableRef2move)
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$panel)
		DELETE RECORD:C58([xShell_Prefs:46])
		KRL_UnloadReadOnly (->[xShell_Prefs:46])
	End for 
End for 

XS_Settings ("GetModuleTables")
XS_Settings ("GetModulePanels")