C_LONGINT:C283($item)
$item:=Selected list items:C379(Self:C308->)
OBJECT SET VISIBLE:C603(*;"todosPagos@";False:C215)
OBJECT SET VISIBLE:C603(*;"todosDctosAsoc@";False:C215)
Case of 
	: ($item=1)
		OBJECT SET VISIBLE:C603(*;"todosPagos@";True:C214)
		
	: ($item=2)
		OBJECT SET VISIBLE:C603(*;"todosDctosAsoc@";True:C214)
		
End case 
REDRAW WINDOW:C456