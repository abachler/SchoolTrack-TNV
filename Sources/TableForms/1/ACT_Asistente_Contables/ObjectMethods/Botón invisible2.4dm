$text:=AT_array2text (->aSoftwares)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	vSoftware:=aSoftwares{$choice}
End if 