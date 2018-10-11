C_LONGINT:C283($l_proc)
$l_proc:=IT_UThermometer (1;0;__ ("Buscando documentos según criterio seleccionado..."))

ACTdteRec_LlenaArreglos (vlACT_RSSel;atACTdteRec_RazonSocial{atACTdteRec_RazonSocial};atACTdteRec_RutEmisor{atACTdteRec_RutEmisor};vrACT_folio;vdACT_fechaEmision;vdACT_fechaRecepcion;atACTdteRec_Periodo{atACTdteRec_Periodo};atACTdteRec_Recepcion{atACTdteRec_Recepcion})

ACTdteRec_Generales ("InicializaOpcionesBusqueda")

IT_UThermometer (-2;$l_proc)