$text:=AT_array2text (->atACT_FillExp)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	vtRelleno:=atACT_FillExp{$choice}
End if 