//%attributes = {}
  //ACTbol_RetornaEstado

C_TEXT:C284($vt_accion;$1;$0;$itemText;$vt_retorno)
C_LONGINT:C283(hlACT_ListaEstadosDT;$itemRef)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="LeeLista")
		hlACT_ListaEstadosDT:=at_array2List (-><>atACT_EstadosBoletas)
		
	: ($vt_accion="LeerLista")
		If (Not:C34(Is a list:C621(hlACT_ListaEstadosDT)))
			ACTbol_RetornaEstado ("LeeLista")
		End if 
		
	: ($vt_accion="RetornaEstadoTexto")
		ACTbol_RetornaEstado ("LeerLista")
		GET LIST ITEM:C378(hlACT_ListaEstadosDT;$ptr1->;$itemRef;$itemText)
		$vt_retorno:=$itemText
		
End case 

$0:=$vt_retorno