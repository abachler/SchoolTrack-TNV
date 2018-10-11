C_POINTER:C301($y_otra)
$y_otra:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_otra")

If ($y_otra->=1)
	ACTpp_DireccionDeFacturacion ("IngresoDireccionFacturacionDesdeTerceros")
Else 
	BEEP:C151
End if 