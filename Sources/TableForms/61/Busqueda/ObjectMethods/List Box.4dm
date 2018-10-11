  // [BBL_Items].Busqueda.List Box()
  // 
  //
  // creado por: Alberto Bachler Klein: 13/03/17, 12:55:19
  // -----------------------------------------------------------


If (Form event:C388=On Double Clicked:K2:5)
	If (Records in set:C195("$ListboxItems")>0)
		USE SET:C118("$ListboxItems")
		SET_ClearSets ("$ListboxItems")
	End if 
	
	If (Records in selection:C76([BBL_Items:61])>0)
		ACCEPT:C269
	Else 
		CANCEL:C270
	End if 
End if 