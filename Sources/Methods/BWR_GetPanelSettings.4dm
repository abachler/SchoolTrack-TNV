//%attributes = {}
  //BWR_GetPanelSettings

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 06/08/03, 15:22:13
  // -------------------------------------------------------------------------------
  // Metodo: BWR_GetPanelSettings
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================

  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_LONGINT:C283(viBWR_HiddenColumns)
C_LONGINT:C283($tableNumber;$moduleRef;$1;$2)
C_TEXT:C284($tableName;$moduleName)
C_TEXT:C284(vtBWR_OnLoadMethod;vtBWR_OnClickMethod;vtBWR_OnDClickMethod;vtBWR_OnRClickMethod;vtVS_FieldFormat;vtBWR_sortOrder;vtBWR_OnEClickMe;vtBWR_OnEDClickMethod;vtBWR_OnERClickMethod;vtBWR_OnHRClickMethod)
C_LONGINT:C283(viBWR_LockColumns)
C_BLOB:C604($blob)

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$moduleRef:=$1
$tableNumber:=$2
$c:=<>vtXS_CountryCode
$l:=<>vtXS_langage
If (Count parameters:C259=4)
	$c:=$3
	$l:=$4
End if 

If ($c="")
	$c:="cl"
End if 
If ($l="")
	$0:="es"
End if 

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
READ ONLY:C145([xShell_Tables:51])
QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$tableNumber)

$prefRef:=XS_GetBlobName ("panel";$ModuleRef;$c;$l;$tableNumber)
$blob:=PREF_fGetBlob (0;$prefRef;$blob)

ARRAY INTEGER:C220(alVS_TableNumber;0)
ARRAY INTEGER:C220(alVS_FieldNumber;0)
ARRAY INTEGER:C220(alVS_BrowserPosition;0)
ARRAY TEXT:C222(atVS_Header;0)
ARRAY TEXT:C222(atVS_FieldNames;0)
ARRAY TEXT:C222(atVS_BrowserFormat;0)
ARRAY INTEGER:C220(alVS_ColumnWidth;0)

ARRAY LONGINT:C221(alVS_QFSourceTableNumber;0)
ARRAY LONGINT:C221(alVS_QFSourceFieldNumber;0)
ARRAY LONGINT:C221(alVS_QFRelateFromField;0)
ARRAY LONGINT:C221(alVS_QFRelateToFieldNumber;0)
ARRAY TEXT:C222(atVS_QFSourceFieldAlias;0)
ARRAY TEXT:C222(atVS_QFSpecialRelationMethod;0)
ARRAY INTEGER:C220(aiVS_QFSourceFieldOrder;0)

Case of 
	: (BLOB size:C605($blob)>0)
		BLOB_Blob2Vars (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
	: (BLOB size:C605([xShell_Tables:51]CamposEnExplorador:6)>0)
		BLOB_Blob2Vars (->[xShell_Tables:51]CamposEnExplorador:6;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Header;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
	Else 
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$tableNumber;*)
		QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]ColumnaEnExplorador:18>0)
		SELECTION TO ARRAY:C260([xShell_Fields:52]ColumnaEnExplorador:18;alVS_BrowserPosition;[xShell_Fields:52]NumeroTabla:1;alVS_TableNumber;[xShell_Fields:52]NumeroCampo:2;alVS_FieldNumber;[xShell_Fields:52]FormatoExplorador:22;atVS_BrowserFormat;[xShell_Fields:52]ID:24;$aFieldID)
		ARRAY TEXT:C222(atVS_Header;Size of array:C274(alVS_TableNumber))
		ARRAY TEXT:C222(atVS_FieldNames;Size of array:C274(alVS_TableNumber))
		For ($i;1;Size of array:C274(alVS_TableNumber))
			atVS_Header{$i}:=XSvs_nombreCampoLocal_Numero (alVS_TableNumber{$i};$aFieldID{$i};<>vtXS_CountryCode;<>vtXS_Langage)
			atVS_FieldNames{$i}:=atVS_Header{$i}
		End for 
		ARRAY INTEGER:C220(alVS_ColumnWidth;Size of array:C274(alVS_BrowserPosition))
End case 
SORT ARRAY:C229(alVS_BrowserPosition;alVS_TableNumber;alVS_FieldNumber;atVS_Header;alVS_ColumnWidth;atVS_BrowserFormat;atVS_FieldNames;>)