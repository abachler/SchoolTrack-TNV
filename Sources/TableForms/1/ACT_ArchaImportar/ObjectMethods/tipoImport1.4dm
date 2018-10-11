$fecha:=DT_PopCalendar 
If (Not:C34(ACTcm_IsMonthOpenFromDate ($fecha)))
	CD_Dlog (0;__ ("Los pagos no podrán ser registrados con esta fecha ya que corresponde a un mes cerrado."))
Else 
	$fechaStr:=String:C10($fecha;7)
	If ($fechaStr#dt_GetNullDateString )
		vdACT_ImpRealDate:=$fecha
		If ($fecha>Current date:C33(*))
			CD_Dlog (0;__ ("La fecha de pago no puede ser superior a la fecha de hoy. Se seleccionará la fecha de hoy."))
			vdACT_ImpRealDate:=Current date:C33(*)
		Else 
			vdACT_ImpRealDate:=$fecha
		End if 
	Else 
		vdACT_ImpRealDate:=!00-00-00!
	End if 
	vd_FechaUF:=vdACT_ImpRealDate
	vt_FechaUF:=String:C10(vd_FechaUF)
End if 