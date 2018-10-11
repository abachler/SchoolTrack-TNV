//%attributes = {}
  // QR_SelectReportInList()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 12:25:22
  // -----------------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_item;$l_itemRef;$l_itemSeleccionado)
C_TEXT:C284($t_nombreInforme)


If (False:C215)
	C_LONGINT:C283(QR_SelectReportInList ;$1)
End if 

$l_item:=$1
If ($l_item>=0)
	$l_item:=$1+1
End if 
vlQR_ReportRecNum:=$l_item-1


SELECT LIST ITEMS BY REFERENCE:C630(hl_Reports;$l_item)
_O_REDRAW LIST:C382(hl_Reports)
If ($l_item<0)
	vlQR_ReportType:=$l_item
Else 
	GOTO RECORD:C242([xShell_Reports:54];vlQR_ReportRecNum)
	vlQR_ReportType:=List item parent:C633(hl_Reports;vlQR_ReportRecNum)
End if 

$l_itemSeleccionado:=Selected list items:C379(hl_Reports)
If ($l_itemSeleccionado>0)
	GET LIST ITEM:C378(hl_Reports;$l_itemSeleccionado;$l_itemRef;$t_nombreInforme)
	vlQR_ReportRecNum:=$l_itemRef-1
	If ($l_itemRef<0)
		vlQR_ReportType:=$l_itemRef
	Else 
		vlQR_ReportType:=List item parent:C633(hl_Reports;$l_itemRef)
	End if 
End if 