$banco:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($banco)
If (Not:C34((Macintosh option down:C545) | (Windows Alt down:C563)))
	If ($choice>0)
		[ACT_CuentasCorrientes:175]PAC_banco_nombre:47:=atACT_BankName{$choice}
		[ACT_CuentasCorrientes:175]PAC_banco_id:48:=atACT_BankID{$choice}
	End if 
Else 
	[ACT_CuentasCorrientes:175]PAC_banco_nombre:47:=""
	[ACT_CuentasCorrientes:175]PAC_banco_id:48:=""
End if 