  // [xShell_MensajesAplicacion].Editor.Botón()
  // Por: Alberto Bachler: 26/03/13, 11:26:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_tamañoFuente)


ST GET ATTRIBUTES:C1094([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion;Attribute text size:K65:6;$l_tamañoFuente)
$l_tamañoFuente:=$l_tamañoFuente+1
If (Find in array:C230(al_FontSizes;$l_tamañoFuente)<0)
	APPEND TO ARRAY:C911(al_FontSizes;$l_tamañoFuente)
	SORT ARRAY:C229(al_FontSizes;>)
End if 
ST SET ATTRIBUTES:C1093([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion;Attribute text size:K65:6;$l_tamañoFuente)
al_FontSizes:=Find in array:C230(al_FontSizes;$l_tamañoFuente)

