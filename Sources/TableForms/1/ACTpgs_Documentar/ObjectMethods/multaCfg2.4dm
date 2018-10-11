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
	vrACT_MontoAPagarApdo:=vrACT_MontoSeleccionado+vrACT_MontoMulta
	POST KEY:C465(Character code:C91("g");Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
End if 