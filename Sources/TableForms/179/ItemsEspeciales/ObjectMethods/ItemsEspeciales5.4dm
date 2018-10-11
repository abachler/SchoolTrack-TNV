If (vr_montoIE<0)
	CD_Dlog (0;__ ("El monto no puede ser negativo.\rPara realizar un descuento seleccione la opción más arriba.");__ ("");__ ("Aceptar"))
	vr_montoIE:=0
End if 
If ((<>gCountryCode="cl") & (vt_monedaIE="UF@"))
	vr_montoIE:=Round:C94(vr_montoIE;4)
Else 
	vr_montoIE:=Round:C94(vr_montoIE;<>vlACT_Decimales)
End if 
