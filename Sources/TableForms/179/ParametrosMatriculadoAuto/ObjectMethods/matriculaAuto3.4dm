ACTcfg_ItemsMatricula ("SeteaEstadosObjetosCfg")
  //20120723 RCH Se registran cambios en conf
$vt_log:=LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->;True:C214)
ACTcfg_ItemsMatricula ("AgregaLogItemsMatricula";->$vt_log)