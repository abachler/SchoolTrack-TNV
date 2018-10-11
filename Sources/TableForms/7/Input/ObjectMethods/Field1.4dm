Self:C308->:=ST_Format (Self:C308)

If (Self:C308->#"")
	OBJECT SET ENTERABLE:C238(*;"Field21";True:C214)
Else 
	OBJECT SET ENTERABLE:C238(*;"Field21";False:C215)
End if 

