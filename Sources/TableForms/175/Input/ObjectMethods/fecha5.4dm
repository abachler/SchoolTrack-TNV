  //Ticket Nº 174553
C_DATE:C307($vd_evaluarSel)
C_TEXT:C284($vt_fechaTexo)

$vd_evaluarSel:=DT_PopCalendar 
If (ok=1)
	$vt_fechaTexo:=String:C10(DT_GetDateFromDayMonthYear (Day of:C23($vd_evaluarSel);Month of:C24($vd_evaluarSel);Year of:C25($vd_evaluarSel)))
	
	If ($vt_fechaTexo#dt_GetNullDateString )
		vt_EstadoCtaDesde:=$vt_fechaTexo
		vd_EstadoCtaDesde:=$vd_evaluarSel
	Else 
		vt_EstadoCtaDesde:=""
		vd_EstadoCtaDesde:=!00-00-00!
	End if 
End if 

ACTbol_AsignaCodigoSII 