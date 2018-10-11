
If (Self:C308->=1)
	OBJECT SET ENABLED:C1123(*;"Casilla_enviacorreo";True:C214)
Else 
	OBJECT SET ENABLED:C1123(*;"Casilla_enviacorreo";False:C215)
	$y_enviaCorreo:=OBJECT Get pointer:C1124(Object named:K67:5;"Casilla_enviacorreo")
	$y_enviaCorreo->:=0
End if 