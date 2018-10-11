$Bancos:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($Bancos)
If (Not:C34((Macintosh option down:C545) | (Windows Alt down:C563)))
	If ($choice>0)
		[ACT_Terceros:138]RC_TitularTD:69:=atACT_BankName{$choice}
	End if 
Else 
	[ACT_Terceros:138]RC_TitularTD:69:=""
End if 