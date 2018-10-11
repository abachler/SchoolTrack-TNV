//%attributes = {}
  //XS_RemoveQFFromAllPanelBlobs

$ModuleRef:=$1
$delete:=$2
$PanelRef:=$3

ARRAY TEXT:C222($aCountryCodes;0)
ARRAY TEXT:C222($aLanguageCodes;0)
HL_List2Array ("XS_CountryCodes";->$aCountryCodes)
HL_List2Array ("XS_LangageCodes";->$aLanguageCodes)

C_BLOB:C604($blob)

For ($i;1;Size of array:C274($aCountryCodes))
	For ($j;1;Size of array:C274($aLanguageCodes))
		$PanelPref:=XS_GetBlobName ("panel";$ModuleRef;ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":");$PanelRef)
		$blob:=PREF_fGetBlob (0;$PanelPref;$blob)
		BLOB_Blob2Vars (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
		AT_Delete ($delete;1;->aiVS_QFSourceFieldOrder;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->atVS_QFSourceFieldAlias;->alVS_QFRelateToFieldNumber;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod)
		For ($c;1;Size of array:C274(aiVS_QFSourceFieldOrder))
			aiVS_QFSourceFieldOrder{$c}:=$c
		End for 
		SORT ARRAY:C229(aiVS_QFSourceFieldOrder;alVS_QFSourceTableNumber;alVS_QFSourceFieldNumber;atVS_QFSourceFieldAlias;alVS_QFRelateToFieldNumber;alVS_QFRelateFromField;atVS_QFSpecialRelationMethod;>)
		SET BLOB SIZE:C606($blob;0)
		BLOB_Variables2Blob (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
		PREF_SetBlob (0;$PanelPref;$blob)
	End for 
End for 

XS_Settings ("GetModuleTables")
XS_Settings ("GetModulePanels")