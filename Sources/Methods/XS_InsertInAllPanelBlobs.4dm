//%attributes = {}
  //XS_InsertInAllPanelBlobs

$ModuleRef:=$1
$PanelRef:=$2
$tableNum:=$3
$fieldNum:=$4
$itemText:=$5
$position:=$6
$format:=$7

QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$tableNum;*)
QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2=$fieldNum)
$fieldID:=[xShell_Fields:52]ID:24
UNLOAD RECORD:C212([xShell_Fields:52])

ARRAY TEXT:C222($aCountryCodes;0)
ARRAY TEXT:C222($aLanguageCodes;0)
HL_List2Array ("XS_CountryCodes";->$aCountryCodes)
HL_List2Array ("XS_LangageCodes";->$aLanguageCodes)

COPY ARRAY:C226(alvs_TableNumber;$alvs_TableNumber)
COPY ARRAY:C226(alvs_FieldNumber;$alvs_FieldNumber)
COPY ARRAY:C226(atvs_Header;$atvs_Header)
COPY ARRAY:C226(alVS_BrowserPosition;$alVS_BrowserPosition)
COPY ARRAY:C226(atVS_BrowserFormat;$atVS_BrowserFormat)
COPY ARRAY:C226(alVS_ColumnWidth;$alVS_ColumnWidth)
COPY ARRAY:C226(atVS_FieldNames;$atVS_FieldNames)

C_BLOB:C604($blob)

For ($i;1;Size of array:C274($aCountryCodes))
	For ($j;1;Size of array:C274($aLanguageCodes))
		$PanelPref:=XS_GetBlobName ("panel";$ModuleRef;ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":");$PanelRef)
		$blob:=PREF_fGetBlob (0;$PanelPref;$blob)
		BLOB_Blob2Vars (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
		AT_Insert ($position;1;->alvs_TableNumber;->alvs_FieldNumber;->atvs_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->alVS_ColumnWidth;->atVS_FieldNames)
		alvs_TableNumber{$position}:=$tableNum
		alvs_FieldNumber{$position}:=$fieldNum
		atvs_Header{$position}:=XSvs_nombreCampoLocal_Numero ($tableNum;$fieldID;ST_GetWord ($aCountryCodes{$i};1;":");ST_GetWord ($aLanguageCodes{$j};1;":"))
		atVS_FieldNames{$position}:=atvs_Header{$position}
		alVS_BrowserPosition{$position}:=$position
		atVS_BrowserFormat{$position}:=$format
		For ($c;1;Size of array:C274(alvs_TableNumber))
			alVS_BrowserPosition{$c}:=$c
		End for 
		SORT ARRAY:C229(alVS_BrowserPosition;alVS_TableNumber;alVS_FieldNumber;atVS_Header;alVS_ColumnWidth;atVS_BrowserFormat;atVS_FieldNames;>)
		BLOB_Variables2Blob (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
		PREF_SetBlob (0;$PanelPref;$blob)
	End for 
End for 
XS_Settings ("GetPanelColumns")