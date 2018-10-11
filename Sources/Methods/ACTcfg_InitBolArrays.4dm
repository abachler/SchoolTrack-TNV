//%attributes = {}
  //ACTcfg_InitBolArrays

C_LONGINT:C283(cb_GenerarBoletaCaja;cb_SeqBoletaPorUsuario;cb_EmitirRecibo;vlACT_NextRecibo;vlACT_CatVR;vlACT_ModRecibo)
C_REAL:C285(cbAgruparBoletas;cb_GenerarBoletaCero;cb_ImprimirCeros;cb_EliminarPagosAsociados;cbUsarCategorias;cb_BoletaSubvencionada)
C_LONGINT:C283(cb_UtilizaMultiNum;btnUsuario;btnRBD;cb_EmiteXApoderado;cb_EmiteXCuenta)
C_LONGINT:C283(cb_Sincroniza)
C_TEXT:C284(vtACT_ModRecibo;vtACT_PrinterRecibo;vtACT_CatVR)
C_LONGINT:C283(cbOrdenaRegXFam)
C_LONGINT:C283(vlACTdt_numLineas)
C_LONGINT:C283(cbEmitirXCategorias)  //20160805 RCH
C_LONGINT:C283(cbEmitirXMonedas)  //20160924 RCH
C_LONGINT:C283(lACTbol_DiaVencimiento)  //20160924 RCH

ARRAY TEXT:C222(atACT_Impresoras;0)
ARRAY TEXT:C222(atACT_ModelosDoc;0)
ARRAY TEXT:C222(atACT_ModelosDesc;0)
ARRAY LONGINT:C221(alACT_ModelosDocID;0)
ARRAY BOOLEAN:C223(abACT_ModelosEsSt;0)
ARRAY LONGINT:C221(alACT_ModelosDocRegXPag;0)
ARRAY TEXT:C222(atACT_Tipos;2)
atACT_Tipos{1}:=__ ("Impreso")
atACT_Tipos{2}:=__ ("Digital")
ARRAY TEXT:C222(atACT_Categorias;0)
ARRAY PICTURE:C279(apACT_ReqDatos;0)
ARRAY BOOLEAN:C223(abACT_ReqDatos;0)

ARRAY PICTURE:C279(apACT_EmiteAfectoExento;0)
ARRAY BOOLEAN:C223(abACT_EmiteAfectoExento;0)

ARRAY TEXT:C222(atACT_Cats;0)
ARRAY TEXT:C222(atACT_NombreDoc;0)
ARRAY TEXT:C222(atACT_ModeloDoc;0)
ARRAY LONGINT:C221(alACT_IDDT;0)
ARRAY LONGINT:C221(alACT_IDCat;0)
ARRAY LONGINT:C221(alACT_IDsCats;0)
ARRAY PICTURE:C279(apACT_Afecta;0)
ARRAY BOOLEAN:C223(abACT_Afecta;0)
ARRAY BOOLEAN:C223(abACT_PorDefecto;0)
ARRAY PICTURE:C279(apACT_PorDefecto;0)
ARRAY BOOLEAN:C223(abACT_DocPorDefecto;0)
ARRAY PICTURE:C279(apACT_DocPorDefecto;0)
ARRAY BOOLEAN:C223(abACT_DocComplete;0)
ARRAY INTEGER:C220(aiACT_Tipo;0)
ARRAY TEXT:C222(atACT_Tipo;0)
ARRAY LONGINT:C221(alACT_Proxima;0)
ARRAY TEXT:C222(atACT_Impresora;0)

ARRAY TEXT:C222(atACT_idNumeracion;0)
ARRAY TEXT:C222(atACT_RBDList;0)

ARRAY LONGINT:C221(alACT_RazonSocial;0)
ARRAY TEXT:C222(atACT_RazonSocial;0)
ARRAY TEXT:C222(atACT_NombreDoc2;0)
  //
ARRAY LONGINT:C221(alACT_IdDTSinc;0)
ARRAY TEXT:C222(atACT_DTSinc;0)

ACTbol_LeeListaDocsTribs ("DeclaraArreglos")

  //20141119 RCH. Ticket 135762
ACTdte_AlertasOpciones ("LeeBlob")