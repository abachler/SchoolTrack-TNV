//%attributes = {}
  //XS_VerifyPanelTranslations

$ModuleRef:=$1
$PanelRef:=$2

ARRAY TEXT:C222($aCountryCodes;0)
ARRAY TEXT:C222($aLanguageCodes;0)
HL_List2Array ("XS_CountryCodes";->$aCountryCodes)
HL_List2Array ("XS_LangageCodes";->$aLanguageCodes)

C_BLOB:C604($blob)

For ($i;1;Size of array:C274($aCountryCodes))
	$country:=ST_GetWord ($aCountryCodes{$i};1;":")
	For ($j;1;Size of array:C274($aLanguageCodes))
		$langage:=ST_GetWord ($aLanguageCodes{$j};1;":")
		$PanelPref:=XS_GetBlobName ("panel";$ModuleRef;$country;$langage;$PanelRef)
		READ ONLY:C145([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$PanelPref;*)
		QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]User:9=0)
		If (Records in selection:C76([xShell_Prefs:46])=0)
			AT_Initialize (->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth)
			vtBWR_OnLoadMethod:=""
			vtBWR_OnClickMethod:=""
			vtBWR_OnDClickMethod:=""
			vtBWR_OnRClickMethod:=""
			AT_Initialize (->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod)
			viBWR_LockColumns:=0
			vtBWR_sortOrder:=""
			vsBWR_defaultInputForm:=""
			vtBWR_OnEClickMethod:=""
			vtBWR_OnEDClickMethod:=""
			vtBWR_OnERClickMethod:=""
			vtBWR_OnHRClickMethod:=""
			viBWR_HiddenColumns:=0
			
			BLOB_Variables2Blob (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
			COMPRESS BLOB:C534($blob)
			PREF_SetBlob (0;$PanelPref;$blob)
		End if 
	End for 
End for 