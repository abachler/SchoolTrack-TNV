$banco:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542($banco)
If (Not:C34((Macintosh option down:C545) | (Windows Alt down:C563)))
	If ($choice>0)
		[Personas:7]ACT_Banco_Cta:47:=atACT_BankName{$choice}
		[Personas:7]ACT_ID_Banco_Cta:48:=atACT_BankID{$choice}
	End if 
Else 
	[Personas:7]ACT_Banco_Cta:47:=""
	[Personas:7]ACT_ID_Banco_Cta:48:=""
End if 