//%attributes = {}
  // BBL_LeePrefsCodigosBarra()
  // Por: Alberto Bachler: 17/09/13, 12:43:56
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
ARRAY TEXT:C222(<>atBBL_Media;0)
ARRAY LONGINT:C221(<>alBBL_IDMedia;0)
_O_ARRAY STRING:C218(3;<>asBBL_AbrevMedia;0)
ARRAY TEXT:C222(<>atBBL_GruposLectores;0)
ARRAY LONGINT:C221(<>alBBL_GruposLectores;0)
_O_ARRAY STRING:C218(3;<>asBBL_AbrevGruposLectores;0)

READ ONLY:C145([xxBBL_Preferencias:65])
ALL RECORDS:C47([xxBBL_Preferencias:65])
FIRST RECORD:C50([xxBBL_Preferencias:65])

<>bBBL_NumeroRegistroEditable:=[xxBBL_Preferencias:65]Registros_NumeroModificable:7
<>bBBL_BarcodeRegistroConPrefijo:=[xxBBL_Preferencias:65]Registro_BarCodeConPrefijo:32
<>bBBL_BarcodeLectorConPrefijo:=[xxBBL_Preferencias:65]Lector_BarCodeConPrefijo:35
<>lBBL_refCampoBarcodeLector:=[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33
<>lBBL_refCampoBarcodeDocumento:=[xxBBL_Preferencias:65]Registro_CampoFuenteBarcode:27


BBLcfg_TiposDocumentoPorDefecto 
BLOB_Blob2Vars (->[xxBBL_Preferencias:65]Items_TipoDocumentos:31;0;-><>atBBL_Media;-><>asBBL_AbrevMedia;-><>alBBL_IDMedia;-><>vlBBL_MediaPorDefecto)
SORT ARRAY:C229(<>atBBL_Media;<>alBBL_IDMedia;<>asBBL_AbrevMedia;>)

  //lectura de los prefijos para Media establecidos en la base  de datos
BBLcfg_GruposLectoresPorDefecto 
BLOB_Blob2Vars (->[xxBBL_Preferencias:65]Lector_GruposLectores:30;0;-><>atBBL_GruposLectores;-><>asBBL_AbrevGruposLectores;-><>alBBL_GruposLectores;-><>vlBBL_GrupoLectorPorDefecto)
SORT ARRAY:C229(<>atBBL_GruposLectores;<>alBBL_GruposLectores;<>asBBL_AbrevGruposLectores;>)
