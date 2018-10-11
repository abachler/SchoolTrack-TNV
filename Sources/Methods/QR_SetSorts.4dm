//%attributes = {}
  //QR_SetSorts

  //`xShell, Alberto Bachler (basado en codigo de Dave Batton)
  //Metodo: QR_SetSorts
  //Por abachler
  //Creada el 21/01/2004, 08:50:46
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_LONGINT:C283($styles)
C_POINTER:C301($fieldPtr)
C_BOOLEAN:C305($enterable)


  //****INICIALIZACIONES****


  //****CUERPO****
$elements:=Count list items:C380(hlQR_SortList)

ARRAY LONGINT:C221($aColumns;$elements)
ARRAY LONGINT:C221($aOrders;$elements)

For ($position;1;$elements)
	GET LIST ITEM:C378(hlQR_SortList;$position;$itemRef;$itemText)
	GET LIST ITEM PROPERTIES:C631(hlQR_SortList;$itemRef;$enterable;$styles;$icon)
	$tableNum:=$itemRef\1000
	$fieldNum:=$itemRef%1000
	
	  //$fieldPtr:=Field($tableNum;$fieldNum)
	
	  //$column:=QR Find column(xQR_ReportArea;$fieldPtr)
	$column:=QR Find column:C776(xQR_ReportArea;$itemText)
	
	
	$aColumns{$position}:=$column
	If ($icon=(23087+Use PicRef:K28:4))
		$aOrders{$position}:=1
	Else 
		$aOrders{$position}:=-1
	End if 
End for 

QR SET SORTS:C752(xQR_ReportArea;$aColumns;$aOrders)


  //****LIMPIEZA****



