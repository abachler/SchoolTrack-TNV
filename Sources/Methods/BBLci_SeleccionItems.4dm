//%attributes = {}
  // BBLci_SeleccionItems()
  // Por: Alberto Bachler: 01/10/13, 18:24:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283(vl_tablaSubForm)
C_POINTER:C301($y_Nil)
vl_tablaSubForm:=Table:C252(->[BBL_Items:61])
WDW_OpenPopupWindow (OBJECT Get pointer:C1124(Object current:K67:2);$y_Nil;"SeleccionRegistros")
DIALOG:C40("SelecciónRegistros")
CLOSE WINDOW:C154


$0:=OK

