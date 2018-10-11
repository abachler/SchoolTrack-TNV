$text:=AT_array2text (->atACT_AlinExp)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	vtAlin:=atACT_AlinExp{$choice}
End if 