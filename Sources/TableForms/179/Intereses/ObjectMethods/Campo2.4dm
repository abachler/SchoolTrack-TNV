If (Self:C308->="")
	CD_Dlog (0;__ ("Los intereses deben tener una glosa. Se mantendrá el valor anterior."))
	Self:C308->:=vtACT_GlosaInteresesIni
End if 