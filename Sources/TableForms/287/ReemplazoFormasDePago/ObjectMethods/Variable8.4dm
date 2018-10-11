If (l_nuevoValor#0)
	C_LONGINT:C283($l_resp)
	
	$l_resp:=CD_Dlog (0;"¿Está seguro de querer reemplazar todos los pagos asociados a la forma de pago "+ST_Qte (t_antiguoValor)+" por la forma de pago "+ST_Qte (atACT_formasDePagoReemp{atACT_formasDePagoReemp})+"?";"";"Si";"No")
	If ($l_resp=1)
		ACCEPT:C269
	End if 
	
Else 
	BEEP:C151
End if 