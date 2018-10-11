If (Self:C308->>Current date:C33(*))
	CD_Dlog (0;__ ("No puede ingresar una fecha superior a la fecha de hoy."))
	Self:C308->:=vdACT_FechaPagoIni
Else 
	$mesAbierto:=ACTcm_IsMonthOpenFromDate (Self:C308->)
	If (Not:C34($mesAbierto))
		CD_Dlog (0;__ ("El pago no podrá ser registrado con esta fecha ya que corresponde a un mes cerrado."))
	Else 
		If (Self:C308->#vdACT_FechaPagoIni)
			ACTpgs_OpcionesVR ("RecalculaTodo")
			ACTpgs_OpcionesVR ("SetFechas")
			vdACT_FechaE:=vdACT_FechaPago
			vtACT_FechaE:=String:C10(vdACT_FechaE)
			vdACT_FechaPagoIni:=Self:C308->
		End if 
	End if 
End if 