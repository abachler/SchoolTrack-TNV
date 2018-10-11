$choice:=Pop up menu:C542(Bancos)
If ($choice>0)
	vtACT_TDBancoEmisor:=atACT_BankName{$choice}
	vtACT_TDBancoCodigo:=atACT_BankID{Find in array:C230(atACT_BankName;vtACT_TDBancoEmisor)}
End if 