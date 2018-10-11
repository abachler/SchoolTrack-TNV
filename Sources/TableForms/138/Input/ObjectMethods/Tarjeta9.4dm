$Bancos:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($Bancos)
If (Not:C34((Macintosh option down:C545) | (Windows Alt down:C563)))
	If ($choice>0)
		[ACT_Terceros:138]PAT_Banco_Emisor:39:=atACT_BankName{$choice}
	End if 
Else 
	[ACT_Terceros:138]PAT_Banco_Emisor:39:=""
End if 