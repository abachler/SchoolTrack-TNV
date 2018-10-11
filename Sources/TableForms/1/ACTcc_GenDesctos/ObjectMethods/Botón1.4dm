If (vb_AplicarDesctos)
	$r:=CD_Dlog (0;__ ("¿Está seguro de querer aplicar los descuentos?");__ ("");__ ("Si");__ ("No"))
	If ($r=1)
		ACCEPT:C269
	End if 
Else 
	CANCEL:C270
End if 