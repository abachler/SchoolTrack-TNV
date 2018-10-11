$banco:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($banco)
If (Not:C34((Macintosh option down:C545) | (Windows Alt down:C563)))
	If ($choice>0)
		[ACT_Terceros:138]PAC_Banco_Nombre:44:=atACT_BankName{$choice}
		[ACT_Terceros:138]PAC_Banco_ID:45:=atACT_BankID{$choice}
	End if 
Else 
	[ACT_Terceros:138]PAC_Banco_Nombre:44:=""
	[ACT_Terceros:138]PAC_Banco_ID:45:=""
End if 