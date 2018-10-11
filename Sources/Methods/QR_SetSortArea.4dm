//%attributes = {}
  // QR_SetSortArea()
  // Por: Alberto Bachler: 25/02/13, 16:33:21
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_ancho;$l_oculta;$l_referenciaIcono;$l_valoresRepetidos)
C_TEXT:C284($t_encabezado;$t_formato;$t_objeto)

ARRAY LONGINT:C221($al_columnas;0)
ARRAY LONGINT:C221($al_ordenamiento;0)

QR GET SORTS:C753(xQR_ReportArea;$al_columnas;$al_ordenamiento)
QR ON COMMAND:C790(xQR_ReportArea;"QR_CommandCallback")
For ($i;1;Size of array:C274($al_columnas))
	QR GET INFO COLUMN:C766(xQR_ReportArea;$al_columnas{$i};$t_encabezado;$t_objeto;$l_oculta;$l_ancho;$l_valoresRepetidos;$t_formato)
	APPEND TO LIST:C376(hlQR_SortList;$t_objeto;$i)
	If ($al_ordenamiento{$i}=1)
		$l_referenciaIcono:=23087+Use PicRef:K28:4
	Else 
		$l_referenciaIcono:=23086+Use PicRef:K28:4
	End if 
	SET LIST ITEM PROPERTIES:C386(hlQR_SortList;$i;False:C215;0;$l_referenciaIcono)
End for 
_O_REDRAW LIST:C382(hlQR_SortList)
