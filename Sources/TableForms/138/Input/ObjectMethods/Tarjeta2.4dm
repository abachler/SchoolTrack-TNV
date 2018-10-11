$vtTipoTC:=AT_array2text (-><>atACT_TarjetasCredito)
$choice:=Pop up menu:C542($vtTipoTC)
If (Not:C34((Macintosh option down:C545) | (Windows Alt down:C563)))
	If ($choice>0)
		[ACT_Terceros:138]RC_TipoTarjetaTD:68:=<>atACT_TarjetasCredito{$choice}
	End if 
Else 
	[ACT_Terceros:138]RC_TipoTarjetaTD:68:=""
End if 