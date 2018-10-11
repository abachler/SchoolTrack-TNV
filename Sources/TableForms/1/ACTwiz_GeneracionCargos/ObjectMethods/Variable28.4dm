$tempaMeses:=aMeses
If (vsACT_Moneda#<>vsACT_MonedaColegio)
	If (vsACT_Moneda="UF")
		vrACT_ValorMoneda:=ACTut_fValorUF (Current date:C33(*))
	Else 
		vrACT_ValorMoneda:=ACTut_fValorDivisa (vsACT_Moneda)
	End if 
	vrACT_MontoPesos:=Round:C94((vrACT_ValorMoneda*Num:C11(Get edited text:C655));<>vlACT_Decimales)
End if 
aMeses:=$tempaMeses
If ((vsACT_Glosa#"") & (vsACT_Moneda#"") & (Num:C11(Get edited text:C655)#0))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 
If (Form event:C388=On Data Change:K2:15)
	vrACT_Monto:=Round:C94(vrACT_Monto;4)
	vrACT_MontoPesos:=Round:C94((vrACT_ValorMoneda*vrACT_Monto);<>vlACT_Decimales)
End if 