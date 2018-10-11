If (Form event:C388#On After Keystroke:K2:26)
	If (Self:C308-><0)
		CD_Dlog (0;__ ("No puede ingresar un valor inferior a 0."))
		Self:C308->:=0
	Else 
		vrACT_MontoPago:=Round:C94(vrACT_MontoPago;<>vlACT_Decimales)
		If ((cb_soloCuotasVencidas=1) & (Self:C308->>vrACT_MontoAPagar))
			BEEP:C151
			Self:C308->:=vrACT_MontoAPagar
		Else 
			  //If (Self->>vrACT_MontoAdeudado)
			  //CD_Dlog (0;"Este apoderado no es apoderado de cuentas. No puede ingresar un valor superior al"+" adeudado.")
			  //Self->:=vrACT_MontoAdeudado
			  //End if 
		End if 
		  //20110822 RCH Se agrega if debido a que cuando cambiaban un monto de pago el monto en moneda no se modificaba. Ticket 102572.
		If (Form event:C388=On Data Change:K2:15)
			  //20110902 RCH No se podia ingresar pago superior al seleccionado
			  //ACTcfgmyt_OpcionesGenerales ("CalculaMontoPagadoMNacional")
			ACTcfgmyt_OpcionesGenerales ("CalculaMontoMoneda")
			vb_MontoModificado:=True:C214
		End if 
	End if 
End if 