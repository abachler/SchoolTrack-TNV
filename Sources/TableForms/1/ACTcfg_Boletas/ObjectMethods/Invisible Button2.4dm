$text:=AT_array2text (->atACT_Impresoras)

$choice:=Pop up menu:C542($text)

If ($choice>0)
	vtACT_PrinterRecibo:=atACT_Impresoras{$choice}
End if 