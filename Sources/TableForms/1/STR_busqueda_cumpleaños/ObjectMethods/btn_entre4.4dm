$dias:=AT_array2text (->al_diasMes2)
$choice:=Pop up menu:C542($dias)
If ($choice>0)
	vl_dia2:=al_diasMes2{$choice}
Else 
	vl_dia2:=Day of:C23(Current date:C33(*))
End if 