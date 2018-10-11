Bancos:=AT_array2text (->atACT_BankName)

$choice:=Pop up menu:C542(Bancos)

If ($choice>0)
	
	vACT_BancoNombre:=atACT_BankName{$choice}
	vACT_BancoCodigo:=atACT_BankID{$choice}
	
End if 