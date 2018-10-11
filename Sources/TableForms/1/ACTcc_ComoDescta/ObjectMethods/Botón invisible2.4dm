$meses:=AT_array2text (->aMeses)
$choice:=Pop up menu:C542($meses)
If ($choice>0)
	vt_Mes:=aMeses{$choice}
	vl_Mes:=$choice
	vl_PrevMes:=vl_Mes
	vl_PrevAño:=vl_Año
End if 