C_LONGINT:C283($l_proc)
$l_proc:=IT_UThermometer (1;0;__ ("Buscando documentos según criterio seleccionado..."))

ACTdteEmi_LlenaArreglos (vlACT_RSSel;vrACT_folio;vdACT_fechaEmision;vdACT_fechaEmisionH;atACTdteEmi_Periodo{atACTdteEmi_Periodo})

ACTdteEmi_Generales ("InicializaOpcionesBusqueda")

IT_UThermometer (-2;$l_proc)