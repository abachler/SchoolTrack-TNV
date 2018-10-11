If (Self:C308->>0)
	If (Self:C308->{Self:C308->}#prevMoneda)
		vrACT_Monto:=0
		vrACT_ValorMoneda:=0
		vrACT_MontoPesos:=0
		vsACT_Moneda:=Self:C308->{Self:C308->}
	End if 
Else 
	vsACT_Moneda:=Self:C308->{1}
End if 
prevMoneda:=Self:C308->{Self:C308->}
$tempaMeses:=aMeses
If (vsACT_Moneda#<>vsACT_MonedaColegio)
	OBJECT SET FORMAT:C236(vrACT_ValorMoneda;"|Despliegue_UF")
	OBJECT SET FORMAT:C236(vrACT_Monto;"|Despliegue_UF")
	If (vsACT_Moneda="UF")
		vrACT_ValorMoneda:=ACTut_fValorUF (Current date:C33(*))
	Else 
		vrACT_ValorMoneda:=ACTut_fValorDivisa (vsACT_Moneda)
	End if 
	vrACT_MontoPesos:=0
Else 
	OBJECT SET FORMAT:C236(vrACT_Monto;"|Despliegue_ACT")
End if 
aMeses:=$tempaMeses
OBJECT SET VISIBLE:C603(*;"@calcextra@";(vsACT_Moneda#<>vsACT_MonedaColegio))
OBJECT SET VISIBLE:C603(*;"@ufcalcextra@";((vsACT_Moneda="UF") & (<>vtXS_CountryCode="cl")))
OBJECT SET VISIBLE:C603(*;"@divisacalcextra@";(Not:C34((vsACT_Moneda="UF") & (<>vtXS_CountryCode="cl"))) & (vsACT_Moneda#<>vsACT_MonedaColegio))
If ((vsACT_Glosa#"") & (vsACT_Moneda#"") & (vrACT_Monto#0))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 
GOTO OBJECT:C206(vrACT_MOnto)