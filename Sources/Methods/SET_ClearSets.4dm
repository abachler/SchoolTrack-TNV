//%attributes = {}
  //SET_ClearSets

For ($i;1;Count parameters:C259)
	If (Records in set:C195(${$i})#0)
		CLEAR SET:C117(${$i})
	End if 
End for 