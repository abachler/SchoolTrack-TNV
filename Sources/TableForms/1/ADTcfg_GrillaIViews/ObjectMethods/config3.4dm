If (Self:C308-><vhPST_FirstInterview)
	CD_Dlog (0;__ ("La hora final no puede ser anterior a la hora inicial."))
	Self:C308->:=?00:00:00?
End if 