vlACT_RSSel:=alACTcfg_Razones{atACTcfg_Razones}
ACTcfg_OpcionesRazonesSociales ("CargaByID";->vlACT_RSSel)

C_LONGINT:C283($l_proc)
$l_proc:=IT_UThermometer (1;0;"Cargando documentos...")
ACTdteEmi_Generales ("InicializaOpcionesBusqueda")
ACTdteEmi_LlenaArreglos (vlACT_RSSel)
IT_UThermometer (-2;$l_proc)