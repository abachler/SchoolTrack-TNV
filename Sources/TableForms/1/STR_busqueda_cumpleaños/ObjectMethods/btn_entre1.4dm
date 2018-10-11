$mesEntre1:=AT_array2text (->aMeses)
$choice:=Pop up menu:C542($mesEntre1)
If ($choice>0)
	vt_Mes1:=aMeses{$choice}
	vl_Mes1:=$choice
Else 
	vt_Mes1:=aMeses{Month of:C24(Current date:C33(*))}
	vl_Mes1:=Month of:C24(Current date:C33(*))
End if 