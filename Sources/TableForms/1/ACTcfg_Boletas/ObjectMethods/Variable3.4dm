AL_UpdateArrays (ALP_TiposdeDoc;0)
AT_Insert (1;1;->atACT_Cats;->atACT_NombreDoc;->alACT_Proxima;->atACT_Tipo;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->apACT_Afecta;->abACT_Afecta;->abACT_DocPorDefecto;->apACT_DocPorDefecto;->abACT_DocComplete;->aiACT_Tipo;->atACT_idNumeracion;->atACT_RazonSocial;->alACT_RazonSocial;->alACT_IdDTSinc;->atACT_DTSinc)
$nextID:=Num:C11(PREF_fGet (0;"ACT_DTNextID";"1"))
alACT_IDDT{1}:=$nextID
PREF_Set (0;"ACT_DTNextID";String:C10($nextID+1))
abACT_Afecta{1}:=False:C215
GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_Afecta{1})
If (Size of array:C274(atACT_Impresoras)=1)
	atACT_Impresora{1}:=atACT_Impresoras{1}
Else 
	atACT_Impresora{1}:=__ ("Seleccionar...")
End if 
atACT_ModeloDoc{1}:=__ ("Seleccionar...")
atACT_Tipo{1}:=__ ("Seleccionar...")
atACT_Cats{1}:=__ ("Seleccionar...")
aiACT_Tipo{1}:=0
AL_UpdateArrays (ALP_TiposdeDoc;-2)
ACTcfg_SetDocRowsColor 
GOTO OBJECT:C206(ALP_TiposdeDoc)
AL_GotoCell (ALP_TiposdeDoc;2;1)
_O_ENABLE BUTTON:C192(bDelDoc)