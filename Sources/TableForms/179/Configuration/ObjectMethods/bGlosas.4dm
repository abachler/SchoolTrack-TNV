$Text:=Get indexed string:C510(21503;65)
$choice:=Pop up menu:C542($Text)

Case of 
	: ($choice=1)
		OBJECT SET VISIBLE:C603(*;"impresion@";False:C215)
		OBJECT SET VISIBLE:C603(*;"glosa@";True:C214)
	: ($choice=2)
		OBJECT SET VISIBLE:C603(*;"impresion@";True:C214)
		OBJECT SET VISIBLE:C603(*;"glosa@";False:C215)
End case 