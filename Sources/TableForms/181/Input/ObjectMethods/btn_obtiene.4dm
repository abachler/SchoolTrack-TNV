If (Shift down:C543)
	If ([ACT_Boletas:181]AR_CAEcodigo:48="")
		[ACT_Boletas:181]AR_RespuestaWS:50:=ACTfear_FECompConsultar ([ACT_Boletas:181]ID_RazonSocial:25;Num:C11([ACT_Boletas:181]codigo_SII:33);[ACT_Boletas:181]Numero:11;[ACT_Boletas:181]AR_CodigoPtoVenta:47)
		[ACT_Boletas:181]AR_CAEcodigo:48:=t_ACT_codigoAUT
		[ACT_Boletas:181]AR_CAEvencimiento:49:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(t_ACT_vencAUT;7;2));Num:C11(Substring:C12(t_ACT_vencAUT;5;2));Num:C11(Substring:C12(t_ACT_vencAUT;1;4)))
		SAVE RECORD:C53([ACT_Boletas:181])
	End if 
End if 