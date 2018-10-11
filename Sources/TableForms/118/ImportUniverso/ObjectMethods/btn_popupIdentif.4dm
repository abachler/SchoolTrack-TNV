$text:=AT_array2text (->at_IIdentificador)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	vIIdentificador:=at_IIdentificador{$choice}
End if 