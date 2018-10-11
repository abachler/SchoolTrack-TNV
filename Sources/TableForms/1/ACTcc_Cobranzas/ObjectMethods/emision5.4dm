Case of 
	: (Form event:C388=On Data Change:K2:15)
		$d_fecha:=DT_GetDateFromDayMonthYear (Self:C308->;aMeses;vdACT_AñoAviso)
		If ($d_fecha#!00-00-00!)
			If ((cbVctoSegunConf=0) & (cbUltimoDiaMes=1))
				l_diasEmision:=0
				vdACT_DiaVctoAviso:=Day of:C23(ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear (DT_GetLastDay (aMeses;vdACT_AñoAviso);aMeses;vdACT_AñoAviso)))
			Else 
				vdACT_FechaAviso:=DT_GetDateFromDayMonthYear (Self:C308->;aMeses;vdACT_AñoAviso)
				vdACT_DiaVctoAviso:=Day of:C23(ACTut_fFechaValida (vdACT_FechaAviso+l_diasEmision))
			End if 
		Else 
			BEEP:C151
			Self:C308->:=viACT_DiaDeuda
			vdACT_FechaAviso:=DT_GetDateFromDayMonthYear (Self:C308->;aMeses;vdACT_AñoAviso)
		End if 
End case 