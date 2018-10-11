$cond:=((cb_PublicarAnotacionesPositivas=0) & (cb_PublicarAnotacionesNegativas=0) & (cb_PublicarAnotacionesNeutras=0) & (cb_PublicarAnotaciones=1))
If ($cond)
	cb_PublicarAnotaciones:=0
End if 