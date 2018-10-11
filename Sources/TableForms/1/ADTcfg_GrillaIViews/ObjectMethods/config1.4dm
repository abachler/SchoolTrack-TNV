If (Self:C308-><vdPST_StartInterviews)
	CD_Dlog (0;__ ("La fecha final no puede ser anterior a la fecha inicial."))
	Self:C308->:=!00-00-00!
End if 