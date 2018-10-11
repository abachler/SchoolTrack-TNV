$dias:=AT_array2text (->al_diasMes1)
$choice:=Pop up menu:C542($dias)
If ($choice>0)
	vl_dia1:=al_diasMes1{$choice}
Else 
	vl_dia1:=Day of:C23(Current date:C33(*))
End if 