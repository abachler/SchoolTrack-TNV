If (Self:C308->>0)
	vt_monedaIE:=Self:C308->{Self:C308->}
	If (vt_monedaIE#Old:C35([xxACT_Items:179]Moneda:10))
		vr_montoIE:=0
	End if 
	vr_montoIE:=vr_montoIE  //para que actualice el formato. Por algún motivo cuando era peso se cambiaba a uf y se volvía a peso no se actualizaba el formato...
	If ((<>gCountryCode="cl") & (vt_monedaIE="UF@"))
		OBJECT SET FORMAT:C236(vr_montoIE;"|Despliegue_UF")
	Else 
		OBJECT SET FORMAT:C236(vr_montoIE;"|Despliegue_ACT")
	End if 
	REDRAW WINDOW:C456
End if 