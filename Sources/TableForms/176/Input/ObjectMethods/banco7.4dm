$bancos:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($bancos)
If ($choice>0)
	[ACT_Documentos_de_Pago:176]TD_BancoCodigo:65:=atACT_BankName{$choice}
	[ACT_Documentos_de_Pago:176]TD_AgnoVencimiento:64:=atACT_BankID{Find in array:C230(atACT_BankName;[ACT_Documentos_de_Pago:176]TD_BancoCodigo:65)}
End if 

