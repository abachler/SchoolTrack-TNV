$tempaMeses:=aMeses
If (vsACT_Moneda#<>vsACT_MonedaColegio)
	If (vsACT_Moneda="UF")
		vrACT_ValorMoneda:=ACTut_fValorUF (Current date:C33(*))
	Else 
		vrACT_ValorMoneda:=ACTut_fValorDivisa (vsACT_Moneda)
	End if 
	vrACT_MontoPesos:=Round:C94(Num:C11(Get edited text:C655);<>vlACT_Decimales)
	vrACT_Monto:=Round:C94(vrACT_MontoPesos/vrACT_ValorMoneda;4)
End if 
aMeses:=$tempaMeses
If ((vsACT_Glosa#"") & (vsACT_Moneda#"") & (Num:C11(Get edited text:C655)#0))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 