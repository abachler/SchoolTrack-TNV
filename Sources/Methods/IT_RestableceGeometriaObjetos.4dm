//%attributes = {}
  // IT_RestableceGeometriaObjetos()
  // Por: Alberto Bachler: 08/11/13, 11:53:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_pagina;$l_PrimerElemento;$l_ultimoElemento)

If (False:C215)
	C_LONGINT:C283(IT_RestableceGeometriaObjetos ;$1)
End if 
If (Count parameters:C259=1)
	$l_pagina:=$1
End if 

If ($l_pagina=0)
	For ($i;1;Size of array:C274(at_Objetos_nombre))
		IT_SetNamedObjectRect (at_Objetos_nombre{$i};al_Objectos_izquierda{$i};al_Objectos_Arriba{$i};al_Objectos_Derecha{$i};al_Objectos_Abajo{$i})
	End for 
Else 
	$l_PrimerElemento:=Find in array:C230(al_Objectos_página;$l_pagina)
	If ($l_PrimerElemento>0)
		$l_ultimoElemento:=Find in array:C230(al_Objectos_página;$l_pagina+1)
		If ($l_ultimoElemento<0)
			$l_ultimoElemento:=Size of array:C274(at_Objetos_nombre)
		End if 
		For ($i;$l_PrimerElemento;$l_ultimoElemento)
			IT_SetNamedObjectRect (at_Objetos_nombre{$i};al_Objectos_izquierda{$i};al_Objectos_Arriba{$i};al_Objectos_Derecha{$i};al_Objectos_Abajo{$i})
		End for 
	End if 
End if 

SET WINDOW RECT:C444(vl_IzquierdaVentana;vl_arribaVentana;vl_derechaVentana;vl_abajoVentana)
WDW_AjustaPosicionVentana 
