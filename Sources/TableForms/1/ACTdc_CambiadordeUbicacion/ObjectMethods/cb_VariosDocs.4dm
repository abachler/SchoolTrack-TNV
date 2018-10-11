If (Self:C308->=1)
	OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
	OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"@next@";True:C214)
	OBJECT SET VISIBLE:C603(*;"@Ingresar@";False:C215)
End if 