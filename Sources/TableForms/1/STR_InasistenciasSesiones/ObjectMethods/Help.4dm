  // [xxSTR_Constants].STR_InasistenciasSesiones.Help()
  // Por: Alberto Bachler: 06/07/13, 18:23:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

vtMSG_Detalle:=MSG_TextoMensaje ("86/Ayuda")
WDW_OpenPopupWindow (Self:C308;$y_Nil;"DLOG_Detalles";32)
DIALOG:C40("DLOG_Detalles")
CLOSE WINDOW:C154

GOTO OBJECT:C206(hl_cursosAsistenciaSesiones)
OBJECT SET SCROLL POSITION:C906(hl_cursosAsistenciaSesiones;Selected list items:C379(hl_cursosAsistenciaSesiones))