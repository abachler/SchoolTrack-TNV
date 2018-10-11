//%attributes = {}
  //XS_SaveInAllPanelBlobs

$ModuleRef:=$1
$PanelRef:=$2

ARRAY TEXT:C222($aCountryCodes;0)
ARRAY TEXT:C222($aLanguageCodes;0)
HL_List2Array ("XS_CountryCodes";->$aCountryCodes)
HL_List2Array ("XS_LangageCodes";->$aLanguageCodes)

$vtBWR_OnLoadMethod:=vtBWR_OnLoadMethod
$vtBWR_OnClickMethod:=vtBWR_OnClickMethod
$vtBWR_OnDClickMethod:=vtBWR_OnDClickMethod
$vtBWR_OnRClickMethod:=vtBWR_OnRClickMethod
$viBWR_LockColumns:=viBWR_LockColumns
$vtBWR_sortOrder:=vtBWR_sortOrder
$vsBWR_defaultInputForm:=vsBWR_defaultInputForm
$vtBWR_OnEClickMethod:=vtBWR_OnEClickMethod
$vtBWR_OnEDClickMethod:=vtBWR_OnEDClickMethod
$vtBWR_OnERClickMethod:=vtBWR_OnERClickMethod
$vtBWR_OnHRClickMethod:=vtBWR_OnHRClickMethod
$viBWR_HiddenColumns:=viBWR_HiddenColumns
COPY ARRAY:C226(atVS_BrowserFormat;$atVS_BrowserFormat)
COPY ARRAY:C226(alVS_ColumnWidth;$alVS_ColumnWidth)
COPY ARRAY:C226(atVS_Header;$atVS_Header)
COPY ARRAY:C226(atVS_FieldNames;$atVS_FieldNames)
COPY ARRAY:C226(alVS_QFSourceTableNumber;$alVS_QFSourceTableNumber)
COPY ARRAY:C226(alVS_QFSourceFieldNumber;$alVS_QFSourceFieldNumber)
COPY ARRAY:C226(alVS_QFRelateToFieldNumber;$alVS_QFRelateToFieldNumber)
COPY ARRAY:C226(atVS_QFSourceFieldAlias;$atVS_QFSourceFieldAlias)
COPY ARRAY:C226(aiVS_QFSourceFieldOrder;$aiVS_QFSourceFieldOrder)
COPY ARRAY:C226(alVS_QFRelateFromField;$alVS_QFRelateFromField)
COPY ARRAY:C226(atVS_QFSpecialRelationMethod;$atVS_QFSpecialRelationMethod)

C_BLOB:C604($blob)

For ($i;1;Size of array:C274($aCountryCodes))
	For ($j;1;Size of array:C274($aLanguageCodes))
		$PanelPref:=XS_GetBlobName ("panel";$ModuleRef;ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":");$PanelRef)
		$blob:=PREF_fGetBlob (0;$PanelPref;$blob)
		BLOB_Blob2Vars (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
		vtBWR_OnLoadMethod:=$vtBWR_OnLoadMethod
		vtBWR_OnClickMethod:=$vtBWR_OnClickMethod
		vtBWR_OnDClickMethod:=$vtBWR_OnDClickMethod
		vtBWR_OnRClickMethod:=$vtBWR_OnRClickMethod
		viBWR_LockColumns:=$viBWR_LockColumns
		vtBWR_sortOrder:=$vtBWR_sortOrder
		vsBWR_defaultInputForm:=$vsBWR_defaultInputForm
		vtBWR_OnEClickMethod:=$vtBWR_OnEClickMethod
		vtBWR_OnEDClickMethod:=$vtBWR_OnEDClickMethod
		vtBWR_OnERClickMethod:=$vtBWR_OnERClickMethod
		vtBWR_OnHRClickMethod:=$vtBWR_OnHRClickMethod
		viBWR_HiddenColumns:=$viBWR_HiddenColumns
		COPY ARRAY:C226($atVS_BrowserFormat;atVS_BrowserFormat)
		COPY ARRAY:C226($alVS_ColumnWidth;alVS_ColumnWidth)
		  //COPY ARRAY($atVS_Header;atVS_Header)
		  //COPY ARRAY($atVS_FieldNames;atVS_FieldNames)
		COPY ARRAY:C226($alVS_QFSourceTableNumber;alVS_QFSourceTableNumber)
		COPY ARRAY:C226($alVS_QFSourceFieldNumber;alVS_QFSourceFieldNumber)
		COPY ARRAY:C226($alVS_QFRelateToFieldNumber;alVS_QFRelateToFieldNumber)
		  //COPY ARRAY($atVS_QFSourceFieldAlias;atVS_QFSourceFieldAlias)
		COPY ARRAY:C226($aiVS_QFSourceFieldOrder;aiVS_QFSourceFieldOrder)
		COPY ARRAY:C226($alVS_QFRelateFromField;alVS_QFRelateFromField)
		COPY ARRAY:C226($atVS_QFSpecialRelationMethod;atVS_QFSpecialRelationMethod)
		SET BLOB SIZE:C606($blob;0)
		BLOB_Variables2Blob (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
		PREF_SetBlob (0;$PanelPref;$blob)
	End for 
End for 

vtBWR_OnLoadMethod:=$vtBWR_OnLoadMethod
vtBWR_OnClickMethod:=$vtBWR_OnClickMethod
vtBWR_OnDClickMethod:=$vtBWR_OnDClickMethod
vtBWR_OnRClickMethod:=$vtBWR_OnRClickMethod
viBWR_LockColumns:=$viBWR_LockColumns
vtBWR_sortOrder:=$vtBWR_sortOrder
vsBWR_defaultInputForm:=$vsBWR_defaultInputForm
vtBWR_OnEClickMethod:=$vtBWR_OnEClickMethod
vtBWR_OnEDClickMethod:=$vtBWR_OnEDClickMethod
vtBWR_OnERClickMethod:=$vtBWR_OnERClickMethod
vtBWR_OnHRClickMethod:=$vtBWR_OnHRClickMethod
viBWR_HiddenColumns:=$viBWR_HiddenColumns
COPY ARRAY:C226($atVS_BrowserFormat;atVS_BrowserFormat)
COPY ARRAY:C226($alVS_ColumnWidth;alVS_ColumnWidth)
COPY ARRAY:C226($atVS_Header;atVS_Header)
COPY ARRAY:C226($atVS_FieldNames;atVS_FieldNames)
COPY ARRAY:C226($alVS_QFSourceTableNumber;alVS_QFSourceTableNumber)
COPY ARRAY:C226($alVS_QFSourceFieldNumber;alVS_QFSourceFieldNumber)
COPY ARRAY:C226($alVS_QFRelateToFieldNumber;alVS_QFRelateToFieldNumber)
COPY ARRAY:C226($atVS_QFSourceFieldAlias;atVS_QFSourceFieldAlias)
COPY ARRAY:C226($aiVS_QFSourceFieldOrder;aiVS_QFSourceFieldOrder)
COPY ARRAY:C226($alVS_QFRelateFromField;alVS_QFRelateFromField)
COPY ARRAY:C226($atVS_QFSpecialRelationMethod;atVS_QFSpecialRelationMethod)