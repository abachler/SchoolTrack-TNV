//%attributes = {}
  //XS_MoveInAllPanelBlobs

$ModuleRef:=$1
$PanelRef:=$2
$origin:=$3
$destination:=$4

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
		$temp1:=alVS_BrowserPosition{$origin}
		$temp2:=alVS_TableNumber{$origin}
		$temp3:=alVS_FieldNumber{$origin}
		$temp4:=atVS_Header{$origin}
		$temp5:=alVS_ColumnWidth{$origin}
		$temp6:=atVS_BrowserFormat{$origin}
		$temp7:=atVS_FieldNames{$origin}
		AT_Delete ($origin;1;->alVS_BrowserPosition;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_ColumnWidth;->atVS_BrowserFormat;->atVS_FieldNames)
		AT_Insert ($destination;1;->alVS_BrowserPosition;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_ColumnWidth;->atVS_BrowserFormat;->atVS_FieldNames)
		alVS_BrowserPosition{$destination}:=$temp1
		alVS_TableNumber{$destination}:=$temp2
		alVS_FieldNumber{$destination}:=$temp3
		atVS_Header{$destination}:=$temp4
		alVS_ColumnWidth{$destination}:=$temp5
		atVS_BrowserFormat{$destination}:=$temp6
		atVS_FieldNames{$destination}:=$temp7
		For ($c;1;Size of array:C274(alvs_TableNumber))
			alVS_BrowserPosition{$c}:=$c
		End for 
		SORT ARRAY:C229(alVS_BrowserPosition;alVS_TableNumber;alVS_FieldNumber;atVS_Header;alVS_ColumnWidth;atVS_BrowserFormat;atVS_FieldNames;>)
		SET BLOB SIZE:C606($blob;0)
		BLOB_Variables2Blob (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
		PREF_SetBlob (0;$PanelPref;$blob)
	End for 
End for 