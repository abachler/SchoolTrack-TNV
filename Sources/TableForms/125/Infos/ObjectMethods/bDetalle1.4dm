  // DLOG_Confirmacion.Botón 3D()
  // Por: Alberto Bachler: 17/06/13, 05:39:48
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_POINTER:C301($y_Nil)
vtMSG_Detalle:=vt_ListaSesiones
WDW_OpenPopupWindow (Self:C308;$y_Nil;"DLOG_Detalles";32)
DIALOG:C40("DLOG_Detalles")
CLOSE WINDOW:C154


