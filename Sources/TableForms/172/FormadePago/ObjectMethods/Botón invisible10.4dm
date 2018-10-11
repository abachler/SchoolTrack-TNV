$text:=AT_array2text (-><>atACT_TarjetasCredito)
$choice:=Pop up menu:C542($text)
If ($choice>0)
	vtACT_TDTipo:=<>atACT_TarjetasCredito{$choice}
End if 