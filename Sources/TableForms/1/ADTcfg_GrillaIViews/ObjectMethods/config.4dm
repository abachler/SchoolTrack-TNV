If (Self:C308->>vdPST_EndInterviews)
	CD_Dlog (0;__ ("La fecha inicial no puede ser posterior a la fecha final."))
	Self:C308->:=!00-00-00!
End if 