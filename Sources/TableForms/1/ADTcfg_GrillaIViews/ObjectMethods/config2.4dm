If (Self:C308->>vhPST_LastInterview)
	CD_Dlog (0;__ ("La hora inicial no puede ser posterior a la hora final."))
	Self:C308->:=?00:00:00?
End if 