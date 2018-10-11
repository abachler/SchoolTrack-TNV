  // [BBL_Lectores].Selección.bSeleccionarregistro()
  // Por: Alberto Bachler: 12/11/13, 17:18:59
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



If (Selected record number:C246(Table:C252(vl_tablaSubForm)->)>0)
	ACCEPT:C269
Else 
	CANCEL:C270
End if 

