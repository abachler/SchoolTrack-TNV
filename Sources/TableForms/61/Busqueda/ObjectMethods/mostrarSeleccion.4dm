  // [BBL_Items].Busqueda.Cerrar1()
  // Por: Alberto Bachler K.: 16-12-14, 18:15:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Records in selection:C76([BBL_Items:61])>0)
	USE SET:C118("$ListboxItems")
	CLEAR SET:C117("$ListboxItems")
	ACCEPT:C269
End if 
