$Bancos:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($Bancos)
If (Not:C34((Macintosh option down:C545) | (Windows Alt down:C563)))
	If ($choice>0)
		[Personas:7]ACT_Banco_TC:53:=atACT_BankName{$choice}
	End if 
Else 
	[Personas:7]ACT_Banco_TC:53:=""
End if 