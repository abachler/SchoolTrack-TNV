$mesEntre2:=AT_array2text (->aMeses)
$choice:=Pop up menu:C542($mesEntre2)
If ($choice>0)
	vt_Mes2:=aMeses{$choice}
	vl_Mes2:=$choice
Else 
	vt_Mes2:=aMeses{Month of:C24(Current date:C33(*))}
	vl_Mes2:=Month of:C24(Current date:C33(*))
End if 