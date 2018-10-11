  // [BBL_Items].Busqueda.Cerrar1()
  // Por: Alberto Bachler K.: 16-12-14, 18:15:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Records in set:C195("$ListboxItems")>0)
	USE SET:C118("$ListboxItems")
	SET_ClearSets ("$ListboxItems")
End if 

If (Records in selection:C76([BBL_Items:61])>0)
	ACCEPT:C269
Else 
	CANCEL:C270
End if 

