$banco:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($banco)
If ($choice>0)
	vtACT_TCBancoEmisor:=atACT_BankName{$choice}
	vtACT_TCBancoCodigo:=atACT_BankID{Find in array:C230(atACT_BankName;vtACT_TCBancoEmisor)}
End if 