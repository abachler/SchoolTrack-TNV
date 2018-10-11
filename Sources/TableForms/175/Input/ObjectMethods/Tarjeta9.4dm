$Bancos:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($Bancos)
If (Not:C34((Macintosh option down:C545) | (Windows Alt down:C563)))
	If ($choice>0)
		[ACT_CuentasCorrientes:175]PAT_banco_emisor:41:=atACT_BankName{$choice}
	End if 
Else 
	[ACT_CuentasCorrientes:175]PAT_banco_emisor:41:=""
End if 