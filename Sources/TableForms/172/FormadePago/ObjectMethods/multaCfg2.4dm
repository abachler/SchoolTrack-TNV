If (Form event:C388#On After Keystroke:K2:26)
	If (Self:C308-><0)
		CD_Dlog (0;__ ("No puede ingresar un valor inferior a 0."))
		Self:C308->:=0
	Else 
		vrACT_MontoRecargo:=Round:C94(vrACT_MontoRecargo;<>vlACT_Decimales)
	End if 
	ACTfdp_OpcionesRecargos ("SumaMontos")
End if 
