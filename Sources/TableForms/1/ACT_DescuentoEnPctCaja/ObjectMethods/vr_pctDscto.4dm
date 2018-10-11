Case of 
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: (Self:C308->>100)
				Self:C308->:=100
			: (Self:C308-><0)
				Self:C308->:=0
		End case 
		If (Self:C308->#0)
			vb_CondonaDescuento:=True:C214
			$continuar:=ACTcfg_OpcionesCondonacion ("SolicitaMotivo")
			If ($continuar)
				Self:C308->:=Round:C94(Self:C308->;2)
			Else 
				Self:C308->:=0
			End if 
		End if 
End case 