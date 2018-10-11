$mes:=AT_array2text (->aMeses)
$choice:=Pop up menu:C542($mes)
If ($choice>0)
	vt_Mes:=aMeses{$choice}
	vl_Mes:=$choice
Else 
	vt_Mes:=aMeses{Month of:C24(Current date:C33(*))}
	vl_Mes:=Month of:C24(Current date:C33(*))
End if 