$bancos:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($bancos)
If ($choice>0)
	vtACT_BancoNombre:=atACT_BankName{$choice}
	vtACT_BancoID:=atACT_BankID{Find in array:C230(atACT_BankName;vtACT_BancoNombre)}
End if 