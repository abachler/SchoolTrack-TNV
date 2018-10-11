//%attributes = {}
  // HL_ClearList()
  // Por: Alberto Bachler K.: 26-08-14, 17:24:17
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283(${1})

C_LONGINT:C283($i;$l_referenciaLista)


If (False:C215)
	C_LONGINT:C283(HL_ClearList ;${1})
End if 

For ($i;1;Count parameters:C259)
	$l_referenciaLista:=${$i}
	If (Is a list:C621($l_referenciaLista))
		CLEAR LIST:C377($l_referenciaLista;*)
	End if 
End for 

