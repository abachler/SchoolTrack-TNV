C_POINTER:C301($y_punteroCol1;$y_punteroCol2;$y_punteroCol3)
$y_punteroCol2:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_IngresaValorCol2")
$y_punteroCol3:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_IngresaValorCol3")
If ((AT_GetSumArray ($y_punteroCol2)=0) | (AT_GetSumArray ($y_punteroCol2)=100))
	ACTcc_DividirEmision ("ArmaObjetoCtas";->[ACT_CuentasCorrientes:175]o_pct_emision:56;$y_punteroCol3;$y_punteroCol2)
	ACCEPT:C269
Else 
	BEEP:C151
End if 