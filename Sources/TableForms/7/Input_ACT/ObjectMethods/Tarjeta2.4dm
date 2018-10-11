$vtTipoTC:=AT_array2text (-><>atACT_TarjetasCredito)
$choice:=Pop up menu:C542($vtTipoTC)
If (Not:C34((Macintosh option down:C545) | (Windows Alt down:C563)))
	If ($choice>0)
		[Personas:7]ACT_Tipo_TD:106:=<>atACT_TarjetasCredito{$choice}
	End if 
Else 
	[Personas:7]ACT_Tipo_TD:106:=""
End if 