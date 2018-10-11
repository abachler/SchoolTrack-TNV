$semana:=AT_array2text (-><>aWeeks)
$choice:=Pop up menu:C542($semana)
If ($choice>0)
	vt_Semana:=<>aWeeks{$choice}
End if 