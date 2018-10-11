Case of 
	: (Form event:C388=On Data Change:K2:15)
		vdACT_FechaAviso:=DT_GetDateFromDayMonthYear (vdACT_DiaAviso;aMeses;vdACT_AñoAviso)
		$fecha:=Add to date:C393(vdACT_FechaAviso;0;0;l_diasEmision)
		Self:C308->:=Day of:C23(ACTut_fFechaValida ($fecha))
End case 