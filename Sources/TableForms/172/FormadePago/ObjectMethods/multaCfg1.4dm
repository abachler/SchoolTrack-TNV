If (Form event:C388#On After Keystroke:K2:26)
	If (Self:C308-><0)
		CD_Dlog (0;__ ("No puede ingresar un valor inferior a 0."))
		Self:C308->:=0
	Else 
		vrACT_MontoMulta:=Round:C94(vrACT_MontoMulta;<>vlACT_Decimales)
	End if 
	ACTcfgmyt_OpcionesGenerales ("SumaMontos")
End if 