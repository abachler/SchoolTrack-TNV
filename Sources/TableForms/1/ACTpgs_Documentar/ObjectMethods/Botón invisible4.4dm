$text:=AT_array2text (-><>atACT_LugaresPago)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	vsACT_LugardePago:=<>atACT_LugaresPago{$choice}
End if 