$meses:=AT_array2text (->aMeses)

$choice:=Pop up menu:C542($meses)

If ($choice>0)
	vt_Mes:=aMeses{$choice}
	vl_Mes:=$choice
End if 