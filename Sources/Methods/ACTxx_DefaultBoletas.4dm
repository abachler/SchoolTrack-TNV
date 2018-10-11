//%attributes = {}
  //ACTxx_DefaultBoletas

$Process:=IT_UThermometer (1;0;__ ("Creando preferencias por defecto..."))
SET BLOB SIZE:C606(xblob;0)
cb_GenerarBoletaCaja:=1
cb_SeqBoletaPorUsuario:=0
LIST TO ARRAY:C288("ACT_Boletas";atACT_TipoDoc)
$TiposDoc:=Size of array:C274(atACT_TipoDoc)
ARRAY BOOLEAN:C223(abACT_Seleccionada;$TiposDoc)
ARRAY LONGINT:C221(alACT_Proxima;$TiposDoc)
ARRAY TEXT:C222(atACT_Impresora;$TiposDoc)
ARRAY TEXT:C222(atACT_ModeloDoc;$TiposDoc)
cb_EmitirRecibo:=0
vbACT_Seleccionada:=False:C215
vtACT_Seleccionar:="Seleccionar..."
vlACT_Proxima:=1
AT_Populate (->abACT_Seleccionada;->vbACT_Seleccionada)
AT_Populate (->alACT_Proxima;->vlACT_Proxima)
AT_Populate (->atACT_Impresora;->vtACT_Seleccionar)
AT_Populate (->atACT_ModeloDoc;->vtACT_Seleccionar)
abACT_Seleccionada{1}:=True:C214
BLOB_Variables2Blob (->xblob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->abACT_Seleccionada;->atACT_TipoDoc;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->cb_EmitirRecibo)
PREF_SetBlob (0;"ACT_boletas";xblob)
IT_UThermometer (-2;$Process)