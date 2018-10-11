$text:=AT_array2text (->atACT_Recibos)
$choice:=Pop up menu:C542($text)

If ($choice#0)
	atACT_Recibos:=$choice
	vtACT_ModeloRecibo:=atACT_Recibos{atACT_Recibos}
End if 