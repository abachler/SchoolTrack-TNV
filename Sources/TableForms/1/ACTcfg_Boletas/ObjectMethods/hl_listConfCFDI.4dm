C_LONGINT:C283($vl_item)

$vl_item:=Selected list items:C379(hl_listConfCFDI)
OBJECT SET VISIBLE:C603(lb_generacionXML;False:C215)
OBJECT SET VISIBLE:C603(lb_generacionFIle;False:C215)
OBJECT SET VISIBLE:C603(*;"cert@";False:C215)

Case of 
	: ($vl_item=1)
		OBJECT SET VISIBLE:C603(*;"cert@";True:C214)
	: ($vl_item=2)
		OBJECT SET VISIBLE:C603(lb_generacionXML;True:C214)
	: ($vl_item=3)
		OBJECT SET VISIBLE:C603(lb_generacionFIle;True:C214)
End case 