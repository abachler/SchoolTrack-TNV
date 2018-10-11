If (Self:C308->=1)
	[xxSTR_Niveles:6]Promoción_auto:18:=False:C215
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]Minimo_asistencia:24;True:C214)
	OBJECT SET ENTERABLE:C238(vs_minimo0;True:C214)
	OBJECT SET ENTERABLE:C238(vs_minimo1;True:C214)
	OBJECT SET ENTERABLE:C238(vs_minimo2;True:C214)
	OBJECT SET ENTERABLE:C238(vs_minimo3;True:C214)
	vb_CambiosEnPromocion:=True:C214
	$y_prom:=OBJECT Get pointer:C1124(Object named:K67:5;"promocion14")  //20180226//199048 //ABC
	OBJECT SET ENTERABLE:C238($y_prom->;True:C214)
End if 