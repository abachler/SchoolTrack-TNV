If (Form event:C388#On After Keystroke:K2:26)
	If (Self:C308-><0)
		CD_Dlog (0;__ ("No puede ingresar un valor inferior a 0."))
		Self:C308->:=0
	Else 
		vrACT_MontoSeleccionado:=Round:C94(vrACT_MontoSeleccionado;<>vlACT_Decimales)
	End if 
	If (Self:C308-><=vrACT_MontoAPagar)
		ACTcfg_OpcionesRecargosCaja ("CalculaMontoMultaXCaja";->vrACT_MontoSeleccionado)
	Else 
		ACTcfg_OpcionesRecargosCaja ("CargaDatosMulta")
	End if 
	ACTcfgmyt_OpcionesGenerales ("SumaMontos")
	  //20140528 ASM Ticket 133330
	ACTfdp_OpcionesRecargos ("CargaVariables";->vlACT_FormasdePago)
	vrACT_MontoRecargo:=ACTfdp_OpcionesRecargos ("CargaMontoRecargo";->vlACT_FormasdePago;->vrACT_MontoSeleccionado)
	ACTfdp_OpcionesRecargos ("SumaMontos")
End if 