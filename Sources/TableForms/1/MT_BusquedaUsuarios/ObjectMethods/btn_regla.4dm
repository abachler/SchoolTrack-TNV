$choices:=AT_array2text (->at_reglasLectores)
$choice:=Pop up menu:C542($choices)
If ($choice>0)
	vt_regla:=at_reglasLectores{$choice}
End if 